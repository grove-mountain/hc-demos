consu config write proxy-defaults.hcl

docker run -it --rm --entrypoint=/bin/ash --name=envoy envoyproxy/envoy-alpine:v1.10.0
docker run --rm --name envoy-proxy grovemountain/consul-envoy:1.6.0-beta3-v1.11.0 connect envoy --sidecar-for http-proxy

DOGS_VERSION=1
CATS_VERSION=1
PARROTS_VERSION=1
docker run --rm --name dog-pics -e NAME=dogs -e VERSION=${DOGS_VERSION} -p 8100:8080 -d grovemountain/picture-service

docker run --rm --name cat-pics -e NAME=cats -e VERSION=${CATS_VERSION} -p 8200:8080 -d grovemountain/picture-service

docker run --rm --name parrot-pics -e NAME=parrots -e VERSION=${PARROTS_VERSION} -p 8300:8080 -d grovemountain/picture-service

STATIC_HTML_PORT=8123
docker run --rm --name nginx -v ${PWD}/assets/static:/usr/share/nginx/html:ro -p ${STATIC_HTML_PORT}:80 -d nginx

# 
consul-template -consul-addr=http://127.0.0.1:8500 -template="assets/consul-template/index.tpl:assets/static/index.html"

consul-template -vault-renew-token=false -consul-addr=http://127.0.0.1:8500 \
  -template="templates/consul-template/holy_grail.json.tpl:static/holy_grail.json" \
  -template="templates/consul-template/holy_grail.html.tpl:static/holy_grail.html"


  #-e CONSUL_BIND_INTERFACE=eth0  \
  #-e CONSUL_CLIENT_INTERFACE=eth0  \

docker run -d \
  --net=host \
  --name=consul1 \
  -e CONSUL_BIND_INTERFACE=eth0  \
  -e CONSUL_CLIENT_INTERFACE=eth0  \
  -v ${PWD}/consul/conf.d:/consul/config \
  grovemountain/consul-envoy \
    agent \
    -config-file=/consul/config/server.hcl \
    -config-dir=/consul/config

docker run -d \
  --name=consul2 \
  -v ${PWD}/consul/conf.d:/consul/config \
  -e CONSUL_BIND_INTERFACE=eth0  \
  -e CONSUL_CLIENT_INTERFACE=eth0  \
  consul \
    agent \
    -server \
    -dev \
    -ui \
    -datacenter=diaspar \
    -retry-join=172.17.0.8 \
    -node=alvin

docker run -d \
  --name=consul3 \
  -v ${PWD}/consul/conf.d:/consul/config \
  -e CONSUL_BIND_INTERFACE=eth0  \
  -e CONSUL_CLIENT_INTERFACE=eth0  \
  consul \
    agent \
    -server \
    -dev \
    -ui \
    -datacenter=diaspar \
    -retry-join=172.17.0.8 \
    -node=sally
