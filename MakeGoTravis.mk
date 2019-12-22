# this file must use as base Makefile

travisFile:
	@echo "you can use #=> find set"
	@echo "install:"
	# - export GO111MODULE=on
	# - go get -t -v $(ROOT_TEST_LIST)
	@echo "script:"
	# - go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)

travisInstall:
	#=> GOPROXY=$(ENV_GO_PROXY) GO111MODULE=on go get -t -v $(ROOT_TEST_LIST)
	@GOPROXY=$(ENV_GO_PROXY) GO111MODULE=on go get -t -v $(ROOT_TEST_LIST)

travisTest:
	GO111MODULE=on go test -test.v $(ROOT_TEST_LIST) -timeout $(ROOT_TEST_MAX_TIME)

travisTestFail:
	GO111MODULE=on go test -test.v $(ROOT_TEST_LIST) -timeout $(ROOT_TEST_MAX_TIME) | grep FAIL --color

travisConvey:
	#=> GO111MODULE=on go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)
	@GO111MODULE=on go test -cover -coverprofile=coverage.txt -covermode=atomic -v $(ROOT_TEST_LIST)

travisConveyLocal:
	@echo "-> use goconvey at https://github.com/smartystreets/goconvey"
	@echo "-> see report at http://localhost:8080"
	which goconvey
	goconvey -depth=1 -launchBrowser=false -workDir=$$PWD

helpGoTravis:
	@echo "Help: MakeTravis.mk"
	@echo "~> make travisFile        - show .travis.yml file can right"
	@echo "~> make travisInstall     - run project to test travis"
	@echo "~> make travisTest        - run project test"
	@echo "~> make travisTestFail    - run project test fast find FAIL"
	@echo "~> make travisConvey      - run project convery"
	@echo "~> make travisConveyLocal - run project convery local as tools https://github.com/smartystreets/goconvey"
	@echo ""