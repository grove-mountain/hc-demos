<!doctype html>
<html lang="en">

<head>
  <style>
    
  </style>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

  <title>HashiCorp Demo Framework</title>
  <div class="container">
    <div class="row mb-5 justify-content-md-center">
      <div class="col-sm my-auto">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <a class="navbar-brand" href="#">HashiCorp Consul Demo</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                <a class="nav-link" href="#">Consul Template<span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">Layer 4 Intentions</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">Layer 7 Routing</a>
              </li>
            </ul>
          </div>
        </nav>
      </div>
    </div>
    <div class="row my-5">
      <div class="col-sm-4 mx-auto my-auto">
      <p>Stop! Who would cross the Bridge of Death must answer me these questions three, ere the other side he see.</p>
      </div>
      <div class="col-sm mx-auto my-auto">
        <table class="table">
          <thead>
            <tr>
              <th scope="col">Bridgekeeper</th>
              <th scope="col">Knight</th>
            </tr>
          </thead>
          <tbody>
          {{ with $i := key "demo/consul-template/questions" | parseJSON }}
            <tr>
              <th scope="row">{{ $i.question1 }}</th>
              <td>{{ $i.answer1 }}</td>
            </tr>
            <tr>
              <th scope="row">{{ $i.question2 }}</th>
              <td>{{ $i.answer2 }}</td>
            </tr>
            <tr>
              <th scope="row">{{ $i.question3 }}</th>
              <td>{{ $i.answer3 }}</td>
            </tr>
          {{ end }}
          </tbody>
        </table>
      </div>
    </div>
  </div>
</head>

<body>

  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
    integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
    integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
    integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
    crossorigin="anonymous"></script>
</body>

</html>
