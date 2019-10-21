DIR_PATH=""
ZIP_NAME=""
debug_info()
{
   echo "[INFO] ----------------> $1"
}



mkdir tmp
zip 'tmp/$ZIP_NAME' $DIR_PATH
cd tmp
python -m http.server 127.0.0.1 --bind 80 &
