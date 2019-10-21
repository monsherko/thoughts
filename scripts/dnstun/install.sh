debug_info()
{
   echo "[INFO] $1"
}

debug_info "install iodine and supervisor"

sudo apt-get install iodine supervisor -y >> /dev/null
