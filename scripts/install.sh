#!/bin/bash

apt-get install python-dev libbluetooth-dev libcap2-bin
setcap 'cap_net_raw,cap_net_admin+eip' $(readlink -f $(which python))

cd /home/pi/waifu-badge
pip install -r requirements.txt

echo '#!/bin/sh -e' > /etc/rc.local
echo 'sudo -u pi python3.5 /home/pi/waifu-badge/scripts/convert.sh' > /etc/rc.local
echo 'sudo -u pi python3.5 /home/pi/waifu-badge/mcp.py &' > /etc/rc.local
echo 'exit 0' > /etc/rc.local
