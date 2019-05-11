. env.sh

# Create the config file.  Address could vary by location, so dynamically create
cat > ${VAULT_CONF} << EOF
storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"
}

listener "tcp" {
  address = "${IP_ADDRESS}:8200"
  tls_disable = true
}

api_addr = "http://${IP_ADDRESS}:8200"
ui = true
EOF

consul agent -server -dev -bind ${IP_ADDRESS} & \
vault server -config ${VAULT_CONF}
