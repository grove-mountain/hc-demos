# Vault Dynamic DB Demo

This demo shows some of the features of using Vault as a Dynamic DB Credentials generator as well as some other Enterprise features like namespaces.   You will need enterprise binaries to demo Namespaces.

This runs a local copy of Postgres and PGAdmin for the database and a GUI to show user accounts being created more easily.  You can always just use basic SQL to show the user accounts if desired.   


## Prerequisites

  * Vault OSS or Enterprise installed locally and in your $PATH
  * Docker 
  * Python libraries: Fabric, requests, psycopg2: (will likely move these into a container in the future, so you don't have to install them locally)


## Usage

Run the numbered scripts in order.  These use demo-magic, so when you'll need to hit return after each command.
