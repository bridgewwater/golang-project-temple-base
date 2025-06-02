# Makefile root
# can change this by env:ENV_CI_DIST_VERSION use and change by env:ENV_CI_DIST_MARK by CI
ENV_DIST_VERSION=latest
ENV_DIST_MARK=

ROOT_NAME?=golang-project-temple-base

## run info start
ENV_RUN_INFO_HELP_ARGS= -h
ENV_RUN_INFO_ARGS=
## run info end

## go test go-test.mk start
# ignore used not matching mode
# set ignore of test case like grep -v -E "vendor|go_fatal_error" to ignore vendor and go_fatal_error package
ENV_ROOT_TEST_INVERT_MATCH ?="vendor|go_fatal_error|robotn|shirou"
ifeq ($(OS),Windows_NT)
ENV_ROOT_TEST_LIST ?=./...
else
ENV_ROOT_TEST_LIST ?=$$(go list ./... | grep -v -E ${ENV_ROOT_TEST_INVERT_MATCH})
endif
# test max time
ENV_ROOT_TEST_MAX_TIME :=1m
## go test go-test.mk end

## go doc start
ENV_GO_GODOC_PORT_NUMBER=36060
ENV_GO_GODOC_EXPORT_PATH=build/godoc
ENV_GO_GODOC_EXPORT_PKG =github.com/bridgewwater/golang-project-temple-base/
include z-MakefileUtils/go-doc.mk
## go doc end

## clean args start
ENV_ROOT_BUILD_PATH=build
ENV_ROOT_LOG_PATH=logs/
## clean args end

## build args start
ENV_ROOT_BUILD_ENTRANCE=cmd/golang-project-temple-base/main.go
ENV_ROOT_BUILD_PATH=build
ENV_ROOT_BUILD_BIN_NAME=${ROOT_NAME}
ENV_ROOT_BUILD_BIN_PATH=${ENV_ROOT_BUILD_PATH}/${ENV_ROOT_BUILD_BIN_NAME}
## build args end

include z-MakefileUtils/MakeBasicEnv.mk
include z-MakefileUtils/go-list.mk
include z-MakefileUtils/go-mod.mk
include z-MakefileUtils/go-test.mk
include z-MakefileUtils/go-test-integration.mk
# include z-MakefileUtils/go-dist.mk

define buildGoBinaryLocal
	@echo "=> start $(0)"
	@echo "-> start build local OS: ${PLATFORM} ${OS_BIT}"
	@echo "         build out path: ${1}"
	@echo "         build entrance: ${2}"
	@echo "         buildID: ${3}"
	go build -ldflags "-X main.buildID=${3}" -o ${1} ${2}
endef

.PHONY: all
all: env

.PHONY: env
env:
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
	@echo "ENV_DIST_CODE_MARK                        ${ENV_DIST_CODE_MARK}"
	@echo "== project env info end =="

.PHONY: clean.build
clean.build:
	@$(RM) -r ${ENV_ROOT_BUILD_PATH}
	@echo "~> finish clean path: ${ENV_ROOT_BUILD_PATH}"

.PHONY: clean.log
clean.log:
	@$(RM) -r ${ENV_ROOT_LOG_PATH}
	@echo "~> finish clean path: ${ENV_ROOT_LOG_PATH}"

.PHONY: clean.test
clean.test: test.go.clean

.PHONY: clean.test.data
clean.test.data:
	$(info -> notes: remove folder [ testdata ] unable to match subdirectories)
	@$(RM) -r **/testdata
	@$(RM) -r **/**/testdata
	@$(RM) -r **/**/**/testdata
	@$(RM) -r **/**/**/**/testdata
	@$(RM) -r **/**/**/**/**/testdata
	@$(RM) -r **/**/**/**/**/**/testdata
	$(info -> finish clean folder [ testdata ])

.PHONY: clean
clean: clean.test clean.build clean.log
	@echo "~> clean finish"

.PHONY: cleanAll
cleanAll: clean
	@echo "~> clean all finish"

init:
	@echo "~> start init this project"
	@echo "-> check version"
	go version
	@echo "-> check env golang"
	go env
	@echo "~> you can use [ make help ] see more task"
	-go mod verify

.PHONY: dep
dep: go.mod.verify go.mod.download go.mod.tidy

.PHONY: style
style: go.mod.verify go.mod.tidy go.mod.fmt go.mod.lint.run.v2

.PHONY: test
test: test.go

.PHONY: ci
ci: style go.mod.vet test

.PHONY: ci.test.benchmark
ci.test.benchmark: test.go.benchmark

.PHONY: ci.coverage.show
ci.coverage.show: test.go.coverage.show

.PHONY: ci.all
ci.all: ci ci.test.benchmark ci.coverage.show

.PHONY: buildMain
buildMain:
	@echo "-> start buildMain local OS: ${PLATFORM} ${OS_BIT}"
ifeq ($(OS),Windows_NT)
	$(call buildGoBinaryLocal,${ENV_ROOT_BUILD_BIN_PATH}.exe,${ENV_ROOT_BUILD_ENTRANCE},${ENV_DIST_CODE_MARK})
	@echo "-> finish build out path: $(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe"
else
	$(call buildGoBinaryLocal,${ENV_ROOT_BUILD_BIN_PATH},${ENV_ROOT_BUILD_ENTRANCE},${ENV_DIST_CODE_MARK})
	@echo "-> finish build out path: ${ENV_ROOT_BUILD_BIN_PATH}"
endif

.PHONY: dev.help
dev.help: export CI_DEBUG=false
dev.help: clean.build buildMain
ifeq ($(OS),Windows_NT)
	$(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe ${ENV_RUN_INFO_HELP_ARGS}
else
	${ENV_ROOT_BUILD_BIN_PATH} ${ENV_RUN_INFO_HELP_ARGS}
endif

.PHONY: dev
dev: export CI_DEBUG=true
dev: clean.build buildMain
ifeq ($(OS),Windows_NT)
	$(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe ${ENV_RUN_INFO_ARGS}
else
	${ENV_ROOT_BUILD_BIN_PATH} ${ENV_RUN_INFO_ARGS}
endif

.PHONY: devInstallLocal
devInstallLocal: clean.build buildMain
ifeq ($(shell go env GOPATH),)
	$(error can not get go env GOPATH)
endif
ifeq ($(OS),Windows_NT)
	$(info -> notes: install $(subst /,\,${ENV_GO_PATH}/bin/${ENV_ROOT_BUILD_BIN_NAME}.exe))
	@cp $(subst /,\,${ENV_ROOT_BUILD_BIN_PATH}).exe $(subst /,\,${ENV_GO_PATH}/bin)
else
	$(info -> notes: install ${GOPATH}/bin/${ENV_ROOT_BUILD_BIN_NAME})
	@cp ${ENV_ROOT_BUILD_BIN_PATH} ${ENV_GO_PATH}/bin
endif

.PHONY: run.help
run.help: export CLI_VERBOSE=false
run.help:
	go run -v ${ENV_ROOT_BUILD_ENTRANCE} ${ENV_RUN_INFO_HELP_ARGS}

run.version: export CLI_VERBOSE=false
run.version:
	go run -v ${ENV_ROOT_BUILD_ENTRANCE} --version

.PHONY: run
run: export CLI_VERBOSE=false
run:
	@echo "=> run start"
ifeq ($(OS),Windows_NT)
	go run -v ${ENV_ROOT_BUILD_ENTRANCE} ${ENV_RUN_INFO_ARGS}
else
	go run -v ${ENV_ROOT_BUILD_ENTRANCE} ${ENV_RUN_INFO_ARGS}
endif

.PHONY: run
run.debug: export CLI_VERBOSE=true
run.debug:
	@echo "=> run start"
ifeq ($(OS),Windows_NT)
	go run -v ${ENV_ROOT_BUILD_ENTRANCE} ${ENV_RUN_INFO_ARGS}
else
	go run -v ${ENV_ROOT_BUILD_ENTRANCE} ${ENV_RUN_INFO_ARGS}
endif

.PHONY: cloc
cloc:
	@echo "see: https://stackoverflow.com/questions/26152014/cloc-ignore-exclude-list-file-clocignore"
	cloc --exclude-list-file=.clocignore .

.PHONY: helpProjectRoot
helpProjectRoot:
	@echo "Help: Project root Makefile"
ifeq ($(OS),Windows_NT)
	@echo ""
	@echo "warning: other install make cli tools has bug, please use: scoop install main/make"
	@echo " run will at make tools version 4.+"
	@echo "windows use this kit must install tools blow:"
	@echo ""
	@echo "https://scoop.sh/#/apps?q=busybox&s=0&d=1&o=true"
	@echo "-> scoop install main/busybox"
	@echo "and"
	@echo "https://scoop.sh/#/apps?q=shasum&s=0&d=1&o=true"
	@echo "-> scoop install main/shasum"
	@echo ""
endif
	@echo "-- now build name: ${ROOT_NAME} version: ${ENV_DIST_VERSION}"
	@echo "-- distTestOS or distReleaseOS will out abi as: ${ENV_DIST_GO_OS} ${ENV_DIST_GO_ARCH} --"
	@echo ""
	@echo "~> make test                 - run test fast"
	@echo "~> make test.go.update       - run test with flag -update"
	@echo "~> make ci.all               - run CI tasks all"
	@echo "~> make ci.test.benchmark    - run CI tasks as test benchmark"
	@echo "~> make ci.coverage.show     - run CI tasks as test coverage and show"
	@echo ""
	@echo "~> make env                  - print env of this project"
	@echo "~> make init                 - check base env of this project"
	@echo "~> make dep                  - check and install by go mod"
	@echo "~> make clean                - remove build binary file, log files, and testdata"
	@echo "~> make style                - run local code fmt and style check"
	@echo "~> make ci                   - run CI tools tasks"
	@echo ""
	@echo "~> make dev.help             - run as develop mode see help with ${ENV_RUN_INFO_HELP_ARGS}"
	@echo "~> make dev                  - run as develop mode"
ifeq ($(OS),Windows_NT)
	@echo "~> make devInstallLocal      - install at $(subst /,\,${ENV_GO_PATH}/bin)"
else
	@echo "~> make devInstallLocal      - install at ${ENV_GO_PATH}/bin"
endif
	@echo "~> make run.help             - run use ${ENV_RUN_INFO_HELP_ARGS}"
	@echo "~> make run                  - run as ordinary mode"
	@echo "~> make run.debug            - run as debug mode open by env:CLI_VERBOSE=true"
	@echo ""

.PHONY: help
help: helpProjectRoot
	@echo "== show more help"
	@echo ""
	@echo "$$ make help.test.go.integration"
	@echo "$$ make help.test.go"
	@echo "$$ make help.go.list"
	@echo "$$ make help.go.mod"
	@echo "$$ make help.go.doc"
	@echo ""
	@echo "-- more info see Makefile include --"