daemon="openvpn"
prog="openvpn-client"
conf_file="/vagrant/vpn/client-dept18-payment.ovpn"

start() {
    echo -n $"Starting $prog: "
        if [ -e /var/lock/subsys/openvpn-client ] && [ $(pgrep -fl "openvpn --config /vagrant/vpn/client-dept18-payment.ovpn" | wc -l) -gt 0 ]; then
        echo_failure
        echo
        exit 1
    fi
    runuser -l root -c "$daemon --config $conf_file >/dev/null 2>&1 &" && echo_success || echo_failure
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/openvpn-client;
    return $RETVAL
}

stop() {
    echo -n $"Stopping $prog: "
    pid=$(ps -ef | grep "openvpn --config $conf_file" | awk '{ print $2 }')
    kill $pid > /dev/null 2>&1 && echo_success || echo_failure
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/openvpn-client;
    return $RETVAL
}

status() {
    pgrep -fl "openvpn --config /vagrant/vpn/cl.ovpn" >/dev/null 2>&1
    RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        pid=$(ps -ef | grep "openvpn --config $conf_file" | awk '{ print $2 }')
        echo $"$prog (pid $pid) is running..."
    else
        echo $"$prog is stopped"
    fi
}

restart() {
    stop
    start
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    condrestart)
        [ -f /var/lock/subsys/openvpn-client ] && restart || :
        ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart|condrestart}"
        exit 1
esac
