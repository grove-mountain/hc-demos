output "get_creds" {
  value = <<EOL
  To retrieve credentials to use for this cluster enter the following on your CLI.   This assumes you have gcloud tool install locally:

  gcloud container clusters get-credentials ${var.cluster_name} --zone ${var.gcp_zone} --project ${var.gcp_project}
  EOL
}
