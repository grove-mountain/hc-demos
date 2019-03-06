variable "gcp_credentials" {
  description = "GCP credentials needed by google provider"
}

variable "gcp_project" {
  description = "GCP project name"
  default     = "jlundberg-demo"
}

variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default = "us-west1"
}

variable "gcp_zone" {
  description = "GCP zone, e.g. us-east1-a"
  default = "us-west1-b"
}

variable "cluster_name" {
  description = "Name for the cluster"
}

variable "node_pool_count" {
  description = "Number of node pool nodes"
  default     = 2
}

variable "node_machine_type" {
  description = "GCP machine type"
  default = "f1-micro"
}
