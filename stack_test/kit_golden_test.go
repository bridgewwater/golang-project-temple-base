package stack_test

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"testing"
)

// test case file tools start

// goldenDataSaveFast
//
//	save data to golden file
//	style as: "TestFuncName/extraName.golden"
func goldenDataSaveFast(t *testing.T, data interface{}, extraName string) error {
	marshal, errJson := json.Marshal(data)
	if errJson != nil {
		t.Fatal(errJson)
	}
	return goldenDataSave(t, marshal, extraName, os.FileMode(0766))
}

// goldenDataSave
//
//	save data to golden file
//	style as: "TestFuncName/extraName.golden"
func goldenDataSave(t *testing.T, data []byte, extraName string, fileMod fs.FileMode) error {
	testDataFolderFullPath, err := getOrCreateTestDataFolderFullPath()
	if err != nil {
		return fmt.Errorf("try goldenDataSave err: %v", err)
	}
	testDataFolder := filepath.Join(testDataFolderFullPath, t.Name())
	if !pathExistsFast(testDataFolder) {
		errMk := mkdir(testDataFolder)
		if errMk != nil {
			t.Fatal(errMk)
		}
	}
	savePath := filepath.Join(testDataFolderFullPath, t.Name(), fmt.Sprintf("%s.golden", extraName))
	var str bytes.Buffer
	err = json.Indent(&str, data, "", "  ")
	if err != nil {
		return err
	}
	err = writeFileByByte(savePath, str.Bytes(), fileMod, true)
	if err != nil {
		return fmt.Errorf("try goldenDataSave at path: %s err: %v", savePath, err)
	}
	return nil
}

// goldenDataReadAsByte
//
//	read golden file as byte
//	style as: "TestFuncName/extraName.golden"
func goldenDataReadAsByte(t *testing.T, extraName string) ([]byte, error) {
	testDataFolderFullPath, err := getOrCreateTestDataFolderFullPath()
	if err != nil {
		return nil, fmt.Errorf("try goldenDataReadAsByte err: %v", err)
	}

	savePath := filepath.Join(testDataFolderFullPath, t.Name(), fmt.Sprintf("%s.golden", extraName))

	fileAsByte, err := readFileAsByte(savePath)
	if err != nil {
		return nil, fmt.Errorf("try goldenDataReadAsByte err: %v", err)
	}
	return fileAsByte, nil
}

// goldenDataReadAsType
//
//	read golden file as type
//	style as: "TestFuncName/extraName.golden"
func goldenDataReadAsType(t *testing.T, extraName string, v interface{}) error {
	readAsByte, err := goldenDataReadAsByte(t, extraName)
	if err != nil {
		t.Fatal(err)
	}
	return json.Unmarshal(readAsByte, v)
}
