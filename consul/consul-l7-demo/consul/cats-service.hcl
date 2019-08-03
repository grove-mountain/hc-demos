service {
  name = "cats"
  port = 8200
  connect { sidecar_service { } }
  checks  = [
    {
        id       = "tcp-8200",
        name     = "TCP on port 8200",
        tcp      = "localhost:8200",
        interval = "10s",
        timeout  = "1s"
    }
  ]
}
