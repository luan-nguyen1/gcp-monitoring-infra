variable "region" {
  description = "The GCP region to create the artifact registry in"
  type        = string
}

variable "repository_id" {
  description = "The name of the artifact registry repository"
  type        = string
}

variable "format" {
  description = "The format of the repository (DOCKER, NPM, etc.)"
  type        = string
  default     = "DOCKER"
}

variable "description" {
  description = "A brief description of the repository"
  type        = string
  default     = "Docker repository for monitoring service"
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}