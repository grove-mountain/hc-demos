# KV V1 Blanket policy
path "kv/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the kv
path "kv/data/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kv/data/*"
{
  capabilities = [ "read", "list"]
}


# Allow deletion of any kv version
path "kv/delete/*"
{
  capabilities = ["update"]
}

# Allow un-deletion of any kv version
path "kv/undelete/*"
{
  capabilities = ["update"]
}

# Allow destroy of any kv version
path "kv/destroy/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "kv/metadata/*"
{
  capabilities = ["list", "read", "delete"]
}
