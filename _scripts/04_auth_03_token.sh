#!/usr/bin/env bash

source _scripts/_functions.sh

################################################################################

# Confugure token

findpath="auth/token/*.json"
for fullpath in ${findpath}
do
  filename="${fullpath##*/}"
  token="${filename%.json}"

  echo "[${0##*/}] token: '${token}'"

  data="@$fullpath"
  path="/auth/token/create"

  curl_post "${data}" "${path}" | jq . > $fullpath.conf
done
