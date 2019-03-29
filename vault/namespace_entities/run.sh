. env.sh

yellow "Start up the ldap server"
yellow "Run the 1_setup_ldap_auth.sh from the ldap_auth demo"

pe "vault namespace create solutions_engineering"
pe "vault secrets enable -namespace=solutions_engineering -version=2 kv"
pe "vault policy write -namespace=solutions_engineering ns-admin policies/ns-admin-policy.hcl"
pe "vault policy write -namespace=solutions_engineering kv-full policies/kv-full-policy.hcl"
pe "vault auth list -format=json | jq -r '.[\"ldap-um/\"].accessor' > um-accessor.txt"

cat << EOF
vault write -format=json identity/group name="solutions_engineering_root"
        type="external"
        | jq -r ".data.id" > se_group_id.txt
EOF
p

vault write -format=json identity/group name="solutions_engineering_root" \
        type="external" \
        | jq -r ".data.id" > se_group_id.txt

cat << EOF
vault write -format=json identity/group-alias name="solutions_engineering"
        mount_accessor=\$(cat um-accessor.txt)
        canonical_id=\$(cat se_group_id.txt)
EOF
p

vault write -format=json identity/group-alias name="solutions_engineering" \
        mount_accessor=$(cat um-accessor.txt) \
        canonical_id=$(cat se_group_id.txt)


cat << EOF
vault write -namespace=solutions_engineering identity/group
        name="SE Admin"
        policies="ns-admin,kv-full"
        member_group_ids=$(cat se_group_id.txt)
EOF
p

vault write -namespace=solutions_engineering identity/group \
        name="SE Admin" \
        policies="ns-admin,kv-full" \
        member_group_ids=$(cat se_group_id.txt)


pe "ROOT_TOKEN=\${VAULT_TOKEN}"
pe "unset VAULT_TOKEN"
pe "vault login -method=ldap -path=ldap-um username=jlundberg password=\${USER_PASSWORD}"
pe "vault token lookup"
pe "export VAULT_NAMESPACE=solutions_engineering"
pe "vault secrets enable -path=kv-jake -version=2 kv"
pe "vault secrets enable pki"
pe "vault auth enable userpass"
pe "vault policy write kv-jake policies/kv-jake-policy.hcl"
#vault write identity/group \
#        name="SE Admin" \
#        policies="ns-admin,kv-full,kv-jake" \
#        member_group_ids=$(cat se_group_id.txt)
#pe "unset VAULT_NAMESPACE"
#pe "vault login -method=ldap -path=ldap-um username=jlundberg password=\${USER_PASSWORD}"
#pe "export VAULT_NAMESPACE=solutions_engineering"
#pe "vault kv put kv-jake/beer favorite='Anchor Cali Lager'"


#vault namespace create vault_education
#vault secrets enable -namespace=vault_education -version=2 kv
#vault policy write -namespace=vault_education ns-admin policies/ns-admin-policy.hcl
#vault policy write -namespace=vault_education kv-full policies/kv-full-policy.hcl
#
#vault write -format=json identity/group name="vault_education_root" \
#        type="external" \
#        | jq -r ".data.id" > ve_group_id.txt
#
#vault write -format=json identity/group-alias name="vault_education" \
#        mount_accessor=$(cat um-accessor.txt) \
#        canonical_id=$(cat ve_group_id.txt)
#
#vault write -namespace=vault_education identity/group \
#        name="VE Admin" \
#        policies="ns-admin,kv-full" \
#        member_group_ids=$(cat ve_group_id.txt)
#
#
#unset VAULT_TOKEN
#vault login -method=ldap -path=ldap-um username=geoffrey password=$USER_PASSWORD
#vault token lookup
#export VAULT_NAMESPACE=vault_education
#vault secrets enable -path=kv-geoffrey -version=2 kv
#vault secrets enable pki
#vault auth enable userpass
#vault policy write kv-geoffrey policies/kv-geoffrey-policy.hcl
