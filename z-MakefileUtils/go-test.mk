## for golang test task
# include z-MakefileUtils/go-test.mk
# need tools: MakeBasicEnv.mk MakeDistTools.mk

# need args
# ENV_ROOT_TEST_LIST test list for most use case is ./...
# ENV_ROOT_TEST_MAX_TIME timeout for test case set

# can use as:

### go test go-test.mk start
## ignore used not matching mode
## set ignore of test case like grep -v -E "vendor|go_fatal_error" to ignore vendor and go_fatal_error package
#ENV_ROOT_TEST_INVERT_MATCH ?="vendor|go_fatal_error|robotn|shirou"
#ifeq ($(OS),Windows_NT)
#ENV_ROOT_TEST_LIST ?=./...
#else
#ENV_ROOT_TEST_LIST ?=$$(go list ./... | grep -v -E ${ENV_ROOT_TEST_INVERT_MATCH})
#endif
## test max time
#ENV_ROOT_TEST_MAX_TIME :=1m
### go test go-test.mk end


ENV_GO_TEST_COVERAGE_PROFILE ?=coverage.txt
ENV_GO_TEST_COVERAGE_OUT ?=coverage.out
ENV_GO_TEST_COVERAGE_HTML_OUT ?=${ENV_PATH_INFO_ROOT_DIST}/coverage.html

.PHONY: test.go.list.cases
test.go.list.cases:
	$(info -> will show all test case)
	@go test -list . ${ENV_ROOT_TEST_LIST}

.PHONY: test.go.clean
test.go.clean:
	@$(RM) coverage.txt
	@$(RM) coverage.out
	@$(RM) profile.txt

.PHONY: test.go
test.go:
	@echo "=> run test start"
ifeq ($(OS),Windows_NT)
	@go test -test.v ${ENV_ROOT_TEST_LIST}
else
	@go test -test.v ${ENV_ROOT_TEST_LIST}
endif

.PHONY: test.go.update
test.go.update:
	@echo "=> run test start"
ifeq ($(OS),Windows_NT)
	-@go test -test.v ${ENV_ROOT_TEST_LIST} -v -update
else
	-@go test -test.v ${ENV_ROOT_TEST_LIST} -v -update
endif

.PHONY: test.go.fail
test.go.fail:
	@echo "=> run test timeout ${ENV_ROOT_TEST_MAX_TIME}, if not find FAIL, will exit 1"
ifeq ($(OS),Windows_NT)
	go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME} | findstr FAIL
else
	go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME} | grep FAIL --color
endif

.PHONY: test.go.max.timeout
test.go.max.timeout:
	@echo "=> run test by timout: ${ENV_ROOT_TEST_MAX_TIME} start"
ifeq ($(OS),Windows_NT)
	@go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME}
else
	@go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME}
endif

.PHONY: test.go.benchmark
test.go.benchmark:
	@echo "=> run test benchmark start"
ifeq ($(OS),Windows_NT)
	@go test -run none -tags test -bench . -benchmem -v ${ENV_ROOT_TEST_LIST}
else
	@go test -run none -tags test -bench . -benchmem -v ${ENV_ROOT_TEST_LIST}
endif

.PHONY: test.go.benchmark.max.timeout
test.go.benchmark.max.timeout:
	@echo "=> run test benchmark by timout: ${ENV_ROOT_TEST_MAX_TIME} start"
ifeq ($(OS),Windows_NT)
	@go test -run none -tags test -bench . -benchmem -v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME}
else
	@go test -run none -tags test -bench . -benchmem -v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_MAX_TIME}
endif

.PHONY: test.go.coverage.clean
test.go.coverage.clean:
	$(info -> clean test coverage file: ${ENV_GO_TEST_COVERAGE_PROFILE})
	@$(RM) ${ENV_GO_TEST_COVERAGE_PROFILE}

.PHONY: test.go.coverage
test.go.coverage:
	@echo "=> run test coverage start"
ifeq ($(OS),Windows_NT)
	@go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode count -coverpkg ./... -tags test -v ${ENV_ROOT_TEST_LIST}
else
	@go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode count -coverpkg ./... -tags test -v ${ENV_ROOT_TEST_LIST}
endif

.PHONY: test.go.coverage.browser
test.go.coverage.browser: test.go.coverage
	@go tool cover -html ${ENV_GO_TEST_COVERAGE_PROFILE}

.PHONY: test.go.coverage.show
test.go.coverage.show: test.go.coverage
	$(info -> show by test coverage file: ${ENV_GO_TEST_COVERAGE_PROFILE})
	go tool cover -func ${ENV_GO_TEST_COVERAGE_PROFILE}

.PHONY: test.go.coverage.html
test.go.coverage.html:
	$(info -> show by test coverage file: ${ENV_GO_TEST_COVERAGE_PROFILE})
	go tool cover -html ${ENV_GO_TEST_COVERAGE_PROFILE} -o ${ENV_GO_TEST_COVERAGE_HTML_OUT}

.PHONY: test.go.coverage.atomic
test.go.coverage.atomic:
	@echo "=> run test coverage start"
ifeq ($(OS),Windows_NT)
	@go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode atomic -coverpkg ./... -tags test -v ${ENV_ROOT_TEST_LIST}
else
	@go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode atomic -coverpkg ./... -tags test  -v ${ENV_ROOT_TEST_LIST}
endif

.PHONY: test.go.coverage.atomic.browser
test.go.coverage.atomic.browser: test.go.coverage.atomic
	@go tool cover -html ${ENV_GO_TEST_COVERAGE_PROFILE}

.PHONY: help.test.go
help.test.go:
	@echo "Help: go-test.mk"
	@echo ""
	@echo "#=> tools for golang test task"
	@echo "sample of golang test task cover"
	@echo "cover script set"
	@echo "go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode set -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"
	@echo "cover script count"
	@echo "go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode count -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"
	@echo "cover script atomi:"
	@echo "go test -cover -coverprofile ${ENV_GO_TEST_COVERAGE_PROFILE} -covermode atomic -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"
	@echo ""
	@echo "~> make test.go.list.cases                  - list test case under this package --invert-match by config"
	@echo "~> make test.go.clean                       - clean test case coverage file"
	@echo "~> make test.go.coverage.clean              - clean test case coverage file"
	@echo "~> make test.go.coverage.atomic             - run test coverage case ignore --invert-match by config, coverage mode atomic"
	@echo "~> make test.go.coverage.browser            - see coverage at browser --invert-match by config, coverage mode count"
	@echo "~> make test.go.coverage.atomic.browser     - see coverage at browser --invert-match by config, coverage mode atomic"
	@echo "~> make test.go.coverage.html               - out coverage by html file at ${ENV_GO_TEST_COVERAGE_HTML_OUT}"
	@echo "~> make test.go.coverage.show               - see coverage by out file ${ENV_GO_TEST_COVERAGE_PROFILE}"
	@echo "~> make test.go.coverage                    - run test coverage case ignore --invert-match by config, coverage mode count"
	@echo "~> make test.go.benchmark                   - run go test benchmark case all"
	@echo "~> make test.go.fail                        - run test case ignore --invert-match by config and try find out FAIL"
	@echo "~> make test.go                             - run test case ignore --invert-match by config"
	@echo ""
	@echo "= this tools must has arg setting as"
	@echo ""
	@echo "ENV_ROOT_TEST_LIST test list for most use case is ./..."
	@echo "ENV_ROOT_TEST_MAX_TIME timeout for test case set"
