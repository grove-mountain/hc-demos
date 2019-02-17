. env.sh

pe "vault auth enable -path=ldap-um ldap"

# Using group of unique names lookups
cat << EOF
vault write auth/ldap-um/config
    url="${LDAP_URL}"
    binddn="${BIND_DN}"
    bindpass="${BIND_PW}"
    userdn="${USER_DN}"
    userattr="${USER_ATTR}"
    groupdn="${GROUP_DN}"
    groupfilter="${UM_GROUP_FILTER}"
    groupattr="${UM_GROUP_ATTR}"
    insecure_tls=true
EOF
p

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

pe "vault auth enable -path=ldap-mo ldap"

cat << EOF
vault write auth/ldap-mo/config
    url="${LDAP_URL}"
    binddn="${BIND_DN}"
    bindpass="${BIND_PW}"
    userdn="${USER_DN}"
    userattr="${USER_ATTR}"
    groupdn="${USER_DN}"
    groupfilter="${MO_GROUP_FILTER}"
    groupattr="${MO_GROUP_ATTR}"
    insecure_tls=true
EOF
p

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


