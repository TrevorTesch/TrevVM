#!/usr/bin/env bash
set -e

WORKSPACE="$(pwd)"

show_fallback() {
  local fallback_dir="$WORKSPACE/.trevvm-fallback"
  local fallback_page="$WORKSPACE/TrevVM/fallback.html"

  if [ ! -f "$fallback_page" ]; then
    echo "Docker failed, and fallback.html was not found at $fallback_page"
    exit 1
  fi

  mkdir -p "$fallback_dir"
  cp "$fallback_page" "$fallback_dir/index.html"

  echo "Docker failed. Open port 3001 in the Codespaces Ports panel."
  exec python3 -m http.server 3001 \
    --bind 0.0.0.0 \
    --directory "$fallback_dir"
}

git clone https://github.com/TrevorTesch/TrevVM
cd TrevVM

python3 -m pip install -r requirements.txt
sleep 2
python3 installer.py

if ! docker build -t trevvm . --no-cache; then
  show_fallback
fi

cd "$WORKSPACE"

sudo apt update
sudo apt install -y jq

mkdir -p Save
cp -r TrevVM/root/config/* Save
json_file="TrevVM/options.json"

if jq ".enablekvm" "$json_file" | grep -q true; then
  if ! docker run -d --name=TrevVM \
    -e PUID=1000 -e PGID=1000 \
    --device=/dev/kvm \
    --security-opt seccomp=unconfined \
    -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=TrevVM \
    -p 3000:3000 --shm-size="2gb" \
    -v "$(pwd)/Save:/config" \
    --restart unless-stopped trevvm; then
    show_fallback
  fi
else
  if ! docker run -d --name=TrevVM \
    -e PUID=1000 -e PGID=1000 \
    --security-opt seccomp=unconfined \
    -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=TrevVM \
    -p 3000:3000 --shm-size="2gb" \
    -v "$(pwd)/Save:/config" \
    --restart unless-stopped trevvm; then
    show_fallback
  fi
fi

sleep 5

if ! docker inspect --format '{{.State.Running}}' TrevVM | grep -qx true; then
  docker logs --tail 50 TrevVM || true
  show_fallback
fi

clear
echo "If you are seeing this, you have sucessfully installed the VM. There may be an issue, if there is then tell me in the issues tab on github. Thanks!"
