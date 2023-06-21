## for golang test task
# include z-MakefileUtils/MakeGoList.mk

goListThisPkg:
	$(info -> list this package)
	@go list ./...

goListThisImports:
	$(info -> list this package import packages)
	@go list -f '{{.ImportPath}} {{.Imports}}' ./...

goListThisDeps:
	$(info -> list this package will import packages)
	@go list -f '{{.ImportPath}} {{.Deps}}' ./...