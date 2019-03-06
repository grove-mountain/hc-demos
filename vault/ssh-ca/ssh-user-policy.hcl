path "sys/mounts" {
  capabilities = ["list","read"]
}
path "ssh-client-signer/sign/clientrole" {
  capabilities = ["create", "update"]
} 
