package main

import (
	"fmt";
	"strconv"
)

func main() {

	var s string = "Hello, Go!"
	
	var count = map[string]int{}
	
	for _,c := range s {
		count[strconv.QuoteRune(c)]++
	}
	
	fmt.Println(count)
}
