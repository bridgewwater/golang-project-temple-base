package stack_test

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func Test_goldenDataSaveFast(t *testing.T) {
	// mock _goldenDataSaveFast
	const extraName = "_goldenDataSaveFast"
	var saveDataStr = "foo data"
	t.Logf("~> mock _goldenDataSaveFast")
	err := goldenDataSaveFast(t, []byte(saveDataStr), extraName)
	if err != nil {
		t.Fatal(err)
	}
	// do _goldenDataSaveFast
	t.Logf("~> do _goldenDataSaveFast")
	readAsByte, err := goldenDataReadAsByte(t, extraName)
	if err != nil {
		t.Fatal(err)
	}
	// verify _goldenDataSaveFast
	assert.Equal(t, saveDataStr, string(readAsByte))
}

func Test_test_data_json(t *testing.T) {
	// mock _test_data_json
	t.Logf("~> mock _test_data_json")

	testDataJsonFullPath, err := getOrCreateTestDataFullPath("json", "basic", "test_data.json")
	if err != nil {
		t.Fatal(err)
	}

	type TestData struct {
		Debug         bool     `json:"debug,omitempty"`
		CiBuildNumber int      `json:"ci_build_number,omitempty"`
		CiKey         string   `json:"ci_key"`
		CiKeys        []string `json:"ci_keys,omitempty"`
	}
	var data = TestData{
		Debug:         envDebug,
		CiBuildNumber: envCiNum,
		CiKey:         envCiKey,
		CiKeys:        envCiKeys,
	}

	// do _test_data_json
	err = writeFileAsJsonBeauty(testDataJsonFullPath, data, true)
	if err != nil {
		t.Fatal(err)
	}
	t.Logf("~> do _test_data_json")

	var readData TestData
	err = readFileAsJson(testDataJsonFullPath, &readData)
	if err != nil {
		t.Fatal(err)
	}
	// verify _test_data_json
	assert.Equal(t, data.CiBuildNumber, readData.CiBuildNumber)
}
