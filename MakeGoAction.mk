# this file must use as base Makefile

# test max time
ROOT_TEST_MAX_TIME := 1m

actionFile:
	@echo "you can use #=> find set"
	@echo "install:"
	# - export GO111MODULE=on
	# - go get -t -v $(ROOT_TEST_LIST)
	@echo "script:"
	# - go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)

actionInstall:
	#=> GOPROXY=$(ENV_GO_PROXY) GO111MODULE=on go get -t -v $(ROOT_TEST_LIST)
	@GOPROXY=$(ENV_GO_PROXY) GO111MODULE=on go get -t -v $(ROOT_TEST_LIST)

actionTest:
	GO111MODULE=on go test -test.v $(ROOT_TEST_LIST) -timeout $(ROOT_TEST_MAX_TIME)

actionTestFail:
	GO111MODULE=on go test -test.v $(ROOT_TEST_LIST) -timeout $(ROOT_TEST_MAX_TIME) | grep FAIL --color

actionConvey:
	#=> GO111MODULE=on go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)
	@GO111MODULE=on go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)

actionConveyLocal:
	@echo "-> use goconvey at https://github.com/smartystreets/goconvey"
	@echo "-> see report at http://localhost:8080"
	which goconvey
	goconvey -depth=1 -launchBrowser=false -workDir=$$PWD

helpGoTravis:
	@echo "Help: MakeTravis.mk"
	@echo "~> make actionFile        - show .action.yml file can right"
	@echo "~> make actionInstall     - run project to test action"
	@echo "~> make actionTest        - run project test"
	@echo "~> make actionTestFail    - run project test fast find FAIL"
	@echo "~> make actionConvey      - run project convery"
	@echo "~> make actionConveyLocal - run project convery local as tools https://github.com/smartystreets/goconvey"
	@echo ""