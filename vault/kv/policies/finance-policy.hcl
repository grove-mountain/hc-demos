# KV V1 Blanket policy
path "secret/db1/finance/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:
path "secret/*"
{
  capabilities = ["list"]
}


# Allow full access to the current version of the secret
path "secret/data/db1/finance/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "secret/data/db1/finance"
{
  capabilities = [ "read", "list"]
}


# Allow deletion of any secret version
path "secret/delete/db1/finance/*"
{
  capabilities = ["update"]
}

# Allow un-deletion of any secret version
path "secret/undelete/db1/finance/*"
{
  capabilities = ["update"]
}

# Allow destroy of any secret version
path "secret/destroy/db1/finance/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "secret/metadata/db1/finance/*"
{
  capabilities = ["list", "read", "delete"]
}
