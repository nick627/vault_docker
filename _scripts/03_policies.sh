#!/usr/bin/env bash

source _scripts/_functions.sh

################################################################################

findpath="policies/*.hcl"
for fullpath in ${findpath}
do
  policy="${fullpath##*/}"
  policy="${policy%.hcl}"

  echo "[${0##*/}] policy: '${policy}'"

  json=$(
      jq \
      --null-input \
      --arg filepolicy "$(cat "${fullpath}")" \
      '{
          "policy": $filepolicy
      }'
  )
  path="/sys/policies/acl/${policy}"

  curl_post "${json}" "${path}"
done
