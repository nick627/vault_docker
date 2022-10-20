Vault
=========

Vault in docker and struct for work with him
#
Base on https://mylinuxblog.ru/ustnovka-i-nastroyka-vault-v-docker/
#
TODO: maybe use other method for loop with spaces https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html


Requirements
------------

`sudo apt-get isntall jq -y`

For disable TLS change settings in [`.env`](./.env) and [`config/vault.json`](./config/vault.json)
\
For TLS add your certs to folder [`tls`](./tls/)

Quick start
--------------

```bash

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

```


Other
--------------

```bash
tokenfile=./token.json
VAULT_TOKEN=$(cat ${tokenfile} | jq -r .root_token )
docker exec -it vault /bin/sh -c "vault login -tls-skip-verify ${VAULT_TOKEN}"
```
