## config-file

`go-release.yml`

### config

```yaml
name: go-release

on:
  push:
    tags:
      - '*' # Push events to matching *, i.e. 1.0.0 v1.0, v20.15.10

permissions:
  contents: write

jobs:
  go-release-cross:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Go SDK
        uses: actions/setup-go@v4
        with:
          go-version: '^1.18'
          cache: false
      - name: Build Release binary
        run: |
          make dep cleanAllDist
          make test
          # make distPlatformTarCommonUse
          # make distPlatformTarAll
      - uses: softprops/action-gh-release@master
        name: Create Release
        if: startsWith(github.ref, 'refs/tags/')
        with:
          ## with permissions to create releases in the other repo
          token: "${{ secrets.GITHUB_TOKEN }}"
          #  body_path: ${{ github.workspace }}-CHANGELOG.txt
          prerelease: true
          # https://github.com/isaacs/node-glob
          # files: |
          #   **/*.tar.gz
          #   **/*.sha256

```

