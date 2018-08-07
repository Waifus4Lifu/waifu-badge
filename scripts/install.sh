#!/bin/bash

apt-get install python-dev libbluetooth-dev libcap2-bin ffmpeg
setcap 'cap_net_raw,cap_net_admin+eip' $(readlink -f $(which python))

cd /home/pi/waifu-badge
sudo pip3 install -r requirements.txt

sudo cp /home/pi/waifu-badge/scripts/rc.local /etc/rc.local

mkdir /badge/logs
