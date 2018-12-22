package main

import (
    "fmt"
)

func gerarNumeros(chseq chan<- int) {
    for i := 2; ;i++ {
        chseq <- i
    }
}

func filtrar(chseq <-chan int, aux chan<- int, prime int) {
    for {
        num := <-chseq
        if num % prime != 0 {
            aux <- num
        }
    }
}

func main() {
    var n int = 100
    chseq := make(chan int)
    go gerarNumeros(chseq)
    fmt.Printf("Primos até %d\n", n)
    for {
        primo := <-chseq
        if primo >= n {
            break
        } else {
            fmt.Printf("%d\n", primo)
            aux := make(chan int)
            go filtrar(chseq, aux, primo)
            chseq = aux
        }
    }
}
