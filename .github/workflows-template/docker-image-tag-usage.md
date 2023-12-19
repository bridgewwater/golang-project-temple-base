## need `New repository secret`

- file `docker-image-tag.yml`
- `DOCKERHUB_TOKEN` from [hub.docker](https://hub.docker.com/settings/security)
    - if close push remote can pass `DOCKERHUB_TOKEN` setting 

## usage at github action

```yml
jobs:
  version:
    name: version
    uses: ./.github/workflows/version.yml

  docker-image-tag:
    name: docker-image-tag
    needs:
      - version
    uses: ./.github/workflows/docker-image-tag.yml
    if: startsWith(github.ref, 'refs/tags/')
    secrets: inherit
    with:
      # push_remote_flag: false
      docker_hub_user: 'bridgewwater'
      docker_image_name: 'bridgewwater/temp-golang-cli-fast'
```

- `push_remote_flag` default is `true`