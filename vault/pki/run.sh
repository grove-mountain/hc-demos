. env.sh

pe "vault secrets enable pki"

pe "vault secrets tune -max-lease-ttl=${MAX_LEASE_TTL} pki"

cat << EOF
vault write -format=json pki/root/generate/internal
  common_name="${ROOT_CA_COMMON_NAME} Root" 
  ttl=${ROOT_CA_TTL}
  > tmp/pki_root_ca.json
EOF
p

vault write -format=json pki/root/generate/internal \
  common_name="${ROOT_CA_COMMON_NAME} Root" \
  ttl=${ROOT_CA_TTL} \
  > tmp/pki_root_ca.json

cat << EOF
cat tmp/vault_pki_root_ca.json | jq -r '.data.certificate'
  > certs/root_ca_cert.pem
EOF
p

cat tmp/vault_pki_root_ca.json | jq -r '.data.certificate' \
  > certs/root_ca_cert.pem

cat << EOF
vault write pki/config/urls
  issuing_certificates="${VAULT_ADDR}/v1/pki/ca"
  crl_distribution_points="${VAULT_ADDR}/v1/pki/crl"
EOF
p

vault write pki/config/urls \
  issuing_certificates="${VAULT_ADDR}/v1/pki/ca" \
  crl_distribution_points="${VAULT_ADDR}/v1/pki/crl"

pe "vault secrets enable -path=pki_int pki"

pe "vault secrets tune -max-lease-ttl=${INT_CA_TTL} pki_int"

cat << EOF
vault write -field=csr pki_int/intermediate/generate/internal
  common_name="${ROOT_CA_COMMON_NAME} Intermediate"
  ttl=${INT_CA_TTL}
  > tmp/pki_int_ca.csr
EOF
p

vault write -field=csr pki_int/intermediate/generate/internal \
  common_name="${ROOT_CA_COMMON_NAME} Intermediate" \
  ttl=${INT_CA_TTL} \
  > tmp/pki_int_ca.csr

cat << EOF
vault write -format=json pki/root/sign-intermediate
  csr=@tmp/pki_int_ca.csr
  format=pem_bundle
  ttl=${INT_CA_TTL}
  > tmp/pki_int_ca_signed.json
EOF
p

vault write -format=json pki/root/sign-intermediate \
  csr=@tmp/pki_int_ca.csr \
  format=pem_bundle \
  ttl=${INT_CA_TTL} \
  > tmp/pki_int_ca_signed.json

cat << EOF
cat tmp/pki_int_ca_signed.json | jq -r '.data.certificate'
  > certs/int_ca_cert.pem
EOF
p

cat tmp/pki_int_ca_signed.json | jq -r '.data.certificate' \
  > certs/int_ca_cert.pem

cat << EOF
vault write pki_int/intermediate/set-signed
  certificate=@certs/int_ca_cert.pem
EOF
p

vault write pki_int/intermediate/set-signed \
  certificate=@certs/int_ca_cert.pem

cat << EOF
vault write pki_int/config/urls
  issuing_certificates="${VAULT_ADDR}/v1/pki_int/ca"
  crl_distribution_points="${VAULT_ADDR}//v1/pki_int/crl"
EOF
p

vault write pki_int/config/urls \
  issuing_certificates="${VAULT_ADDR}/v1/pki_int/ca" \
  crl_distribution_points="${VAULT_ADDR}//v1/pki_int/crl"

cat << EOF
vault write pki_int/roles/app1-${ROLE_ROOT_DOMAIN}
  allowed_domains=app1.${ROOT_DOMAIN}
  allow_subdomains=true
  key_bits=${KEY_BITS}

  max_ttl=${LEAF_TTL}
EOF
p

cat << EOF
vault write pki_int/roles/app1-${ROLE_ROOT_DOMAIN}
  allowed_domains=app1.${ROOT_DOMAIN}
  allow_subdomains=true
  key_bits=${KEY_BITS}
  max_ttl=${LEAF_TTL}
EOF
p

vault write pki_int/roles/app1-${ROLE_ROOT_DOMAIN} \
  allowed_domains=app1.${ROOT_DOMAIN} \
  allow_subdomains=true \
  key_bits=8192 \
  max_ttl=${LEAF_TTL}


cat << EOF
vault write -format=json pki_int/issue/app1-${ROLE_ROOT_DOMAIN}
  common_name=web1.app1.${ROOT_DOMAIN}
  > tmp/web1.app1.${ROOT_DOMAIN}.json
EOF
p

vault write -format=json pki_int/issue/app1-${ROLE_ROOT_DOMAIN} \
  common_name=web1.app1.${ROOT_DOMAIN} \
  > tmp/web1.app1.${ROOT_DOMAIN}.json

cat << EOF
cat tmp/web1.app1.${ROOT_DOMAIN}.json | jq -r '.data.certificate'
  > certs/web1.app1.${ROOT_DOMAIN}_cert.pem
EOF
p

cat tmp/web1.app1.${ROOT_DOMAIN}.json | jq -r '.data.certificate' \
  > certs/web1.app1.${ROOT_DOMAIN}_cert.pem


cat << EOF
cat tmp/web1.app1.${ROOT_DOMAIN}.json | jq -r '.data.private_key'
  > certs/web1.app1.${ROOT_DOMAIN}_key.pem
EOF
p

cat tmp/web1.app1.${ROOT_DOMAIN}.json | jq -r '.data.private_key' \
  > certs/web1.app1.${ROOT_DOMAIN}_key.pem

cat << EOF
vault write -format=json pki_int/issue/app1-${ROLE_ROOT_DOMAIN}
  common_name=db1.app1.${ROOT_DOMAIN}
  > tmp/db1.app1.${ROOT_DOMAIN}.json
EOF
p

vault write -format=json pki_int/issue/app1-${ROLE_ROOT_DOMAIN} \
  common_name=db1.app1.${ROOT_DOMAIN} \
  > tmp/db1.app1.${ROOT_DOMAIN}.json

cat << EOF
cat tmp/db1.app1.${ROOT_DOMAIN}.json | jq -r '.data.certificate'
  > certs/db1.app1.${ROOT_DOMAIN}_cert.pem
EOF
p

cat << EOF
cat tmp/db1.app1.${ROOT_DOMAIN}.json | jq -r '.data.certificate'
  > certs/db1.app1.${ROOT_DOMAIN}_cert.pem
EOF
p

cat tmp/db1.app1.${ROOT_DOMAIN}.json | jq -r '.data.certificate' \
  > certs/db1.app1.${ROOT_DOMAIN}_cert.pem

cat << EOF
cat tmp/web1.app1.${ROOT_DOMAIN}.json | jq -r '.data.private_key'
  > certs/db1.app1.${ROOT_DOMAIN}_key.pem
EOF
p

cat tmp/web1.app1.${ROOT_DOMAIN}.json | jq -r '.data.private_key' \
  > certs/db1.app1.${ROOT_DOMAIN}_key.pem

#keytool -import -noprompt \
# -alias int.hashidemos.com \
# -keystore keystore.jks \
# -storepass foofoo \
# -keypass foofoo \
# -file certs/int_ca_cert.pem
