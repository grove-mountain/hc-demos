#!/bin/sh
# Configures the Vault server for a database secrets demo

# cd /tmp
sudo apt-get -y update > /dev/null 2>&1
sudo apt install -y unzip jq cowsay mysql-client > /dev/null 2>&1
wget https://releases.hashicorp.com/vault/1.0.1/vault_1.0.1_linux_amd64.zip
sudo unzip vault_1.0.1_linux_amd64.zip -d /usr/local/bin/

# Set Vault up as a systemd service
echo "Installing systemd service for Vault..."
sudo bash -c "cat >/etc/systemd/system/vault.service" << EOF
[Unit]
Description=Hashicorp Vault
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/local/bin/vault server -dev -dev-root-token-id=${VAULT_TOKEN} -dev-listen-address=0.0.0.0:8200
Restart=on-failure # or always, on-abort, etc

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl start vault

echo "Setting up environment variables..."
echo "export VAULT_ADDR=http://localhost:8200" >> $HOME/.bashrc
echo "export VAULT_TOKEN=${VAULT_TOKEN}" >> $HOME/.bashrc
echo "export AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}" >> $HOME/.bashrc
echo "export AZURE_RESOURCE_GROUP=${AZURE_RESOURCE_GROUP}" >> $HOME/.bashrc
echo "export AZURE_TENANT_ID=${AZURE_TENANT_ID}" >> $HOME/.bashrc
echo "export AZURE_APPLICATION_ID=${AZURE_APPLICATION_ID}" >> $HOME/.bashrc
echo "export AZURE_SP_PASSWORD=${AZURE_SP_PASSWORD}" >> $HOME/.bashrc
echo "export MYSQL_HOST=${MYSQL_HOST}" >> $HOME/.bashrc
echo "export MYSQL_HOST_FULL=${MYSQL_HOST}.mysql.database.azure.com" >> $HOME/.bashrc
echo "export MYSQL_DATABASE=${MYSQL_DATABASE}" >> $HOME/.bashrc
echo "export MYSQL_VAULT_USER=${MYSQL_VAULT_USER}" >> $HOME/.bashrc
echo "export MYSQL_VAULT_PASSWORD=${MYSQL_VAULT_PASSWORD}" >> $HOME/.bashrc

echo "Vault installation complete."

echo "Installing code repo for demo"
git clone https://github.com/grove-mountain/hc-demos.git
export MYSQL_HOST_FULL=${MYSQL_HOST}.mysql.database.azure.com

mysql -h ${MYSQL_HOST_FULL} -D ${MYSQL_DATABASE} -u ${MYSQL_VAULT_USER}@${MYSQL_HOST} --password=${MYSQL_VAULT_PASSWORD} < hc-demos/vault/azure_secret_sprawl_webinar/terraform/files/create_beer_table.sql
