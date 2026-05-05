set dotenv-load

arch := `uname -m`
bootc_image_builder := "quay.io/centos-bootc/bootc-image-builder:latest"

default:
    @just --list

pre-commit-install:
    pre-commit install

build-image type target:
  #! /usr/bin/env bash
  IMAGE="ghcr.io/kevindurb/{{target}}"

  mkdir -p ./dist
  mkdir -p ~/.local/share/containers/storage
  podman pull "${IMAGE}" "{{bootc_image_builder}}"

  podman run --rm -it --privileged \
  --security-opt label=type:unconfined_t \
  -v $(pwd)/config.toml:/config.toml:ro \
  -v $(pwd)/dist:/output \
  -v ~/.local/share/containers/storage:/var/lib/containers/storage \
  --platform "linux/{{arch}}" \
  "{{bootc_image_builder}}" \
  --in-vm --use-librepo=True \
  --target-arch "{{arch}}" \
  --rootfs xfs \
  --type "{{type}}" \
  "${IMAGE}"
