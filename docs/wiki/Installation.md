# Installation

## Requirements

You need a Linux environment with:

- Docker and permission to run Docker containers.
- `git`, `curl`, `python3`, `pip`, and `sudo` access.
- Internet access for the repository, Ubuntu packages, the base image, and selected application downloads.
- A host port available for the web interface. The default is `3000`.

KVM is optional. The installer records an `enablekvm` choice, and the launch command uses `/dev/kvm` only when enabled and available.

## Codespaces quick start

The repository README describes using a blank GitHub Codespace. In an authorized Codespace or another authorized Linux host:

```bash
curl -O https://raw.githubusercontent.com/TrevorTesch/TrevVM/main/install.sh
chmod +x install.sh
./install.sh
```

The script clones the repository, installs the Python `textual` package, launches `installer.py`, builds the Docker image without cache, installs `jq`, saves the initial configuration, and starts the container.

## Manual build

```bash
git clone https://github.com/TrevorTesch/TrevVM.git
cd TrevVM
pip install textual
python3 installer.py
docker build -t trevvm . --no-cache
```

The interactive installer writes `options.json`. The Docker build copies the repository's `root/` tree into the image and installs the selected desktop environment and applications.

## Start the container

The supported launch path is the final portion of `install.sh`, because it applies the selected options and mounts the saved configuration. If you start the image manually, expose port `3000` and mount a persistent directory at `/config`:

```bash
mkdir -p Save
docker run -d --name TrevVM \
  -p 3000:3000 \
  --shm-size=2gb \
  --security-opt seccomp=unconfined \
  -e PUID=1000 -e PGID=1000 -e TZ=Etc/UTC \
  -v "$(pwd)/Save:/config" \
  trevvm
```

Only add `--device=/dev/kvm` when you have permission to use host KVM and the device is present. Review the security implications before using `--security-opt seccomp=unconfined`.

Open the forwarded port in the host or Codespaces interface. Do not expose an unauthenticated desktop service to the public internet.
