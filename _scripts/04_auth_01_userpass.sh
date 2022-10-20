#!/usr/bin/env bash

source _scripts/_functions.sh

################################################################################

# Confugure path

findpath="auth/userpass/*/_payload.json.conf"
for fullpath in ${findpath}
do
  path=$(echo $fullpath | awk -F '/' '{print $(NF-1)}')

  echo "[${0##*/}] userpass, path: '${path}'"

  data="@$fullpath"
  path="/sys/auth/${path}"

  curl_post "${data}" "${path}"
done
