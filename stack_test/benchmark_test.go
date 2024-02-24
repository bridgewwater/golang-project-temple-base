package stack_test

import (
	"bytes"
	"fmt"
	"github.com/sinlov-go/unittest-kit/unittest_file_kit"
	"github.com/sinlov-go/unittest-kit/unittest_random_kit"
	"github.com/stretchr/testify/assert"
	"strings"
	"testing"
)

// benchmark_test

var strData []string

func initStrData() {
	if len(strData) == 0 {
		for i := 0; i < 200; i++ {
			strData = append(strData, unittest_random_kit.RandomStr(300))
		}
	}
}

func TestRandomStr(t *testing.T) {
	for i := 0; i < 10; i++ {
		t.Logf("randomStr: %s", unittest_random_kit.RandomStr(16))
	}
}

func TestRandomInt(t *testing.T) {
	for i := 0; i < 10; i++ {
		t.Logf("randomInt: %d", unittest_random_kit.RandomInt(1024))
	}
}

func BenchmarkExampleBasic(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		testDataFolderFullPath, err := testGoldenKit.GetOrCreateTestDataFolderFullPath()
		if err != nil {
			b.Fatal(err)
		}
		assert.Truef(b, unittest_file_kit.PathExistsFast(testDataFolderFullPath), "want BenchmarkExampleBasic exist: %s", testDataFolderFullPath)
	}
	b.StopTimer()
}

func BenchmarkExampleParallel(b *testing.B) {
	b.ResetTimer()
	b.RunParallel(func(pb *testing.PB) {
		for pb.Next() {
			assert.Equal(b, 10, len(unittest_random_kit.RandomStr(10)))
		}
	})
	b.StopTimer()
}

func demoCunt() bool {
	return unittest_random_kit.RandomInt(10) > 5
}

func BenchmarkExampleTimer(b *testing.B) {
	// mock ExampleTimer

	// reset counter
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		// do ExampleTimer
		flag := demoCunt()
		if flag {
			// need for timing
			//b.Log("StartTimer")
			b.StartTimer()
		} else {
			// no need for timing
			//b.Log("StopTimer")
			b.StopTimer()
		}
		// verify ExampleTimer
		assert.Truef(b, true, "please fix this")
	}
	b.StopTimer()
}

func BenchmarkStringsAdd(b *testing.B) {
	initStrData()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		var s string
		for _, v := range strData {
			s += v
		}
	}
	b.StopTimer()
}

func BenchmarkStringsFmt(b *testing.B) {
	initStrData()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		var _ string = fmt.Sprint(strData)
	}
	b.StopTimer()
}

func BenchmarkStringsJoin(b *testing.B) {
	initStrData()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_ = strings.Join(strData, "")
	}
	b.StopTimer()
}

func BenchmarkStringsBuffer(b *testing.B) {
	initStrData()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		n := len("") * (len(strData) - 1)
		for i := 0; i < len(strData); i++ {
			n += len(strData[i])
		}
		var s bytes.Buffer
		s.Grow(n)
		for _, v := range strData {
			s.WriteString(v)
		}
		_ = s.String()
	}
	b.StopTimer()
}

func BenchmarkStringsBuilder(b *testing.B) {
	initStrData()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		n := len("") * (len(strData) - 1)
		for i := 0; i < len(strData); i++ {
			n += len(strData[i])
		}
		var b strings.Builder
		b.Grow(n)
		b.WriteString(strData[0])
		for _, s := range strData[1:] {
			b.WriteString("")
			b.WriteString(s)
		}
		_ = b.String()
	}
	b.StopTimer()
}
