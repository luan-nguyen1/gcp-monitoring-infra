variable "instance_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "zone" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_user" {
  type = string
}

variable "ssh_pub_key" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "service_account_scopes" {
  type = list(string)
}

variable "docker_image" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}