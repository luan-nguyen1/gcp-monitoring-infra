# modules/monitoring/variables.tf
variable "grafana_admin_password" {
  type        = string
  description = "Admin password for Grafana"
  sensitive   = true
}

variable "domain_name" {
  type        = string
  description = "Domain name for Grafana ingress"
}

variable "gke_cluster_endpoint" {
  type        = string
  description = "GKE cluster endpoint"
}

variable "gke_ca_certificate" {
  type        = string
  description = "GKE cluster CA certificate"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}