# Eliminating Secret Sprawl with Vault on Azure

The main purpose of this webinar was to demonstrate how to eliminate secret sprawl with Vault.   Basic K/V demo was used locally, and then patterns for Azure Auth login via MSI assigned to the image were used for these examples.

Azure resources were launched using Terraform code at: https://github.com/grove-mountain/azure-terraform-vault-workshop.git.   This is a fork of Sean Carolan's excellent work located at https://github.com/scarolan/azure-terraform-vault-workshop.   It's been modified to add in Service Principals for doing Azure Auth into Vault.   


Useful links:
https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest

https://github.com/hashicorp/vault-guides/tree/master/secrets/azure-secret

https://www.vaultproject.io/docs/auth/azure.html



