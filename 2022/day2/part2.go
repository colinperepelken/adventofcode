package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)

	a := "ABC"
	b := "XYZ"

	score := 0
	for scanner.Scan() {
		line := strings.Split(scanner.Text(), " ")
		indexA := strings.Index(a, line[0])
		indexB := strings.Index(b, line[1])

		choice := ""
		if line[1] == "Z" {
			choice = string(a[(indexA+1)%3])
		} else if line[1] == "Y" {
			choice = line[0]
		} else {
			choice = string(a[(indexA+2)%3])
		}

		score += strings.Index(a, choice) + 3*indexB + 1
	}

	fmt.Println(score)
}
