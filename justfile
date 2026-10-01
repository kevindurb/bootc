set dotenv-load

bootc_image_builder := "ghcr.io/osbuild/image-builder-cli:latest"
dist := "./dist"
iso_image := "localhost/iso-build"

default:
    @just --list

pre-commit-install:
    pre-commit install

build-image target:
  mkdir -p {{dist}}
  podman pull "{{bootc_image_builder}}"
  podman build --pull=always --platform linux/amd64 \
    --build-arg BASE="{{target}}" \
    -t "{{iso_image}}" \
    -f containers/iso/Containerfile containers/iso
  podman run --rm -it --privileged \
    -v ./config.toml:/config.toml:ro \
    -v {{dist}}:/output \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    "{{bootc_image_builder}}" \
    build bootc-generic-iso \
    --bootc-default-fs xfs \
    --blueprint /config.toml \
    --arch x86_64 \
    --bootc-ref "{{iso_image}}"
