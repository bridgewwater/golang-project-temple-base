package main

import (
	"flag"
	"log"
)

var cliVersion = flag.String("version", "v0.1.2", "show version of this cli")
var serverPort = flag.String("serverPort", "49002", "http service address")

func main() {
	flag.Parse()
	log.Printf("=> now version %v", *cliVersion)
	log.Printf("-> run serverPort %v", *serverPort)
}
