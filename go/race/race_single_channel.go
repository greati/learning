package main

import (
    "fmt"
    "math/rand"
    "time"
    "sync"
)


func runner(i int, patches chan int, wg* sync.WaitGroup) {
    fmt.Printf("Runner #%d in its mark!\n", i)
    wg.Done()
    for {
        stick := <-patches
        if (stick != i) {
            patches<- stick
        } else {
            fmt.Printf("Runner #%d have the stick!\n", i)
            s1 := rand.NewSource(time.Now().UnixNano()) // Running from determinism
            r1 := rand.New(s1)
            timeToReach := r1.Intn(5)
            time.Sleep(time.Duration(timeToReach + 1) * time.Second)
            if (i < 4) {
                fmt.Printf("After #%d s, runner #%d passed the stick!\n", timeToReach, i)
                patches<- (stick + 1) // Pass the stick
            } else {
                fmt.Printf("After #%d s, runner #%d reached the end!\n", timeToReach, i)
            }
            wg.Done()
            break;
        }
    }
}

func printDots() {
    for i := 1; i <= 3; i++ {
        fmt.Print(".")
        time.Sleep(400*time.Millisecond)
    }
}

func main() {
    patches := make(chan int)

    var wg sync.WaitGroup
    wg.Add(4)

    fmt.Print("Okay, runners, be in your marks!")
    printDots()
    fmt.Println()

    for i := 1; i <= 4; i++ {
        go runner(i, patches, &wg)
    }
    wg.Wait()

    fmt.Print("\nPrepare")
    printDots()

    time.Sleep(600*time.Millisecond)
    fmt.Println("\n\nGo!\n")
    wg.Add(4)
    patches <- 1

    wg.Wait()
    close(patches)
}
