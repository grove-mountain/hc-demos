# KV V1 Blanket policy
path "kv-jake/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the kv-jake
path "kv-jake/data/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kv-jake/data/*"
{
  capabilities = [ "read", "list"]
}


# Allow deletion of any kv-jake version
path "kv-jake/delete/*"
{
  capabilities = ["update"]
}

# Allow un-deletion of any kv-jake version
path "kv-jake/undelete/*"
{
  capabilities = ["update"]
}

# Allow destroy of any kv-jake version
path "kv-jake/destroy/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "kv-jake/metadata/*"
{
  capabilities = ["list", "read", "delete"]
}
