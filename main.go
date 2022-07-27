package main

import (
	"flag"
	"log"
)

var serverPort = flag.String("serverPort", "49002", "http service address")

func main() {
	flag.Parse()
	log.Printf("-> run serverPort %v", *serverPort)
}
