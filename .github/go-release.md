## config-file

`go-release.yml`

## config

```yml
name: go Create release and push binary

on:
  push:
    tags:
      - '*' # Push events to matching *, i.e. 1.0.0 v1.0, v20.15.10

#env:
  # name of docker image
#  DOCKER_HUB_USER: sinlov

permissions:
  contents: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Build Release binary
      run: |
        make dep
        make distPlatformTarAll
    - uses: softprops/action-gh-release@master
      name: Create Release
      if: startsWith(github.ref, 'refs/tags/')
      with:
        ## with permissions to create releases in the other repo
        token: "${{ secrets.GITHUB_TOKEN }}"
#        body_path: ${{ github.workspace }}-CHANGELOG.txt
        prerelease: true
        # https://github.com/isaacs/node-glob
        files: |
          **/*.tar.gz
          **/*.sha256


```