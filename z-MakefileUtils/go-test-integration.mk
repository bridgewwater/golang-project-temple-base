## for golang integration test task
# include z-MakefileUtils/go-test-integration.mk
# need tools: MakeBasicEnv.mk MakeDistTools.mk

# need args
# ENV_ROOT_TEST_LIST test list for most use case is ./...
# ENV_ROOT_TEST_MAX_TIME timeout for test case set
# ENV_ROOT_BUILD_PATH=build
# ENV_ROOT_BUILD_ENTRANCE=cmd/template-gitea-sinlov-cn-golang-tiny-lib/main.go
# ENV_ROOT_BUILD_BIN_NAME=${ROOT_NAME}
# ENV_RUN_INFO_ARGS=
# ENV_RUN_INFO_HELP_ARGS=
# can use as:
#
### go test go-test.mk start
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
### go test go-test.mk end

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

.PHONY: env.go.test.integration
env.go.test.integration:
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

.PHONY: test.go.integration.cover.dir.root.clean
test.go.integration.cover.dir.root.clean:
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

.PHONY: test.go.integration.cover.dir.clean
test.go.integration.cover.dir.clean:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_GO_COVER_DIR_PATH}
else
	@$(RM) -r ${ENV_PATH_GO_COVER_DIR_PATH}
endif
	$(info -> has clean ${ENV_PATH_GO_COVER_DIR_PATH})

.PHONY: test.go.integration.build
test.go.integration.build:
ifeq ($(OS),Windows_NT)
	@go build -cover -o $(subst /,\,${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}).exe -coverpkg ./... ${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ENTRANCE}
	@echo "-> finish build integration out path: $(subst /,\,${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}).exe"
else
	@go build -cover -o ${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH} -coverpkg ./... ${ENV_ROOT_GO_TEST_INTEGRATION_BUILD_ENTRANCE}
	@echo "-> finish build integration out path: ${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}"
endif

.PHONY: test.go.integration.run
test.go.integration.run: export GOCOVERDIR=$(strip ${ENV_PATH_GO_COVER_DIR_VALUE})
test.go.integration.run: test.go.integration.cover.dir.clean pathCheckGoCoverDir test.go.integration.build
ifeq ($(OS),Windows_NT)
	$(subst /,\,${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH}).exe ${ENV_ROOT_GO_TEST_INTEGRATION_RUN_ARGS}
else
	./${ENV_ROOT_GO_TEST_INTEGRATION_BIN_PATH} ${ENV_ROOT_GO_TEST_INTEGRATION_RUN_ARGS}
endif
	go tool covdata percent -i $(strip ${ENV_PATH_GO_COVER_DIR_VALUE})

.PHONY: test.go.integration.percent
test.go.integration.percent: export GOCOVERDIR=$(strip ${ENV_PATH_GO_COVER_DIR_VALUE})
test.go.integration.percent:
	go tool covdata percent -i $(strip ${ENV_PATH_GO_COVER_DIR_VALUE})

.PHONY: test.go.integration.reporting
test.go.integration.reporting:
	go tool covdata textfmt -i $(strip ${ENV_PATH_GO_COVER_DIR_VALUE}) -o ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}

.PHONY: test.go.integration.reporting.show
test.go.integration.reporting.show: test.go.integration.reporting
	$(info -> show by test coverage file: ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH})
	go tool cover -func ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}

.PHONY: test.go.integration.reporting.html
test.go.integration.reporting.html: pathCheckRootDist
	$(info -> out by test coverage file: ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH} to ${ENV_PATH_GO_INTEGRATION_TEST_COVERAGE_HTML_OUT})
	go tool cover -html ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH} -o ${ENV_PATH_GO_INTEGRATION_TEST_COVERAGE_HTML_OUT}

.PHONY: help.test.go.integration
help.test.go.integration:
	@echo "Help: go-test-integration.mk"
	@echo ""
	@echo "integration tests coverage see: https://go.dev/testing/coverage/"
	@echo ""
	@echo "~> make env.go.test.integration                           - show env for go integration test"
	@echo "~> make test.go.integration.cover.dir.root.clean          - clean go cover dir root at: ${ENV_PATH_GO_COVER_ROOT_DIR_PATH}"
	@echo "~> make test.go.integration.cover.dir.clean               - clean go cover dir at: ${ENV_PATH_GO_COVER_DIR_PATH}"
	@echo "~> make test.go.integration.build                         - build go integration test"
	@echo "~> make test.go.integration.percent                       - percent after testing"
	@echo "~> make test.go.integration.run                           - run go integration test"
	@echo "~> make test.go.integration.reporting                     - reporting after test.go.integration.run to: ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}"
	@echo "~> make test.go.integration.reporting.show                - show after test.go.integration.reporting read: ${ENV_PATH_GO_COV_DATA_TEXT_FMT_PATH}"
	@echo "~> make test.go.integration.reporting.html                - out html after test.go.integration.reporting to: ${ENV_PATH_GO_INTEGRATION_TEST_COVERAGE_HTML_OUT}"
	@echo ""
