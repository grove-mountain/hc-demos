# KV V1 Blanket policy
path "secret/pro_svcs/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the secret
path "secret/data/pro_svcs/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Allow deletion of any secret version
path "secret/delete/pro_svcs/*"

{
  capabilities = ["update"]
}

# Allow un-deletion of any secret version
path "secret/undelete/pro_svcs/*"
{
  capabilities = ["update"]
}

# Allow destroy of any secret version
path "secret/destroy/pro_svcs/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "secret/metadata/pro_svcs/*"
{
  capabilities = ["list", "read", "delete"]
}
