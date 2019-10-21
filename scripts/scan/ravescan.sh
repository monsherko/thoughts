#!/bin/bash

usage()
{
   echo ""
   echo "Usage: $0 -f FILE_PATH || -h"
   echo "   ";
   echo "  -f               : file with targets hosts";
   echo "  -h               : usage";
   exit 1 # Exit script after printing help
}

debug_info()
{
   echo "[INFO] ----------------> $1"
}


while getopts "f:" opt
do
   case "$opt" in
      f ) FILE_PATH="$OPTARG" ;;
      ? ) usage ;; # Print helpFunction in case parameter is non-existent
   esac
done

  # Print helpFunction in case parameters are empty
if [ -z "$FILE_PATH" ]
then
   echo "Some or all of the parameters are empty";
   usage
fi


debug_info "starting..."

while read line
do
  nmap  --dns-servers ns1.asuscomm.com -iL $FILE_PATH -sV -p 80,8080,443,8443 -T2 -O -v -v -v -Pn --script auth,version  -oX _"$line"_.xml
  debug_info "next range to scan"
done < "$FILE_PATH"
debug_info "finish"
