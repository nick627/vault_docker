#!/usr/bin/env bash

source _scripts/_functions.sh

################################################################################

# Confugure engine

findpath="data/*/_payload.json.conf"
for fullpath in ${findpath}
do
  engine=$(echo $fullpath | awk -F '/' '{print $(NF-1)}')

  echo "[${0##*/}] engine: '${engine}'"

  data="@$fullpath"
  path="/sys/mounts/${engine}"

  curl_post "${data}" "${path}"
done
