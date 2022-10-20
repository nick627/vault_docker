#!/usr/bin/env bash

FOLDER_PATH=$(dirname "$0")
source ${FOLDER_PATH}/../.env

################################################################################

tokenfile=${FOLDER_PATH}/../token.json

if test -f "${tokenfile}"; then
  VAULT_TOKEN=$(cat ${tokenfile} | jq -r .root_token )
  VAULT_HEADER="X-Vault-Token: ${VAULT_TOKEN}"
fi
