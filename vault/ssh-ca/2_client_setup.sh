#!/usr/bin/env bash
. env.sh

# Create ssh key pair
pe "ssh-keygen -f /home/vagrant/.ssh/id_rsa -t rsa -N ''"

pe "sudo curl -s ${VAULT_ADDR}/v1/ssh-client-signer/public_key -o /etc/ssh/trusted-user-ca-keys.pem"

pe "unset VAULT_TOKEN"
# Authenticate to Vault
pe "vault login -method=ldap -path=ldap-um username=jlundberg password=\${USER_PASSWORD}"

pe "rm -f /home/vagrant/.ssh/id_rsa-cert.pub"

cat << EOF
vault write -format=json ssh-client-signer/sign/clientrole public_key=@${HOME}/.ssh/id_rsa.pub 
  | jq -r '.data.signed_key' > ${HOME}/.ssh/id_rsa-cert.pub
EOF
p

vault write -format=json ssh-client-signer/sign/clientrole public_key=@${HOME}/.ssh/id_rsa.pub \
  | jq -r '.data.signed_key' > ${HOME}/.ssh/id_rsa-cert.pub

pe "chmod 0400 /home/vagrant/.ssh/id_rsa-cert.pub"

yellow "When you're getting ghost authentication failures that don't make any sense.  It's probably ssh-add"
pe "ssh-add"

echo "To use the new cert you can use the following command"
echo "ssh vault.hashidemos.com"
