# In Memory Consul Backed Vault

This set of scripts allows you to very quickly create a local Vault server backed by an in-memory Consul server.   The intent is more to allow for a more enterprise-y architecture on a local machine.  This is not intended to be run in production.

Running this tool will automatically initialize and unseal vault and set the root token.   

This assumes you have Vault and Consul binaries somewhere in your ${PATH}.   Getting those there is up to you.   

## Steps

It's best to do this in separate windows as Vault will be running in the foreground

1. Start Consul Vault with start_vault.sh in one window
2. In another window, source the init_vault.sh (DO NOT RUN, Sourcing allows you to both run the commands and export the environment)

Window 1
```
./start_vault.sh
```

Window 2
```
. init_vault.sh
```
