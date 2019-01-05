# KV V1 Blanket policy
path "vault_education/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the secret
path "vault_education/data/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Allow deletion of any secret version
path "vault_education/delete/*"

{
  capabilities = ["update"]
}

# Allow un-deletion of any secret version
path "vault_education/undelete/*"
{
  capabilities = ["update"]
}

# Allow destroy of any secret version
path "vault_education/destroy/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "vault_education/metadata/*"
{
  capabilities = ["list", "read", "delete"]
}
