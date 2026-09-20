# Troubleshooting

## The installer does not start

Confirm the Python package is installed in the same environment used to run the installer:

```bash
python3 -m pip install textual
python3 installer.py
```

If your environment blocks global package installation, use a virtual environment instead.

## The image build fails

Check Docker connectivity and review the first package or download error. The Dockerfile installs Firefox, `jq`, and `wget`, then runs `/install-de.sh` and `/installapps.sh`. Package repositories and selected third-party download locations must be reachable.

Re-run the build after correcting the underlying error:

```bash
docker build --progress=plain -t trevvm . --no-cache
```

## Port 3000 is unavailable

Find the process using the port or map a different host port:

```bash
docker ps
# Example: expose host port 3001 while keeping the container on 3000
docker run ... -p 3001:3000 ...
```

## The container exits

Inspect the container logs and configuration:

```bash
docker ps -a --filter name=TrevVM
docker logs TrevVM
cat options.json
```

Verify that the selected desktop environment is supported by the corresponding script under `root/` and that `/config` is writable.

## KVM errors

KVM is optional. If `/dev/kvm` is missing or inaccessible, recreate the container without `--device=/dev/kvm` and ensure the installer configuration does not request KVM acceleration.

## Reporting an issue

Include reproducible steps, the selected desktop and applications, Docker version, host environment, relevant logs, and whether KVM was enabled. Never include credentials, private tokens, or private hostnames.
