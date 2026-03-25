set dotenv-load

bootc_image_builder := "quay.io/centos-bootc/bootc-image-builder:latest"

default:
    @just --list

pre-commit-install:
    pre-commit install

build-image type target:
  #! /usr/bin/env bash
  ARCH=$(uname -m)
  IMAGE="ghcr.io/kevindurb/{{target}}"

  mkdir -p ./dist
  sudo podman pull "${IMAGE}" "{{bootc_image_builder}}"

  sudo podman run --rm -it --privileged \
  --security-opt label=type:unconfined_t \
  -v $(pwd)/config.toml:/config.toml:ro \
  -v $(pwd)/dist:/output \
  -v /var/lib/containers/storage:/var/lib/containers/storage \
  --platform "linux/${ARCH}" \
  "{{bootc_image_builder}}" \
  --target-arch "${ARCH}" \
  --rootfs xfs \
  --type "{{type}}" \
  "${IMAGE}"
