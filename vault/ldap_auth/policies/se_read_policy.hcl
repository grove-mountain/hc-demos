# KV V1 
path "secret/solutions_engineering/*"
{
  capabilities = ["read", "list"]
}

# KV V2 

# Allow full access to the current version of the secret
path "secret/data/solutions_engineering/*"
{
  capabilities = ["read", "list"]
}


# Allow list and view of metadata and to delete all versions and metadata for a key
path "secret/metadata/solutions_engineering/*"
{
  capabilities = ["list", "read"]
}
