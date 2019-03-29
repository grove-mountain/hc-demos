path 

# Manage auth methods broadly across Vault
path "auth/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create and manage ACL policies via CLI
path "identity/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create and manage namespaces 
path "sys/namespaces/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create, update, and delete auth methods
path "sys/auth/*"
{
  capabilities = ["create", "update", "delete", "sudo"]
}

# List auth methods
path "sys/auth"
{
  capabilities = ["read"]
}

# To list policies
path "sys/policy"
{
  capabilities = ["read"]
}

# To manage policies
path "sys/policy/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create and manage policies via API
# These policy blocks allow for newer (>0.9) policy management.
path "sys/policies/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Create and manage ACL policies via API
path "sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create and manage Sentinel EGP policies via API
path "sys/policies/egp/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create and manage Sentinel RGP policies via API
path "sys/policies/rgp/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Capabilities
path "sys/capabilities"
{
  capabilities = ["create", "update"]
}

# To perform Step 4
path "sys/capabilities-self"
{
  capabilities = ["create", "update"]
}

# Manage secret engines broadly across Vault
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List existing secret engines
path "sys/mounts"
{
  capabilities = ["read"]
}

# Read health checks
path "sys/health"
{
  capabilities = ["read", "sudo"]
}

# Admin Control groups
path "sys/config/control-group"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/internal/ui/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
