package main

import (
	_ "embed"
	"flag"
	"github.com/bridgewwater/golang-project-temple-base/pkgJson"
	"log"
)

//go:embed package.json
var packageJson string

var cliVersion *string
var serverPort = flag.String("serverPort", "49002", "http service address")

func main() {
	pkgJson.InitPkgJsonContent(packageJson)
	cliVersion = flag.String("version", pkgJson.GetPackageJsonVersionGoStyle(), "show version of this cli")
	flag.Parse()
	log.Printf("=> now version %v", *cliVersion)
	log.Printf("-> run serverPort %v", *serverPort)
}
