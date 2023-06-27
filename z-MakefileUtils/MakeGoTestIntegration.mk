## for golang integration test task
# include z-MakefileUtils/MakeGoTestIntegration.mk
# need tools MakeBasicEnv.mk

# need args
# ENV_ROOT_TEST_LIST test list for most use case is ./...
# ENV_ROOT_TEST_MAX_TIME timeout for test case set
# ENV_ROOT_BUILD_PATH=build
# ENV_ROOT_BUILD_ENTRANCE=main.go
# ENV_ROOT_BUILD_BIN_NAME=${ROOT_NAME}
# ENV_RUN_INFO_ARGS=
# ENV_RUN_INFO_HELP_ARGS=
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

ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ROOT_PATH=${ENV_ROOT_BUILD_PATH}
ENV_ROOT_GO_TEST_INTEGRATION_BUILD_BIN_NAME=integration-test-${ENV_ROOT_BUILD_BIN_NAME}
ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH=${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ROOT_PATH}/${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_BIN_NAME}
ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ENTRANCE=${ENV_ROOT_BUILD_ENTRANCE}
ENV_ROOT_GO_TEST_INTEGRATION_RUN_ARGS=${ENV_RUN_INFO_HELP_ARGS}

ENV_PATH_GO_COVER_ROOT_DIR_PATH=${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ROOT_PATH}/integration-test
ENV_PATH_GO_COVER_DIR_PATH=${ENV_PATH_GO_COVER_ROOT_DIR_PATH}/${PLATFORM}/${OS_BIT}
ENV_PATH_GO_COVER_DIR_VALUE=${ENV_PATH_GO_COVER_DIR_PATH}
ENV_PATH_GO_INTEGRATION_TEST_COVERAGE_HTML_OUT=${ENV_PATH_INFO_ROOT_DIST}/integration-coverage.html

ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH=profile.txt

envGoTestIntegration:
	@echo "== go integration test env print start"
	@echo ""
	@echo "ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ROOT_PATH  ${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ROOT_PATH}"
	@echo "ENV_ROOT_GO_TEST_INTEGRATION_BUILD_BIN_NAME   ${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_BIN_NAME}"
	@echo "ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH         ${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}"
	@echo "ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ENTRANCE   ${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ENTRANCE}"
	@echo ""
	@echo "ENV_GO_COVER_DIR_PATH                         ${ENV_PATH_GO_COVER_DIR_PATH}"
	@echo "ENV_PATH_GO_COVER_DIR_VALUE                   ${ENV_PATH_GO_COVER_DIR_VALUE}"
	@echo "ENV_ROOT_GO_TEST_INTEGRATION_RUN_ARGS         ${ENV_ROOT_GO_TEST_INTEGRATION_RUN_ARGS}"
	@echo ""
	@echo "ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH            ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}"
	@echo ""
	@echo "== go integration test env print end"
	@echo ""

cleanGoCoverDirRoot:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_GO_COVER_ROOT_DIR_PATH}
else
	@$(RM) -r ${ENV_PATH_GO_COVER_ROOT_DIR_PATH}
endif
	$(info -> has clean ${ENV_PATH_GO_COVER_ROOT_DIR_PATH})

pathCheckGoCoverDir: | $(ENV_PATH_GO_COVER_DIR_PATH)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_GO_COVER_DIR_PATH}"

$(ENV_PATH_GO_COVER_DIR_PATH):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_GO_COVER_DIR_PATH}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_GO_COVER_DIR_PATH}
else
	@mkdir -p ${ENV_PATH_GO_COVER_DIR_PATH}
endif

cleanGoCoverDir:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_GO_COVER_DIR_PATH}
else
	@$(RM) -r ${ENV_PATH_GO_COVER_DIR_PATH}
endif
	$(info -> has clean ${ENV_PATH_GO_COVER_DIR_PATH})

testIntegrationBuild:
ifeq ($(OS),Windows_NT)
	@go build -cover -o $(subst /,\,${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}).exe -coverpkg ./... ${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ENTRANCE}
	@echo "-> finish build integration out path: $(subst /,\,${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}).exe"
else
	@go build -cover -o ${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH} -coverpkg ./... ${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ENTRANCE}
	@echo "-> finish build integration out path: ${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}"
endif

testIntegrationRun: export GOCOVERDIR=$(strip ${ENV_PATH_GO_COVER_DIR_VALUE})
testIntegrationRun: cleanGoCoverDir pathCheckGoCoverDir testIntegrationBuild
ifeq ($(OS),Windows_NT)
	$(subst /,\,${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}).exe ${ENV_ROOT_GO_TEST_INTEGRATION_RUN_ARGS}
else
	./${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH} ${ENV_ROOT_GO_TEST_INTEGRATION_RUN_ARGS}
endif
	go tool covdata percent -i $(strip ${ENV_PATH_GO_COVER_DIR_VALUE})

testIntegrationPercent: export GOCOVERDIR=$(strip ${ENV_PATH_GO_COVER_DIR_VALUE})
testIntegrationPercent:
	go tool covdata percent -i $(strip ${ENV_PATH_GO_COVER_DIR_VALUE})

testIntegrationReporting:
	go tool covdata textfmt -i $(strip ${ENV_PATH_GO_COVER_DIR_VALUE}) -o ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}

testIntegrationReportingShow:
	$(info -> show by test coverage file: ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH})
	go tool cover -func ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}

testIntegrationReportingHtml: pathCheckRootDist
	$(info -> out by test coverage file: ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH} to ${ENV_PATH_GO_INTEGRATION_TEST_COVERAGE_HTML_OUT})
	go tool cover -html ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH} -o ${ENV_PATH_GO_INTEGRATION_TEST_COVERAGE_HTML_OUT}

helpGoTestIntegration:
	@echo "== go integration test help start"
	@echo ""
	@echo "integration tests coverage see: https://go.dev/testing/coverage/"
	@echo ""
	@echo "make envGoTestIntegration          - show env for go integration test"
	@echo "make cleanGoCoverDirRoot           - clean go cover dir root"
	@echo "make pathCheckGoCoverDir           - check go cover dir"
	@echo "make cleanGoCoverDir               - clean go cover dir"
	@echo "make testIntegrationBuild          - build go integration test"
	@echo "make testIntegrationRun            - run go integration test"
	@echo "make testIntegrationPercent        - percent after testing"
	@echo "make testIntegrationReporting      - reporting after testIntegrationRun to: ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}"
	@echo "make testIntegrationReportingShow  - show after testIntegrationReporting read: ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}"
	@echo "make testIntegrationReportingHtml  - out html after testIntegrationReporting to: ${ENV_PATH_GO_INTEGRATION_TEST_COVERAGE_HTML_OUT}"
	@echo ""
	@echo "== go integration test help end"
	@echo ""