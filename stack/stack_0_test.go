package stack

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestStack(t *testing.T) {
	// mock
	stack := NewStack()
	stack.Push(1)
	stack.Push(2)
	stack.Push(3)
	stack.Push(4)

	lenStack := stack.Len()
	assert.Equal(t, 4, lenStack, "stack.Len() failed.")

	value := stack.Peak().(int)
	assert.Equal(t, 4, value, "stack.Peak() failed.")

	value = stack.Pop().(int)
	assert.Equal(t, 4, value, "stack.Pop() failed.")

	lenStack = stack.Len()
	assert.Equal(t, 3, lenStack, "stack.Len() failed.")

	value = stack.Peak().(int)
	assert.Equal(t, 3, value, "stack.Peak() failed.")

	value = stack.Pop().(int)
	assert.Equal(t, 3, value, "stack.Pop() failed.")

	value = stack.Pop().(int)
	assert.Equal(t, 2, value, "stack.Pop() failed.")

	empty := stack.Empty()
	assert.Falsef(t, empty, "stack.Empty() failed.")

	value = stack.Pop().(int)
	assert.Equal(t, 1, value, "stack.Pop() failed.")

	empty = stack.Empty()
	assert.Truef(t, empty, "stack.Empty() failed.")

	nilValue := stack.Peak()
	assert.Nilf(t, nilValue, "stack.Peak() failed. Got %d", nilValue)

	nilValue = stack.Pop()
	assert.Nilf(t, nilValue, "stack.Pop() failed. Got %d", nilValue)

	lenStack = stack.Len()
	assert.Equalf(t, 0, lenStack, "stack.Len() failed. Got %d", lenStack)
}
