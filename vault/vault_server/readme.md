# Local Vault Server for demos

Most demos are driven by the need to show off certain secret engines or auth methods.   A local Vault server is more than adequate to show off these features.


These are some simple scripts and aliases used for launching a local vault dev server.   This helps you quickly create a local dev server in no matter what network environment you launch this server into with predictable root passwords and doesn't require unsealing the Vault.

Another benefit is that you won't be burning money running cloud resources which may largely be unneccessary for your demos.   


## Install

 * Copy the appropriate vault_env for your OS to your home directory ~/.vault_env
 * Add the aliases into your .bashrc

e.g.

```
cp vault_env_$(uname)  ~/.vault_env
cat bashrc_vault_entry.sh >> ~/.bashrc
```

## Use

Start dev server:
```
vault_dev
```

Setup environment for other windows.  Run this in any other window you're going to run vault commands in or interact with the Vault environment:
```
vault_env
```

