## need `New repository secret`

- file `docker-image-latest.yml`
- `ACCESS_TOKEN` from [hub.docker](https://hub.docker.com/settings/security)

## base template

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
      run: echo "${{ secrets.ACCESS_TOKEN }}" | docker login -u $DOCKER_HUB_USER --password-stdin
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

## buildx template

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
      run: echo "${{ secrets.ACCESS_TOKEN }}" | docker login -u $DOCKER_HUB_USER --password-stdin
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