// Implements methods for a relay race
//
// Expected command-line arguments:
// 1 - Number of teams (lanes)
// 2 - Number of runners per lane
//
// Output meanings:
// 1 - It's shown the setup of the race first
// 2 - Then, the lanes are illustrated in a matrix,
// where "-" means a waiting runner, and "*" means
// that the runner has arrived the end of its patch
// and given the stick to the next.
// 3 - After, a log of the race is shown, demonstrating
// each step of the race
// 4 - Finally, the race podium is given.
package main

import (
    "os"
    "fmt"
    "math/rand"
    "time"
    "sync"
    "strconv"
)

// Routine to represent a runner
//
// Each runner in the race has its runner go routine instance and its own channel,
// so that the routine takes a matrix of channels as arguments (patches).
// A random time (500ms-3000ms) is chosen to be the time spent by the runner in its patch 
// (the distance doesn't matter here).
// After completing its patch, the runner passes its stick to the next
// runner in its lane, which means passing in a message to the channel
// where the next runner is waiting.
func runner(teams int, perteam int, lane int, order int, patches [][]chan int,
                places chan int,
                winners chan<- int,
                visual *[][]string, log* []string,
                wg* sync.WaitGroup, printmux, logmux *sync.Mutex) {

    fmt.Printf("Runner #%d of lane #%d in its mark!\n", order+1, lane+1)
    wg.Done()

    stick := <-patches[lane][order]

    logger(fmt.Sprintf("Runner #%d at lane #%d have the stick!\n", order+1, lane+1), log, logmux)

    s1 := rand.NewSource(time.Now().UnixNano()) // Running from determinism
    r1 := rand.New(s1)
    timeToReach := r1.Intn(3000) + 500
    time.Sleep(time.Duration(timeToReach) * time.Millisecond)

    if (order < perteam - 1) {
        logger(fmt.Sprintf("After %d ms, runner #%d at lane #%d passed the stick!\n", stick+timeToReach, order+1, lane+1), log, logmux)
        printVisual(teams, perteam, visual, printmux)
        patches[lane][order + 1]<- (stick + timeToReach) // Pass the stick
        (*visual)[lane][order] = "*"
    } else {
        place := <-places
        logger(fmt.Sprintf("After #%d ms, runner #%d at lane #%d ended in place %d!\n", 
                        stick+timeToReach, order+1, lane+1, place), log, logmux)
        (*visual)[lane][order] = strconv.Itoa(place)
        printVisual(teams, perteam, visual, printmux)
        winners<- lane
    }

    wg.Done()
}

// Print three dots with a sleep
func printDots(ms int) {
    for i := 1; i <= 3; i++ {
        fmt.Print(".")
        time.Sleep(time.Duration(ms)*time.Millisecond)
    }
}

// Initialize visualization matrix
func initializeVisual(teams int, perteam int) [][]string {
    visual := make([][]string, teams)
    for i := 0; i < teams; i++ {
        for j := 0; j < perteam; j++ {
            visual[i] = append(visual[i], "-")
        }
    }
    return visual
}

// Print visualization matrix
func printVisual(teams int, perteam int, visual *[][]string, mux *sync.Mutex) {
    mux.Lock()
    for i := 0; i < teams; i++ {
        fmt.Printf("%d | ", i+1)
        for j := 0; j < perteam; j++ {
            fmt.Print((*visual)[i][j])
        }
        fmt.Println()
    }
    fmt.Println("...")
    mux.Unlock()
}

// Register the log messages
func logger(l string, log* []string, mux* sync.Mutex) {
    mux.Lock()
    *log = append(*log, l)
    mux.Unlock()
}

func main() {

    args := os.Args[1:]

    if (len(args) < 1) {
        fmt.Println("[ERROR] Please, provide the number of teams.")
        return;
    } else if (len(args) < 2) {
        fmt.Println("[ERROR] Please, provide the number of runners per team.")
        return;
    }

    teams, err1 := strconv.Atoi(args[0])
    perteam, err2 := strconv.Atoi(args[1])

    if (err1 != nil || err2 != nil) {
        fmt.Println("Parse error.")
        return;
    } else if (teams <= 0 || perteam <= 0) {
        fmt.Println("Teams and per team quantities must be positive.")
        return;
    }

    var log []string

    // Make a channel for each runner
    patches := make([][]chan int, teams)
    for i := 0; i < teams; i++ {
        for j := 0; j < perteam; j++ {
            patches[i] = append(patches[i], make(chan int))
        }
    }

    // A buffered channel to take the places
    places := make(chan int, teams)

    for l := 1; l <= teams; l++ {
        places<- l
    }

    // A buffered channel to have the winners order
    winners := make(chan int, teams)

    var wg sync.WaitGroup

    // Wait for all to be prepared
    wg.Add(teams*perteam)

    fmt.Print("Okay, runners, be in your marks!")
    printDots(500)
    fmt.Println("\n")

    visual := initializeVisual(teams, perteam)

    var mux sync.Mutex
    var logmux sync.Mutex

    // Start go routines for each runner and wait until all have been waiting
    for l := 0; l < teams; l++ {
        for p := 0; p < perteam; p++ {
            go runner(teams, perteam, l, p, patches, places, winners, &visual, &log, &wg, &mux, &logmux)
        }
    }

    wg.Wait()

    fmt.Print("\nPrepare")
    printDots(500)

    time.Sleep(600*time.Millisecond)

    fmt.Println("\n\nGo!\n")

    time.Sleep(100*time.Millisecond)

    wg.Add(teams*perteam)

    // Give the sticks to the first runner in each lane
    for l := 0; l < teams; l++ {
        patches[l][0] <- 0
    }

    wg.Wait()

    close(winners)
    close(places)

    for l := 0; l < teams; l++ {
        for p := 0; p < perteam; p++ {
            close(patches[l][p])
        }
    }

    // Print log
    for _,l := range log {
        fmt.Println(l)
    }

    fmt.Println("\n**** Podium ****")
    i := 1
    for p := range winners {
        fmt.Printf("Place #%d: Team %d\n", i, p+1)
        i = i + 1
    }
}
