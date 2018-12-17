# Most likely this will be your wifi interface, though 
if [ $(uname) == 'Darwin' ];then
  export IP_ADDRESS=$(ipconfig getifaddr en0)
fi

export VAULT_ADDR="http://${IP_ADDRESS}:8200"

# This is for the time to wait when using demo_magic.sh
if [[ -z ${DEMO_WAIT} ]];then
  DEMO_WAIT=0
fi

# Demo magic gives wrappers for running commands in demo mode.   Also good for learning via CLI.

. demo-magic.sh -d -p -w ${DEMO_WAIT}
