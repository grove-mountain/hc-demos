service {
  id   = "parrots"
  name = "parrots"
  port = 8300
  connect { sidecar_service { } }
  checks  = [
    {
        id       = "tcp-8300",
        name     = "TCP on port 8300",
        tcp      = "localhost:8300",
        interval = "10s",
        timeout  = "1s"
    }
  ]
}
