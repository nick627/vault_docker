#!/usr/bin/env bash

source _scripts/_functions.sh

################################################################################

# Put/update data

root_dir="data/"
root_dir_escape=$(echo "$root_dir" | sed 's/\//\\\//g')
findpath=$(find ${root_dir} -name '*.json')

OIFS="$IFS"
IFS=$'\n'

for fullpath in ${findpath}
do
  filename="${fullpath##*/}"
  path=$(echo $fullpath | awk -F '/' '{print $2}')

  secretpath="${fullpath%.json}"
  secretpath=$(echo "$secretpath" | sed "s/^${root_dir_escape}${path}//")
  secretpath="${secretpath#*/}"

  json=$(
    jq '{"data": .}' < ${fullpath}
  )

  path="/${path}/data/${secretpath}"

  echo "[${0##*/}] secret: '${fullpath}', path: '${path}'"

  curl_post "${json}" "${path}"
done

IFS="$OIFS"
