# this file must use as base Makefile

# test max time
ENV_ROOT_TEST_ACTION_MAX_TIME:=5m

actionInfo:
	@echo "you can use #=> find set"
	@echo "install:"
	@echo "go get -t -v ${ENV_ROOT_TEST_LIST}"
	@echo "cover script set:"
	@echo "go test -cover -coverprofile coverage.txt -covermode set -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"
	@echo "cover script count:"
	@echo "go test -cover -coverprofile coverage.txt -covermode count -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"
	@echo "cover script atomic:"
	@echo "go test -cover -coverprofile coverage.txt -covermode atomic -coverpkg ./... -v ${ENV_ROOT_TEST_LIST}"

actionInstall:
	go get -t -v ${ENV_ROOT_TEST_LIST}

actionTest:
	go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_ACTION_MAX_TIME}

actionTestBenchmark:
	go test -run none -bench . -benchmem ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_ACTION_MAX_TIME}

actionTestFail:
	go test -test.v ${ENV_ROOT_TEST_LIST} -timeout ${ENV_ROOT_TEST_ACTION_MAX_TIME} | grep FAIL --color

actionCoverage:
	@go test -cover -coverprofile coverage.txt -covermode count -tags test -v ${ENV_ROOT_TEST_LIST}

actionCoverageAtomic:
	@go test -cover -coverprofile coverage.txt -covermode atomic -tags test -v ${ENV_ROOT_TEST_LIST}

actionCoverageBrowserLocal: actionCoverage
	@go tool cover -html coverage.txt

actionCodecovPush: actionCoverage
	@echo "must finish before CI build"
	@echo "set env: CODECOV_TOKEN="
	@echo "add task of run: bash <(curl -s https://codecov.io/bash)"

helpGoAction:
	@echo "Help: MakeAction.mk"
	@echo "~> make actionInfo                  - show action.yml base info"
	@echo "~> make actionInstall               - run project to test action"
	@echo "~> make actionTest                  - run project test"
	@echo "~> make actionTestBenchmark         - run project test benchmark"
	@echo "~> make actionTestFail              - run project test fast find FAIL"
	@echo "~> make actionCoverage              - run project coverage"
	@echo "~> make actionCoverageAtomic        - run project coverage as atomic"
	@echo "~> make actionCoverageBrowserLocal  - run project coverage and see at browser"
	@echo "~> make actionCodecovPush           - run project coverage push"
	@echo ""