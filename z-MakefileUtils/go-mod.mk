## for golang go.mod task
#include z-MakefileUtils/go-go.mod.mk
#
# and add dep as
#dep: go.mod.verify go.mod.download go.mod.tidy
#
#style: go.mod.verify go.mod.tidy go.mod.fmt go.mod.lint.run
#
#ci: style go.mod.vet test

# windows use must install tools
# https://scoop.sh/#/apps?q=busybox&s=0&d=1&o=true
# scoop install main/busybox

checkEnvGOPATH:
ifndef GOPATH
	@echo Environment variable GOPATH is not set
	exit 1
endif

ENV_GO_PATH=$(shell go env GOPATH)

.PHONY: go.mod.fetch
go.mod.fetch:
	@echo "-> can fetch last version github.com/gin-gonic/gin as"
	@echo "go list -mod readonly -m -versions github.com/gin-gonic/gin | awk '{print \044\061 \042 lastest: \042 \044\0116\0106 }'"
	@echo ""
ifeq ($(OS),Windows_NT)
	@go list -mod mod -m -versions github.com/stretchr/testify
else
	@echo "last version"
	@go list -mod mod -m -versions github.com/stretchr/testify | awk '{print $$1 " lastest: " $$NF }'
endif

.PHONY: go.mod.name
go.mod.name:
ifeq ($(OS),Windows_NT)
	@echo "-> this package go mod name: $(subst module ,,$(shell head -n 1 go.mod))"
else
	@echo "-> this package go mod name: $(subst module ,,$(shell head -n 1 go.mod))"
endif

.PHONY: go.mod.clean
go.mod.clean:
	@echo "=> try to clean: go.sum vendor/"
	@$(RM) go.sum
	@$(RM) -r vendor/
	@echo "=> finish clean: go.sum vendor/"

.PHONY: go.mod.list
go.mod.list:
	$(info show go list -mod readonly -json all)
	@go list -mod readonly -json all

.PHONY: go.mod.graph.dependencies
go.mod.graph.dependencies:
	@go mod graph

.PHONY: go.mod.verify
go.mod.verify:
	@go mod verify

.PHONY: go.mod.tidy
go.mod.tidy:
	@go mod tidy -v

.PHONY: go.mod.download
go.mod.download:
	@go mod download -x

.PHONY: go.mod.update
go.mod.update:
	@go get -u
	@go mod tidy -v

.PHONY: go.mod.update.recursively
go.mod.update.recursively:
	@go get -u ./...
	@go mod tidy -v

.PHONY: go.mod.update.all
go.mod.update.all:
	@echo "-> update all modules from the build list from go.mod"
	@echo "more info see: https://go.dev/ref/mod#glos-build-list"
	@go get -u all
	@go mod tidy -v

.PHONY: go.mod.vendor
go.mod.vendor:
	@go mod vendor

.PHONY: go.mod.fmt
go.mod.fmt:
	@go fmt -x ./...

.PHONY: go.mod.vet
go.mod.vet:
	@go vet ./...

.PHONY: go.mod.why
go.mod.why:
	@go mod why ./...

.PHONY: go.mod.ci.lint.install
go.mod.ci.lint.install:
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

.PHONY: go.mod.lint.run
go.mod.lint.run:
	@echo "-> if run error try fix: make go.mod.ci.lint.install"
	@golangci-lint --version
	golangci-lint run -c .golangci.yaml

.PHONY: go.mod.lint.run.v2
go.mod.lint.run.v2:
	@echo "-> if run error try fix: make go.mod.ci.lint.install"
	@golangci-lint --version
	golangci-lint run -c .golangci-v2.yaml

.PHONY: help.go.mod
help.go.mod:
	@echo "Help: go-mod.mk"
	@echo ""
	@echo "-> go mod document at: https://go.dev/ref/mod"
	@echo "this project use go mod, so golang version must 1.12+"
	@echo "~> make go.mod.name                  - will show this go mod name"
	@echo "~> make go.mod.clean                 - will clean ./go.sum and ./vendor"
	@echo "~> make go.mod.list                  - list all depends as: go list -m -json all"
	@echo "~> make go.mod.graph.dependencies    - see depends graph of this project"
	@echo "~> make go.mod.verify                - verify as: go mod verify"
	@echo "~> make go.mod.download              - download as: go mod download and go mod vendor"
	@echo "~> make go.mod.tidy                  - tidy depends graph of project as go mod tidy"
	@echo "~> make go.mod.update                - update depends as: go get -u"
	@echo "~> make go.mod.update.recursively    - update depends recursively as: go get -u ./..."
	@echo "~> make go.mod.update.all            - update depends modules from the build list from go.mod as: go get -u all"
	@echo "~> make go.mod.fetch                 - check last version of one lib"
	@echo ""
