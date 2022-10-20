#!/usr/bin/env bash

source _scripts/_source.sh

rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

function curl_post() {

  # Not empty
  if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "[-] Func: '${FUNCNAME[0]}' missing arguments"
    return 0
  fi

  local data=$1
  local path=$2

  if [ ${data:0:1} == "@" ]
  then
    :
  else
    data=$(echo "${data}" | jq -c)
  fi

  path=$( rawurlencode "${path}" )

  curl \
    --insecure \
    --silent \
    --header "${VAULT_HEADER}" \
    --request POST \
    --data "${data}" \
    ${VAULT_REST_URL}${path}
}

function curl_get_list() {

  if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "[-] Func: '${FUNCNAME[0]}' missing arguments"
    return 0
  fi

  if [ "$1" != "GET" ] && [ "$1" != "LIST" ] 
  then
    echo "[-] Func: '${FUNCNAME[0]}' wrong request arguments"
    return 0
  fi

  local request=$1
  local path=$2

  path=$( rawurlencode "${path}" )

  curl \
    --insecure \
    --silent \
    --header "${VAULT_HEADER}" \
    --request ${request} \
    ${VAULT_REST_URL}${path}
}
