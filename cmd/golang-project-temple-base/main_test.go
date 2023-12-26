package main

import (
	"bytes"
	"errors"
	"github.com/stretchr/testify/assert"
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

}

func Test_package_main_error(t *testing.T) {
	cmdFail := exec.Command(os.Args[0], "--error.arg")
	cmdFail.Env = append(os.Environ(), "ENV_WEB_AUTO_HOST=true")
	err := cmdFail.Run()
	var e *exec.ExitError
	if errors.As(err, &e) {
		assert.False(t, e.Success())
		assert.Equal(t, 2, e.ExitCode())
		return
	}
	t.Fatalf("Process run with err %v, want os.Exit(2)", err)
}
