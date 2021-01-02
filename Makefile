.PHONY: test check clean build dist all

TOP_DIR := $(shell pwd)

# ifeq ($(FILE), $(wildcard $(FILE)))
# 	@ echo target file not found
# endif

# each tag change this
ENV_DIST_VERSION := v1.0.0
# need open proxy 1 is need 0 is default
ENV_NEED_PROXY=1

# linux windows darwin  list as: go tool dist list
ENV_DIST_OS := linux
# amd64 386
ENV_DIST_ARCH := amd64
ENV_DIST_OS_DOCKER ?= linux
ENV_DIST_ARCH_DOCKER ?= amd64

ROOT_NAME ?= golang-project-temple-base

# ignore used not matching mode
ROOT_TEST_INVERT_MATCH ?= "vendor"
# set ignore of test case like grep -v -E "vendor|fataloom" to ignore vendor and fataloom package
ROOT_TEST_LIST ?= $$(go list ./... | grep -v -E $(ROOT_TEST_INVERT_MATCH))

ROOT_BUILD_PATH ?= ./build
ROOT_DIST ?= ./dist
ROOT_REPO ?= ./dist
ROOT_LOG_PATH ?= ./log
ROOT_TEST_BUILD_PATH ?= $(ROOT_BUILD_PATH)/test/$(ENV_DIST_VERSION)
ROOT_TEST_DIST_PATH ?= $(ROOT_DIST)/test/$(ENV_DIST_VERSION)
ROOT_TEST_OS_DIST_PATH ?= $(ROOT_DIST)/$(ENV_DIST_OS)/test/$(ENV_DIST_VERSION)
ROOT_REPO_DIST_PATH ?= $(ROOT_REPO)/$(ENV_DIST_VERSION)
ROOT_REPO_OS_DIST_PATH ?= $(ROOT_REPO)/$(ENV_DIST_OS)/release/$(ENV_DIST_VERSION)

# can use as https://goproxy.io/ https://gocenter.io https://mirrors.aliyun.com/goproxy/
ENV_GO_PROXY ?= https://goproxy.cn/

# include MakeDockerRun.mk for docker run
include MakeGoMod.mk
include MakeDockerRun.mk
include MakeGoTravis.mk

checkEnvGOPATH:
ifndef GOPATH
	@echo Environment variable GOPATH is not set
	exit 1
endif

cleanBuild:
	@if [ -d ${ROOT_BUILD_PATH} ]; \
	then rm -rf ${ROOT_BUILD_PATH} && echo "~> cleaned ${ROOT_BUILD_PATH}"; \
	else echo "~> has cleaned ${ROOT_BUILD_PATH}"; \
	fi

cleanDist:
	@if [ -d ${ROOT_DIST} ]; \
	then rm -rf ${ROOT_DIST} && echo "~> cleaned ${ROOT_DIST}"; \
	else echo "~> has cleaned ${ROOT_DIST}"; \
	fi

cleanLog:
	@if [ -d ${ROOT_LOG_PATH} ]; \
	then rm -rf ${ROOT_LOG_PATH} && echo "~> cleaned ${ROOT_LOG_PATH}"; \
	else echo "~> has cleaned ${ROOT_LOG_PATH}"; \
	fi

clean: cleanBuild cleanLog
	@echo "~> clean finish"

checkTestBuildPath:
	@if [ ! -d ${ROOT_TEST_BUILD_PATH} ]; then mkdir -p ${ROOT_TEST_BUILD_PATH} && echo "~> mkdir ${ROOT_TEST_BUILD_PATH}"; fi

checkTestDistPath:
	@if [ ! -d ${ROOT_TEST_DIST_PATH} ]; then mkdir -p ${ROOT_TEST_DIST_PATH} && echo "~> mkdir ${ROOT_TEST_DIST_PATH}"; fi

checkTestOSDistPath:
	@if [ ! -d ${ROOT_TEST_OS_DIST_PATH} ]; then mkdir -p ${ROOT_TEST_OS_DIST_PATH} && echo "~> mkdir ${ROOT_TEST_OS_DIST_PATH}"; fi

checkReleaseDistPath:
	@if [ ! -d ${ROOT_REPO_DIST_PATH} ]; then mkdir -p ${ROOT_REPO_DIST_PATH} && echo "~> mkdir ${ROOT_REPO_DIST_PATH}"; fi

checkReleaseOSDistPath:
	@if [ ! -d ${ROOT_REPO_OS_DIST_PATH} ]; then mkdir -p ${ROOT_REPO_OS_DIST_PATH} && echo "~> mkdir ${ROOT_REPO_OS_DIST_PATH}"; fi

init:
	@echo "~> start init this project"
	@echo "-> check version"
	go version
	@echo "-> check env golang"
	go env
	@echo "~> you can use [ make help ] see more task"
	-GOPROXY="$(ENV_GO_PROXY)" GO111MODULE=on go mod vendor

buildMain:
	@echo "-> start build local OS"
	@go build -o build/main main.go

buildARCH:
	@echo "-> start build OS:$(ENV_DIST_OS) ARCH:$(ENV_DIST_ARCH)"
	@GOOS=$(ENV_DIST_OS) GOARCH=$(ENV_DIST_ARCH) go build -o build/main main.go

dev: buildMain
	-ENV_WEB_AUTO_HOST=true ./build/main

run: dev
	@echo "=> run start"

test:
	@echo "=> run test start"
	#=> go test -test.v $(ROOT_TEST_LIST)
	@go test -test.v $(ROOT_TEST_LIST)

testBenchmem:
	@echo "=> run test benchmem start"
	@go test -test.benchmem

cloc:
	# https://stackoverflow.com/questions/26152014/cloc-ignore-exclude-list-file-clocignore
	cloc --exclude-list-file=.clocignore .

helpProjectRoot:
	@echo "Help: Project root Makefile"
	@echo "-- now build name: $(ROOT_NAME) version: $(ENV_DIST_VERSION)"
	@echo "-- distTestOS or distReleaseOS will out abi as: $(ENV_DIST_OS) $(ENV_DIST_ARCH) --"
	@echo ""
	@echo "~> make init         - check base env of this project"
	@echo "~> make clean        - remove binary file and log files"
	@echo "~> make test         - run test case ignore --invert-match $(ROOT_TEST_INVERT_MATCH)"
	@echo "~> make testBenchmem - run go test benchmem case all"
	@echo "~> make dev          - run as develop"

help: helpGoMod helpDockerRun helpGoTravis helpProjectRoot
	@echo ""
	@echo "-- more info see Makefile include: MakeGoMod.mk MakeDockerRun.mk --"
