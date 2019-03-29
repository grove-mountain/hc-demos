. env.sh

ROOT_TOKEN=${VAULT_TOKEN}

pe "vault auth enable approle"
pe "vault secrets enable -path=approle-kv -version=2 kv"
pe "vault kv put approle-kv/finance/ar-app username=ar-15 password=thisistotallynotagunreference"
pe "vault kv put approle-kv/finance/ap-app username=ap-42 password=lifeuniverseeverything"
pe "vault kv put approle-kv/it/helpdesk username=helpme password=ahelpingofhelp"
pe "vault kv put approle-kv/it/ops username=operator password=canyouhelpmeplacethiscall?"
pe "vault policy write finance policies/finapp-policy.hcl"
pe "vault policy read finance"
pe "vault policy write it policies/itapp-policy.hcl"
pe "vault policy read it"
pe "vault write auth/approle/role/finance policies=finance"
pe "ROLE_ID=\$(vault read -field=role_id auth/approle/role/finance/role-id)"
green "ROLE_ID=${ROLE_ID}"
pe "SECRET_ID=\$(vault write -field=secret_id -f auth/approle/role/finance/secret-id)"
green "SECRET_ID=${SECRET_ID}"
pe "VAULT_TOKEN=\$(vault write -field=token auth/approle/login role_id=\${ROLE_ID} secret_id=\${SECRET_ID})"
pe "vault kv get approle-kv/finance/ar-app"
pe "vault kv get approle-kv/finance/ap-app"
pe "vault kv get approle-kv/it/helpdesk"
pe "vault kv get approle-kv/it/ops"

yellow "But how do I safely distribute the SECRET_ID???"
p
green "Response wrapping to the rescue!!!!"
p
export VAULT_TOKEN=${ROOT_TOKEN}

pe "vault write auth/approle/role/it policies=it"
pe "ROLE_ID=\$(vault read -field=role_id auth/approle/role/it/role-id)"
green "Wrapping tokens are single use tokens that also have TTLs on them"
pe "WRAP=\$(vault write -field=wrapping_token -wrap-ttl=5m -f auth/approle/role/it/secret-id)"
pe "SECRET_ID=\$(VAULT_TOKEN=\${WRAP} vault unwrap -field=secret_id)"
yellow "What happens when you try to unwrap twice?"
p
pe "VAULT_TOKEN=\${WRAP} vault unwrap -field=secret_id"
pe "vault write auth/approle/login role_id=\${ROLE_ID} secret_id=\${SECRET_ID}"
pe "VAULT_TOKEN=\$(vault write -field=token auth/approle/login role_id=\${ROLE_ID} secret_id=\${SECRET_ID})"
pe "vault kv get approle-kv/it/helpdesk"
pe "vault kv get approle-kv/it/ops"
pe "vault kv get approle-kv/finance/ar-app"
pe "vault kv get approle-kv/finance/ap-app"
