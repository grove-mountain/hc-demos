. env.sh

cat > vault_config.hcl << EOL
storage "inmem" {}

listener "tcp" {
  address = "${IP_ADDRESS}:8200"
  tls_disable = "true"
}
ui=true
EOL

pe "vault server -config=vault_config.hcl"
