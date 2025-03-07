# environments/dev/main.tf
provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  docker_image = "${var.region}-docker.pkg.dev/${var.project_id}/${module.artifact_registry.repo_name}/monitoring-service:latest"
}

module "artifact_registry" {
  source        = "../../modules/artifact-registry"
  region        = var.region
  repository_id = "monitoring-repo"
  format        = "DOCKER"
  description   = "Docker repository for monitoring service"
  project_id    = var.project_id
}

module "iam" {
  source     = "../../modules/iam"
  project_id = var.project_id
}

module "network" {
  source      = "../../modules/network"
  vpc_name    = "dev-vpc"
  subnet_name = "dev-subnet"
  subnet_cidr = "10.0.0.0/24"
  region      = var.region
}

module "compute" {
  source                = "../../modules/compute"
  instance_name         = "monitoring-server"
  machine_type          = "e2-small"
  zone                  = "${var.region}-a"
  subnet_id             = module.network.subnet_id
  ssh_user              = var.ssh_user
  ssh_pub_key           = var.ssh_pub_key
  service_account_email = module.iam.vm_sa_email
  service_account_scopes = ["cloud-platform"]
  docker_image          = local.docker_image
  project_id            = var.project_id
  tags                  = ["monitoring", "http-server"]
}

module "gke" {
  source       = "../../modules/gke"
  region       = var.region
  cluster_name = "dev-monitoring-cluster"
  project_id   = var.project_id
}

module "monitoring" {
  source                  = "../../modules/monitoring"
  grafana_admin_password  = var.grafana_admin_password
  domain_name             = var.domain_name
  gke_cluster_endpoint    = module.gke.endpoint
  gke_ca_certificate      = module.gke.ca_certificate
  region                  = var.region
  project_id              = var.project_id
}