set -e

WORKSPACE="$(pwd)"

show_fallback() {
  mkdir -p "$WORKSPACE/.trevvm-fallback"
  cp "$WORKSPACE/TrevVM/fallback.html" \
     "$WORKSPACE/.trevvm-fallback/index.html"

  echo "Docker failed. Open port 3001 in the Codespaces Ports panel."
  exec python3 -m http.server 3001 \
    --bind 0.0.0.0 \
    --directory "$WORKSPACE/.trevvm-fallback"
}

git clone https://github.com/TrevorTesch/TrevVM
cd TrevVM
python3 -m pip install -r requirements.txt
sleep 2
python3 installer.py
docker build -t trevvm . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir Save
cp -r TrevVM/root/config/* Save

json_file="TrevVM/options.json"
if jq ".enablekvm" "$json_file" | grep -q true; then
    docker run -d --name=TrevVM -e PUID=1000 -e PGID=1000 --device=/dev/kvm --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=TrevVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped trevvm
else
    docker run -d --name=TrevVM -e PUID=1000 -e PGID=1000 --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=TrevVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped trevvm
fi
clear
echo "If you are seeing this, you have sucessfully installed the VM. There may be an issue, if there is then tell me in the issues tab on github. Thanks!"
