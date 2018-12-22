package main

import (
    "fmt"
    "math/rand"
    "time"
    "sync"
    "strconv"
)


func runner(lane int, order int, patches [4][4]chan int, 
                places chan int, 
                winners chan<- int, 
                visual *[4][4]string,
                wg* sync.WaitGroup, mux *sync.Mutex) {
    fmt.Printf("Runner #%d of lane #%d in its mark!\n", order, lane)
    wg.Done()
    for {
        stick := <-patches[lane][order]
        mux.Lock()
        fmt.Printf("Runner #%d at lane #%d have the stick!\n", order, lane)
        mux.Unlock()
        s1 := rand.NewSource(time.Now().UnixNano()) // Running from determinism
        r1 := rand.New(s1)
        timeToReach := r1.Intn(5)
        time.Sleep(time.Duration(timeToReach + 1) * time.Second)
        if (order < 3) {
            mux.Lock()
            fmt.Printf("After %ds, runner #%d at lane #%d passed the stick!\n", timeToReach, order, lane)
            printVisual(visual, mux)
            mux.Unlock()
            patches[lane][order + 1]<- (stick + 1) // Pass the stick
            visual[lane][order] = "*"
        } else {
            place := <-places
            mux.Lock()
            fmt.Printf("After #%d s, runner #%d at lane #%d ended in place %d!\n", 
                            timeToReach, order, lane, place)
            visual[lane][order] = strconv.Itoa(place)
            printVisual(visual, mux)
            mux.Unlock()
            winners<- lane
        }
        wg.Done()
        break;
    }
}

func printDots() {
    for i := 1; i <= 3; i++ {
        fmt.Print(".")
        time.Sleep(500*time.Millisecond)
    }
}

func initializeVisual(visual *[4][4]string) {
    for i := 0; i < 4; i++ {
        for j := 0; j < 4; j++ {
            visual[i][j] = "-"
        }
    }
}

func printVisual(visual *[4][4]string, mux *sync.Mutex) {
    for i := 0; i < 4; i++ {
        for j := 0; j < 4; j++ {
            fmt.Print(visual[i][j])
        }
        fmt.Println()
    }
}

func main() {

    var patches [4][4]chan int
    for l := 0; l < 4; l++ {
        for p := 0; p < 4; p++ {
            patches[l][p] = make(chan int)
        }
    }

    places := make(chan int, 4)

    for l := 1; l <= 4; l++ {
        places<- l
    }

    winners := make(chan int, 4)

    var wg sync.WaitGroup
    wg.Add(16)

    fmt.Print("Okay, runners, be in your marks!")
    printDots()
    fmt.Println("\n")

    var visual [4][4]string
    initializeVisual(&visual)

    var mux sync.Mutex

    for l := 0; l < 4; l++ {
        for p := 0; p < 4; p++ {
            go runner(l, p, patches, places, winners, &visual, &wg, &mux)
        }
    }
    wg.Wait()

    fmt.Print("\nPrepare")
    printDots()

    time.Sleep(600*time.Millisecond)
    fmt.Println("\n\nGo!\n")
    wg.Add(16)

    for l := 0; l < 4; l++ {
        patches[l][0] <- 0
    }

    wg.Wait()

    close(winners)
    close(places)

    for l := 0; l < 4; l++ {
        for p := 0; p < 4; p++ {
            close(patches[l][p])
        }
    }

    fmt.Println("\n\n**** Podium ****")
    i := 1
    for p := range winners {
        fmt.Printf("Place #%d: lane %d\n", i, p)
        i = i + 1
    }
}
