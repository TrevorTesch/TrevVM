#!/usr/bin/env bash
set -Eeuo pipefail

repo_url="https://github.com/TrevorTesch/TrevVM"
repo_dir="${REPO_DIR:-TrevVM}"

if [[ -d "$repo_dir/.git" ]]; then
    git -C "$repo_dir" pull --ff-only origin main
else
    git clone --depth 1 "$repo_url" "$repo_dir"
fi

cd "$repo_dir"

python3 -m pip install --quiet textual
sleep 2
python3 installer.py

docker build -t trevvm . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir -p Save
cp -r "$repo_dir/root/config/"* Save

json_file="$repo_dir/options.json"
if [[ ! -f "$json_file" ]]; then
    echo "Missing options.json: $json_file" >&2
    exit 1
fi

if jq -e '.enablekvm == true' "$json_file" >/dev/null; then
    docker run -d --name=TrevVM -e PUID=1000 -e PGID=1000 --device=/dev/kvm --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=TrevVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped ghcr.io/linuxserver/kasmvnc:latest
else
    docker run -d --name=TrevVM -e PUID=1000 -e PGID=1000 --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=TrevVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped ghcr.io/linuxserver/kasmvnc:latest
fi

clear
echo "TrevVM possibly was installed, check port tab. If nothing you ask AI like I did."
