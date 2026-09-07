git clone https://github.com/TrevorTesch/TrevVM
cd TrevVM
pip install textual
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
echo "TrevVM possibly was installed, check port tab. If nothing you ask ai like i did."
