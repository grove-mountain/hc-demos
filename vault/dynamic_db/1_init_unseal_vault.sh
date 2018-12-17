# Source common environments
. env.sh

pe "vault operator init -key-shares=${VAULT_KEY_SHARES} -key-threshold=${VAULT_KEY_THRESHOLD} > ${VAULT_INIT_OUTPUT}"

for key in $(grep "Unseal Key" ${VAULT_INIT_OUTPUT} | awk '{print $4}');do
  pe "vault operator unseal $key"
done

pe "echo \"export VAULT_TOKEN=$(grep 'Initial Root Token' ${VAULT_INIT_OUTPUT} | awk '{print $4}')\" > root_token"

