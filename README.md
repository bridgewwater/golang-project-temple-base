[![go-ubuntu](https://github.com/bridgewwater/golang-project-temple-base/workflows/go-ubuntu/badge.svg?branch=main)](https://github.com/sinlov/golang-project-temple-base/actions)
[![TravisBuildStatus](https://api.travis-ci.com/bridgewwater/golang-project-temple-base.svg?branch=main)](https://travis-ci.com/bridgewwater/golang-project-temple-base)
[![GoDoc](https://godoc.org/github.com/bridgewwater/golang-project-temple-base?status.png)](https://godoc.org/github.com/bridgewwater/golang-project-temple-base/)
[![GoReportCard](https://goreportcard.com/badge/github.com/bridgewwater/golang-project-temple-base)](https://goreportcard.com/report/github.com/bridgewwater/golang-project-temple-base)
[![codecov](https://codecov.io/gh/bridgewwater/golang-project-temple-base/branch/main/graph/badge.svg)](https://codecov.io/gh/bridgewwater/golang-project-temple-base)

## for what

- this project used to github golang

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
$ go list -v -m -versions github.com/bridgewwater/golang-project-temple-base
# or use last version add go.mod by script
$ echo "go mod edit -require=$(go list -m -versions github.com/bridgewwater/golang-project-temple-base | awk '{print $1 "@" $NF}')"
$ echo "go mod vendor"
```

## evn

- golang sdk 1.15+

# dev

```bash
make init
```

- test code

```bash
make test
```

add main.go file and run

```bash
make run
```

## docker

```bash
make helpDockerRun
```

docker file can replace

## use

- use to replace
  `bridgewwater/golang-project-temple-base` to you code

### cli tools to init project fast

```
$ curl -L --fail https://raw.githubusercontent.com/bridgewwater/golang-project-temple-base/master/temp-golang-base
# let temp-golang-base file folder under $PATH
$ chmod +x temp-golang-base
# see how to use
$ temp-golang-base -h
```
