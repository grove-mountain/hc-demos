# KV V1 Blanket policy
path "secret/solutions_engineering/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the secret
path "secret/data/solutions_engineering/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "secret/data/solutions_engineering"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}


# Allow deletion of any secret version
path "secret/delete/solutions_engineering/*"
{
  capabilities = ["update"]
}

path "secret/delete/solutions_engineering"
{
  capabilities = ["update"]
}

# Allow un-deletion of any secret version
path "secret/undelete/solutions_engineering/*"
{
  capabilities = ["update"]
}

path "secret/undelete/solutions_engineering"
{
  capabilities = ["update"]
}

# Allow destroy of any secret version
path "secret/destroy/solutions_engineering/*"
{
  capabilities = ["update"]
}

path "secret/destroy/solutions_engineering"
{
  capabilities = ["update"]
}
# Allow list and view of metadata and to delete all versions and metadata for a key
path "secret/metadata/solutions_engineering/*"
{
  capabilities = ["list", "read", "delete"]
}

path "secret/metadata/solutions_engineering"
{
  capabilities = ["list", "read", "delete"]
}
