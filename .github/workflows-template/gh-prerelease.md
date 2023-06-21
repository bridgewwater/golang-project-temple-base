## softprops/action-gh-release

- [https://github.com/softprops/action-gh-release](https://github.com/softprops/action-gh-release)

`gh-prerelease.yml`

```yml
name: gh prerelease

on:
  push:
    tags:
      - '*' # Push events to matching *, i.e. 1.0.0 v1.0, v20.15.10

permissions:
  contents: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - uses: softprops/action-gh-release@master
        name: Create Prerelease
        if: startsWith(github.ref, 'refs/tags/')
        with:
          ## with permissions to create releases in the other repo
          token: "${{ secrets.GITHUB_TOKEN }}"
        # body_path: ${{ github.workspace }}-CHANGELOG.txt
          prerelease: true
          # https://github.com/isaacs/node-glob
        #  files: |
        #    **/*.tar.gz
        #    **/*.sha256
