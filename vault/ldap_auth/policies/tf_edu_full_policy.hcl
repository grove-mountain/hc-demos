# KV V1 Blanket policy
path "terraform_education/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the secret
path "terraform_education/data/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Allow deletion of any secret version
path "terraform_education/delete/*"

{
  capabilities = ["update"]
}

# Allow un-deletion of any secret version
path "terraform_education/undelete/*"
{
  capabilities = ["update"]
}

# Allow destroy of any secret version
path "terraform_education/destroy/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "terraform_education/metadata/*"
{
  capabilities = ["list", "read", "delete"]
}
