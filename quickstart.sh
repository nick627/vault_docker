#!/usr/bin/env bash

docker-compose down

docker-compose up --build -d

################################################################################

./_scripts/01_init.sh

./_scripts/02_unseal.sh

./_scripts/03_policies.sh

./_scripts/04_auth_01_userpass.sh

./_scripts/04_auth_02_users.sh

./_scripts/04_auth_03_token.sh

./_scripts/05_data_01_engine.sh

./_scripts/05_data_02_data.sh

################################################################################

./_scripts/backup.sh
