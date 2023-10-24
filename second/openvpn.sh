
if [ ! -f ./config.sh ]; then
    echo "config.sh not found"
    exit 1
fi  

apt-get -y install openvpn easy-rsa net-tools

source ./config.sh
source ./interfaces.sh