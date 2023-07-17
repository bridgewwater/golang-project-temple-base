//go:build !test

package main

import (
	"flag"
	"github.com/bridgewwater/golang-project-temple-base"
	"log"
	"os"

	"github.com/bridgewwater/golang-project-temple-base/pkgJson"
)

var cliVersion *string
var serverPort = flag.String("serverPort", "49002", "http service address")

func main() {
	log.Printf("-> env:ENV_WEB_AUTO_HOST %s", os.Getenv("ENV_WEB_AUTO_HOST"))
	pkgJson.InitPkgJsonContent(golang_project_temple_base.PackageJson)
	cliVersion = flag.String("version", pkgJson.GetPackageJsonVersionGoStyle(false), "show version of this cli")
	flag.Parse()
	log.Printf("=> now version %v", *cliVersion)
	log.Printf("-> run serverPort %v", *serverPort)
}
