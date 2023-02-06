package main

import (
	"os"
	"os/exec"
	"testing"
)

func Test_assert_equal(t *testing.T) {
	main()
	cmd := exec.Command(os.Args[0], "-h")
	cmd.Env = append(os.Environ(), "ENV_WEB_AUTO_HOST=true")
	err := cmd.Run()
	if err != nil {
		t.Fatal(err)
	}

	cmdFail := exec.Command(os.Args[0], "--error.arg")
	cmdFail.Env = append(os.Environ(), "ENV_WEB_AUTO_HOST=true")
	err = cmdFail.Run()
	if e, ok := err.(*exec.ExitError); ok && !e.Success() {
		return
	}
	t.Fatalf("Process run with err %v, want os.Exit(1)", err)
}
