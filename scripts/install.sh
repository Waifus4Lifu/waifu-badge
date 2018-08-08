#!/bin/bash

apt-get install python-dev libbluetooth-dev libcap2-bin ffmpeg
setcap 'cap_net_raw,cap_net_admin+eip' $(readlink -f $(which python))

cd /home/pi/waifu-badge
sudo pip3 install -r requirements.txt
sudo pip3 install beacontools
sudo pip3 install beacontools[scan]

sudo cp rc.local /etc/rc.local

mkdir /badge/slideshow
mkdir/badge/images

mkdir /badge/logs
cp config.yaml /badge/config.yaml
