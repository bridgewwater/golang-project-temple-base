package stack_test

import (
	"errors"
	"github.com/sebdah/goldie/v2"
	"github.com/stretchr/testify/assert"
	"testing"
)

type goldieDataInType struct {
	Foo string
	Bar int
}

type goldieDataOutType struct {
	Foo string
	Bar int
}

var goldDataInEmpty = errors.New("goldieDataInType is empty")

func goldieDataMock(int goldieDataInType) (*goldieDataOutType, error) {
	if int.Foo == "" {
		return nil, goldDataInEmpty
	}
	return &goldieDataOutType{
		Foo: int.Foo,
		Bar: int.Bar,
	}, nil
}

func TestGoldieData(t *testing.T) {
	tests := []struct {
		name    string
		c       goldieDataInType
		wantErr error
	}{
		{
			name: "sample",
			c: goldieDataInType{
				Foo: "foo",
				Bar: 2,
			},
		},
		{
			name:    "err",
			wantErr: goldDataInEmpty,
		},
	}
	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			g := goldie.New(t,
				goldie.WithDiffEngine(goldie.ClassicDiff), // default: goldie.ClassicDiff
			)

			gotResult, gotErr := goldieDataMock(tc.c)
			assert.Equal(t, tc.wantErr, gotErr)
			if tc.wantErr != nil {
				return
			}
			g.AssertJson(t, t.Name(), gotResult)
		})
	}
}

func Test_goldenDataSaveFast(t *testing.T) {
	// mock _goldenDataSaveFast
	const extraName = "_goldenDataSaveFast"
	type testData struct {
		Name string
	}
	var fooData = testData{
		Name: "foo",
	}
	t.Logf("~> mock _goldenDataSaveFast")
	err := goldenDataSaveFast(t, fooData, extraName)
	if err != nil {
		t.Fatal(err)
	}
	// do _goldenDataSaveFast
	t.Logf("~> do _goldenDataSaveFast")
	var readData testData
	err = goldenDataReadAsType(t, extraName, &readData)
	if err != nil {
		t.Fatal(err)
	}
	// verify _goldenDataSaveFast
	assert.Equal(t, fooData.Name, readData.Name)
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
