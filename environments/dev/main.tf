# environments/dev/main.tf
provider "google" {
  project = var.project_id
  region  = var.region
}

module "apis" {
  source     = "../../modules/apis"
  project_id = var.project_id
}

# Enable required APIs
resource "google_project_service" "cloud_resource_manager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  project = var.project_id
  service = "container.googleapis.com"
}

resource "google_project_service" "artifact_registry" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "service_usage" {
  project = var.project_id
  service = "serviceusage.googleapis.com"
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