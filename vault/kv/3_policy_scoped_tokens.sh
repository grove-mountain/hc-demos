. env.sh

green "The purpose of this stage of the demo is to show how policy scoped tokens work"
p
yellow "Regardless of authentication method, you get a token scoped by policies."
p
green "Text output CLI"
pe "vault token create -policy=kv-beer"

green "JSON output full"
pe "vault token create -format=json -policy=kv-beer"

green "JSON output just token"
pe "vault token create -format=json -policy=kv-beer | jq -r '.auth.client_token'"

green "CLI based field output.  Same as JSON raw output"
pe "vault token create -field=token -policy=kv-beer"

yellow "Why were all the token values above different?"
p
green "Because we created different tokens on each call"
p
green "It's good be be mindful of when you create tokens versus use old ones"

ROOT_TOKEN=${VAULT_TOKEN}
unset VAULT_TOKEN
vault login ${ROOT_TOKEN} &> /dev/null
pe "TOKEN=\$(vault token create -field=token -policy=kv-beer)"
pe "vault login ${TOKEN}"

pe "vault kv get secret/db1/beer/read-only"
pe "vault kv get secret/db1/finance/read-only"
pe "vault kv get secret/hitchhikers/drinks/best"

unset VAULT_TOKEN
vault login ${ROOT_TOKEN} &> /dev/null
green "VAULT_TOKEN is an envvar read by vault can can save you a step"
pe "export VAULT_TOKEN=\$(vault token create -field=token -policy=kv-finance)"

pe "vault kv get secret/db1/beer/read-only"
pe "vault kv get secret/db1/finance/read-only"
pe "vault kv get secret/hitchhikers/drinks/best"


unset VAULT_TOKEN
vault login ${ROOT_TOKEN} &> /dev/null
green "You can also attach multiple policies to one auth method."
green "This enables code re-use"
pe "export VAULT_TOKEN=\$(vault token create -field=token -policy=kv-finance -policy=kv-beer)"

pe "vault kv get secret/db1/beer/read-only"
pe "vault kv get secret/db1/finance/read-only"
pe "vault kv get secret/hitchhikers/drinks/best"

green "This demonstrates how wildcards can maybe get out of control."
p
yellow "Be careful with policies and wildcard boundaries"
p
red "...and always be leery of Hitchhikers"

unset VAULT_TOKEN
vault login ${ROOT_TOKEN} &> /dev/null
pe "export VAULT_TOKEN=\$(vault token create -field=token -policy=kv-hitchhikers)"
pe "vault kv get secret/db1/beer/read-only"
pe "vault kv get secret/db1/finance/read-only"
pe "vault kv get secret/hitchhikers/drinks/best"
pe "vault kv get secret/hitchhikers/life/theuniverse/everything"

green "For a refresher on this policy. (And to seen beneath the curtain a bit)"
p
pe "unset VAULT_TOKEN"
pe "vault login ${ROOT_TOKEN} &> /dev/null"
pe "vault policy read kv-hitchhikers"
