package main

import (
	"errors"
	"fmt"
)

type Stack interface {
	push(interface{})
	pop() (interface{}, error)
	top() (interface{}, error)
	size() int
}

type ListStack struct {
	items []interface{}
}

func (s *ListStack) push(e interface{}) {
	s.items = append(s.items, e)
}

func (s *ListStack) top() (interface{}, error) {
	if len(s.items) > 0 {
		return s.items[len(s.items)-1], nil
	} else {
		return 0, errors.New("Empty stack.")
	}
}

func (s *ListStack) pop() (interface{}, error) {
	if len(s.items) > 0 {
		t, _ := s.top()
		s.items = s.items[:len(s.items)-1]
		return t, nil
	} else {
		return 0, errors.New("Empty stack.")
	}
}

func (s *ListStack) size() int {
	return len(s.items)
}

func main() {

	var l ListStack

	l.push(1)
	l.push("oi")
	l.push(1.2222222)
	n := l.size()
	fmt.Println(n)
	fmt.Println(l)
	_, err := l.pop()

	fmt.Println(err)

	fmt.Println(l)

}
