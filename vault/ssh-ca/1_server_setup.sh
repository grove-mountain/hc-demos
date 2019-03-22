#!/usr/bin/env bash
. env.sh

green "Setup Host key signer"
# Mount a backend's instance for signing host keys
pe "vault secrets enable -path ssh-host-signer ssh"

# Allow host certificate to have longer TTLs
pe "vault secrets tune -max-lease-ttl=87600h ssh-host-signer"

green "Generate the host signing CA"
# Configure the host CA certificate
cat << EOF
vault write -f -format=json ssh-host-signer/config/ca | '
  jq -r '.data.public_key' > ${HOME}/host_CA_certificate_raw
EOF
p
vault write -f -format=json ssh-host-signer/config/ca |  \
  jq -r '.data.public_key' > ${HOME}/host_CA_certificate_raw

cat << EOF
echo "@cert-authority *.hashidemos.com \$(cat ${HOME}/host_CA_certificate_raw)" > ${HOME}/CA_certificate
EOF
p

echo "@cert-authority *.hashidemos.com $(cat ${HOME}/host_CA_certificate_raw)" > ${HOME}/CA_certificate

green "Add the CA to known hosts"
pe "cat ${HOME}/CA_certificate >> ${HOME}/.ssh/known_hosts"


green "Create the role that's allowed to sign host keys"
cat << EOF
# Create a role to sign host keys
vault write ssh-host-signer/roles/hostrole ttl=87600h 
  allow_host_certificates=true 
  key_type=ca 
  allowed_domains="localdomain,hashidemos.com" 
  allow_subdomains=true
EOF
p

vault write ssh-host-signer/roles/hostrole ttl=87600h \
  allow_host_certificates=true \
  key_type=ca \
  allowed_domains="localdomain,hashidemos.com" \
  allow_subdomains=true

cat << EOF
vault write -format=json ssh-host-signer/sign/hostrole 
  public_key=@/etc/ssh/ssh_host_rsa_key.pub 
  cert_type=host 
  | jq -r ".data.signed_key" | sudo tee /etc/ssh/ssh_host_rsa_key-cert.pub
EOF
p

vault write -format=json ssh-host-signer/sign/hostrole \
  public_key=@/etc/ssh/ssh_host_rsa_key.pub \
  cert_type=host \
  | jq -r ".data.signed_key" | sudo tee /etc/ssh/ssh_host_rsa_key-cert.pub


green "Configure client key signing"

# Mount a backend's instance for signing client keys
pe "vault secrets enable -path ssh-client-signer ssh"

# Configure the client CA certificate
cat << EOF
vault write -f -format=json ssh-client-signer/config/ca | 
  jq -r '.data.public_key' >>  ${HOME}/trusted-user-ca-keys.pem
EOF
p

vault write -f -format=json ssh-client-signer/config/ca | \
  jq -r '.data.public_key' >>  ${HOME}/trusted-user-ca-keys.pem

pe "sudo mv ${HOME}/trusted-user-ca-keys.pem /etc/ssh/trusted-user-ca-keys.pem"


cat << EOF
echo '
  {
    "allow_user_certificates": true,
    "allowed_users": "*",
    "default_extensions": [
      {
        "permit-pty": ""
      }
    ],
    "key_type": "ca",
    "key_bits": "2048",
    "key_id_format": "vault-{{role_name}}-{{token_display_name}}-{{public_key_hash}}",
    "default_user": "vagrant",
    "max_ttl": "24h",
    "ttl": "30m0s"
  }' >> /home/vagrant/clientrole.json
EOF
p

echo '
  {
    "allow_user_certificates": true,
    "allowed_users": "*",
    "default_extensions": [
      {
        "permit-pty": ""
      }
    ],
    "key_type": "ca",
    "key_bits": "2048",
    "key_id_format": "vault-{{role_name}}-{{token_display_name}}-{{public_key_hash}}",
    "default_user": "vagrant",
    "max_ttl": "24h",
    "ttl": "30m0s"
  }' >> ${HOME}/clientrole.json


# Create a role to sign client keys
pe "vault write ssh-client-signer/roles/clientrole @${HOME}/clientrole.json"

green "Configure the SSH Daemon with user ca keys and host keys"
cat << EOF
echo "TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem" | sudo tee --append /etc/ssh/sshd_config
echo "HostCertificate /etc/ssh/ssh_host_rsa_key-cert.pub" | sudo tee --append /etc/ssh/sshd_config
EOF
p

echo "TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem" | sudo tee --append /etc/ssh/sshd_config
echo "HostCertificate /etc/ssh/ssh_host_rsa_key-cert.pub" | sudo tee --append /etc/ssh/sshd_config

# Restart sshd
pe "sudo systemctl restart sshd"

cat << EOF > ssh-user-policy.hcl
path "sys/mounts" {
  capabilities = ["list","read"]
}
path "ssh-client-signer/sign/clientrole" {
  capabilities = ["create", "update"]
} 
EOF

green "Setup policy and LDAP group to allow SSH Access"
yellow "You need to actually setup LDAP Auth First Jake!"
p
pe "vault policy write ssh-user ./ssh-user-policy.hcl"
pe "vault policy read ssh-user"
pe "vault write auth/ldap-um/groups/solutions_engineering policies=se_full,pro_svcs_read,ssh-user"
