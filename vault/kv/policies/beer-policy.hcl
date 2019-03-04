# KV V1 Blanket policy
path "secret/db1/beer/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the secret
path "secret/data/db1/beer/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "secret/data/db1/beer"
{
  capabilities = [ "read", "list"]
}


# Allow deletion of any secret version
path "secret/delete/db1/beer/*"
{
  capabilities = ["update"]
}

# Allow un-deletion of any secret version
path "secret/undelete/db1/beer/*"
{
  capabilities = ["update"]
}

# Allow destroy of any secret version
path "secret/destroy/db1/beer/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "secret/metadata/db1/beer/*"
{
  capabilities = ["list", "read", "delete"]
}
