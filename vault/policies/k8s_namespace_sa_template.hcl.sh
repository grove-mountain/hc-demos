# Mount accessors are different per installation and per mounted authentication methods
# Example setting MOUNT_ACCESSOR
MOUNT_PATH="kubernetes/"
MOUNT_ACCESSOR=$(vault auth list -format=json | jq -r '.["${MOUNT_PATH}"].accessor')

cat > k8s_ns_sa_acl_policy_template.hcl << EOF
# Give access to $namespace/$service_account
# This is V2 style
path "kv/data/{{identity.entity.aliases.${MOUNT_ACCESSOR}.metadata.service_account_namespace}}/{{identity.entity.aliases.${MOUNT_ACCESSOR}.metadata.service_account_name}}/*" {
capabilities = ["create", "read", "update", "delete", "list"]
}


# Give list access to $namespace, so applications can see what other secrets can be requested. More just showing options than this is a real use case
path "kv/data/{{identity.entity.aliases.${MOUNT_ACCESSOR}.metadata.service_account_namespace}} {
capabilities = ["list"]
}
EOF
