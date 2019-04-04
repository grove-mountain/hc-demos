. env.sh

green "Enable the Azure auth method"
pe "vault auth enable azure"



green "Azure auth needs a service principle to actually verify logins from other service principles"
cat << EOF
vault write auth/azure/config
  tenant_id=\${AZURE_TENANT_ID}
  resource=https://management.azure.com
  client_id=\${AZURE_APPLICATION_ID}
  client_secret=\${AZURE_SP_PASSWORD}
EOF
p ""
vault write auth/azure/config \
  tenant_id=${AZURE_TENANT_ID} \
  resource=https://management.azure.com \
  client_id=${AZURE_APPLICATION_ID} \
  client_secret=${AZURE_SP_PASSWORD}

green "Write policies that will be consumed by roles"
pe "vault policy write db-full-read ./db-full-read-policy.hcl"
pe "vault policy read db-full-read"
p
green "Create the role tied to the policy or policies defined"
cat << EOF
vault write auth/azure/role/db-full-read
  policies=db-full-read
  bound_subscription_ids=\${AZURE_SUBSCRIPTION_ID}
  bound_resource_groups=\${AZURE_RESOURCE_GROUP}
EOF
p ""

vault write auth/azure/role/db-full-read \
  policies=db-full-read \
  bound_subscription_ids=${AZURE_SUBSCRIPTION_ID} \
  bound_resource_groups=${AZURE_RESOURCE_GROUP}

green "You need to use the following variables when you or your applications login to Vault using a Service Principle.  This is merely highlighting the process"

pe "export jwt=\$(curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com' -H Metadata:true | jq -r '.access_token')"
echo $jwt
pe "export subscription_id=\$(curl -s -H Metadata:true 'http://169.254.169.254/metadata/instance?api-version=2017-08-01' | jq -r '.compute | .subscriptionId')"
echo $subscription_id

pe "export resource_group_name=\$(curl -s -H Metadata:true 'http://169.254.169.254/metadata/instance?api-version=2017-08-01' | jq -r '.compute | .resourceGroupName')"
echo $resource_group_name

pe "export vm_name=\$(curl -s -H Metadata:true 'http://169.254.169.254/metadata/instance?api-version=2017-08-01' | jq -r '.compute | .name')"
echo $vm_name

green "Putting some arbitrary values for test/fail conditions"
pe "vault kv put secret/foo password=woo"
pe "vault kv put secret/life/universe/everything answer=42 question=???"


green "Enabling the database secrets engine.  Notice the path to separate different databases from each other"
# Enable database secrets engine
pe "vault secrets enable -path=db-mysql database"


green "Vault needs access to a user who can create other roles in the target database"
# Configure our secret engine
cat << EOF
vault write db-mysql/config/wsmysqldatabase
    plugin_name=mysql-database-plugin
    connection_url="{{username}}:{{password}}@tcp(${MYSQL_HOST}.mysql.database.azure.com:3306)/"
    allowed_roles="beer-read-long","beer-read-short"
    username="\${MYSQL_VAULT_USER}@\${MYSQL_HOST}"
    password="\${MYSQL_VAULT_PASSWORD}"
EOF
p ""

vault write db-mysql/config/wsmysqldatabase \
    plugin_name=mysql-database-plugin \
    connection_url="{{username}}:{{password}}@tcp(${MYSQL_HOST}.mysql.database.azure.com:3306)/" \
    allowed_roles="beer-read-long","beer-read-short" \
    username="${MYSQL_VAULT_USER}@${MYSQL_HOST}" \
    password="${MYSQL_VAULT_PASSWORD}"


green "These are the stubs for the user(s) that Vault will create dynamically"
green "Pay special attention to the TTL values"
# Create our roles
cat << EOF
vault write db-mysql/roles/beer-read-long
    db_name=wsmysqldatabase
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON wsmysqldatabase.beer TO '{{name}}'@'%';"
    default_ttl="10m"
    max_ttl="24h"
EOF
p ""

vault write db-mysql/roles/beer-read-long \
    db_name=wsmysqldatabase \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON wsmysqldatabase.beer TO '{{name}}'@'%';" \
    default_ttl="10m" \
    max_ttl="24h"


cat << EOF
vault write db-mysql/roles/beer-read-short
    db_name=wsmysqldatabase
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON wsmysqldatabase.beer TO '{{name}}'@'%';"
    default_ttl="1m"
    max_ttl="1h"
EOF
p ""

vault write db-mysql/roles/beer-read-short \
    db_name=wsmysqldatabase \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON wsmysqldatabase.beer TO '{{name}}'@'%';" \
    default_ttl="1m" \
    max_ttl="1h"


green "Actually login to Vault using the Azure MSI information"
# User/application experience
cat << EOF
export VAULT_TOKEN=\$(vault write -field=token auth/azure/login role="db-full-read"
     jwt=\${jwt}
     subscription_id=\${AZURE_SUBSCRIPTION_ID}
     resource_group_name=\${AZURE_RESOURCE_GROUP}
     vm_name=\${vm_name})
EOF
p ""

export VAULT_TOKEN=$(vault write -field=token auth/azure/login role="db-full-read" \
     jwt=$jwt \
     subscription_id=${AZURE_SUBSCRIPTION_ID} \
     resource_group_name=${AZURE_RESOURCE_GROUP} \
     vm_name=${vm_name})

green "Generate a few short lived credentials"
pe "vault read -format=json db-mysql/creds/beer-read-short | jq .data"
pe "vault read -format=json db-mysql/creds/beer-read-short | jq .data"
pe "vault read -format=json db-mysql/creds/beer-read-short | jq .data"

green "Generate some longer lived credentials for logging in to the CLI"
cat << EOF
vault read -format=json db-mysql/creds/beer-read-long
  |  jq -r '.data | to_entries | map("\(.key)=\(.value|tostring)")|.[]'
  |  sed -e 's/^/export /'
  | tee .db_creds
EOF
p ""

vault read -format=json db-mysql/creds/beer-read-long \
  |  jq -r '.data | to_entries | map("\(.key)=\(.value|tostring)")|.[]' \
  |  sed -e 's/^/export /' \
  | tee .db_creds

pe ". .db_creds"
pe "mysql --table -h ${MYSQL_HOST_FULL} -D ${MYSQL_DATABASE} -u ${username}@${MYSQL_HOST} --password=${password} < select_beer.sql"
