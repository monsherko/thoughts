mkfifo pipe;

while true ; 
do 
  # rand_log_name=$(mktemp -d "${TMPDIR:-/tmp}"/tmp.XXXXXXXX)
   NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
   #use read line from pipe to make it blocks before request comes in,
   #this is the key.
   { read line<pipe;echo -e "HTTP/1.1 200 OK\r\n";echo  $(date)\"; }
   | nc -l -q 0 -p 8080 > pipe; cat pipe | grep "data" |  cut -d "=" -f 2; | base64 -d  > /data/${md5sum pipe}.log 
done

# while true ;  do     { read line<pipe;echo -e "HTTP/1.1 200 OK\r\n";echo  $(date)\"; }  | nc -l -q 0 -p 8080 > pipe; cat pipe | grep "data" |  cut -d "=" -f 2; done;


