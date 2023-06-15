# this file must use as base Makefile

checkEnvGOPATH:
ifndef GOPATH
	@echo Environment variable GOPATH is not set
	exit 1
endif

modClean:
	@echo "=> try to clean: go.sum vendor/"
	@$(RM) go.sum
	@$(RM) -r vendor/
	@echo "=> finish clean: go.sum vendor/"

modList:
	$(info show go list -mod=readonly -json all)
	@go list -mod=readonly -json all

modGraphDependencies:
	@go mod graph

modVerify:
	@go mod verify

modTidy:
	@go mod tidy -x -v

modDownload:
	@go mod download -x

modVendor:
	@go mod vendor

modFetch:
	@echo "-> can fetch last version github.com/gin-gonic/gin as"
	@echo "go list -m -versions github.com/gin-gonic/gin | awk '{print \044\061 \042 lastest: \042 \044\0116\0106 }'"
	@echo ""
	@echo "full version update v1.x"
	@go list -m -versions github.com/gin-gonic/gin

modFmt:
	@go fmt -x ./...

modVet:
	@go vet ./...

modCiLintInstall:
	$(info go lint tools use: https://golangci-lint.run/)
ifeq ($(OS),Windows_NT)
	@echo "scoop install main/golangci-lint"
	@scoop install main/golangci-lint
else
ifeq ($(shell uname),Darwin)
	@echo "brew install golangci-lint"
	@brew install golangci-lint
else
	@echo "install golangci-lint by offical script"
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $$(go env GOPATH)/bin latest
endif
endif

modLintRun:
	@echo "-> if run error try fix: make modCiLintInstall"
	golangci-lint run -c .golangci.yaml

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