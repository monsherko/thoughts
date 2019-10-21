#!/bin/bash

LINES=32

debug_info()
{
   echo "[INFO] ----------------> $1"
}


while getopts "f:" opt
do
   case "$opt" in
      f ) FILE_PATH="$OPTARG" ;;
      ? ) usage ;;
   esac
done

debug_info "setting ip tables.."
iptables -A INPUT -p tcp --dport 61000 -j DROP

i=1


debug_info "staring scanning"
while read line
do
  masscan -iL FILE_PATH  -p0-65535  -oJ _"$i"_.json --banners  --source-port 61000 --shards "$i"/$LINES
  i=$((i+1))
  debug_info "file _$line was created"
done < "$FILE_PATH"
debug_info "finisn"
