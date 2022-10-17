.PHONY: test check clean build dist all
#TOP_DIR := $(shell pwd)
# each tag change this
ENV_DIST_VERSION := v1.15.6

ROOT_NAME ?= golang-project-temple-base

# ignore used not matching mode
ROOT_TEST_INVERT_MATCH ?= "vendor|go_fatal_error|robotn|shirou|go_robot"
# set ignore of test case like grep -v -E "vendor|go_fatal_error" to ignore vendor and go_fatal_error package
ROOT_TEST_LIST := $$(go list ./... | grep -v -E $(ROOT_TEST_INVERT_MATCH))
# test max time
ROOT_TEST_MAX_TIME := 1

# linux windows darwin  list as: go tool dist list
ENV_DIST_OS := linux
# amd64 386
ENV_DIST_ARCH := amd64
ENV_DIST_OS_DOCKER ?= linux
ENV_DIST_ARCH_DOCKER ?= amd64
ENV_MODULE_MAKE_FILE ?= ./Makefile
ENV_MODULE_MANIFEST = ./package.json
ENV_MODULE_CHANGELOG = ./CHANGELOG.md
ROOT_BUILD_PATH ?= build
ROOT_BUILD_ENTRANCE ?= main.go
ROOT_BUILD_BIN_NAME ?= main
ROOT_BUILD_BIN_PATH ?= $(ROOT_BUILD_PATH)/$(ROOT_BUILD_BIN_NAME)
ROOT_DIS_BIN_NAME ?= $(ROOT_NAME)
ROOT_DIST ?= ./dist
ROOT_REPO ?= ./dist
ROOT_LOG_PATH ?= ./log
ROOT_TEST_BUILD_PATH ?= $(ROOT_BUILD_PATH)/test/$(ENV_DIST_VERSION)
ROOT_TEST_DIST_PATH ?= $(ROOT_DIST)/test/$(ENV_DIST_VERSION)
ROOT_TEST_OS_DIST_PATH ?= $(ROOT_DIST)/$(ENV_DIST_OS)/test_os/$(ENV_DIST_VERSION)
ROOT_REPO_DIST_PATH ?= $(ROOT_REPO)/release/$(ENV_DIST_VERSION)
ROOT_REPO_OS_DIST_PATH ?= $(ROOT_REPO)/$(ENV_DIST_OS)/release_os/$(ENV_DIST_VERSION)

ENV_DIST_MARK=
ifneq ($(strip $(DRONE_COMMIT)),)
	ENV_DIST_MARK=-${DRONE_COMMIT}# this can change to other mark
endif
ifneq ($(strip $(GITHUB_SHA)),)
	ENV_DIST_MARK=-${GITHUB_SHA}# https://docs.github.com/cn/enterprise-server@2.22/actions/learn-github-actions/environment-variables
endif

# ifeq ($(FILE), $(wildcard $(FILE)))
# 	@ echo target file not found
# endif

# include MakeDockerRun.mk for docker run
include MakeGoMod.mk
include MakeDockerRun.mk
include MakeGoAction.mk
include MakeDist.mk

#checkEnvGOPATH:
#ifndef GOPATH
#	@echo Environment variable GOPATH is not set
#	exit 1
#endif

env:
	@echo "== project env info start =="
	@echo ""
	@echo "ROOT_NAME                         ${ROOT_NAME}"
	@echo "ENV_DIST_VERSION                  ${ENV_DIST_VERSION}"
	@echo "ENV_MODULE_CHANGELOG              ${ENV_MODULE_CHANGELOG}"
	@echo ""
	@echo "ROOT_BUILD_ENTRANCE               ${ROOT_BUILD_ENTRANCE}"
	@echo "ROOT_BUILD_PATH                   ${ROOT_BUILD_PATH}"
	@echo "ROOT_BUILD_BIN_PATH               ${ROOT_BUILD_BIN_PATH}"
	@echo "ROOT_TEST_DIST_PATH               ${ROOT_TEST_DIST_PATH}"
	@echo "ROOT_REPO_DIST_PATH               ${ROOT_REPO_DIST_PATH}"
	@echo "ENV_DIST_OS                       ${ENV_DIST_OS}"
	@echo "ENV_DIST_ARCH                     ${ENV_DIST_ARCH}"
	@echo "ROOT_TEST_OS_DIST_PATH            ${ROOT_TEST_OS_DIST_PATH}"
	@echo "ROOT_REPO_OS_DIST_PATH            ${ROOT_REPO_OS_DIST_PATH}"
	@echo ""
	@echo "ENV_DIST_MARK                     ${ENV_DIST_MARK}"
	@echo "== project env info end =="

utils:
	node -v
	npm -v
	npm install -g commitizen cz-conventional-changelog conventional-changelog-cli

versionHelp:
	@git fetch --tags
	@echo "project base info"
	@echo " project name         : ${ROOT_NAME}"
	@echo " if error can fix after git set remote url, then run: npm init"
	@echo ""
	@echo "=> please check to change version, now is [ ${ENV_DIST_VERSION} ]"
	@echo "-> check at: ${ENV_MODULE_MAKE_FILE}:4"
	@echo " $(shell head -n 4 ${ENV_MODULE_MAKE_FILE} | tail -n 1)"
	@echo "-> check at: ${ENV_MODULE_MANIFEST}:3"
	@echo " $(shell head -n 3 ${ENV_MODULE_MANIFEST} | tail -n 1)"

tagBefore: versionHelp
	@echo " if error can fix after git set remote url, then run: npm init"
	@conventional-changelog -i ${ENV_MODULE_CHANGELOG} -s --skip-unstable
	@echo ""
	@echo "=> new CHANGELOG.md at: ${ENV_MODULE_CHANGELOG}"
	@echo "place check all file, then can add tag like this!"
	@echo "$$ git tag -a '${ENV_DIST_VERSION}' -m 'message for this tag'"

cleanBuild:
	@if [ -d ${ROOT_BUILD_PATH} ]; \
	then rm -rf ${ROOT_BUILD_PATH} && echo "~> cleaned ${ROOT_BUILD_PATH}"; \
	else echo "~> has cleaned ${ROOT_BUILD_PATH}"; \
	fi

cleanLog:
	@if [ -d ${ROOT_LOG_PATH} ]; \
	then rm -rf ${ROOT_LOG_PATH} && echo "~> cleaned ${ROOT_LOG_PATH}"; \
	else echo "~> has cleaned ${ROOT_LOG_PATH}"; \
	fi

clean: cleanBuild cleanLog
	@echo "~> clean finish"

init:
	@echo "~> start init this project"
	@echo "-> check version"
	go version
	@echo "-> check env golang"
	go env
	@echo "~> you can use [ make help ] see more task"
	-go mod verify

buildMain:
	@echo "-> start build local OS"
	@go build -o ${ROOT_BUILD_BIN_PATH} ${ROOT_BUILD_ENTRANCE}

buildARCH:
	@echo "-> start build OS:$(ENV_DIST_OS) ARCH:$(ENV_DIST_ARCH)"
	@GOOS=$(ENV_DIST_OS) GOARCH=$(ENV_DIST_ARCH) go build -o ${ROOT_BUILD_BIN_PATH} ${ROOT_BUILD_ENTRANCE}

dev: buildMain
	-ENV_WEB_AUTO_HOST=true ${ROOT_BUILD_BIN_PATH}

run: dev
	@echo "=> run start"

test:
	@echo "=> run test start"
	#=> go test -test.v $(ROOT_TEST_LIST)
	@go test -test.v $(ROOT_TEST_LIST)

testCoverage:
	@echo "=> run test coverage start"
	@go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)

testCoverageBrowser: testCoverage
	@go tool cover -html=coverage.txt

testBenchmark:
	@echo "=> run test benchmark start"
	@go test -test.benchmem $(ROOT_TEST_LIST)

cloc:
	# https://stackoverflow.com/questions/26152014/cloc-ignore-exclude-list-file-clocignore
	cloc --exclude-list-file=.clocignore .

helpProjectRoot:
	@echo "Help: Project root Makefile"
	@echo "-- now build name: $(ROOT_NAME) version: $(ENV_DIST_VERSION)"
	@echo "-- distTestOS or distReleaseOS will out abi as: $(ENV_DIST_OS) $(ENV_DIST_ARCH) --"
	@echo ""
	@echo "~> make env                 - print env of this project"
	@echo "~> make init                - check base env of this project"
	@echo "~> make clean               - remove binary file and log files"
	@echo "~> make test                - run test case ignore --invert-match by config"
	@echo "~> make testCoverage        - run test coverage case ignore --invert-match by config"
	@echo "~> make testCoverageBrowser - see coverage at browser --invert-match by config"
	@echo "~> make testBenchmark       - run go test benchmark case all"
	@echo "~> make dev                 - run as develop"

help: helpGoMod helpDockerRun helpGoAction helpDist helpProjectRoot
	@echo ""
	@echo "-- more info see Makefile include: MakeGoMod.mk MakeDockerRun.mk MakeGoAction.mk MakeDist.mk--"
