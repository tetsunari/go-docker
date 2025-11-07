package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	// 1行目: N M
	scanner.Scan()
	line1 := scanner.Text()
	parts1 := strings.Split(line1, " ")
	N, _ := strconv.Atoi(parts1[0])
	M, _ := strconv.Atoi(parts1[1])

	// 2行目: A1 A2 ... AN
	scanner.Scan()
	line2 := scanner.Text()
	parts2 := strings.Split(line2, " ")

	// 品物の大きさの合計を計算
	sum := 0
	for i := 0; i < N; i++ {
		A, _ := strconv.Atoi(parts2[i])
		sum += A
	}

	// 判定結果を出力
	if sum <= M {
		fmt.Println("Yes")
	} else {
		fmt.Println("No")
	}
}
