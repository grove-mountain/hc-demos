# This is a stub file that can go in pretty much all demos contained here.
USER_PASSWORD=${USER_PASSWORD:-"thispasswordsucks"}

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

