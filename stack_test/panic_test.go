package stack_test

import (
	"fmt"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestExampleShouldPanicFast(t *testing.T) {
	// mock TestExampleShouldPanicFast

	if !assert.Panics(t, func() {
		// do TestExampleShouldPanicFast
		panic("mock panic")
	}) {
		// verify TestExampleShouldPanicFast
		t.Fatalf("TestExampleShouldPanicFast should panic")
	}
}

func TestExampleShouldPanicErrorWithValue(t *testing.T) {
	// mock TestExampleShouldPanicErrorWithValue

	errorValue := "at the disco"
	if !assert.PanicsWithValue(t, errorValue, func() {
		// do TestExampleShouldPanicErrorWithValue
		panic(errorValue)
	}) {
		// verify TestExampleShouldPanicErrorWithValue
		t.Fatalf("TestExampleShouldPanicErrorWithValue should panic")
	}
}

func TestExampleShouldPanicErrorWithStr(t *testing.T) {
	// mock TestExampleShouldPanicErrorWithStr

	errString := "new error"
	if !assert.PanicsWithError(t, errString, func() {
		// do TestExampleShouldPanicErrorWithStr
		panic(fmt.Errorf(errString))
	}) {
		// verify TestExampleShouldPanicErrorWithStr
		t.Fatalf("TestExampleShouldPanic should panic")
	}
}
