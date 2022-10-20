#!/usr/bin/env bash

source _scripts/_functions.sh

################################################################################

# Confugure users

findpath="auth/userpass/*/*.json"
for fullpath in ${findpath}
do
  filename="${fullpath##*/}"
  path=$(echo $fullpath | awk -F '/' '{print $(NF-1)}')
  user="${filename%.json}"

  echo "[${0##*/}] userpass, path: '${path}', user: '${user}'"

  data="@$fullpath"
  path="/auth/${path}/users/${user}"

  curl_post "${data}" "${path}"
done
