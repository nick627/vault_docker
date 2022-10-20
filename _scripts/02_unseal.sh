#!/usr/bin/env bash

source _scripts/_source.sh

################################################################################

for entry in $(cat $FOLDER_PATH/../token.json | jq -r .keys[])
do
  data='{
    "key": "'${entry}'"
  }'

  data=$(echo "${data}" | jq -c)

  curl \
    --insecure \
    --silent \
    --request POST \
    --data ${data} \
    ${VAULT_REST_URL}/sys/unseal
done
