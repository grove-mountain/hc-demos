. env.sh

pe "vault policy write se_full policies/se_full_policy.hcl"
pe "vault policy write se_read policies/se_read_policy.hcl"

pe "vault policy write pro_svcs_full policies/pro_svcs_full_policy.hcl"
pe "vault policy write pro_svcs_read policies/pro_svcs_read_policy.hcl"

pe "vault write auth/ldap-um/groups/solutions_engineering policies=se_full,pro_svcs_read"
pe "vault write auth/ldap-um/groups/pro_svcs policies=pro_svcs_full,se_read"


# Test Unique Member logins and capabilities
pe "vault login -method=ldap -path=ldap-um/ username=jlundberg password=${USER_PASSWORD}"
pe "vault kv put secret/solutions_engineering/db password=42foo"

pe "vault login -method=ldap -path=ldap-um/ username=bgreen password=${USER_PASSWORD}"
pe "vault kv put secret/pro_svcs/db password=42woo"
pe "vault kv put secret/solutions_engineering/db password=42foo"
pe "vault kv get secret/solutions_engineering/db"
