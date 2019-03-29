# Allow logins via approle
path "auth/approle/login" {
  capabilities = [ "create", "read" ]
}

# Allow full access to the current version of the approle-kv
path "approle-kv/data/finance/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "approle-kv/data/finance"
{
  capabilities = [ "read", "list"]
}


# Allow deletion of any approle-kv version
path "approle-kv/delete/finance/*"
{
  capabilities = ["update"]
}

# Allow un-deletion of any approle-kv version
path "approle-kv/undelete/finance/*"
{
  capabilities = ["update"]
}

# Allow destroy of any approle-kv version
path "approle-kv/destroy/finance/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "approle-kv/metadata/finance/*"
{
  capabilities = ["list", "read", "delete"]
}

