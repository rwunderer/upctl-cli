[![GitHub license](https://img.shields.io/github/license/rwunderer/upctl-cli.svg)](https://github.com/rwunderer/upctl-cli/blob/main/LICENSE)
<a href="https://renovatebot.com"><img alt="Renovate enabled" src="https://img.shields.io/badge/renovate-enabled-brightgreen.svg?style=flat-square"></a>

# upctl-cli
Minimal Docker image with [UpCloud cli utility](https://github.com/UpCloudLtd/upcloud-cli)

## Image variants

This image is based on [distroless](https://github.com/GoogleContainerTools/distroless) and comes in two variants:

### Minimal image

The minimal image is based on `gcr.io/distroless/static-debian12:nonroot` and does not contain a shell. It can be directly used from the command line, eg:

```
$ docker run --rm -it ghcr.io/rwunderer/upctl-cli:v2.10.0-minimal version

  Version:      2.10.0
  Build date:   2023-07-17T12:09:30Z
  Built with:   go1.20.5
  System:       linux
  Architecture: amd64

```

### Debug image

The debug images is based on `gcr.io/distroless/base-debian12:debug-nonroot` and contains a busybox shell for use in ci images.
As upctl's output is also available in json it also containts [jq](https://github.com/jqlang/jq).

E.g. for GitLab CI:

```
list images:
  image:
    name: ghcr.io/rwunderer/upctl-cli:v2.10.0-debug
    entrypoint: [""]
  variables:
    UPCLOUD_USERNAME=""
    UPCLOUD_PASSWORD=""

  script:
    - upctl storage list --template
```

## Workflows

| Badge      | Description
|------------|---------
|[![Auto-Tag](https://github.com/rwunderer/upctl-cli/actions/workflows/renovate-create-tag.yml/badge.svg)](https://github.com/rwunderer/upctl-cli/actions/workflows/renovate-create-tag.yml) | Automatic Tagging of new upctl releases
|[![Docker](https://github.com/rwunderer/upctl-cli/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/rwunderer/upctl-cli/actions/workflows/docker-publish.yml) | Docker image build
