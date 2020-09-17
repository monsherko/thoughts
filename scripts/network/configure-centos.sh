#!/bin/bash

TYPE="Ethernet"
PROXY_METHOD="no"
BROWSER_ONLY="no"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEM_MODE="stable-privacy"

usage() {

  echo "list option:"
  echo  "     -h | --help"
  echo  "     -a | --addr"
  echo  "     -p | --prefix"
  echo  "     -g | --gateway"
  echo  -e "  -i | --interface\n"
  echo "params with default options:"
  echo "  --type=${TYPE}"
  echo "  --proxy-method=${PROXY_METHOD}"
  echo "  --browser-only${BROWSER_ONLY}"
  echo "  --bootproto=${BOOTPROTO}"
  echo "  --defroute=${DEFROUTE}"
  echo "  --ipv4-failure-fatal=${IPV4_FAILURE_FATAL}"
  echo "  --ipv6init=${IPV6INIT}"
  echo "  --ipv6_autocond=${IPV6_AUTOCONF}"
  echo "  --ipv6_defroute=${IPV6_DEFROUTE}"
  echo "  --ipv6_failure_fatal=${IPV6_FAILURE_FATAL}"
  echo -e "  --ipv6_addr_gem_mode=${IPV6_ADDR_GEM_MODE}\n"

}

example() {
  echo "./nethlper.sh -a 172.2.1.44 -p 24 -g 172.2.1.1 -i ens3"
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -e | --example)
            example
            exit
            ;;
        -a | --addr)
            IPADDR=$VALUE
            ;;
        -p | --prefix)
            PREFIX=$VALUE
            ;;
        -g | --gateway)
            GATEWAY=$VALUE
            ;;
        -i | --interface)
            INTERFACE=$VALUE
            ;;
        --type)
            TYPE=$VALUE
            ;;
        --proxy-method)
            PROXY_METHOD=$VALUE
            ;;
        --browser-only)
            BROWSER_ONLY=$VALUE
            ;;
        --bootproto)
            BOOTPROTO=$VALUE
            ;;
        --defroute)
            DEFROUTE=$VALUE
            ;;
        --ipv4-failure-fatal)
            IPV4_FAILURE_FATAL=$VALUE
            ;;
        --ipv6init)
            IPV6INIT=$VALUE
            ;;
        --ipv6_autocond)
            IPV6_AUTOCONF=$VALUE
            ;;
        --ipv6_defroute)
            IPV6_DEFROUTE=$VALUE
            ;;
        --ipv6_failure_fatal)
            IPV6_FAILURE_FATAL=$VALUE
            ;;
        --ipv6_addr_gem_mode)
            IPV6_ADDR_GEM_MODE=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

echo "NETWORKING=yes" > /etc/sysconfig/network
echo "GATEWAY=10.50.30.1" >> /etc/sysconfig/network
echo  "TYPE=${TYPE}" > /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "PROXY_METHOD=${PROXY_METHOD}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "BROWSER_ONLY=${BROWSER_ONLY}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "BOOTPROTO=${BOOTPROTO}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "IPADDR=${IPADDR}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "PREFIX=${PREFIX}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "GATEWAY=${GATEWAY}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "DEFROUTE=${DEFROUTE}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "IPV4_FAILURE_FATAL=${IPV4_FAILURE_FATAL}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "IPV6INIT=${IPV6INIT}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "IPV6_AUTOCONF=${IPV6_AUTOCONF}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "IPV6_DEFROUTE=${IPV6_DEFROUTE}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "IPV6_FAILURE_FATAL=${IPV6_FAILURE_FATAL}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "IPV6_ADDR_GEM_MODE=${IPV6_ADDR_GEM_MODE}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}
echo  "NAME=${INTERFACE}" >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE}


#ip addr add ${IPADDR}${PREFIX} dev ${INTERFACE}

