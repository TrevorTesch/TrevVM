#!/bin/bash
set -Eeuo pipefail

json_file="/options.json"

if [[ ! -f "$json_file" ]]; then
    echo "Missing $json_file" >&2
    exit 1
fi

if jq -e '.defaultapps | contains([0])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/wine.sh
    /installable-apps/wine.sh
fi
if jq -e '.defaultapps | contains([1])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/chrome.sh
    /installable-apps/chrome.sh
fi
if jq -e '.defaultapps | contains([2])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/xarchiver.sh
    /installable-apps/xarchiver.sh
fi
if jq -e '.defaultapps | contains([3])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/discord.sh
    /installable-apps/discord.sh
fi
if jq -e '.defaultapps | contains([4])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/steam.sh
    /installable-apps/steam.sh
fi
if jq -e '.defaultapps | contains([5])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/minecraft.sh
    /installable-apps/minecraft.sh
fi

if jq -e '.programming | contains([0])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/openjdk-8-jre.sh
    /installable-apps/openjdk-8-jre.sh
fi
if jq -e '.programming | contains([1])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/openjdk-17-jre.sh
    /installable-apps/openjdk-17-jre.sh
fi
if jq -e '.programming | contains([2])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/vscodium.sh
    /installable-apps/vscodium.sh
fi

if jq -e '.apps | contains([0])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/vlc.sh
    /installable-apps/vlc.sh
fi
if jq -e '.apps | contains([1])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/libreoffice.sh
    /installable-apps/libreoffice.sh
fi
if jq -e '.apps | contains([2])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/synaptic.sh
    /installable-apps/synaptic.sh
fi
if jq -e '.apps | contains([3])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/aqemu.sh
    /installable-apps/aqemu.sh
fi
if jq -e '.apps | contains([4])' "$json_file" >/dev/null; then
    chmod +x /installable-apps/tlauncher.sh
    /installable-apps/tlauncher.sh
fi

rm -rf /installable-apps
