# this file must use as base Makefile

# test max time
ROOT_TEST_MAX_TIME := 1m

actionInfo:
	@echo "you can use #=> find set"
	@echo "install:"
	# - export GO111MODULE=on
	# - go get -t -v $(ROOT_TEST_LIST)
	@echo "script:"
	# - go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)

actionInstall:
	GO111MODULE=on go get -t -v $(ROOT_TEST_LIST)

actionTest:
	GO111MODULE=on go test -test.v $(ROOT_TEST_LIST) -timeout $(ROOT_TEST_MAX_TIME)

actionTestBenchmark:
	GO111MODULE=on go test -test.benchmem $(ROOT_TEST_LIST)

actionTestFail:
	GO111MODULE=on go test -test.v $(ROOT_TEST_LIST) -timeout $(ROOT_TEST_MAX_TIME) | grep FAIL --color

actionCoverage:
	#=> GO111MODULE=on go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)
	@GO111MODULE=on go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)

actionCoverageLocal:
	@echo "-> use goconvey at https://github.com/smartystreets/goconvey"
	@echo "-> see report at http://localhost:8080"
	which goconvey
	goconvey -depth=1 -launchBrowser=false -workDir=$$PWD

actionCodecovPush: actionCoverage
	@echo "must finish before CI build"
	@echo "set env: CODECOV_TOKEN="
	@echo "add task of run: bash <(curl -s https://codecov.io/bash)"

helpGoAction:
	@echo "Help: MakeAction.mk"
	@echo "~> make actionInfo          - show action.yml base info"
	@echo "~> make actionInstall       - run project to test action"
	@echo "~> make actionTest          - run project test"
	@echo "~> make actionTestBenchmark - run project test benchmark"
	@echo "~> make actionTestFail      - run project test fast find FAIL"
	@echo "~> make actionCoverage      - run project coverage"
	@echo "~> make actionCoverageLocal - run project coverage local as tools https://github.com/smartystreets/goconvey"
	@echo ""