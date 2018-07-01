hciconfig hci0 down
sleep 1
hciconfig hci0 up
sleep 1
hciconfig hci0 leadv 3
sleep 1
hciconfig hci0 noscan
sleep 1
#hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 C8 00
#hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 $1 00 00 00 10 C8 00
hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 E2 0A 39 F4 73 F5 4B C4 A1 2F 17 D1 AD 07 A9 61 00 00 00 10 C8 00
sleep 1
hciconfig hci0 down
hciconfig hci0 up
