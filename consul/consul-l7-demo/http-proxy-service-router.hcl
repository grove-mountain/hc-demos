kind = "service-router"
name = "http-proxy"
routes = [
  {
    match {
      http {
        path_prefix = "/dogs"
      }
    }
    destination {
      service = "dogs"
    }
  },
#  {
#    match {
#      http {
#        path_prefix = "/cats"
#      }
#    }
#    destination {
#      service = "cats"
#    }
#  },
#  {
#    match {
#      http {
#        path_prefix = "/parrots"
#      }
#    }
#    destination {
#      service = "parrots"
#    }
#  }
]
