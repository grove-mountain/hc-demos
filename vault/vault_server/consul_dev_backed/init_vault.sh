. env.sh

vault operator init -key-shares=${KEY_SHARES} -key-threshold=${KEY_THRESHOLD} -format json > init_out.json

for i in $(seq 0 $((${KEY_THRESHOLD} - 1)));do
  vault operator unseal $(cat init_out.json | jq -r .unseal_keys_b64[$i])
done

export VAULT_TOKEN=$(jq -r '.root_token' init_out.json)
