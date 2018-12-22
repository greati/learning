package main

import (
    "fmt"
    "math"
)

func compterms (terms chan float64, n int) {
    for i := 0; i <= n; i++ {
        var t float64 = math.Pow(-1.0,float64(i))/(2.0 * float64(i) + 1.0)
        terms <- t
    }
}

func main() {
    var sum float64 = 0.0
    var n int = 1000
    terms := make(chan float64)
    go compterms(terms, n)

    for i := 0; i <= n; i++ {
        sum = sum + <-terms
    }

    fmt.Println(4.0*sum)
}

