## need `New repository secret`

- file `docker-image-tag.yml`
- `DOCKERHUB_TOKEN` from [hub.docker](https://hub.docker.com/settings/security)
- `IMAGE_BUILD_OS_NAME` like `alpine` and let `Dockerfile` under this folder

## buildx template

- file `docker-image-tag.yml`

```yaml
name: Docker Image buildx tag semver

permissions:
  contents: write

on:
  push:
    tags:
      - 'v*' # Push events to matching v*, i.e. v1.0.0 v1.0, v20.15.10

env:
  # name of docker image
  DOCKER_HUB_USER: bridgewwater
  IMAGE_NAME: golang-project-temple-base
  DOCKER_IMAGE_PLATFORMS: linux/amd64,linux/386,linux/arm64,linux/arm/v7

jobs:
  build:
    strategy:
      matrix:
        os: [ ubuntu-latest ]
        docker_image:
          - platform: linux/amd64
          - platform: linux/386
          - platform: linux/arm64
          - platform: linux/arm/v7
    runs-on: ubuntu-latest
    steps:
      -
        name: Checkout
        uses: actions/checkout@v3
      - name: Docker meta
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: ${{ env.DOCKER_HUB_USER }}/${{ env.IMAGE_NAME }}
          tags: |
            # type semver https://github.com/docker/metadata-action#typesemver
            type=semver,pattern={{version}}
      -
        name: Set up QEMU
        uses: docker/setup-qemu-action@v2
      -
        name: "Login into registry as user: env.DOCKER_HUB_USER"
        uses: docker/login-action@v2
        with:
          username: ${{ env.DOCKER_HUB_USER }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      -
        name: Build dry
        uses: docker/build-push-action@v4 # https://github.com/docker/build-push-action
        with:
          context: .
          file: Dockerfile
          platforms: ${{ matrix.docker_image.platform }}
          labels: ${{ steps.meta.outputs.labels }}
          tags: ${{ steps.meta.outputs.tags }}
          no-cache: false
          pull: true
          push: false

  push:
    runs-on: ubuntu-latest
    needs:
      - build
    steps:
      -
        name: Checkout
        uses: actions/checkout@v3
      -
        name: Docker meta
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: ${{ env.DOCKER_HUB_USER }}/${{ env.IMAGE_NAME }}
          tags: |
            # type semver https://github.com/docker/metadata-action#typesemver
            type=semver,pattern={{version}}
      -
        name: Set up QEMU
        uses: docker/setup-qemu-action@v2
      -
        name: "Login into registry as user: env.DOCKER_HUB_USER"
        uses: docker/login-action@v2
        with:
          username: ${{ env.DOCKER_HUB_USER }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      -
        name: Build and push
        id: docker_push
        uses: docker/build-push-action@v4 # https://github.com/docker/build-push-action
        with:
          context: .
          file: Dockerfile
          platforms: ${{ env.DOCKER_IMAGE_PLATFORMS }}
          labels: ${{ steps.meta.outputs.labels }}
          tags: ${{ steps.meta.outputs.tags }}
          no-cache: false
          pull: true
          push: true

#  release:
#    runs-on: ubuntu-latest
#    needs:
#      - push
#    steps:
#      - uses: softprops/action-gh-release@master # https://github.com/softprops/action-gh-release#-customizing
#        name: pre release
#        if: startsWith(github.ref, 'refs/tags/')
#        with:
#          ## with permissions to create releases in the other repo
#          token: "${{ secrets.GITHUB_TOKEN }}"
#          # body_path: ${{ github.workspace }}-CHANGELOG.txt
#          prerelease: true

```

## base template by shell

- just only support OS/ARCH `linux/amd64`

```yml
name: Docker Image build by tag on alpine

permissions:
  contents: write

on:
  push:
    tags:
      - '*' # Push events to matching *, i.e. 1.0.0 v1.0, v20.15.10

env:
  # name of docker image
  DOCKER_HUB_USER: bridgewwater
  IMAGE_BUILD_OS_NAME: alpine
  IMAGE_NAME: golang-project-temple-base

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Build the Docker image
      run: |
        docker build . --file Dockerfile --tag $IMAGE_NAME
    - name: "Login into registry as user: $DOCKER_HUB_USER"
      run: echo "${{ secrets.DOCKERHUB_TOKEN }}" | docker login -u $DOCKER_HUB_USER --password-stdin
    - name: Push image
      run: |
        # now pwd
        echo $PWD

        # parse docker image id
        IMAGE_ID=$DOCKER_HUB_USER/$IMAGE_NAME
        # lower case all git
        IMAGE_ID=$(echo $IMAGE_ID | tr '[A-Z]' '[a-z]')
        # ref get version
        VERSION=$(echo "${{ github.ref }}" | sed -e 's,.*/\(.*\),\1,')
        # replace v chat at tag
        [[ "${{ github.ref }}" == "refs/tags/"* ]] && VERSION=$(echo $VERSION | sed -e 's/^v//')
        # Use Docker `latest` tag convention when get main
        [ "$VERSION" == "main" ] && VERSION=latest
        # add docker build os
        VERSION=$VERSION-${IMAGE_BUILD_OS_NAME}

        echo IMAGE_ID=$IMAGE_ID
        echo VERSION=$VERSION
        # setting tag
        docker tag $IMAGE_NAME $IMAGE_ID:$VERSION

        # docker push
        docker push $IMAGE_ID:$VERSION

```

## buildx template by shell

```yml
name: Docker Image buildx by tag on alpine

permissions:
  contents: write

on:
  push:
    tags:
      - '*' # Push events to matching *, i.e. 1.0.0 v1.0, v20.15.10

env:
  # name of docker image
  DOCKER_HUB_USER: bridgewwater
  IMAGE_BUILD_OS_NAME: alpine
  IMAGE_NAME: golang-project-temple-base

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: "Login into registry as user: $DOCKER_HUB_USER"
      run: echo "${{ secrets.DOCKERHUB_TOKEN }}" | docker login -u $DOCKER_HUB_USER --password-stdin
    - name: Docker buildx ready
      run: |
        DOCKER_CLI_EXPERIMENTAL=enabled
        docker run --privileged --rm tonistiigi/binfmt --install all
        docker buildx create --use --name mybuilder
        docker buildx inspect mybuilder --bootstrap
    - name: Push image
      run: |
        # now pwd
        echo $PWD

        # parse docker image id
        IMAGE_ID=$DOCKER_HUB_USER/$IMAGE_NAME
        # lower case all git
        IMAGE_ID=$(echo $IMAGE_ID | tr '[A-Z]' '[a-z]')
        # ref get version
        VERSION=$(echo "${{ github.ref }}" | sed -e 's,.*/\(.*\),\1,')
        # replace v chat at tag
        [[ "${{ github.ref }}" == "refs/tags/"* ]] && VERSION=$(echo $VERSION | sed -e 's/^v//')
        # Use Docker `latest` tag convention when get main
        [ "$VERSION" == "main" ] && VERSION=latest
        # add docker build os
        VERSION=$VERSION-${IMAGE_BUILD_OS_NAME}

        echo IMAGE_ID=$IMAGE_ID
        echo VERSION=$VERSION
        # build and push
        docker buildx build -t $IMAGE_ID:$VERSION --platform=linux/arm,linux/arm64,linux/amd64 . --push

```