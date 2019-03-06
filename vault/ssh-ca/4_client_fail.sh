. env.sh

pe "unset VAULT_TOKEN"
# Authenticate to Vault
pe "vault login -method=ldap -path=ldap-um username=bgreen password=\${USER_PASSWORD}"

pe "vault write -format=json ssh-client-signer/sign/clientrole public_key=@${HOME}/.ssh/id_rsa.pub"

