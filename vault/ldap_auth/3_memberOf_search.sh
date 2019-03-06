. env.sh

pe "vault secrets enable -path=vault_education kv"
pe "vault secrets enable -path=terraform_education kv"

pe "vault policy write vault_edu_full policies/vault_edu_full_policy.hcl"
pe "vault policy read vault_edu_full"
pe "vault policy write vault_edu_read policies/vault_edu_read_policy.hcl"
pe "vault policy read vault_edu_read"

pe "vault policy write tf_edu_full policies/tf_edu_full_policy.hcl"
pe "vault policy read tf_edu_full"
pe "vault policy write vault_edu_read policies/vault_edu_read_policy.hcl"
pe "vault policy write tf_edu_read policies/tf_edu_read_policy.hcl"
pe "vault policy read tf_edu_read"

pe "vault write auth/ldap-mo/groups/cn=vault_education,ou=um_group,dc=hashidemos,dc=com policies=vault_edu_full,tf_edu_read"

pe "vault write auth/ldap-mo/groups/cn=terraform_education,ou=um_group,dc=hashidemos,dc=com policies=tf_edu_full,vault_edu_read"

pe "vault kv put vault_education/root password=voot"
pe "vault kv put terraform_education/root password=toot"
# Test Member Of logins and capabilities
unset VAULT_TOKEN
pe "vault login -method=ldap -path=ldap-mo/ username=yoko password=${USER_PASSWORD}"
pe "vault kv put vault_education/db1 password=42zoo"
pe "vault kv get vault_education/db1"
pe "vault kv put terraform_education/db1 password=42zoo"
pe "vault kv get terraform_education/root"

unset VAULT_TOKEN
pe "vault login -method=ldap -path=ldap-mo/ username=rachel password=${USER_PASSWORD}"
pe "vault kv put terraform_education/db1 password=42zoo"
pe "vault kv get terraform_education/db1"
pe "vault kv put vault_education/db1 password=42zoo"
pe "vault kv get vault_education/root"
