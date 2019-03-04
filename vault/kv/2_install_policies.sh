. env.sh

pe "vault policy write kv-beer policies/beer-policy.hcl"
pe "vault policy read kv-beer"

pe "vault policy write kv-finance policies/finance-policy.hcl"
pe "vault policy read kv-finance"

pe "vault policy write kv-hitchhikers policies/hitchhikers-policy.hcl"
pe "vault policy read kv-hitchhikers"


