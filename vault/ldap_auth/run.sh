LDAP_HOST=127.0.0.1
LDAP_URL="ldap://${LDAP_HOST}"
BIND_DN="cn=read-only,dc=hashidemos,dc=com"
BIND_PW="devsecopsFTW"
USER_DN="ou=people,dc=hashidemos,dc=com"
USER_ATTR="cn"
GROUP_DN="ou=um_group,dc=hashidemos,dc=com"
UM_GROUP_FILTER="(&(objectClass=groupOfUniqueNames)(uniqueMember={{.UserDN}}))"
UM_GROUP_ATTR="cn"
MO_GROUP_FILTER="(&(objectClass=person)(uid={{.Username}}))"
MO_GROUP_ATTR="memberOf"
USER_PASSWORD="thispasswordsucks"

vault auth enable -path=ldap-um ldap

# Using group of unique names lookups
vault write auth/ldap-um/config \
    url="${LDAP_URL}" \
    binddn="${BIND_DN}" \
    bindpass="${BIND_PW}" \
    userdn="${USER_DN}" \
    userattr="${USER_ATTR}" \
    groupdn="${GROUP_DN}" \
    groupfilter="${UM_GROUP_FILTER}" \
    groupattr="${UM_GROUP_ATTR}" \
    insecure_tls=true 


vault policy write se_full policies/se_full_policy.hcl
vault policy write se_read policies/se_read_policy.hcl

vault policy write pro_svcs_full policies/pro_svcs_full_policy.hcl
vault policy write pro_svcs_read policies/pro_svcs_read_policy.hcl

vault write auth/ldap-um/groups/solutions_engineering policies=se_full,pro_svcs_read
vault write auth/ldap-um/groups/pro_svcs policies=pro_svcs_full,se_read


vault auth enable -path=ldap-mo ldap

vault write auth/ldap-mo/config \
    url="${LDAP_URL}" \
    binddn="${BIND_DN}" \
    bindpass="${BIND_PW}" \
    userdn="${USER_DN}" \
    userattr="${USER_ATTR}" \
    groupdn="${USER_DN}" \
    groupfilter="${MO_GROUP_FILTER}" \
    groupattr="${MO_GROUP_ATTR}" \
    insecure_tls=true

vault secrets enable -path=vault_education kv
vault secrets enable -path=terraform_education kv

vault policy write vault_edu_full policies/vault_edu_full_policy.hcl
vault policy write vault_edu_read policies/vault_edu_read_policy.hcl

vault policy write tf_edu_full policies/tf_edu_full_policy.hcl
vault policy write tf_edu_read policies/tf_edu_read_policy.hcl

vault write auth/ldap-mo/groups/cn=vault_education,ou=um_group,dc=hashidemos,dc=com policies=vault_edu_full,tf_edu_read

vault write auth/ldap-mo/groups/cn=terraform_education,ou=um_group,dc=hashidemos,dc=com policies=tf_edu_full,vault_edu_read


# Test Unique Member logins and capabilities
vault login -method=ldap -path=ldap-um/ username=jlundberg password=${USER_PASSWORD}
vault kv put secret/solutions_engineering/db password=42foo

vault login -method=ldap -path=ldap-um/ username=bgreen password=${USER_PASSWORD}
vault kv put secret/pro_svcs/db password=42woo
vault kv put secret/solutions_engineering/db password=42foo
vault kv get secret/solutions_engineering/db

# Test Member Of logins and capabilities
vault login -method=ldap -path=ldap-mo/ username=yoko password=${USER_PASSWORD}
vault write vault_education/db1 password=42zoo
