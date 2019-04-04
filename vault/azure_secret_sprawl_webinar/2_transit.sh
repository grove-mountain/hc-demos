. env.sh

green "This demo shows how to use the Vault transit engine"
green "This is a great way of providing Encryption as a Service to your developers"
echo ""
green "Enabling transit and creating some keys"
pe "vault secrets enable transit"
pe "vault write -f transit/keys/db-pii"

yellow "This key is to demonstrate a failure condition later in the demo"
pe "vault write -f transit/keys/db-admin"

pe "vault policy write transit-db-pii ./transit-db-pii-policy.hcl"
pe "vault policy read transit-db-pii"
green "Notice the permissions granted by this policy"
echo ""
echo ""
green "We need to add a role to allow the Azure auth to assign a policy"
cat << EOF
vault write auth/azure/role/transit-db-pii
  policies=transit-db-pii
  bound_subscription_ids=\${AZURE_SUBSCRIPTION_ID}
  bound_resource_groups=\${AZURE_RESOURCE_GROUP}
EOF
p ""

vault write auth/azure/role/transit-db-pii \
  policies=transit-db-pii \
  bound_subscription_ids=${AZURE_SUBSCRIPTION_ID} \
  bound_resource_groups=${AZURE_RESOURCE_GROUP}

p
green "Re-iterating the process of using Azure Auth"

pe "export jwt=\$(curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com' -H Metadata:true | jq -r '.access_token')"
echo $jwt
pe "export subscription_id=\$(curl -s -H Metadata:true 'http://169.254.169.254/metadata/instance?api-version=2017-08-01' | jq -r '.compute | .subscriptionId')"
echo $subscription_id

pe "export resource_group_name=\$(curl -s -H Metadata:true 'http://169.254.169.254/metadata/instance?api-version=2017-08-01' | jq -r '.compute | .resourceGroupName')"
echo $resource_group_name

pe "export vm_name=\$(curl -s -H Metadata:true 'http://169.254.169.254/metadata/instance?api-version=2017-08-01' | jq -r '.compute | .name')"
echo $vm_name

p
green "Authenticating to Vault using MSI"
# User/application experience
cat << EOF
export VAULT_TOKEN=\$(vault write -field=token auth/azure/login role="transit-db-pii"
     jwt=\${jwt}
     subscription_id=\${AZURE_SUBSCRIPTION_ID}
     resource_group_name=\${AZURE_RESOURCE_GROUP}
     vm_name=\${vm_name})
EOF
p ""

export VAULT_TOKEN=$(vault write -field=token auth/azure/login role="transit-db-pii" \
     jwt=$jwt \
     subscription_id=${AZURE_SUBSCRIPTION_ID} \
     resource_group_name=${AZURE_RESOURCE_GROUP} \
     vm_name=${vm_name})

p
green "Encrypting sensitive data and creating database records"
pe "export NAME='Master Chief'"
pe "export SSN='123-45-6789'"
pe "enc_ssn=\$(vault write -field=ciphertext transit/encrypt/db-pii plaintext=\$(base64 <<< ${SSN}))"

green "Notice the v1 in the key below, this can be used for key rolling by version"
cat << EOF
INSERT INTO characters VALUES
(${NAME}, ${enc_ssn});
EOF
p

pe "export NAME='Jacob Keyes'"
pe "export SSN='321-45-6789'"
pe "enc_ssn=\$(vault write -field=ciphertext transit/encrypt/db-pii plaintext=\$(base64 <<< ${SSN}))"

cat << EOF
INSERT INTO characters VALUES
(${NAME}, ${enc_ssn});
EOF
p


pe "export NAME='Avery Johnson'"
pe "export SSN='987-65-4321'"
pe "enc_ssn=\$(vault write -field=ciphertext transit/encrypt/db-pii plaintext=\$(base64 <<< ${SSN}))"

cat << EOF
INSERT INTO characters VALUES
(${NAME}, ${enc_ssn});
EOF
p


green "Decrypting is just as easy, just use the decrypt endpoint"
pe "dec_ssn=\$(vault write -field=plaintext transit/decrypt/db-pii ciphertext=\${enc_ssn}| base64 --decode)"
echo "Decrypted SSN for ${NAME}: ${dec_ssn}"
p


red "How about failure conditions when trying to use a key you don't have permission to use?"
pe "export NAME='Miranda Keyes'"
pe "export SSN='321-45-6789'"
pe "enc_ssn=\$(vault write -field=ciphertext transit/encrypt/db-admin plaintext=\$(base64 <<< ${SSN}))"


green "It's always a good idea to test failures as well"
