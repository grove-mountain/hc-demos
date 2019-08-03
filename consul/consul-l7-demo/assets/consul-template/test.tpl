{{ range $k, $v := key "demo/consul-template/questions" | parseJSON }}
{{ $k }} : {{ $v }}
{{ end }}
