package stack_test

import (
	"math/rand"
	"time"
)

const randomStrLetterCnt = 62

var randomStrLetters = []byte("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")

// randomStr
//
//	new random string by cnt
func randomStr(cnt uint) string {
	result := make([]byte, cnt)
	rs := rand.New(rand.NewSource(time.Now().Unix()))
	for i := range result {
		index := rs.Intn(randomStrLetterCnt)
		result[i] = randomStrLetters[index]
	}
	return string(result)
}

// randomInt
//
//	new random int by max
func randomInt(max int) int {
	rs := rand.New(rand.NewSource(time.Now().Unix()))
	return rs.Intn(max)
}
