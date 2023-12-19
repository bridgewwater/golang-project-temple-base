## need `New repository secret`

- file `docker-image-latest.yml`
- `DOCKERHUB_TOKEN` from [hub.docker](https://hub.docker.com/settings/security)
    - if close push remote can pass `DOCKERHUB_TOKEN` setting

## usage at github action

```yml
jobs:
  version:
    name: version
    uses: ./.github/workflows/version.yml

  docker-image-latest:
    name: docker-image-latest
    needs:
      - version
    uses: ./.github/workflows/docker-image-latest.yml
    if: ${{ ( github.event_name == 'push' && github.ref == 'refs/heads/main' ) || ( github.base_ref == 'main' && github.event.pull_request.merged == true ) }}
    secrets: inherit
    with:
      docker_hub_user: 'bridgewwater'
      docker_image_name: 'bridgewwater/temp-golang-cli-fast'
      build_branch_name: 'main'
      # push_remote_flag: ${{ github.event.pull_request.merged == true }}
      # push_remote_flag: ${{ github.ref == 'refs/heads/main' }}
```

- `push_remote_flag` default is `false`