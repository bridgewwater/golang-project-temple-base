//go:build !test

package main

import (
	"flag"
	"github.com/bridgewwater/golang-project-temple-base"
	"github.com/bridgewwater/golang-project-temple-base/internal/pkg_kit"
	"log"
	"os"
)

var cliVersion *string
var serverPort = flag.String("serverPort", "49002", "http service address")

var buildID string

func init() {
	if buildID == "" {
		buildID = "unknown"
	}
}

func main() {
	log.Printf("-> env:ENV_WEB_AUTO_HOST %s", os.Getenv("ENV_WEB_AUTO_HOST"))
	pkg_kit.InitPkgJsonContent(golang_project_temple_base.PackageJson)
	cliVersion = flag.String("version", pkg_kit.GetPackageJsonVersionGoStyle(false), "show version of this cli")
	flag.Parse()
	log.Printf("=> now version %v", *cliVersion)
	log.Printf("-> run serverPort %v", *serverPort)
	log.Printf("-> buildID %s", buildID)
}
