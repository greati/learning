package main

import (
	"fmt"
	"math"
)

func max(data []float64) float64 {
	var m float64 = data[0]
	for _,num := range data {
		if (num >= m) {
			m = num
		}
	}
	return m
}

func min(data []float64) float64 {
	var m float64 = data[0]
	for _,num := range data {
		if (num <= m) {
			m = num
		}
	}
	return m
}

func mean(data []float64) float64 {
	var m float64 = 0.0
	for _,num := range data {
		m += num
	}
	return m/float64(len(data))
}

func std(data []float64) float64 {
	var v float64 = 0.0
	var m float64 = mean(data)
	for _,num := range data {
		v += math.Pow((num - m),2)
	}
	return math.Pow(v/float64(len(data)-1),0.5)
}

func main() {

	var data = []float64{2.0,3.0,6.0,7.0}

	fmt.Println("Count: "+fmt.Sprint(len(data)))
	fmt.Println("Max: "+fmt.Sprint(max(data)))
	fmt.Println("Min: "+fmt.Sprint(min(data)))
	fmt.Println("Mean: "+fmt.Sprint(mean(data)))
	fmt.Println("Standard Deviation: " +fmt.Sprint(std(data)))
}
