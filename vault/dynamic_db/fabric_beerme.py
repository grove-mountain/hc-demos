from fabric.api import task
from fabric.colors import red,green,yellow
import requests
import psycopg2
import os
import json
import psycopg2
import os.path


VAULT_ADDR=os.environ['VAULT_ADDR']
VAULT_TOKEN=os.environ['VAULT_TOKEN']
DB_HOST=os.environ['DB_HOST']
DB_PORT=os.environ['DB_PORT']
DB_ROLE=os.environ['DB_ROLE']

def get_db_creds(role):
    path="v1/database/creds/{}".format(role)
    secret_obj = get_secret(path)
    username=secret_obj['data']['username']
    password=secret_obj['data']['password']
    return username,password


def get_secret(path, vault_addr=VAULT_ADDR, vault_token=VAULT_TOKEN):
    # Return the JSON object as a dictionary
    url="{}/{}".format(VAULT_ADDR, path)
    headers={"X-Vault-Token" : VAULT_TOKEN }
    response = requests.get(url, headers=headers)
    return response.json()


def query_postgres(host, user, password,
                   port=5432, dbname=None, query="select current_user"):
    """Login and perform a query against a postgres database
    host   : FQDN or IP Address of database endpoint
    user   : Postgresql
    port   : PSQL Port to connect to.  Default 5432"""
    conn = psycopg2.connect(host=host,
                            port=port,
                            user=user,
                            password=password,
                            dbname=dbname)
    cursor=conn.cursor()
    cursor.execute(query)
    records = cursor.fetchall()
    return records

@task
def get_beer(host=DB_HOST, port=DB_PORT, dbname='vices', vault_role="full-read"):
    """Does a query against the beer table and displays some delicious beer
    facts
    """
    username,password=get_db_creds(vault_role)
    query="select * from beer"
    records = query_postgres(host=host,
                             port=port,
                             user=username,
                             password=password,
                             dbname=dbname,
                             query=query)
    print("User: "+yellow("{}".format(username))+" Password: {}".format(red("{}".format(password))))
    header = ("Brewery","Beer","Style","SRM (Color)","IBUs","ABV%")
    line_tmpl="{:<20} {:<30} {:<20} {:<12} {:<4} {:<5}"
    print(green(line_tmpl.format(*header)))
    for record in records:
        print(line_tmpl.format(*record))
