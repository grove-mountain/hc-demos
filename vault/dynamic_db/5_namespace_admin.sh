. env.sh

echo 'Hey Jake!  You need to create the finance namespace in the GUI!'
echo "Or: vault namespace create finance"
p
echo 'Dont forget to also add in the ns-admin policy!'
echo 'Or: vault policy write -namespace=finance ns-admin policies/ns-admin-policy.hcl'
p
echo 'Last thing I swear, enable the userpass auth method!'
echo 'Or: vault auth enable -namespace=finance userpass'
p

pe "vault kv get -namespace= secret/life/theuniverse/everything"

pe "export VAULT_NAMESPACE=finance"

cat << EOG

ACCESSOR=\$(vault auth list -namespace=finance -format=json | jq -r '.["userpass/"].accessor')

EOG
p

ACCESSOR=$(vault auth list -namespace=finance -format=json | jq -r '.["userpass/"].accessor')

cat << EOZ
cat > policies/user-policy.hcl << EOF
path "auth/userpass/users/{{identity.entity.aliases.\${ACCESSOR}.name}}/password" {
  capabilities = [ "update" ]
}
EOF
EOZ
p

cat > policies/user-policy.hcl << EOF
path "auth/userpass/users/{{identity.entity.aliases.${ACCESSOR}.name}}/password" {
  capabilities = [ "update" ]
}
EOF

pe "vault policy write user policies/user-policy.hcl"

pe "vault write auth/userpass/users/jake password=1234 policies=ns-admin,user"

unset VAULT_TOKEN
pe "vault login -method=userpass username=jake password=1234"

pe "vault secrets list"

pe "vault secrets enable kv"

pe "vault write kv/foo username=jake password=foo"
pe "vault read kv/foo"
pe "vault write auth/userpass/users/jake/password password=12345"

pe "export VAULT_NAMESPACE=root"
pe "vault kv get secret/life/theuniverse/everything"
pe "vault read kv/foo"

