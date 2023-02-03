package main

import (
	"flag"
	"log"
)

const (
	Version = "v0.1.2"
)

var cliVersion = flag.String("version", Version, "show version of this cli")
var serverPort = flag.String("serverPort", "49002", "http service address")

func main() {
	flag.Parse()
	log.Printf("=> now version %v", *cliVersion)
	log.Printf("-> run serverPort %v", *serverPort)
}
