. env.sh
rm payload.json

yellow "This is will fail now, but in the future, secret KV will not be enabled by default."
green "Please plan accordingly"

pe "vault secrets enable -path=secret -version=2 kv"

green "This demo will read and write using the root token"
yellow "This is not normal for most operations with Vault and only illustrates basic usage journeys"
green "Putting in basic kv secrets and reading them out using CLI"
pe "vault kv put secret/db1/beer/read-only username=anchor password=thebest"
pe "vault kv get secret/db1/beer/read-only"
pe "vault kv get -field=password secret/db1/beer/read-only"


pe "vault kv put secret/db1/finance/read-only username=warren password=feargreedmoney"
pe "vault kv get secret/db1/finance/read-only"
pe "vault kv get -field=password secret/db1/finance/read-only"


green "Putting in basic kv secrets and reading them out using API"
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
p

cat << EOF
curl -s --header "X-Vault-Token:\${VAULT_TOKEN}"
    --request GET
    \${VAULT_ADDR}/v1/secret/data/hitchhikers/drinks/best | jq .
EOF
p

curl -s --header "X-Vault-Token:${VAULT_TOKEN}" \
    --request GET \
    ${VAULT_ADDR}/v1/secret/data/hitchhikers/drinks/best | jq .
p

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
p

cat << EOF
curl -s --header "X-Vault-Token:\${VAULT_TOKEN}"
    --request GET
    \${VAULT_ADDR}/v1/secret/data/hitchhikers/life/theuniverse/everything | jq .data.data
EOF
p

curl -s --header "X-Vault-Token:${VAULT_TOKEN}" \
    --request GET \
    ${VAULT_ADDR}/v1/secret/data/hitchhikers/life/theuniverse/everything | jq .data.data
p


