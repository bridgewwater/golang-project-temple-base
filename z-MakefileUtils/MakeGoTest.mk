## for golang test task
# include z-MakefileUtils/MakeGoTest.mk
# need MakeBasicEnv.mk MakeDistTools.mk
# need args
# ENV_ROOT_TEST_LIST test list for most use case is ./...
# ENV_ROOT_TEST_MAX_TIME timeout for test case set
# can use as:
#
### go test MakeGoTest.mk start
## ignore used not matching mode
## set ignore of test case like grep -v -E "vendor|go_fatal_error" to ignore vendor and go_fatal_error package
#ENV_ROOT_TEST_INVERT_MATCH?="vendor|go_fatal_error|robotn|shirou"
#ifeq ($(OS),Windows_NT)
#ENV_ROOT_TEST_LIST?=./...
#else
#ENV_ROOT_TEST_LIST?=$$(go list ./... | grep -v -E ${ENV_ROOT_TEST_INVERT_MATCH})
#endif
## test max time
#ENV_ROOT_TEST_MAX_TIME:=1m
### go test MakeGoTest.mk end


ENV_GO_TEST_COVERAGE_PROFILE ?=coverage.txt
ENV_GO_TEST_COVERAGE_OUT ?=coverage.out
ENV_GO_TEST_COVERAGE_HTML_OUT ?=${ENV_PATH_INFO_ROOT_DIST}/coverage.html

testListCases:
	$(info -> will show all test case)
	@go test -list . ${ENV_ROOT_TEST_LIST}

test:
	@echo "=> run test start"
ifeq ($(OS),Windows_NT)
	@go test -test.v ${ENV_ROOT_TEST_LIST}
else
	@go test -test.v ${ENV_ROOT_TEST_LIST}
endif

testFail:
	@echo "=> run test timeout ${ENV_ROOT_TEST_MAX_TIME}, if not find FAIL, will exit 1"
ifeq ($(OS),Windows_NT)
	go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME} | findstr FAIL
else
	go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME} | grep FAIL --color
endif

testMaxTimeOut:
	@echo "=> run test by timout: ${ENV_ROOT_TEST_MAX_TIME} start"
ifeq ($(OS),Windows_NT)
	@go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME}
else
	@go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME}
endif

testInstall:
	go get -t -v ./...

testBuild:
	go build -v ./...

testBenchmark:
	@echo "=> run test benchmark start"
ifeq ($(OS),Windows_NT)
	@go test -run none -tags test -bench . -benchmem -v ${ENV_ROOT_TEST_LIST}
else
	@go test -run none -tags test -bench . -benchmem -v ${ENV_ROOT_TEST_LIST}
endif

testBenchmarkMaxTimeOut:
	@echo "=> run test benchmark by timout: ${ENV_ROOT_TEST_MAX_TIME} start"
ifeq ($(OS),Windows_NT)
	@go test -run none -tags test -bench . -benchmem -v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME}
else
	@go test -run none -tags test -bench . -benchmem -v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME}
endif

testCoverageClean:
	$(info -> clean test coverage file: ${ENV_GO_TEST_COVERAGE_PROFILE})
	@$(RM) ${ENV_GO_TEST_COVERAGE_PROFILE}

testCoverage:
	@echo "=> run test coverage start"
ifeq ($(OS),Windows_NT)
	@go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode count -coverpkg ./... -tags test -v ${ENV_ROOT_TEST_LIST}
else
	@go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode count -coverpkg ./... -tags test -v ${ENV_ROOT_TEST_LIST}
endif

testCoverageBrowser: testCoverage
	@go tool cover -html ${ENV_GO_TEST_COVERAGE_PROFILE}

testCoverageShow:
	$(info -> show by test coverage file: ${ENV_GO_TEST_COVERAGE_PROFILE})
	go tool cover -func ${ENV_GO_TEST_COVERAGE_PROFILE}

testCoverageHtml: pathCheckRootDist
	$(info -> show by test coverage file: ${ENV_GO_TEST_COVERAGE_PROFILE})
	go tool cover -html ${ENV_GO_TEST_COVERAGE_PROFILE} -o ${ENV_GO_TEST_COVERAGE_HTML_OUT}

testCoverageAtomic:
	@echo "=> run test coverage start"
ifeq ($(OS),Windows_NT)
	@go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode atomic -coverpkg ./... -tags test -v ${ENV_ROOT_TEST_LIST}
else
	@go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode atomic -coverpkg ./... -tags test  -v ${ENV_ROOT_TEST_LIST}
endif

testCoverageAtomicBrowser: testCoverageAtomic
	@go tool cover -html ${ENV_GO_TEST_COVERAGE_PROFILE}

helpGoTest:
	@echo "#=> MakeGoTest.mk tools for golang test task"
	@echo ""
	@echo "sample of golang test task cover"
	@echo "cover script set"
	@echo "go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode set -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"
	@echo "cover script count"
	@echo "go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode count -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"
	@echo "cover script atomi:"
	@echo "go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode atomic -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"
	@echo ""
	@echo "~> make testListCases                - list test case under this package --invert-match by config"
	@echo "~> make test                         - run test case ignore --invert-match by config"
	@echo "~> make testCoverageClean            - clean test case coverage file"
	@echo "~> make testCoverage                 - run test coverage case ignore --invert-match by config, coverage mode count"
	@echo "~> make testCoverageAtomic           - run test coverage case ignore --invert-match by config, coverage mode atomic"
	@echo "~> make testCoverageBrowser          - see coverage at browser --invert-match by config, coverage mode count"
	@echo "~> make testCoverageAtomicBrowser    - see coverage at browser --invert-match by config, coverage mode atomic"
	@echo "~> make testCoverageOut              - out coverage by html file at ${ENV_GO_TEST_COVERAGE_HTML_OUT}"
	@echo "~> make testCoverageShow             - see coverage by out file ${ENV_GO_TEST_COVERAGE_PROFILE}"
	@echo "~> make testBenchmark                - run go test benchmark case all"
	@echo "~> make testInstall                  - run go install case all"
	@echo "~> make testBuild                    - run go build case all"
	@echo "~> make testFail                     - run test case ignore --invert-match by config and try find out FAIL"
	@echo ""
	@echo "= this tools must has arg setting as"
	@echo ""
	@echo "ENV_ROOT_TEST_LIST test list for most use case is ./..."
	@echo "ENV_ROOT_TEST_MAX_TIME timeout for test case set"
