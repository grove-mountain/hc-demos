provider "google" {
  # This is janky, was having some issues getting my credentials via environment variables
  credentials = "${var.gcp_credentials}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}

resource "google_container_cluster" "k8s" {
  name                    = "${var.cluster_name}"
  description             = "GKE Cluster ${var.cluster_name}"
  zone                    = "${var.gcp_zone}" 
  project                 = "${var.gcp_project}"
  enable_kubernetes_alpha = "true"
  enable_legacy_abac      = "true"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  zone       = "${var.gcp_zone}"
  cluster    = "${google_container_cluster.k8s.name}"
  node_count = "${var.node_pool_count}"

  node_config {
    preemptible  = true
    machine_type = "${var.node_machine_type}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
