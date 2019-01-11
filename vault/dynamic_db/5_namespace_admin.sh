. env.sh

echo 'Hey Jake!  You need to create the finance namespace in the GUI!'
p
echo 'Dont forget to also add in the ns-admin policy!'
p
echo 'Last thing I swear, enable the userpass auth method!'
p

pe "vault kv get -namespace= secret/life/theuniverse/everything"

pe "export VAULT_NAMESPACE=finance"
pe "vault write auth/userpass/users/jake password=1234 policies=ns-admin"

unset VAULT_TOKEN
pe "vault login -method=userpass username=jake password=1234"

pe "vault secrets list"

pe "vault secrets enable kv"

pe "vault write kv/foo username=jake password=foo"
pe "vault read kv/foo"

pe "export VAULT_NAMESPACE=root"
pe "vault kv get secret/life/theuniverse/everything"
pe "vault read kv/foo"
