. env.sh

green "You can mount secret engines multiple times at different path names"
p
green "Because secret engines are mounted with unique paths unknown to users, you cannot use relative path names to other secret engines"
p
green "This allows you another dimension of security when trying to isolate users/applications from each other"
p


pe "vault secrets enable -path=kv-finance kv"
pe "vault kv put kv-finance/db1/read-only username=warren password=feargreedmoney"

unset VAULT_TOKEN
vault login ultra-secure &> /dev/null
pe "export VAULT_TOKEN=\$(vault token create -field=token -policy=kv-hitchhikers)"
pe "vault kv get secret/db1/finance/read-only"
pe "vault kv get kv-finance/db1/read-only"
pe "vault kv get secret/../kv-finance/db1/read-only"


