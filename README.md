[![ci](https://github.com/bridgewwater/golang-project-temple-base/actions/workflows/ci.yml/badge.svg)](https://github.com/bridgewwater/golang-project-temple-base/actions/workflows/ci.yml)
[![TravisBuildStatus](https://api.travis-ci.com/bridgewwater/golang-project-temple-base.svg?branch=main)](https://travis-ci.com/bridgewwater/golang-project-temple-base)

[![go mod version](https://img.shields.io/github/go-mod/go-version/bridgewwater/golang-project-temple-base?label=go.mod)](https://github.com/bridgewwater/golang-project-temple-base)
[![GoDoc](https://godoc.org/github.com/bridgewwater/golang-project-temple-base?status.png)](https://godoc.org/github.com/bridgewwater/golang-project-temple-base)
[![goreportcard](https://goreportcard.com/badge/github.com/bridgewwater/golang-project-temple-base)](https://goreportcard.com/report/github.com/bridgewwater/golang-project-temple-base)

[![GitHub license](https://img.shields.io/github/license/bridgewwater/golang-project-temple-base)](https://github.com/bridgewwater/golang-project-temple-base)
[![codecov](https://codecov.io/gh/bridgewwater/golang-project-temple-base/branch/main/graph/badge.svg)](https://codecov.io/gh/bridgewwater/golang-project-temple-base)
[![GitHub latest SemVer tag)](https://img.shields.io/github/v/tag/bridgewwater/golang-project-temple-base)](https://github.com/bridgewwater/golang-project-temple-base/tags)
[![github release](https://img.shields.io/github/v/release/bridgewwater/golang-project-temple-base?style=social)](https://github.com/bridgewwater/golang-project-temple-base/releases)

### cli tools to init project fast

```bash
$ curl -L --fail https://raw.githubusercontent.com/bridgewwater/golang-project-temple-base/main/temp-golang-base
# let temp-golang-base file folder under $PATH
$ chmod +x temp-golang-base
# see how to use
$ temp-golang-base -h
```

## for what

- this project used to GitHub.com with golang

## Contributing

[![Contributor Covenant](https://img.shields.io/badge/contributor%20covenant-v1.4-ff69b4.svg)](.github/CONTRIBUTING_DOC/CODE_OF_CONDUCT.md)
[![GitHub contributors](https://img.shields.io/github/contributors/bridgewwater/golang-project-temple-base)](https://github.com/bridgewwater/golang-project-temple-base/graphs/contributors)

We welcome community contributions to this project.

Please read [Contributor Guide](.github/CONTRIBUTING_DOC/CONTRIBUTING.md) for more information on how to get started.

## Features

- [ ] more perfect test case coverage
- [ ] more perfect benchmark case

## usage

- use this template, replace list below
  - `github.com/bridgewwater/golang-project-temple-base` to your package name
  - `bridgewwater` to your owner name
  - `golang-project-temple-base` to your project name
  - `go 1.18`, `^1.18`, `1.18.10` to new go version for dev

## evn

- minimum go version: go 1.18

### libs

| lib                                 | version |
|:------------------------------------|:--------|
| https://github.com/stretchr/testify | v1.8.4  |

# dev

## depends

in go mod project

```bash
# warning use privte git host must set
# global set for once
# add private git host like github.com to evn GOPRIVATE
$ go env -w GOPRIVATE='github.com'
# use ssh proxy
# set ssh-key to use ssh as http
$ git config --global url."git@github.com:".insteadOf "http://github.com/"
# or use PRIVATE-TOKEN
# set PRIVATE-TOKEN as gitlab or gitea
$ git config --global http.extraheader "PRIVATE-TOKEN: {PRIVATE-TOKEN}"
# set this rep to download ssh as https use PRIVATE-TOKEN
$ git config --global url."ssh://github.com/".insteadOf "https://github.com/"

# before above global settings
# test version info
$ git ls-remote -q http://github.com/bridgewwater/golang-project-temple-base.git

# test depends see full version
$ go list -mod readonly -v -m -versions github.com/bridgewwater/golang-project-temple-base
# or use last version add go.mod by script
$ echo "go mod edit -require=$(go list -mod=readonly -m -versions github.com/bridgewwater/golang-project-temple-base | awk '{print $1 "@" $NF}')"
$ echo "go mod vendor"
```

```bash
$ make init dep
```

- test code

```bash
$ make test testBenchmark
```

edit [main.go](main.go) file and run

```bash
# run at env dev
$ make dev

# run at env ordinary
$ make run
```

- ci to fast check

```bash
$ make ci
```

### docker

```bash
# then test build as test/Dockerfile
$ make dockerTestRestartLatest
# clean test build
$ make dockerTestPruneLatest

# more info see
$ make helpDocker
```
