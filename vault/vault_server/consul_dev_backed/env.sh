VAULT_CONF=vault_conf.hcl
KEY_SHARES=${VAULT_KEY_SHARES:-5}
KEY_THRESHOLD=${VAULT_KEY_THRESHOLD:-3}

case $(uname) in
  Darwin) export IP_ADDRESS=$(ipconfig getifaddr en0);;
  *) echo "Method for finding IP Address unknown for this OS" && exit 1;;
esac
