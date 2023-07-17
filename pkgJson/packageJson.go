package pkgJson

import (
	"encoding/json"
	"fmt"
	"regexp"
	"strings"
)

var (
	pkgJsonContent          string
	pkgVersionPrefixGoStyle = "v"
	pkgJson                 *PkgJson
)

// InitPkgJsonContent
//
//	initialization will change the global variable pkgJsonContent
func InitPkgJsonContent(content string) {
	pkgJsonContent = content
	initJsonContent()
}

func SetVersionPrefixGoStyle(prefix string) {
	pkgVersionPrefixGoStyle = prefix
}

var regNoNumberAndDot *regexp.Regexp

func replaceNoNumberAndDot(ctx string) string {
	if regNoNumberAndDot == nil {
		regNoNumberAndDot, _ = regexp.Compile("[^0-9.]+")
	}
	return regNoNumberAndDot.ReplaceAllString(ctx, "")
}

func GetPackageJsonVersionGoStyle(onlyKeepVersion bool) string {
	jsonVersion := GetPackageJsonVersion()
	if onlyKeepVersion {
		jsonVersion = replaceNoNumberAndDot(jsonVersion)
	}
	if pkgVersionPrefixGoStyle != "" && !strings.HasPrefix(jsonVersion, pkgVersionPrefixGoStyle) {
		return fmt.Sprintf("%s%s", pkgVersionPrefixGoStyle, jsonVersion)
	}
	return jsonVersion
}

func GetPackageJsonName() string {
	checkPackageJsonLoad()
	return pkgJson.Name
}

func GetPackageJsonVersion() string {
	checkPackageJsonLoad()
	return pkgJson.Version
}

func GetPackageJsonAuthor() Author {
	checkPackageJsonLoad()
	return pkgJson.Author
}

func GetPackageJsonHomepage() string {
	return pkgJson.Homepage
}

func GetPackageJsonDescription() string {
	checkPackageJsonLoad()
	return pkgJson.Description
}

func checkPackageJsonLoad() {
	if pkgJsonContent == "" {
		panic(fmt.Errorf("pkgJson must use InitPkgJsonContent(content), then use"))
	}
	if pkgJson == nil {
		initJsonContent()
	}
}

func initJsonContent() {
	if pkgJsonContent == "" {
		panic(fmt.Errorf("InitPkgJsonContent(content) , can not be empty content"))
	}
	pkgJ := PkgJson{}
	err := json.Unmarshal([]byte(pkgJsonContent), &pkgJ)
	if err != nil {
		panic(fmt.Errorf("pkgJson parse package.json err: %v", err))
	}
	if pkgJ.Name == "" {
		panic(fmt.Errorf("pkgJson parse package.json name is empty"))
	}
	if pkgJ.Version == "" {
		panic(fmt.Errorf("pkgJson parse package.json version is empty"))
	}
	if pkgJ.Author.Name == "" {
		panic(fmt.Errorf("pkgJson parse package.json author name is empty"))
	}
	if pkgJ.Author.Email == "" {
		panic(fmt.Errorf("pkgJson parse package.json author email is empty"))
	}
	pkgJson = &pkgJ
}

// PkgJson
//
//	struct of package.json
type PkgJson struct {
	// Name
	//
	Name string `json:"name"`

	// Version
	//
	Version string `json:"version"`

	// Author
	//
	Author Author `json:"author"`

	// Description
	//
	Description string `json:"description,omitempty"`

	// Directories
	//
	Directories Directories `json:"directories,omitempty"`

	// Repository
	//
	Repository Repository `json:"repository,omitempty"`

	// Keywords
	//
	Keywords []string `json:"keywords,omitempty"`

	// License
	//
	License string `json:"license,omitempty"`

	// Bugs
	//
	Bugs Bugs `json:"bugs,omitempty"`

	// Homepage
	//
	Homepage string `json:"homepage,omitempty"`
}

// Directories
// struct
type Directories struct {

	// Doc
	//
	Doc string `json:"doc,omitempty"`
}

// Repository
// struct
type Repository struct {

	// Type
	//
	Type string `json:"type,omitempty"`

	// Url
	//
	Url string `json:"url,omitempty"`
}

// Author
// struct
type Author struct {

	// Name
	//
	Name string `json:"name,omitempty"`

	// Email
	//
	Email string `json:"email,omitempty"`

	// Url
	//
	Url string `json:"url,omitempty"`
}

// Bugs
// struct
type Bugs struct {

	// Url
	//
	Url string `json:"url,omitempty"`
}
