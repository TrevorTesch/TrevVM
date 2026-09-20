# Third-Party Software

TrevVM is built on and downloads software from third parties. Important components include:

- LinuxServer.io's `baseimage-kasmvnc:ubuntujammy` image.
- Ubuntu packages and desktop environments such as KDE Plasma, XFCE4, i3, GNOME, Cinnamon, and LXQt.
- Firefox, `jq`, and `wget` installed by the Dockerfile.
- Optional applications selected by the installer, including Wine, Chrome, Discord, Steam, Minecraft-related tooling, OpenJDK, VSCodium, VLC, LibreOffice, Synaptic, AQemu, and TLauncher.
- Python's Textual package used by the interactive installer.

Each third-party component remains subject to its own license, trademarks, privacy policy, and terms of service. TrevVM does not grant permission to redistribute proprietary software, bypass licensing, or use third-party brands as if they were affiliated with this project.

Before distributing an image containing optional applications, review the applicable licenses and distribution rules. Keep attribution and license notices required by those components.
