package stack_test

import (
	"fmt"
	"github.com/sinlov-go/unittest-kit/env_kit"
	"github.com/sinlov-go/unittest-kit/unittest_file_kit"
	"path/filepath"
	"runtime"
)

const (
	keyEnvDebug  = "CI_DEBUG"
	keyEnvCiNum  = "CI_NUMBER"
	keyEnvCiKey  = "CI_KEY"
	keyEnvCiKeys = "CI_KEYS"
)

var (
	// testBaseFolderPath
	//  test base dir will auto get by package init()
	testBaseFolderPath = ""
	testGoldenKit      *unittest_file_kit.TestGoldenKit

	envDebug  = false
	envCiNum  = 0
	envCiKey  = ""
	envCiKeys []string
)

func init() {
	testBaseFolderPath, _ = getCurrentFolderPath()

	envDebug = env_kit.FetchOsEnvBool(keyEnvDebug, false)
	envCiNum = env_kit.FetchOsEnvInt(keyEnvCiNum, 0)
	envCiKey = env_kit.FetchOsEnvStr(keyEnvCiKey, "")
	envCiKeys = env_kit.FetchOsEnvArray(keyEnvCiKeys)

	testGoldenKit = unittest_file_kit.NewTestGoldenKit(testBaseFolderPath)
}

// test case basic tools start
// getCurrentFolderPath
//
//	can get run path this golang dir
func getCurrentFolderPath() (string, error) {
	_, file, _, ok := runtime.Caller(1)
	if !ok {
		return "", fmt.Errorf("can not get current file info")
	}
	return filepath.Dir(file), nil
}

// test case basic tools end
