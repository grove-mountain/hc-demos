. env.sh

pe "fab -f fabric_beerme.py get_beer:username=${VAULT_ADMIN_USER},password=${VAULT_ADMIN_PW}"
pe "vault write -force database/rotate-root/vices"
pe "fab -f fabric_beerme.py get_beer:username=${VAULT_ADMIN_USER},password=${VAULT_ADMIN_PW}"
