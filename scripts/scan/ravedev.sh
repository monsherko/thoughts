#!/bin/bash
IP=192.168.1.0
NUM_RANGE=24

usage()
{
   echo ""
   echo "Usage: $0 -f FILE_PATH || -h"
   echo "   ";
   echo "  -f               : file output";
   echo "  -h               : usage";
   exit 1 # Exit script after printing help
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


nmap  "$IP"/"$NUM_RANGE" -sP |  grep -oE "\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"   >  $FILE_PATH
