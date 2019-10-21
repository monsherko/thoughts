OVPN_CONFIG_FILE=""
GPG_PUB_KEY_FILE=""
FTP_SERVER=""
FTP_USER=""
FTP_PASSWORD=""

function usage()
{
    echo "Usage: $0 --ovpn-file OVPN_CONFIG_FILE
    --gpg-pubkey GPG_PUB_KEY_FILE
    --ftp-server FTP_SERVER
    --ftp-user FTP_USER
    --ftp-password FTP_PASSWORD ||
    -h help"
    echo "\t-h --help"
    echo ""
}


debug_info()
{
   echo "[INFO] ----------------> $1"
}

ovpn_connect()
{
  openvpn --daemon $1
}


while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
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
            exit 1
            ;;
    esac
    shift
done

debug_info "connect to vpn..."
