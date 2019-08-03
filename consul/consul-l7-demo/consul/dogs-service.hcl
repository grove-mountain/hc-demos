service {
  name = "dogs"
  port = 8100
  connect { sidecar_service { } }
  checks  = [
    {
        id       = "tcp-8100",
        name     = "TCP on port 8100",
        tcp      = "localhost:8100",
        interval = "10s",
        timeout  = "1s"
    }
  ]
}
