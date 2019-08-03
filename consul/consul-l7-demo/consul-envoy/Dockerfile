FROM envoyproxy/envoy-alpine:v1.11.0

FROM consul-dev:latest
COPY --from=0 /usr/local/bin/envoy /usr/local/bin/envoy
COPY ./wait_for_consul.sh /wait_for_consul.sh
RUN chmod +x /wait_for_consul.sh
