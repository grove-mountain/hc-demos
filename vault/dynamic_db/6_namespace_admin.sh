. env.sh

pe "echo 'Hey Jake!  You need to create the finance namespace in the GUI!'"
pe "echo 'Dont forget to also add in the ns-admin policy!'"
pe "echo 'Last thing I swear, enable the userpass auth method!'"

pe "export VAULT_NAMESPACE=finance"
pe "vault write auth/userpass/users/jake password=1234 policies=ns-admin"

pe "vault login -method=userpass username=jake password=1234"

pe "vault secrets list"

pe "vault secrets enable kv"

pe "vault write kv/foo username=jake password=foo"
