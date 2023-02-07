package pkgJson

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestGetPackageJsonVersion(t *testing.T) {
	// mock GetPackageJsonVersion
	defer func() {
		if r := recover(); r != nil {
			t.Logf("do TestGetPackageJsonVersion err: %v", r)
			return
		}
	}()
	t.Logf("~> mock GetPackageJsonVersion")
	// do GetPackageJsonVersion
	pkgJson = nil
	t.Logf("~> do GetPackageJsonVersion")
	jsonVersion := GetPackageJsonVersion()
	t.Logf("jsonVersion %s", jsonVersion)
	// verify GetPackageJsonVersion
	assert.Equal(t, "", "")
}

func TestInitPkgJsonVersion(t *testing.T) {
	pkgJson = nil
	InitPkgJsonContent(`
{
  "version": "1.2.3"
}
`)
	jsonVersion := GetPackageJsonVersion()
	assert.Equal(t, "1.2.3", jsonVersion)
	versionGoStyle := GetPackageJsonVersionGoStyle()
	assert.Equal(t, "v1.2.3", versionGoStyle)
	SetVersionPrefixGoStyle("go-")
	goNewStyle := GetPackageJsonVersionGoStyle()
	assert.Equal(t, "go-1.2.3", goNewStyle)
}

func TestGetPackageJsonVersionGoStyle(t *testing.T) {
	pkgJson = nil
	InitPkgJsonContent(`
{
  "version": "v1.2.3"
}
`)
	SetVersionPrefixGoStyle("v")
	versionGoStyle := GetPackageJsonVersionGoStyle()
	assert.Equal(t, "v1.2.3", versionGoStyle)
}

func TestInitPkgJsonContentError(t *testing.T) {
	defer func() {
		if r := recover(); r != nil {
			t.Logf("do test case TestInitPkgJsonContentError err: %v", r)
			return
		}
	}()
	pkgJson = nil
	InitPkgJsonContent(`

  "version": "1.2.3",
}
`)
	GetPackageJsonVersion()
}
