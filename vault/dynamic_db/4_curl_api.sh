. env.sh

cat > payload.json << EOL
{
  "data" : {
    "answer" : "42",
    "question" : "????"
  }
}
EOL

cat << EOF
curl -s --header "X-Vault-Token:${VAULT_TOKEN}" 
    --request POST 
    --data @payload.json 
    ${VAULT_ADDR}/v1/secret/data/life/theuniverse/everything
EOF
p

curl -s --header "X-Vault-Token:${VAULT_TOKEN}" \
    --request POST \
    --data @payload.json \
    ${VAULT_ADDR}/v1/secret/data/life/theuniverse/everything


pe "vault kv get secret/life/theuniverse/everything"

cat << EOF 
curl -s --header "X-Vault-Token:${VAULT_TOKEN}"
  ${VAULT_ADDR}/v1/database/creds/full-read | jq .
EOF
p

curl -s --header "X-Vault-Token:${VAULT_TOKEN}" \
  ${VAULT_ADDR}/v1/database/creds/full-read | jq .
