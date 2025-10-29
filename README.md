# bootc

Bootable container images for immutable Fedora-based systems.

## Quick Start

```bash
# List available tasks
task --list-all

# Build a container image
task containers:workstation

# Create bootable disk image
podman run --rm -it --privileged \
  --security-opt label=type:unconfined_t \
  -v $(pwd)/output:/output \
  -v /var/lib/containers/storage:/var/lib/containers/storage \
  quay.io/centos-bootc/bootc-image-builder:latest \
  --target-arch $(uname -m) \
  --type raw \
  --local ghcr.io/kevindurb/workstation

# Test with QEMU
task qemu:qemu-x86_64
```

## Available Images

| Image | Base | Purpose |
|-------|------|---------|
| `workstation` | Kinoite | KDE desktop environment |
| `tablet` | Kinoite | Touch device with fingerprint/camera |
| `steamdeck` | Bazzite | Gaming-optimized |
| `router` | uCore | DHCP/DNS server with dnsmasq |
| `k8s-node` | uCore | Kubernetes node with k3s |
| `wg-hub` | uCore | WireGuard VPN gateway |
| `apx` | Golang | Vanilla OS package manager |

## Pull Pre-built Images

```bash
podman pull ghcr.io/kevindurb/<image>:latest
```

Images are automatically built weekly and signed with cosign.

## Requirements

- [Podman](https://podman.io/)
- [Task](https://taskfile.dev/)
- QEMU (for local testing)

## Project Structure

```
containers/     # Container image definitions
scripts/        # Installation scripts
.taskfiles/     # Task definitions for building/testing
```

## License

MIT
