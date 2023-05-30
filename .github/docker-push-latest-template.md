## need `New repository secret`

- file `docker-image-latest.yml`
- `DOCKERHUB_TOKEN` from [hub.docker](https://hub.docker.com/settings/security)

## buildx template

- file `docker-image-latest.yml`

```yml
name: Docker Image buildx latest

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

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
            # set latest tag for main branch https://github.com/docker/metadata-action#latest-tag
            type=raw,value=latest,enable=${{ github.ref == format('refs/heads/{0}', 'main') }}
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
            # set latest tag for main branch https://github.com/docker/metadata-action#latest-tag
            type=raw,value=latest,enable=${{ github.ref == format('refs/heads/{0}', 'main') }}
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

```

## base template by shell

- just only support OS/ARCH `linux/amd64`

```yml
name: Docker Image build latest

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

env:
  # name of docker image
  DOCKER_HUB_USER: bridgewwater
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
        # parse docker image id
        IMAGE_ID=$DOCKER_HUB_USER/$IMAGE_NAME
        # lower case all
        IMAGE_ID=$(echo $IMAGE_ID | tr '[A-Z]' '[a-z]')
        # ref get version
        VERSION=$(echo "${{ github.ref }}" | sed -e 's,.*/\(.*\),\1,')
        # replace v chat at tag
        [[ "${{ github.ref }}" == "refs/tags/"* ]] && VERSION=$(echo $VERSION | sed -e 's/^v//')
        # Use Docker `latest` tag convention when get main
        [ "$VERSION" == "main" ] && VERSION=latest

        echo IMAGE_ID=$IMAGE_ID
        echo VERSION=$VERSION
        # setting tag
        docker tag $IMAGE_NAME $IMAGE_ID:$VERSION

        # docker push
        docker push $IMAGE_ID:$VERSION

```

## buildx template by shell

```yml
name: Docker Image buildx latest

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

env:
  # name of docker image
  DOCKER_HUB_USER: bridgewwater
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
        # parse docker image id
        IMAGE_ID=$DOCKER_HUB_USER/$IMAGE_NAME
        # lower case all
        IMAGE_ID=$(echo $IMAGE_ID | tr '[A-Z]' '[a-z]')
        # ref get version
        VERSION=$(echo "${{ github.ref }}" | sed -e 's,.*/\(.*\),\1,')
        # replace v chat at tag
        [[ "${{ github.ref }}" == "refs/tags/"* ]] && VERSION=$(echo $VERSION | sed -e 's/^v//')
        # Use Docker `latest` tag convention when get main
        [ "$VERSION" == "main" ] && VERSION=latest

        echo IMAGE_ID=$IMAGE_ID
        echo VERSION=$VERSION
        # build
        docker buildx build -t $IMAGE_ID:$VERSION --platform=linux/arm,linux/arm64,linux/amd64 . --push

```