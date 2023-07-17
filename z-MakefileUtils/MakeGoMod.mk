## for golang test task
# include z-MakefileUtils/MakeGoMod.mk
# windows use must install tools
# https://scoop.sh/#/apps?q=gow&s=0&d=1&o=true
# scoop install gow

checkEnvGOPATH:
ifndef GOPATH
	@echo Environment variable GOPATH is not set
	exit 1
endif

ENV_GO_PATH=$(shell go env GOPATH)

modFetch:
	@echo "-> can fetch last version github.com/gin-gonic/gin as"
	@echo "go list -mod readonly -m -versions github.com/gin-gonic/gin | awk '{print \044\061 \042 lastest: \042 \044\0116\0106 }'"
	@echo ""
ifeq ($(OS),Windows_NT)
	@go list -mod mod -m -versions github.com/stretchr/testify
else
	@echo "last version"
	@go list -mod mod -m -versions github.com/stretchr/testify | awk '{print $$1 " lastest: " $$NF }'
endif

modName:
ifeq ($(OS),Windows_NT)
	@echo "-> this package go mod name: $(subst module ,,$(shell head -n 1 go.mod))"
else
	@echo "-> this package go mod name: $(subst module ,,$(shell head -n 1 go.mod))"
endif

modClean:
	@echo "=> try to clean: go.sum vendor/"
	@$(RM) go.sum
	@$(RM) -r vendor/
	@echo "=> finish clean: go.sum vendor/"

modList:
	$(info show go list -mod readonly -json all)
	@go list -mod readonly -json all

modGraphDependencies:
	@go mod graph

modVerify:
	@go mod verify

modTidy:
	@go mod tidy -v

modDownload:
	@go mod download -x

modVendor:
	@go mod vendor

modFmt:
	@go fmt -x ./...

modVet:
	@go vet ./...

modWhy:
	@go mod why ./...

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
	@echo "install golangci-lint to $(go env GOPATH)/bin"
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
endif
endif
	golangci-lint --version


modLintRun:
	@echo "-> if run error try fix: make modCiLintInstall"
	golangci-lint run -c .golangci.yaml

helpGoMod:
	@echo "Help: MakeGoMod.mk"
	@echo "-> go mod document at: https://go.dev/ref/mod"
	@echo "this project use go mod, so golang version must 1.12+"
	@echo "~> make modName              - will show this go mod name"
	@echo "~> make modClean             - will clean ./go.sum and ./vendor"
	@echo "~> make modList              - list all depends as: go list -m -json all"
	@echo "~> make modGraphDependencies - see depends graph of this project"
	@echo "~> make modVerify            - verify as: go mod verify"
	@echo "~> make modDownload          - download as: go mod download and go mod vendor"
	@echo "~> make modTidy              - tidy depends graph of project as go mod tidy"
	@echo "~> make dep                  - check depends of project and download all, parent task is: modVerify modDownload"
	@echo "~> make modFetch             - check last version of one lib"
	@echo ""