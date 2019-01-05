# KV V1 
path "vault_education/*"
{
  capabilities = ["read", "list"]
}

# KV V2 

# Allow full access to the current version of the secret
path "vault_education/data/*"
{
  capabilities = ["read", "list"]
}


# Allow list and view of metadata and to delete all versions and metadata for a key
path "vault_education/metadata/*"
{
  capabilities = ["list", "read"]
}
