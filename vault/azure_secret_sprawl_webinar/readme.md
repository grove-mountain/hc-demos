# Eliminating Secret Sprawl with Vault on Azure

The main purpose of this webinar was to demonstrate how to eliminate secret sprawl with Vault.   Basic K/V demo was used locally, and then patterns for Azure Auth login via MSI assigned to the image were used for these examples.

Azure resources were launched using a fork of Sean Carolan's excellent work located at https://github.com/scarolan/azure-terraform-vault-workshop.   It's been modified to add in Service Principals for doing Azure Auth into Vault.   

The code is linked up here under the terraform/ directory.

Useful links related to this webinar/blog:
https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest

https://github.com/hashicorp/vault-guides/tree/master/secrets/azure-secret

https://www.vaultproject.io/docs/auth/azure.html


All of the example code here is run from Bash command line, but can be translated to any shell. 

## Clone this repo and change directories
```
git clone git@github.com:grove-mountain/hc-demos.git
cd hc-demos/vault/azure_secret_sprawl_webinar/terraform
```

## Terraform the Azure environment

Terraform is a cloud agnostic infrastructure provisioning tool.   It has the ability to launch resources in all the major cloud providers using a common, easy-to-use language called HashiCorp Configuration Language (HCL).   It also allows people to share re-useable code to easily launch environments for demos like this.

This code will help you stand up resources in Azure for this demo.   We highly encourage you to destroy the environment after running this demo.   The code will allow you to easily recreate it later.


 * Create the terraform.tfvars file.  
 * Change "prefix" to a descriptive name
 * Initialize Terraform
 * Login to Azure (if not currently logged in)
 * Plan Terraform
 * Apply Terraform

This file only contains the name prefix for the project and should be descriptive in the event you're running many resource groups in Azure.  Also contained is the admin_password.   If default passwords aren't your thing, uncomment and change this as well.

e.g.
```
cp terraform.tfvars.example terraform.tfvars
```
Use your editor of choice to change prefix and optionally admin_password.  Then...

```
az login 
terraform init
terraform plan
```

Terraform plan displays all the resources it plans on creating. It's a good practice to review what is going to be created and verify the work you'd expect.   If you're new to Infrastructure as Code, this may be more informational than anything.   Once reviewed, apply the code.   This can take 8-10m on Azure to create all necessary resources.   This is a great time to have a coffee break and read up on some of the Useful Links supplied above or the following:

 * https://www.terraform.io/ 
 * https://learn.hashicorp.com/terraform/

When Terraform is finished running, it's going to output some data like:

```
Outputs:

MySQL_Server_FQDN = jlundberg-mysql-server.mysql.database.azure.com
Vault_Server_URL = http://jlundberg.centralus.cloudapp.azure.com:8200
_Instructions =
 # Connect to your Linux Virtual Machine
 #
 # Run the command below to SSH into your server. You can also use PuTTY or any
 # other SSH client. Your password is: Password123!

 ssh hashicorp@jlundberg.centralus.cloudapp.azure.com
```

** WARNING **
This contains very sensitive information about your environment.  Do not save this data to files and do not check any output data into version control.   This is here for informational purposes to help you with the remainder of the demo.   You are expected to destroy this environment after use.   

## SSH to the bastion host

The bastion host is where you will run all commands from.   SSH to it and use the password supplied.   This is not a highly secure method.  Again, we expect you to destroy this host after testing so it will not be an attack surface into your environment later.

e.g.
```
ssh hashicorp@jlundberg.centralus.cloudapp.azure.com -o PubkeyAuthentication=false
```

### Note
If you've run this more than once, you'll likely have conflicting SSH connections.  Use your favorite tool to clean up old connections.

e.g. 
```
ssh-keygen -R jlundberg.centralus.cloudapp.azure.com
```

## Run the online demos

For the generic K/V demo, change to the KV demo directory and run the demo files:

Run each demo script.   These use Demo Magic, meaning all you have to do is run the script and hit RETURN at each step.  Keep hitting RETURN until the demo is finished.
```
cd ~/hc-demos/vault/kv
./1_basic_ops.sh
./2_install_policies.sh
./3_policy_scoped_tokens.sh
./4_secret_mount_points.sh
```

Change directory to the azure_secret_sprawl_webinar demo directory
```
cd ~/hc-demos/vault/azure_secret_sprawl_webinar
```


This demo shows you the power of using both AD/MSI authentication as well as dynamic database credentials.
```
./1_azure_dyn_db.sh
```

This demo shows you how to use the transit secret engine to encrypt/decrypt data stored at rest.
```
./2_transit.sh
```


## Destroy your terraform resources

Once done, exit out of the bastion host and destroy your resources.  This will automatically tear down anything created for this demo saving you the effort of deleting these resources by hand and saving money in the long run as well.  

```
exit

terraform destroy
```
