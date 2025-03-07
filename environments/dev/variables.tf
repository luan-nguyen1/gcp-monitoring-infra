variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "europe-central2"
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "Domain name for monitoring services"
  type        = string
  default     = "monitoring.example.com"
}

variable "ssh_user" {
  description = "SSH username for VM access"
  type        = string
  default     = "luan"
}

variable "ssh_pub_key" {
  description = "SSH public key for accessing VM"
  type        = string
}
