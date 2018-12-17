storage "inmem" {}

listener "tcp" {
  address = "172.20.10.8:8200"
  tls_disable = "true"
}
ui=true
