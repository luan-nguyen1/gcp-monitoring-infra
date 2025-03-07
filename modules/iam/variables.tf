variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "vm_service_account_name" {
  description = "Service account name for the monitoring VM"
  type        = string
  default     = "monitoring-vm-sa"
}

variable "vm_service_account_display_name" {
  description = "Display name for the VM service account"
  type        = string
  default     = "Monitoring VM Service Account"
}

variable "iam_roles" {
  description = "List of IAM roles to assign to the service account"
  type        = list(object({
    role   = string
    member = string
  }))
  default = [
    { role = "roles/artifactregistry.reader", member = "serviceAccount:monitoring-vm-sa" },
    { role = "roles/storage.objectViewer", member = "serviceAccount:monitoring-vm-sa" },
    { role = "roles/compute.viewer", member = "user:luandeveloper1@gmail.com" },
    { role = "roles/compute.securityAdmin", member = "user:luandeveloper1@gmail.com" },
    { role = "roles/editor", member = "user:luandeveloper1@gmail.com" }
  ]
}
