echo $1
hciconfig hci0 down
sleep 1
hciconfig hci0 up
sleep 1
hciconfig hci0 leadv 3
sleep 1
hciconfig hci0 noscan
sleep 1
hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 $1 $2 05 39 C8 00
