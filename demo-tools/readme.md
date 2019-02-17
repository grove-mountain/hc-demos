# Demo Tools

Helper scripts and tools for running demos.

## Demo Magic

This is a minor fork of: https://github.com/paxtonhare/demo-magic

The updates add in things like colors and preventing the script from failing if some of the prerequisites like pv aren't installed.   Since when I'm running demos I don't really care if someone thinks I'm actually typing, I normally turn that feature off.   

Typically inside an env.sh file for any demo I'll put the following:

```
export PATH=${PATH}:../../demo-tools

# This is for the time to wait when using demo_magic.sh
if [[ -z ${DEMO_WAIT} ]];then
  DEMO_WAIT=0
fi

# Demo magic gives wrappers for running commands in demo mode.   Also good for learning via CLI.

. demo-magic.sh -d -p -w ${DEMO_WAIT}
```


The two major functions are:
 * pe -- Print/Execute
 * p -- Print

Three minor functions for coloring are here for flavoring any informational echos you may want to put in.  Great for video demos for conferences when you can't hear the talk track:
 * green
 * red
 * yellow

### Usage
```
pe "vault secrets enable database"
```

Because this murders large blocks of text with line feeds, it's often helpful to just print out the commands in format and then run them "behind the scenes" using the 'p' command as the pause gate:

```
cat << EOF
vault write database/config/vices
    plugin_name=postgresql-database-plugin
    allowed_roles=full-read
    connection_url="postgresql://{{username}}:{{password}}@${DB_HOST}:${DB_PORT}/vices?sslmode=disable"
    username="${VAULT_ADMIN_USER}"
    password="${VAULT_ADMIN_PW}"
EOF
p ""

vault write database/config/vices \
    plugin_name=postgresql-database-plugin \
    allowed_roles=full-read \
    connection_url="postgresql://{{username}}:{{password}}@${DB_HOST}:${DB_PORT}/vices?sslmode=disable" \
    username="${VAULT_ADMIN_USER}" \
    password="${VAULT_ADMIN_PW}"
```

Print green text
```
green "This is green text"
```

Print red text
```
red "This is red text"
```

