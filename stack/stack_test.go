package stack

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestNewStack(t *testing.T) {
	stack := NewStack()
	stack.Push(0)
	stack.Push(1)
	stack.Push(2)
	stack.Push(3)
	stLen := stack.Len()
	assert.Equal(t, stLen, 4)
	t.Logf("stack len %v\n", stLen)
	value := stack.Peak().(int)
	assert.Equal(t, value, 3)
	t.Logf("stack Peak value %v\n", value)
	value = stack.Pop().(int)
	assert.Equal(t, value, 3)
	t.Logf("stack Pop value %v\n", value)
	afterPopLen := stack.Len()
	assert.Equal(t, afterPopLen, 3)
	t.Logf("stack after Pop Len %v\n", value)
	afterPopPeak := stack.Peak().(int)
	t.Logf("stack after Pop Peak %v\n", afterPopPeak)
	isEmpty := stack.Empty()
	assert.NotEqual(t, isEmpty, true)
	t.Logf("now stack isEmpty %v\n", isEmpty)
	stack.Pop()
	stack.Pop()
	stack.Pop()
	nowIsEmpty := stack.Empty()
	assert.Equal(t, nowIsEmpty, true)
	t.Logf("now stack isEmpty %v\n", nowIsEmpty)
	nilValue := stack.Pop()
	assert.Equal(t, nilValue, nil)
	t.Logf("Empty stack Pop nil value %v\n", nilValue)
}
