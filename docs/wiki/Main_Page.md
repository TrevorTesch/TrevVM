# TrevVM Wiki

Welcome to the TrevVM documentation hub.

TrevVM packages a browser-accessible Linux desktop environment using the LinuxServer KasmVNC base image, Docker, and an interactive Textual installer. It is intended for personal projects, development, testing, and other environments where you have permission to run containers and access the required host capabilities.

> **Responsible use:** Do not use TrevVM to evade school, workplace, network, account, content, or device controls. Obtain permission from the system owner and comply with applicable laws, policies, and terms of service.

## Quick links

- [Installation](Installation)
- [Configuration](Configuration)
- [Troubleshooting](Troubleshooting)
- [Security and privacy](Security-and-Privacy)
- [Third-party software](Third-Party-Software)
- [Contributing](Contributing)
- [Acceptable use](Acceptable-Use)

## Project scope

TrevVM builds a Docker image based on `ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy`, exposes the KasmVNC web interface on port `3000`, and persists desktop state in `/config`. The installer can select a desktop environment and optional applications before the image is built.

## Support

Before opening an issue:

1. Read [Installation](Installation) and [Troubleshooting](Troubleshooting).
2. Check the repository's open issues and discussions.
3. Remove passwords, tokens, private URLs, and personal data from logs.
4. Include the host environment, Docker version, selected desktop, and the exact error.

Security vulnerabilities should be reported privately according to the repository's security policy rather than posted publicly.
