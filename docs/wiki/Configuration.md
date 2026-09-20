# Configuration

## Installer choices

`installer.py` uses Textual to collect three application groups and one desktop environment:

- Default applications: Wine, Chrome, Xarchiver, Discord, Steam, and Minecraft.
- Programming: OpenJDK 8, OpenJDK 17, and VSCodium.
- Applications: VLC, LibreOffice, Synaptic, AQemu, and TLauncher.
- Desktop environments: KDE Plasma, XFCE4, i3, GNOME 42, Cinnamon, or LXQt.

The installer serializes the selection to `options.json`. The image build copies that file into the image, where `root/install-de.sh` and `root/installapps.sh` read it with `jq`.

## Persistence

The container stores user state in `/config`. The installation script copies the initial configuration into a local `Save` directory and mounts it back into the container. Back up this directory before rebuilding or removing the container.

```bash
docker stop TrevVM
tar -czf TrevVM-config-$(date +%F).tar.gz Save/
```

## Desktop startup

The selected desktop environment determines the startup script copied to `/defaults/startwm.sh`. The repository includes startup scripts for KDE Plasma, XFCE4, i3, GNOME, Cinnamon, and LXQt. These scripts disable selected visual effects or power blanking where needed for the browser-based desktop.

## Port and environment

The image exposes TCP port `3000`. The launch script sets `PUID=1000`, `PGID=1000`, `TZ=Etc/UTC`, `SUBFOLDER=/`, and `TITLE=TrevVM`. Change these values only when you understand the behavior of the LinuxServer base image and your deployment environment.
