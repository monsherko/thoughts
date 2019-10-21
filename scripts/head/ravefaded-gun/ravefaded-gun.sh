#!/bin/bash

OVPN_CONFIG_FILE=""
GPG_PUB_KEY_FILE=""
FTP_SERVER=""
FTP_USER=""
FTP_PASSWORD=""

usage()
{
    echo "Usage: $1 --ovpn-file OVPN_CONFIG_FILE\n
    --gpg-pubkey GPG_PUB_KEY_FILE\n    --ftp-server FTP_SERVER\n    --ftp-user FTP_USER\n    --ftp-password FTP_PASSWORD ||\n    -h help"
    echo ""
}


debug_info()
{
   echo "[INFO] ----------------> $1"
}

pid=$(ps -ef | grep "openvpn --config $conf_file" | awk '{ print $2 }')


ovpn_connect()
{
  debug_info "connect to vpn..."
  openvpn --daemon $1 --config $OVPN_CONFIG_FILE
  sleep 8
  debug_info "connection initialization $link"

}

ovpn_dissconect()
{
  pid=$(ps -ef | grep "openvpn --config $conf_file" | awk '{ print $2 }')
  kill $pid
  debug_info "vpn dissconnect"
}

nmap_finder()
{
  debug_info "find all devices"
  nmap  192.168.0.0/16 -sP |  grep -oE "\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"   >>  $1
  debug_info "ip adresses devices save to $1"
}

nmap_ravefinder()
{
  debug_info "start master scannig.."
  mkdir "$2"
  while read line
  do
    debug_info "starting ip : $line scanning"
    nmap  --dns-servers ns1.asuscomm.com $line -sV --top-ports 1000  --data-length 80 -T2 -O -v -v -v -Pn --script auth,version  -oX "$2"/_"$line"_.xml >> _debug_.txt
    debug_info "done ip: $line scanning"
  done < $1
  debug_info "finish master scanning"
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage

            ;;
        --ovpn-file)
            OVPN_CONFIG_FILE=$VALUE
            ;;
        --gpg-pubkey)
            GPG_PUB_KEY_FILE=$VALUE
            ;;
        --ftp-server)
            FTP_SERVER=$VALUE
            ;;
        --ftp-user)
            FTP_USER=$VALUE
            ;;
        --ftp-password)
            FTP_PASSWORD=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1df
            ;;
    esac
    shift
done

link=${cat client.ovpn  |  grep 'remote' | awk '{ print $2 }'

ovpn_connect

nmap_finder "listip.txt"

nmap_ravefinder "listip.txt" $link

ovpn_dissconect
