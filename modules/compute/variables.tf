variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = "e2-micro"
}

variable "zone" {
  description = "Zone for the VM"
  type        = string
}

variable "image" {
  description = "Boot disk image"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "subnet_id" {
  description = "Subnet ID for the VM"
  type        = string
}

variable "ssh_user" {
  description = "SSH username"
  type        = string
  default     = "admin"
}

variable "ssh_pub_key" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "startup_script" {
  description = "Startup script for the VM"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Network tags for the VM"
  type        = list(string)
  default     = []
}

variable "service_account_email" {
  description = "Email of the service account to attach to the VM"
  type        = string
}

variable "service_account_scopes" {
  description = "Scopes for the attached service account"
  type        = list(string)
  default     = ["cloud-platform"]
}
