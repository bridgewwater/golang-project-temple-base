## for golang godoc task
# ## godoc start
# ENV_GO_GODOC_PORT_NUMBER=36060
# ENV_GO_GODOC_EXPORT_PATH=build/doc
# ENV_GO_GODOC_EXPORT_PKG =
# include z-MakefileUtils/go-doc.mk
# ## godoc end
#
## godoc kits from
# usage doc https://pkg.go.dev/golang.org/x/tools/cmd/godoc
# source https://cs.opensource.google/go/x/tools
# env
ENV_ROOT_GO_GODOC_PORT_NUMBER=${ENV_GO_GODOC_PORT_NUMBER}
ENV_ROOT_GO_GODOC_EXPORT_PATH=${ENV_GO_GODOC_EXPORT_PATH}
ENV_ROOT_GO_GODOC_EXPORT_PKG=${ENV_GO_GODOC_EXPORT_PKG}

.PHONY go.doc.install:
go.doc.install:
	@echo "install godoc"
	@echo "source: https://cs.opensource.google/go/x/tools"
	@echo "usage see: https://pkg.go.dev/golang.org/x/tools/cmd/godoc"
	go install golang.org/x/tools/cmd/godoc@latest
	@echo "install golds"
	@echo "source: https://github.com/go101/golds"
	go install go101.org/golds@latest

.PHONY go.doc.http:
go.doc.http:
	@echo "if not found godoc try: go.doc.install"
	@echo "runt at local port ${ENV_ROOT_GO_GODOC_PORT_NUMBER}"
	godoc -http=:${ENV_ROOT_GO_GODOC_PORT_NUMBER} -index

.PHONY go.doc.http.playground:
go.doc.http.playground:
	@echo "if not found godoc try: go.doc.install"
	@echo " open play mode"
	@echo "runt at local port ${ENV_ROOT_GO_GODOC_PORT_NUMBER}"
	godoc -http=:${ENV_ROOT_GO_GODOC_PORT_NUMBER} -index -play

go.doc.export:
	-wget -r -np -N -E -k -p -erobots=off --no-host-directories --no-use-server-timestamps \
	-P ${ENV_ROOT_GO_GODOC_EXPORT_PATH} \
	"http://localhost:${ENV_ROOT_GO_GODOC_PORT_NUMBER}/pkg/${ENV_ROOT_GO_GODOC_EXPORT_PKG}"

go.doc.golds.local:
	@echo "if not found godoc try: go.doc.install"
	golds ./...

go.doc.golds.export:
	golds -gen -nouses -plainsrc -wdpkgs-listing=promoted ./...

.PHONY help.go.doc:
help.go.doc:
	@echo "Help: go-doc.mk"
	@echo ""
	@echo "~> make go.doc.install               - install go doc kits"
	@echo ""
	@echo "~> make go.doc.golds.local           - run go doc server with golds at local"
	@echo "~> make go.doc.golds.export          - export go doc with golds at local package"
	@echo ""
	@echo "~> make go.doc.http                  - run go doc server at local"
	@echo "~> make go.doc.http.playground       - run go doc server at local open playground mode"
	@echo "~> make go.doc.export                - export go doc package by ${ENV_ROOT_GO_GODOC_EXPORT_PKG} with wget"
	@echo ""