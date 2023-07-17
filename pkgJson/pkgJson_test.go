package pkgJson

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

const (
	jsonInfo = `
{
  "version": "1.2.3",
  "name": "mock",
  "author": {
    "name": "bridgewwater",
    "email": "bridgewwatergmppt@gmail.com",
    "url": "https://github.com/bridgewwater/golang-project-temple-base"
  }
}
`
	jsonInfoGoStyle = `
{
  "version": "v1.2.3",
  "name": "mock go style",
  "author": {
    "name": "bridgewwater",
    "email": "bridgewwatergmppt@gmail.com",
    "url": "https://github.com/bridgewwater/golang-project-temple-base"
  },
  "description": "mock go style",
  "homepage": "https://github.com/bridgewwater/golang-project-temple-base#readme"
}
`
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

	InitPkgJsonContent(jsonInfo)
	jsonVersion := GetPackageJsonVersion()
	assert.Equal(t, "1.2.3", jsonVersion)
	versionGoStyle := GetPackageJsonVersionGoStyle(false)
	assert.Equal(t, "v1.2.3", versionGoStyle)
}

func TestGetPackageJsonVersionGoStyle(t *testing.T) {
	pkgJson = nil
	InitPkgJsonContent(jsonInfoGoStyle)
	versionGoStyle := GetPackageJsonVersionGoStyle(false)
	assert.Equal(t, "v1.2.3", versionGoStyle)
	SetVersionPrefixGoStyle("go-")
	goNewStyle := GetPackageJsonVersionGoStyle(true)
	assert.Equal(t, "go-1.2.3", goNewStyle)
	SetVersionPrefixGoStyle("")
	assert.Equal(t, "1.2.3", GetPackageJsonVersionGoStyle(true))
}

func TestPanicInitPkgJsonContentError(t *testing.T) {
	// mock TestPanicInitPkgJsonContentError

	if !assert.Panics(t, func() {
		// do TestPanicInitPkgJsonContentError
		InitPkgJsonContent("")
	}) {
		// verify TestPanicInitPkgJsonContentError
		t.Fatalf("TestPanicInitPkgJsonContentError should panic")
	}
	if !assert.Panics(t, func() {
		// do TestPanicInitPkgJsonContentError
		InitPkgJsonContent(`{
  "name": "foo",
  "version": "1.2.3",
}
`)
	}) {
		// verify TestPanicInitPkgJsonContentError
		t.Fatalf("TestPanicInitPkgJsonContentError should panic")
	}
}

func TestPanicPackageJsonLoadName(t *testing.T) {
	// mock TestPanicPackageJsonLoadName

	errString := "pkgJson parse package.json name is empty"

	if !assert.PanicsWithError(t, errString, func() {
		// do TestPanicPackageJsonLoadName
		InitPkgJsonContent(`{
  "version": "1.2.3"
}
`)
	}) {
		// verify TestPanicPackageJsonLoadName
		t.Fatalf("TestPanicPackageJsonLoadName should panic")
	}
}

func TestPanicPackageJsonLoadVersion(t *testing.T) {
	// mock TestPanicPackageJsonLoadVersion

	errString := "pkgJson parse package.json version is empty"

	if !assert.PanicsWithError(t, errString, func() {
		// do TestPanicPackageJsonLoadVersion
		InitPkgJsonContent(`{
  "name": "foo"
}
`)
	}) {
		// verify TestPanicPackageJsonLoadVersion
		t.Fatalf("TestPanicPackageJsonLoadVersion should panic")
	}
}

func TestPanicPackageJsonLoadAuthor(t *testing.T) {
	// mock TestPanicPackageJsonLoadAuthor

	errString := "pkgJson parse package.json author name is empty"

	if !assert.PanicsWithError(t, errString, func() {
		// do TestPanicPackageJsonLoadAuthor
		InitPkgJsonContent(`{
  "name": "foo",
  "version": "1.2.3"
}
`)
	}) {
		// verify TestPanicPackageJsonLoadAuthor
		t.Fatalf("TestPanicPackageJsonLoadAuthor should panic")
	}

	errString = "pkgJson parse package.json author email is empty"

	if !assert.PanicsWithError(t, errString, func() {
		// do TestPanicPackageJsonLoadAuthor
		InitPkgJsonContent(`{
  "name": "foo",
  "version": "1.2.3",
  "author": {
    "name": "bridgewwater"
  }
}
`)
	}) {
		// verify TestPanicPackageJsonLoadAuthor
		t.Fatalf("TestPanicPackageJsonLoadAuthor should panic")
	}
}

func TestGetPackageJsonName(t *testing.T) {
	t.Logf("~> mock GetPackageJsonName")
	// mock GetPackageJsonName
	InitPkgJsonContent(jsonInfo)

	t.Logf("~> do GetPackageJsonName")
	// do GetPackageJsonName

	// verify GetPackageJsonName
	assert.Equal(t, "mock", GetPackageJsonName())
}

func TestGetPackageJsonAuthor(t *testing.T) {
	t.Logf("~> mock GetPackageJsonAuthor")
	// mock GetPackageJsonAuthorName
	InitPkgJsonContent(jsonInfo)

	t.Logf("~> do GetPackageJsonAuthor")
	// do GetPackageJsonAuthorName

	// verify GetPackageJsonAuthorName
	assert.Equal(t, "bridgewwater", GetPackageJsonAuthor().Name)
	assert.Equal(t, "bridgewwatergmppt@gmail.com", GetPackageJsonAuthor().Email)
}
func TestGetPackageJsonDescription(t *testing.T) {
	t.Logf("~> mock GetPackageJsonDescription")
	// mock GetPackageJsonDescription
	InitPkgJsonContent(jsonInfo)

	t.Logf("~> do GetPackageJsonDescription")
	// do GetPackageJsonDescription

	// verify GetPackageJsonDescription
	assert.Equal(t, "", GetPackageJsonDescription())

	InitPkgJsonContent(jsonInfoGoStyle)
	assert.Equal(t, "mock go style", GetPackageJsonDescription())
}

func TestGetPackageJsonHomepage(t *testing.T) {
	t.Logf("~> mock GetPackageJsonHomepage")
	// mock GetPackageJsonHomepage
	InitPkgJsonContent(jsonInfo)

	t.Logf("~> do GetPackageJsonHomepage")
	// do GetPackageJsonHomepage

	// verify GetPackageJsonHomepage
	assert.Equal(t, "", GetPackageJsonHomepage())

	InitPkgJsonContent(jsonInfoGoStyle)
	assert.Equal(t, "https://github.com/bridgewwater/golang-project-temple-base#readme", GetPackageJsonHomepage())
}
