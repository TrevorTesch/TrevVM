# Security and Privacy

## Privacy policy

**Effective date:** 2026-09-20

TrevVM is distributed as open-source software. The repository maintainer does not intentionally operate a central TrevVM telemetry service, and the code reviewed for this documentation does not implement analytics, account tracking, or a TrevVM-hosted data collection endpoint.

When you run TrevVM, data may still be processed by the systems you choose to use, including:

- GitHub and GitHub Codespaces, if you clone or run the project there.
- Docker and the container runtime on your host.
- Ubuntu package repositories and other download services used by the image or optional application installers.
- The websites and services accessed from the desktop environment.
- Files, browser data, credentials, and other content that you deliberately store in the persistent `/config` volume.

Those services have their own privacy policies and terms. TrevVM does not control their collection or retention practices.

## Data you control

The persistent configuration is mounted from the local `Save` directory into `/config`. Protect this directory like any other user data. Do not store secrets in public images, issue reports, shell history, or configuration files committed to Git.

If you open an issue or discussion, GitHub processes the information you submit. Redact logs and screenshots before posting them.

## Security guidance

- Use TrevVM only on systems and networks where you have authorization.
- Keep Docker, the host OS, and the base image updated.
- Do not expose port `3000` directly to an untrusted network.
- Review every shell installer before running it and pin or verify dependencies for production use.
- Treat `--security-opt seccomp=unconfined` and `/dev/kvm` access as privileged settings.
- Use a dedicated, non-sensitive workspace; the project is not a hardened isolation boundary.
- Do not use the software to bypass access controls, monitoring, filtering, or acceptable-use policies.

This page is informational and is not legal advice. If the project begins collecting telemetry, operating a hosted service, or receiving personal data, this policy must be reviewed and updated before that change is deployed.
