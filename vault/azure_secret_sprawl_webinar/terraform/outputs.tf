##############################################################################
# Outputs File
#
# Expose the outputs you want your users to see after a successful 
# `terraform apply` or `terraform output` command. You can add your own text 
# and include any data from the state file. Outputs are sorted alphabetically;
# use an underscore _ to move things to the bottom. In this example we're 
# providing instructions to the user on how to connect to their own custom 
# demo environment.
#

output "azure_tenant_id" {
    value = "${data.azurerm_client_config.current.tenant_id}"
}

output "azure_subscription_id" {
    value = "${data.azurerm_client_config.current.subscription_id}"
}

output "azure_application_id" {
    value = "${azurerm_azuread_application.vaultapp.application_id}"
}

output "azure_sp_password" {
    value = "${azurerm_azuread_service_principal_password.vaultapp.value}"
}

output "azure_resource_group" {
    value = "${azurerm_resource_group.vaultworkshop.name}"
}

output "Vault_Server_URL" {
    value = "http://${azurerm_public_ip.vault-pip.fqdn}:8200"
}

output "MySQL_Server_FQDN" {
    value = "${azurerm_mysql_server.mysql.fqdn}"
}

output "_Instructions" {
   value = <<SHELLCOMMANDS

 # Connect to your Linux Virtual Machine
 #
 # Run the command below to SSH into your server. You can also use PuTTY or any
 # other SSH client. Your password is: ${var.admin_password}
 
 ssh ${var.admin_username}@${azurerm_public_ip.vault-pip.fqdn}
 SHELLCOMMANDS
}

