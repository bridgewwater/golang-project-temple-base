package stack

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func BenchmarkStack(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		stack := NewStack()
		stack.Push(0)
		stack.Push(1)
		stack.Push(2)
		stack.Push(3)
		stLen := stack.Len()
		assert.Equal(b, stLen, 4)
		value := stack.Peak().(int)
		assert.Equal(b, value, 3)
		value = stack.Pop().(int)
		assert.Equal(b, value, 3)
		afterPopLen := stack.Len()
		assert.Equal(b, afterPopLen, 3)
		afterPopPeak := stack.Peak().(int)
		assert.Equal(b, afterPopPeak, 2)
		isEmpty := stack.Empty()
		assert.NotEqual(b, isEmpty, true)
		stack.Pop()
		stack.Pop()
		stack.Pop()
		nowIsEmpty := stack.Empty()
		assert.Equal(b, nowIsEmpty, true)
		nilValue := stack.Pop()
		assert.Equal(b, nilValue, nil)
	}
	b.StopTimer()
}
