# KV V1 
path "terraform_education/*"
{
  capabilities = ["read", "list"]
}

# KV V2 

# Allow full access to the current version of the secret
path "terraform_education/data/*"
{
  capabilities = ["read", "list"]
}


# Allow list and view of metadata and to delete all versions and metadata for a key
path "terraform_education/metadata/*"
{
  capabilities = ["list", "read"]
}
