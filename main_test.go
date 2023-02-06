package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_assert_equal(t *testing.T) {
	main()
	assert.Equal(t, true, true)
}
