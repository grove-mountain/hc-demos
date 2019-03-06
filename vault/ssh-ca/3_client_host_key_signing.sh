#!/usr/bin/env bash
. env.sh


pe "curl -s ${VAULT_ADDR}/v1/ssh-host-signer/public_key > ${HOME}/.ssh/host-signer-ca"

grep -q "$(cat ${HOME}/.ssh/host-signer-ca)" ${HOME}/.ssh/known_hosts

if [ $? -gt 0 ];then
  pe "echo \"@cert-authority *.hashidemos.com $(cat ${HOME}/.ssh/host-signer-ca)\" >> ${HOME}/.ssh/known_hosts"
else
  green "Host signing key already exists in known_hosts...skipping add"
fi

echo "To use the new cert you can use the following command"
echo "ssh vault.hashidemos.com"
