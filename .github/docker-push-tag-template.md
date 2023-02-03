## need `New repository secret`

- file `docker-image-tag.yml`
- `ACCESS_TOKEN` from [hub.docker](https://hub.docker.com/settings/security)
- `IMAGE_BUILD_OS_NAME` like `alpine` and let `Dockerfile` under this folder

## base template

- just only support OS/ARCH `linux/amd64`

```yml
name: Docker Image build by tag on alpine

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
      run: echo "${{ secrets.ACCESS_TOKEN }}" | docker login -u $DOCKER_HUB_USER --password-stdin
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

## buildx template

```yml
name: Docker Image buildx by tag on alpine

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
      run: echo "${{ secrets.ACCESS_TOKEN }}" | docker login -u $DOCKER_HUB_USER --password-stdin
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