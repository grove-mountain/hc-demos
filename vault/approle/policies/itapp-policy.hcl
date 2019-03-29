# Allow logins via approle
path "auth/approle/login" {
  capabilities = [ "create", "read" ]
}

# Allow full access to the current version of the approle-kv
path "approle-kv/data/it/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "approle-kv/data/it"
{
  capabilities = [ "read", "list"]
}


# Allow deletion of any approle-kv version
path "approle-kv/delete/it/*"
{
  capabilities = ["update"]
}

# Allow un-deletion of any approle-kv version
path "approle-kv/undelete/it/*"
{
  capabilities = ["update"]
}

# Allow destroy of any approle-kv version
path "approle-kv/destroy/it/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "approle-kv/metadata/it/*"
{
  capabilities = ["list", "read", "delete"]
}

