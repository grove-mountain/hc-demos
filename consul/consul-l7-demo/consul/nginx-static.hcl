service {
  id      = "nginx-static"
  name    = "nginx-static"
  port    = 8400
  connect = { sidecar_service { } }
  checks  = [ 
    {
        id       = "tcp-8400",
        name     = "TCP on port 8400",
        tcp      = "localhost:8400",
        interval = "10s",
        timeout  = "1s"
    }
  ]
}
