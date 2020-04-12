# this file must use as base Makefile

modClean:
	@echo "=> try to clean ./go.sum and ./vendor"
	@if [ -f ./go.sum ]; \
	then rm -f ./go.sum && echo "~> cleaned file ./go.sum"; \
	else echo "~> has cleaned file ./go.sum"; \
	fi
	@if [ -d ./vendor ]; \
	then rm -rf ./vendor && echo "~> cleaned folder ./vendor";\
	else echo "~> has cleaned folder ./vendor"; \
	fi

modList:
	@echo "// show go list -m -json all"
	@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then GOPROXY="$(ENV_GO_PROXY)" go list -m -json all; \
	else go list -m -json all; \
	fi

modGraphDependencies:
	@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then echo "-> now use GOPROXY=$(ENV_GO_PROXY)"; \
	fi
	-@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then GOPROXY="$(ENV_GO_PROXY)" GO111MODULE=on go mod graph; \
	else GO111MODULE=on go mod graph; \
	fi

modVerify:
	# in GOPATH must use [ GO111MODULE=on go mod ] to use
	# open goproxy to build change Makefile: [ ENV_NEED_PROXY=1 ]
	@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then echo "-> now use GOPROXY=$(ENV_GO_PROXY)"; \
	fi
	@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then GOPROXY="$(ENV_GO_PROXY)" GO111MODULE=on go mod verify; \
	else GO111MODULE=on go mod verify; \
	fi

modDownload:
	@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then echo "-> now use GOPROXY=$(ENV_GO_PROXY)"; \
	fi
	@echo "=> If error can use [ make modVerify ] to fix"
	@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then GOPROXY="$(ENV_GO_PROXY)" GO111MODULE=on go mod download && GOPROXY="$(ENV_GO_PROXY)" GO111MODULE=on go mod vendor; \
	else GO111MODULE=on go mod download && GO111MODULE=on go mod vendor; \
	fi

modTidy:
	@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then echo "-> now use GOPROXY=$(ENV_GO_PROXY)"; \
	fi
	-if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then GOPROXY="$(ENV_GO_PROXY)" GO111MODULE=on go mod tidy; \
	else GO111MODULE=on go mod tidy; \
	fi

dep: modVerify modDownload
	@echo "-> just check depends below"

modFetch:
	@echo "can fetch last version as"
	go list -m -versions github.com/gin-gonic/gin | awk '{print $$1 " lastest: " $$NF}'

helpGoMod:
	@echo "Help: MakeGoMod.mk"
	@echo "this project use go mod, so golang version must 1.12+"
	@if [ $(ENV_NEED_PROXY) -eq 1 ]; \
	then echo "-> now use GOPROXY=$(ENV_GO_PROXY)"; \
	fi
	@echo "~> make modClean             - will clean ./go.sum and ./vendor"
	@echo "~> make modList              - list all depends as: go list -m -json all"
	@echo "~> make modGraphDependencies - see depends graph of this project"
	@echo "~> make modVerify            - verify as: go mod verify"
	@echo "~> make modDownload          - download as: go mod download and go mod vendor"
	@echo "~> make modTidy              - tidy depends graph of project as go mod tidy"
	@echo "~> make dep                  - check depends of project and download all, parent task is: modVerify modDownload"
	@echo "~> make modFetch             - check last version of one lib"
	@echo ""
