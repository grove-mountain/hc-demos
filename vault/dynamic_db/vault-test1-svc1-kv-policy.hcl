# List, create, update, and delete key/value secrets
# In this example:
# Namespace Path: vault-test1-eng1
# KV Mount: vault-test1-svc1-kv (it might be helpful to put the version here as well)
# e.g. vault-test1-svc1-kvv1, vault-test1-svc1-kvv2

# KV V1 Blanket policy
path "vault-test1-eng/vault-test1-svc1-kv/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the secret
path "vault-test1-eng/vault-test1-svc1-kv/data/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Allow deletion of any secret version
path "vault-test1-eng/vault-test1-svc1-kv/delete/*"
{
  capabilities = ["update"]
}

# Allow un-deletion of any secret version
path "vault-test1-eng/vault-test1-svc1-kv/undelete/*"
{
  capabilities = ["update"]
}

# Allow destroy of any secret version
path "vault-test1-eng/vault-test1-svc1-kv/destroy/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "vault-test1-eng/vault-test1-svc1-kv/metadata/*"
{
  capabilities = ["list", "read", "delete"]
}
