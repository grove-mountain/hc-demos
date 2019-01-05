# KV V1 
path "secret/pro_svcs/*"
{
  capabilities = ["read", "list"]
}

# KV V2 

# Allow full access to the current version of the secret
path "secret/data/pro_svcs/*"
{
  capabilities = ["read", "list"]
}


# Allow list and view of metadata and to delete all versions and metadata for a key
path "secret/metadata/pro_svcs/*"
{
  capabilities = ["list", "read"]
}
