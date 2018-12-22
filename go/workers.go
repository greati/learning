package main

import (
    "fmt"
    "sync"
)

type Task struct {
    id int
}

func (t* Task) print () {
    fmt.Printf("Processed: #%d\n", t.id)
}

func worker(taskch <-chan Task, wg* sync.WaitGroup) {
    for true {
        t := <-taskch
        t.print()
        wg.Done()
    }
}

func pool(wg* sync.WaitGroup, workers, tasks int) {
    wg.Add(tasks)
    taskch := make(chan Task)
    for i := 1; i <= workers; i++ {
        go worker(taskch, wg)
    }
    for i := 1; i <= tasks; i++ {
        var t Task
        t.id = i
        taskch <- t
    }
    wg.Wait()
}

func main() {
    var wg sync.WaitGroup
    var tasks int = 100
    var workers int = 5
    pool(&wg, workers, tasks)
}

