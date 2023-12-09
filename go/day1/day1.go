package day1

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var substitutions = [...][]string{
	{"one", "1"},
	{"two", "2"},
	{"three", "3"},
	{"four", "4"},
	{"five", "5"},
	{"six", "6"},
	{"seven", "7"},
	{"eight", "8"},
	{"nine", "9"},
	{"zero", "0"},
}

func reverseString(str string) (result string) {
	// iterate over str and prepend to result
	for _, v := range str {
		result = string(v) + result
	}
	return
}

func findNumber(line string, inverted bool, substitute bool) string {
	var first string
	var firstIndex int
	for _, sub := range substitutions {
		var foundS int
		if substitute {
			if inverted {
				foundS = strings.Index(line, reverseString(sub[0]))
			} else {
				foundS = strings.Index(line, sub[0])
			}
		}
		foundN := strings.Index(line, sub[1])

		if foundS != -1 && (first == "" || foundS < firstIndex) {
			first = sub[1]
			firstIndex = foundS
		}

		if foundN != -1 && (first == "" || foundN < firstIndex) {
			first = sub[1]
			firstIndex = foundN
		}
	}
	return first
}

func solution(substitute bool) int {
	scanner := bufio.NewScanner(os.Stdin)
	var sum int = 0
	for scanner.Scan() {
		var line = scanner.Text()
		first := findNumber(line, false, substitute)
		last := findNumber(reverseString(line), true, substitute)
		fmt.Println(line, first, last)
		num, err := strconv.Atoi(string(first) + string(last))
		if err == nil {
			sum += num
		}
	}
	return sum
}

func Run1() int {
	return solution(false)
}

func Run2() int {
	return solution(true)
}
