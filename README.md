[![TravisBuildStatus](https://api.travis-ci.org/bridgewwater/golang-project-temple-base.svg?branch=master)](https://travis-ci.org/bridgewwater/golang-project-temple-base)
[![GoDoc](https://godoc.org/github.com/bridgewwater/golang-project-temple-base?status.png)](https://godoc.org/github.com/bridgewwater/golang-project-temple-base/)
[![GoReportCard](https://goreportcard.com/badge/github.com/bridgewwater/golang-project-temple-base)](https://goreportcard.com/report/github.com/bridgewwater/golang-project-temple-base)
[![codecov](https://codecov.io/gh/bridgewwater/golang-project-temple-base/branch/master/graph/badge.svg)](https://codecov.io/gh/bridgewwater/golang-project-temple-base)

## for what

- this project used to github golang

## depends

in go mod project

```bash
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
$ go list -v -m -versions github.com/bridgewwater/golang-project-temple-base

# see full version
$ go list -v -m -versions github.com/bridgewwater/golang-project-temple-base
# use as
$ echo "go mod edit -require=$(go list -m -versions github.com/bridgewwater/golang-project-temple-base.git | awk '{print $1 "@" $NF}')"
$ echo "go mod vendor"
```

## use

- use to replace
 `bridgewwater/golang-project-temple-base` to you code

- and run

```bash
make init
```

add main.go file and run

```bash
make run
```

# dev

## evn

- golang sdk 1.13+

## docker

base docker file can replace
