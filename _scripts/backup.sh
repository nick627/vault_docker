#!/usr/bin/env bash

source _scripts/_functions.sh

OIFS="$IFS"
IFS=$'\n'

################################################################################

# Global

backup_folder="backup/$(date +%Y_%m_%d-%H_%M)/"
mkdir -p ${backup_folder}

################################################################################

# Get secrets and save to folder as struct

function list_kv_secrets() {

  # Not null
  if [ "$1" == 0 ] || [ "$2" == 0 ]
  then
    echo "[-] Func: '${FUNCNAME[0]}' missing arguments"
    return 0
  fi

  local path=$1
  local kv=$2
  local current_folder=${backup_folder}${kv}${path}
  local request_path="/${kv}metadata/${path}"
  local request_list=$(curl_get_list "LIST" "${request_path}")

  for entry in $(echo $request_list | jq -r .data.keys[])
  do

    if [ "${entry: -1}" == "/" ]
    then

      # Is folder
      list_kv_secrets "${path}${entry}" "${kv}"

    else

      # Secret
      echo "[${0##*/}]  secret: '${path}${entry}'"

      mkdir -p "${current_folder}"

      local request_data="/${kv}data/${path}${entry}"
      (curl_get_list "GET" "${request_data}" | jq -r .data.data) > "${current_folder}${entry}.json"

    fi

  done
}

################################################################################

# Main

path="/sys/mounts"
mounts=$(curl_get_list "GET" "${path}" | jq .data)

for entry in $(echo $mounts | jq -r '. | to_entries | .[].key')
do
  type=$(echo $mounts | jq -r '."'"${entry}"'".type')

  if [ ${type} == "kv" ]
  then

    echo "[${0##*/}] engine: '${entry}'"

    list_kv_secrets "" "${entry}"

  else

    continue

  fi

done

################################################################################

IFS="$OIFS"
