# This is for the time to wait when using demo_magic.sh
# Using DEMO_WAIT=0 means you don't require the pv program locally.
# This to move forward, just hit return
export PATH=${PATH}:../../demo-tools

if [[ -z ${DEMO_WAIT} ]];then
  DEMO_WAIT=0
fi

# Demo magic gives wrappers for running commands in demo mode.   Also good for learning via CLI.
. demo-magic.sh -d -p -w ${DEMO_WAIT}

###  Put any other environment variables or functions needed for all demos in this folder below ###
