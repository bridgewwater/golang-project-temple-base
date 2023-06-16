## config-file

`golang-codecov.yml`

```yml
name: golang-codecov

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  golang-codecov:
    name: glang-codecov
    strategy:
      matrix:
        go:
          - '^1.17'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Go SDK
        uses: actions/setup-go@v4
        with:
          go-version: ${{ matrix.go }}
          cache: false
      - name: Print env info
        run: |
          go env
          go version

      - name: Run go build
        run: go build -v ./...

      - name: Run test coverage
        run: go test -cover -coverprofile coverage.txt -covermode count -tags test -coverpkg ./... -v ./...

      - name: Codecov
        uses: codecov/codecov-action@v3.1.4
        with:
          token: ${{secrets.CODECOV_TOKEN}}
          files: coverage.txt
#          verbose: true

```