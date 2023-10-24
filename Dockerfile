#-------------------
# Download upctl
#-------------------
FROM alpine:3.8.5@sha256:2bb501e6173d9d006e56de5bce2720eb06396803300fe1687b58a7ff32bf4c14 as builder

# renovate: datasource=github-releases depName=upcloud-cli lookupName=UpCloudLtd/upcloud-cli
ARG UPCTL_VERSION=2.10.0
ARG TARGETARCH
ARG TARGETOS
ARG TARGETVARIANT

WORKDIR /tmp

RUN apk --no-cache add --upgrade \
    curl

RUN ARCH=${TARGETARCH} && \
    [ "${ARCH}" == "amd64" ] && ARCH="x86_64" || true && \
    IMAGE=upcloud-cli_${UPCTL_VERSION}_${TARGETOS}_${ARCH}${TARGETVARIANT}.tar.gz && \
    curl -SsL -o ${IMAGE} https://github.com/UpCloudLtd/upcloud-cli/releases/download/v${UPCTL_VERSION}/${IMAGE} && \
    tar xzf ${IMAGE} upctl && \
    install upctl /bin/upctl && \
    rm ${IMAGE} upctl

#-------------------
# Minimal image
#-------------------
FROM gcr.io/distroless/static-debian12:nonroot@sha256:43a5ce527e9def017827d69bed472fb40f4aaf7fe88c356b23556a21499b1c04 as upctl-cli-minimal

COPY --from=builder /bin/upctl /bin/upctl

ENTRYPOINT ["/bin/upctl"]

#-------------------
# Debug image
#-------------------
FROM gcr.io/distroless/static-debian12:debug-nonroot@sha256:12f9bf5f9955ae90e619520e58eeba839a7ec959e051a62a780de447f38d65ed as upctl-cli-debug

COPY --from=builder /bin/upctl /bin/upctl

ENTRYPOINT ["/bin/upctl"]
