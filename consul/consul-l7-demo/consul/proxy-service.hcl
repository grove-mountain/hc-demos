service {
  name = "http-proxy"
  port = 8000
  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "dog-pics"
            local_bind_port = 21100
          },
	  {
            destination_name = "cat-pics"
            local_bind_port = 21200
          },
	  {
            destination_name = "parrot-pics"
            local_bind_port = 21200
          }
        ]
      }
    }
  }
}
