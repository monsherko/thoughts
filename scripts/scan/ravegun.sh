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



while getopts "f:" opt
do
   case "$opt" in
      f ) FILE_PATH="$OPTARG" ;;
      ? ) usage ;;
   esac
done

  # Print helpFunction in case parameters are empty
if [ -z "$FILE_PATH" ]
then
   echo "Some or all of the parameters are empty";
   usage
fi



while read line
do
  nmap  --dns-servers ns1.asuscomm.com -iL $FILE_PATH -sV --top-ports 1000  -T2 -O -v -v -v -Pn --script auth,version,banners  -oX _"$line"_.xml
done < "$FILE_PATH"
