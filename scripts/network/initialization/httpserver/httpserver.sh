#!/bin/bash
mkfifo pipe;

while true ; 
do 
   #use read line from pipe to make it blocks before request comes in,
   #this is the key.
   { read line<pipe;echo -e "HTTP/1.1 200 OK\r\n";echo "\t$(date)\";
   }  | nc -l -q 0 -p 8080 > pipe;  

done
