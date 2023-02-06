.PHONY: test check clean build dist all
#TOP_DIR := $(shell pwd)
# can change this by env:ENV_CI_DIST_VERSION use to CI/CD
ENV_DIST_VERSION = v0.1.2
ifneq ($(strip $(ENV_CI_DIST_VERSION)),)
    ENV_DIST_VERSION=${ENV_CI_DIST_VERSION}
endif

ROOT_NAME ?= golang-project-temple-base
ENV_RUN_INFO_HELP_ARGS= -h
ENV_RUN_INFO_ARGS=
# change to other build enterance
ENV_ROOT_BUILD_ENTRANCE = main.go
ENV_ROOT_BUILD_BIN_NAME = $(ROOT_NAME)
ENV_ROOT_BUILD_PATH = build
ENV_ROOT_BUILD_BIN_PATH = $(ENV_ROOT_BUILD_PATH)/$(ENV_ROOT_BUILD_BIN_NAME)
ENV_ROOT_LOG_PATH = log/

# ignore used not matching mode
# set ignore of test case like grep -v -E "vendor|go_fatal_error" to ignore vendor and go_fatal_error package
ENV_ROOT_TEST_INVERT_MATCH ?= "vendor|pkgJson|go_fatal_error|robotn|shirou|go_robot"
ifeq ($(OS),Windows_NT)
ENV_ROOT_TEST_LIST ?= ./...
else
ENV_ROOT_TEST_LIST ?= $$(go list ./... | grep -v -E $(ENV_ROOT_TEST_INVERT_MATCH))
endif
# test max time
ENV_ROOT_TEST_MAX_TIME := 1

# linux windows darwin  list as: go tool dist list
ENV_DIST_GO_OS = linux
# amd64 386
ENV_DIST_GO_ARCH = amd64

#ENV_NOW_GIT_COMMIT_ID_SHORT=$(shell git --no-pager rev-parse --short HEAD)
#ENV_DIST_MARK=-${ENV_NOW_GIT_COMMIT_ID_SHORT}
ENV_DIST_MARK=

# this can change to other mark https://docs.drone.io/pipeline/environment/substitution/
ifneq ($(strip $(DRONE_TAG)),)
    ENV_DIST_MARK=-tag.${DRONE_TAG}
else
    ifneq ($(strip $(DRONE_COMMIT)),)
        ENV_DIST_MARK=-${DRONE_COMMIT}
    endif
endif
ifneq ($(strip $(GITHUB_SHA)),)
    ENV_DIST_MARK=-${GITHUB_SHA}# https://docs.github.com/cn/enterprise-server@2.22/actions/learn-github-actions/environment-variables
endif

# ifeq ($(FILE), $(wildcard $(FILE)))
# 	@ echo target file not found
# endif

# MakeGoDist.mk settings
INFO_ROOT_DIST_PATH ?= dist

include MakeGoMod.mk
include MakeGoAction.mk
include MakeGoDist.mk
include MakeDocker.mk

#checkEnvGOPATH:
#ifndef GOPATH
#	@echo Environment variable GOPATH is not set
#	exit 1
#endif

ENV_ROOT_MAKE_FILE ?= Makefile
ENV_ROOT_MANIFEST_PKG_JSON ?= package.json
ENV_ROOT_CHANGELOG_PATH ?= CHANGELOG.md

env: distEnv
	@echo "== project env info start =="
	@echo ""
	@echo "test info"
	@echo "ENV_ROOT_TEST_LIST                        ${ENV_ROOT_TEST_LIST}"
	@echo ""
	@echo "ROOT_NAME                                 ${ROOT_NAME}"
	@echo "ENV_DIST_VERSION                          ${ENV_DIST_VERSION}"
	@echo "ENV_ROOT_CHANGELOG_PATH                   ${ENV_ROOT_CHANGELOG_PATH}"
	@echo ""
	@echo "ENV_ROOT_BUILD_ENTRANCE                   ${ENV_ROOT_BUILD_ENTRANCE}"
	@echo "ENV_ROOT_BUILD_PATH                       ${ENV_ROOT_BUILD_PATH}"
ifeq ($(OS),Windows_NT)
	@echo "ENV_ROOT_BUILD_BIN_PATH                   $(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe"
else
	@echo "ENV_ROOT_BUILD_BIN_PATH                   ${ENV_ROOT_BUILD_BIN_PATH}"
endif
	@echo "ENV_DIST_GO_OS                            ${ENV_DIST_GO_OS}"
	@echo "ENV_DIST_GO_ARCH                          ${ENV_DIST_GO_ARCH}"
	@echo ""
	@echo "ENV_DIST_MARK                             ${ENV_DIST_MARK}"
	@echo "== project env info end =="

versionUtils:
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
	@echo "-> check at: ${ENV_ROOT_MAKE_FILE}:4"
ifeq ($(OS),Windows_NT)
	@echo " $(shell head -n 4 ${ENV_ROOT_MAKE_FILE} | findstr ${ENV_DIST_VERSION})"
else
	@echo " $(shell head -n 4 ${ENV_ROOT_MAKE_FILE} | tail -n 1)"
endif
	@echo "-> check at: ${ENV_ROOT_MANIFEST_PKG_JSON}:3"
ifeq ($(OS),Windows_NT)
	@echo " $(shell head -n 3 ${ENV_ROOT_MANIFEST_PKG_JSON} | findstr ${ENV_DIST_VERSION})"
else
	@echo " $(shell head -n 3 ${ENV_ROOT_MANIFEST_PKG_JSON} | tail -n 1)"
endif

tagBefore: versionHelp
	@echo " if error can fix after git set remote url, then run: npm init"
	@conventional-changelog -i ${ENV_ROOT_CHANGELOG_PATH} -s --skip-unstable
	@echo ""
	@echo "=> new CHANGELOG.md at: ${ENV_ROOT_CHANGELOG_PATH}"
	@echo "place check all file, then can add tag like this!"
	@echo "$$ git tag -a '${ENV_DIST_VERSION}' -m 'message for this tag'"

cloc:
	@echo "see: https://stackoverflow.com/questions/26152014/cloc-ignore-exclude-list-file-clocignore"
	cloc --exclude-list-file=.clocignore .

cleanBuild:
	-@RM -r ${ENV_ROOT_BUILD_PATH}
	@echo "~> finish clean path: ${ENV_ROOT_BUILD_PATH}"

cleanLog:
	-@RM -r ${ENV_ROOT_LOG_PATH}
	@echo "~> finish clean path: ${ENV_ROOT_LOG_PATH}"

clean: cleanBuild cleanLog
	@echo "~> clean finish"

cleanAll: clean cleanAllDist
	@echo "~> clean all finish"

init:
	@echo "~> start init this project"
	@echo "-> check version"
	go version
	@echo "-> check env golang"
	go env
	@echo "~> you can use [ make help ] see more task"
	-go mod verify

test:
	@echo "=> run test start"
ifeq ($(OS),Windows_NT)
	@go test -v $(ENV_ROOT_TEST_LIST)
else
	@go test -test.v $(ENV_ROOT_TEST_LIST)
endif

testCoverage:
	@echo "=> run test coverage start"
ifeq ($(OS),Windows_NT)
	@go test -cover -coverprofile=coverage.txt -covermode=count -coverpkg ./... -v $(ENV_ROOT_TEST_LIST)
else
	@go test -cover -coverprofile=coverage.txt -covermode=count -coverpkg ./... -v $(ENV_ROOT_TEST_LIST)
endif

testCoverageBrowser: testCoverage
	@go tool cover -html=coverage.txt

testBenchmark:
	@echo "=> run test benchmark start"
	@go test -bench=. -test.benchmem $(ENV_ROOT_TEST_LIST)

buildMain:
	@echo "-> start build local OS"
ifeq ($(OS),Windows_NT)
	@go build -o $(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe ${ENV_ROOT_BUILD_ENTRANCE}
	@echo "-> finish build out path: $(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe"
else
	@go build -o ${ENV_ROOT_BUILD_BIN_PATH} ${ENV_ROOT_BUILD_ENTRANCE}
	@echo "-> finish build out path: ${ENV_ROOT_BUILD_BIN_PATH}"
endif

buildARCH:
	@echo "-> start build OS:$(ENV_DIST_GO_OS) ARCH:$(ENV_DIST_GO_ARCH)"
ifeq ($(ENV_DIST_GO_OS),windows)
	@GOOS=$(ENV_DIST_GO_OS) GOARCH=$(ENV_DIST_GO_ARCH) go build \
	-a \
	-tags netgo \
	-ldflags '-w -s --extldflags "-static -fpic"' \
	-o $(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe ${ENV_ROOT_BUILD_ENTRANCE}
	@echo "-> finish build out path: $(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe"
else
	@GOOS=$(ENV_DIST_GO_OS) GOARCH=$(ENV_DIST_GO_ARCH) go build \
	-a \
	-tags netgo \
	-ldflags '-w -s --extldflags "-static -fpic"' \
	-o ${ENV_ROOT_BUILD_BIN_PATH} ${ENV_ROOT_BUILD_ENTRANCE}
	@echo "-> finish build out path: ${ENV_ROOT_BUILD_BIN_PATH}"
endif

dev: export ENV_WEB_AUTO_HOST=true
dev: cleanBuild buildMain
ifeq ($(OS),windows)
	$(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe ${ENV_RUN_INFO_HELP_ARGS}
else
	${ENV_ROOT_BUILD_BIN_PATH} ${ENV_RUN_INFO_HELP_ARGS}
endif

run: export ENV_WEB_AUTO_HOST=false
run:  cleanBuild buildMain
	@echo "=> run start"
ifeq ($(OS),windows)
	$(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe ${ENV_RUN_INFO_ARGS}
else
	${ENV_ROOT_BUILD_BIN_PATH} ${ENV_RUN_INFO_ARGS}
endif

helpProjectRoot:
	@echo "Help: Project root Makefile"
	@echo "-- now build name: $(ROOT_NAME) version: $(ENV_DIST_VERSION)"
	@echo "-- distTestOS or distReleaseOS will out abi as: $(ENV_DIST_GO_OS) $(ENV_DIST_GO_ARCH) --"
	@echo ""
	@echo "~> make env                 - print env of this project"
	@echo "~> make init                - check base env of this project"
	@echo "~> make clean               - remove binary file and log files"
	@echo "~> make test                - run test case ignore --invert-match by config"
	@echo "~> make testCoverage        - run test coverage case ignore --invert-match by config"
	@echo "~> make testCoverageBrowser - see coverage at browser --invert-match by config"
	@echo "~> make testBenchmark       - run go test benchmark case all"
	@echo "~> make dev                 - run as develop"

help: helpGoMod helpDocker helpGoAction helpDist helpProjectRoot
	@echo ""
	@echo "-- more info see Makefile include: MakeGoMod.mk MakeDockerRun.mk MakeGoAction.mk MakeDist.mk--"
