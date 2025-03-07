variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "eu-central2"
}

variable "ssh_user" {
  description = "SSH username"
  type        = string
  default     = "admin"
}

variable "ssh_pub_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "docker_image" {
  description = "Docker image for the monitoring service"
  type        = string
  default     = ""
}
