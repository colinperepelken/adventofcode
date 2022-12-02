package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	data, _ := os.ReadFile("input.txt")

	groups := strings.Split(string(data), "\n\n")

	maxArray := []int{0, 0, 0}
	for _, g := range groups {
		calories := strings.Split(g, "\n")
		sum := 0
		for _, c := range calories {
			number, _ := strconv.Atoi(c)
			sum += number
		}

		sort.Ints(maxArray)
		for i, max := range maxArray {
			if (sum > max) {
				maxArray[i] = sum
				break
			}
		}
	}

	total := 0
	for _, max := range maxArray {
		total += max
	}

	fmt.Print(total)
}
