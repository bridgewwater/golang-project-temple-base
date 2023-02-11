package main

import (
	"bytes"
	"os"
	"os/exec"
	"testing"
)

func Test_package_main(t *testing.T) {

	cmd := exec.Command(os.Args[0], "-h")
	cmd.Env = append(os.Environ(), "ENV_WEB_AUTO_HOST=true")
	var outStd bytes.Buffer
	cmd.Stdout = &outStd
	var errStd bytes.Buffer
	cmd.Stderr = &errStd
	err := cmd.Run()
	if err != nil {
		t.Fatal(err)
	}
	t.Logf("-h result: %s\n%s", outStd.String(), errStd.String())

	cmdFail := exec.Command(os.Args[0], "--error.arg")
	cmdFail.Env = append(os.Environ(), "ENV_WEB_AUTO_HOST=true")
	err = cmdFail.Run()
	if e, ok := err.(*exec.ExitError); ok && !e.Success() {
		return
	}
	t.Fatalf("Process run with err %v, want os.Exit(1)", err)
}
