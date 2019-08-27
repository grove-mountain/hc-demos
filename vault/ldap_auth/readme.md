# Vault LDAP Auth

This demo is for showing off how to configure and use LDAP auth for Vault.

## Prerequisites

- Docker
- Script to launch Docker-based LDAP Server merged into this repo
- merged `ldiff` directory and `env.sh` (renamed to `denv.sh` here)
  - Used original version before LDAP organization renamed to OurCorp
  - [grove-mountain/docker-ldap-server](https://github.com/grove-mountain/docker-ldap-server/tree/d2fd4e77048a55e8ccafc17d6464b453c9fb563e)

## Launch LDAP Server

- run `0_launch_ldap.sh` to launch ldap container
- run demos
- run `docker stop openldap` when finished to stop ldap container
