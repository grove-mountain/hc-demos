. env.sh
rm payload.json

green "This is mainly due to the fact secret will not be mount by default in the future.  Plan accordingly"

pe "vault secrets enable -path=secret -version=2 kv"

pe "vault kv put secret/db1/beer/read-only username=anchor password=thebest"
pe "vault kv get secret/db1/beer/read-only"
pe "vault kv get -field=password secret/db1/beer/read-only"


pe "vault kv put secret/db1/finance/read-only username=warren password=feargreedmoney"
pe "vault kv get secret/db1/finance/read-only"
pe "vault kv get -field=password secret/db1/finance/read-only"

cat > payload.json << EOL
{
  "data" : {
    "answer" : "Pan Galactic Gargle Blaster"
  }
}
EOL

pe "cat payload.json"

cat << EOF
curl -s --header "X-Vault-Token:\${VAULT_TOKEN}"
    --request POST
    --data @payload.json
    \${VAULT_ADDR}/v1/secret/data/hitchhikers/drinks/best
EOF
p

curl -s --header "X-Vault-Token:${VAULT_TOKEN}" \
    --request POST \
    --data @payload.json \
    ${VAULT_ADDR}/v1/secret/data/hitchhikers/drinks/best | jq .


pe "vault kv get secret/hitchhikers/drinks/best"



cat > payload.json << EOL
{
  "data" : {
    "answer" : "42",
    "question" : "????"
  }
}
EOL

pe "cat payload.json"

cat << EOF
curl -s --header "X-Vault-Token:\${VAULT_TOKEN}"
    --request POST
    --data @payload.json
    \${VAULT_ADDR}/v1/secret/data/hitchhikers/life/theuniverse/everything
EOF
p

curl -s --header "X-Vault-Token:${VAULT_TOKEN}" \
    --request POST \
    --data @payload.json \
    ${VAULT_ADDR}/v1/secret/data/hitchhikers/life/theuniverse/everything | jq .


pe "vault kv get secret/hitchhikers/life/theuniverse/everything"

