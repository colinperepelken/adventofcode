package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	data, _ := os.ReadFile("input.txt")

	groups := strings.Split(string(data), "\n\n")

	max := 0
	for _, g := range groups {
		calories := strings.Split(g, "\n")
		sum := 0
		for _, c := range calories {
			i, _ := strconv.Atoi(c)
			sum += i
		}

		if sum > max {
			max = sum
		}

	}

	fmt.Print(max)
}
