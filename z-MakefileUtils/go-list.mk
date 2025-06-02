## for golang test task
# include z-MakefileUtils/go-list.mk

.PHONY: go.list.install
go.list.install:
	go get -t -v ./...

.PHONY: go.list.build
go.list.build:
	go build -v ./...

.PHONY: go.list.this.pkg
go.list.this.pkg:
	$(info -> list this package)
	@go list ./...

.PHONY: go.list.this.imports
go.list.this.imports:
	$(info -> list this package import packages)
	@go list -f '{{.ImportPath}} {{.Imports}}' ./...

.PHONY: go.list.this.deps
go.list.this.deps:
	$(info -> list this package will import packages)
	@go list -f '{{.ImportPath}} {{.Deps}}' ./...

.PHONY: help.go.list
help.go.list:
	@echo "Help: go-list.mk"
	@echo ""
	@echo "-> go list document at: https://go.dev/ref/mod"
	@echo "this project use go mod, so golang version must 1.12+"
	@echo "~> make go.list.install              - install this package"
	@echo "~> make go.list.build                - build this package"
	@echo "~> make go.list.this.pkg             - list this package"
	@echo "~> make go.list.this.imports         - list this package import packages"
	@echo "~> make go.list.this.deps            - list this package will import packages"
	@echo ""
