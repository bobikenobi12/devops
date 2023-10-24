DEVICES=$(ifconfig -s | grep -v "Iface\|lo\|tun0" | cut -d " " -f 1)
NUMDEVICES=$(ifconfig -s | wc -l)
VPNDEVICE=$(ifconfig -s | grep tun0 | cut -d " " -f 1)

if ifconfig -s | grep -q eth0; then
    export VPNDEVICE="eth0"
elif [ $NUMDEVICES -eq 3 ] then 
    export VPNDEVICE=$(ifconfig -s | tail -n 2 | cut -d " " -f 1 | grep -v "lo\|tun0")
else 
    echo "There are multiple network devices on this server."
    echo ""
    ifconfig -s | cut -d " " -f 1 | grep -v "Iface\|lo\|tun0"
    echo ""
    echo " Please enter the device name you want to use for VPN:"
    read VPNDEVICE
     
    while ! echo $DEVICES | grep -q "${VPNDEVICE}"
    do 
        echo "{$VPNDEVICE} was not found in the list of decices. Please type the device name again"
        read VPNDEVICE
    done
    export $VPNDEVICE
fi