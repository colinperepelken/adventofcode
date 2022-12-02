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
		score += indexB + 1

		if (indexA+1)%3 == indexB {
			score += 6
		} else if indexA == indexB {
			score += 3
		}
	}

	fmt.Println(score)
}
