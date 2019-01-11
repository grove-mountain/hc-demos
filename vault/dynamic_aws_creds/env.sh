export PATH=${PATH}:../../demo-tools
TTL=1m
MAX_TTL=10m

# This is for the time to wait when using demo_magic.sh
if [[ -z ${DEMO_WAIT} ]];then
  DEMO_WAIT=0
fi

# Demo magic gives wrappers for running commands in demo mode.   Also good for learning via CLI.

. demo-magic.sh -d -p -w ${DEMO_WAIT}
