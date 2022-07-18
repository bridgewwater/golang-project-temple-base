# this file must use as base Makefile and add

## can use as: go env -w GOPROXY=https://goproxy.cn,direct

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
	@echo "=> show go list -m -json all"
	go list -m -json all

modGraphDependencies:
	go mod graph

modVerify:
	# in GOPATH must use [ GO111MODULE=on go mod ] to use
	# open goproxy add env: [ go env -w GOPROXY=https://goproxy.cn,direct ]
	go mod verify

modDownload:
	go mod download && go mod vendor

modTidy:
	go mod tidy

dep: modVerify modTidy modDownload
	@echo "-> just check depends finish"

modFetch:
	@echo "each mod like [ github.com/stretchr/testify ] fetch last version as"
	go list -mod=readonly -m -versions github.com/stretchr/testify | awk '{print $$1 " lastest: " $$NF}'

# print as: $make helpGoMod
helpGoMod:
	@echo "Help: MakeGoMod.mk"
	@echo "this project use go mod, so golang version must 1.12+"
	@echo "~> make modClean             - will clean ./go.sum and ./vendor"
	@echo "~> make modList              - list all depends as: go list -m -json all"
	@echo "~> make modGraphDependencies - see depends graph of this project"
	@echo "~> make modVerify            - verify as: go mod verify"
	@echo "~> make modDownload          - download as: go mod download and go mod vendor"
	@echo "~> make modTidy              - tidy depends graph of project as go mod tidy"
	@echo "~> make dep                  - check depends of project and download all, parent task is: modVerify modDownload"
	@echo "~> make modFetch             - check last version of one lib"
	@echo ""
