#!/usr/bin/env bash

source _scripts/_source.sh

################################################################################

curl \
  --insecure \
  --silent \
  --request POST \
  --data @${FOLDER_PATH}/../config/init.json \
  ${VAULT_REST_URL}/sys/init \
| jq . > ${FOLDER_PATH}/../token.json
