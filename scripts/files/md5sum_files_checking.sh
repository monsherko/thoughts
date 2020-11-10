
PACKAGES=(
  "56082f82d65fad0424323199a9868ea2:audit-libs-python-2.8.5-4.el7.x86_64.rpm"
  "f727210d08bd3764bccd7f014db3e71e:checkpolicy-2.5-8.el7.x86_64.rpm"
)


CONTAINERS=(
  ""
)

rand_dir_name=$(mktemp -d "${TMPDIR:-/tmp}"/tmp.XXXXXXXX)

function packages_verify_install() {

  mkdir ${rand_dir_name}

  find ${1}  -type f -print0 | while read -r -d '' f;  do
    for i in "${PACKAGES[@]}"; do
      if [[ $(md5sum ${f}) == "${i%%:*}"* ]]; then
        cp "${f}"  "${rand_dir_name}/"
        break;
      fi
    done
  done
  if [[ ! $(ls -1 ${rand_dir_name} | wc -l) -eq ${#PACKAGES[@]} ]];  then
    rm -rf ${rand_dir_name}
    exit 0
  fi

 yum localinstall -y ${rand_dir_name}/*.rpm


  rm -rf ${rand_dir_name}

}
