set dotenv-load

bootc_image_builder := "ghcr.io/osbuild/image-builder-cli:latest"
dist := "./dist"
fs := env_var_or_default("BOOTC_FS", "xfs")

default:
    @just --list

pre-commit-install:
    pre-commit install

# Build an install ISO for <target>, a bootc image ref; output goes to ./dist/<name>/
build-image target:
  #!/usr/bin/env bash
  set -euo pipefail
  if [ "$(id -u)" -ne 0 ]; then
    echo "error: run with sudo; the builder uses /var/lib/containers/storage" >&2
    exit 1
  fi
  target="$1"
  name="${target##*/}"
  name="${name%%@*}"
  name="${name%%:*}"
  out="{{dist}}/$name"
  installer="localhost/iso-build:$name"
  mkdir -p "$out"
  podman pull "{{bootc_image_builder}}"
  # The payload is copied from local container storage into the ISO, so it must
  # be there and current.  Fall back to a local-only image that was never pushed.
  podman pull "$target" || podman image exists "$target"
  podman build --pull=always --platform linux/amd64 \
    --build-arg TARGET_IMG="$target" \
    -t "$installer" \
    -f containers/iso/Containerfile containers/iso
  podman run --rm -it --privileged \
    -v ./config.toml:/config.toml:ro \
    -v "$out":/output \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    "{{bootc_image_builder}}" \
    build bootc-generic-iso \
    --bootc-default-fs "{{fs}}" \
    --blueprint /config.toml \
    --arch x86_64 \
    --bootc-ref "$installer" \
    --bootc-installer-payload-ref "$target"
