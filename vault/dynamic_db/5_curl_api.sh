. env.sh

cat > payload.json << EOL
{
  "answer" : "42",
  "question" : "????"
}
EOL

pe "curl -s --header \"X-Vault-Token:${VAULT_TOKEN}\" \
    --request POST \
    --data @payload.json \
    ${VAULT_ADDR}/v1/secret/life/theuniverse/everything
"

pe "vault read secret/life/theuniverse/everything"

pe "curl -s --header \"X-Vault-Token:${VAULT_TOKEN}\" ${VAULT_ADDR}/v1/database/creds/full-read | jq ."
