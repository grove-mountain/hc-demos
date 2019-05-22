# This is a stub file that can go in pretty much all demos contained here.

# This path may need to be modified based on demo folder depth
export PATH=${PATH}:../../demo-tools

# This is for the time to wait when using demo_magic.sh
# Using DEMO_WAIT=0 means you don't require the pv program locally.  
# This to move forward, just hit return
if [[ -z ${DEMO_WAIT} ]];then
  DEMO_WAIT=0
fi

# Demo magic gives wrappers for running commands in demo mode.   Also good for learning via CLI.
. demo-magic.sh -d -p -w ${DEMO_WAIT}

###  Put any other environment variables or functions needed for all demos in this folder below ###

export VAULT_PROTO=${VAULT_PROTO:-http}
export VAULT_HOST=${VAULT_HOST:-localhost}
export VAULT_PORT=${VAULT_PORT:-8200}
export VAULT_ADDR=${VAULT_ADDR:-${VAULT_PROTO}://${VAULT_HOST}:${VAULT_PORT}}
export PKI_PATH=pki
export MAX_LEASE_TTL=${MAX_LEASE_TTL:-87600h}
export ROOT_DOMAIN=${ROOT_DOMAIN:-hashidemos.com}
export ROOT_CA_COMMON_NAME=${ROOT_CA_COMMON_NAME:-${ROOT_DOMAIN}}
export ROOT_CA_TTL=${ROOT_CA_TTL:-87600h}
export INT_CA_TTL=${INT_CA_TTL:-43800h}
export LEAF_TTL=${LEAF_TTL:-24h}
export ROLE_ROOT_DOMAIN=${ROOT_DOMAIN/./-}
export KEY_BITS=4096
