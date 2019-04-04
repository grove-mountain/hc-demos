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


# The following are example values from a previous install that's been deleted.
# Most likely these can be gleaned from Terraform information
#azure_application_id=b36b4be1-c82c-480b-a975-f52abaedc07a
#azure_resource_group=jlundberg-vault-workshop
#azure_sp_password=9pLMcqZKxHedVe2ULB12_Cld6McCax4LZogzYxmF0ac
#azure_subscription_id=c0a607b2-6372-4ef3-abdb-dbe52a7b56ba
#azure_tenant_id=0e3e2e88-8caf-41ca-b4da-e3b33b6c52ec
#MYSQL_DATABASE=wsmysqldatabase
#MYSQL_HOST=jlundberg-mysql-server
#MYSQL_HOST_FULL=${MYSQL_HOST}.mysql.database.azure.com
#MYSQL_VAULT_USER=hashicorp
#MYSQL_VAULT_PASSWORD=${MYSQL_VAULT_PASSWORD}
