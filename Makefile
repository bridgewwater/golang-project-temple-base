.PHONY: test check clean build dist all

TOP_DIR := $(shell pwd)

# ifeq ($(FILE), $(wildcard $(FILE)))
# 	@ echo target file not found
# endif

ROOT_BUILD_PATH ?= ./build

checkEnvGo:
ifndef GOPATH
	@echo Environment variable GOPATH is not set
	exit 1
endif

init: checkEnvGo
	@echo "~> start init this project"
	@echo "-> check version"
	-go version
	@echo "-> check env set"
	-go env
	@echo "~> you can use [ make help ] see more task"

cleanBuild:
	@if [ -d ${ROOT_BUILD_PATH} ]; then rm -rf ${ROOT_BUILD_PATH} && echo "~> cleaned ${ROOT_BUILD_PATH}"; else echo "~> has cleaned ${ROOT_BUILD_PATH}"; fi

clean: cleanBuild
	@echo "~> clean finish"

buildMain:
	@go build -o build/main main.go

run: buildMain
	-./build/main

help:
	@echo "make init - check base env of this project"
	@echo "make clean - remove binary file and vim swp files"
	@echo "run main.go"