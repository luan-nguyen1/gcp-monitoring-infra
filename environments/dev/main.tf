locals {
  docker_image = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.monitoring_repo.repository_id}/monitoring-service:latest"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# ✅ First, Create the Service Account
resource "google_service_account" "vm_sa" {
  account_id   = "monitoring-vm-sa"
  display_name = "Monitoring VM Service Account"
}

# ✅ Then, Assign IAM Roles to the Service Account
resource "google_project_iam_member" "artifact_registry_access" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

resource "google_project_iam_member" "storage_access" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

resource "google_project_iam_member" "compute_viewer" {
  project = var.project_id
  role    = "roles/compute.viewer"
  member  = "user:luandeveloper1@gmail.com"
}

resource "google_project_iam_member" "firewall_viewer" {
  project = var.project_id
  role    = "roles/compute.securityAdmin"
  member  = "user:luandeveloper1@gmail.com"
}

resource "google_project_iam_member" "editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = "user:luandeveloper1@gmail.com"
}

# ✅ Define the Artifact Registry Repo
resource "google_artifact_registry_repository" "monitoring_repo" {
  location       = "europe-central2"
  repository_id  = "monitoring-repo"
  format         = "DOCKER"
  description    = "Docker repository for monitoring service"
}

# ✅ Create the VPC Network
module "network" {
  source = "../../modules/network"

  vpc_name    = "dev-vpc"
  subnet_name = "dev-subnet"
  subnet_cidr = "10.0.0.0/24"
  region      = var.region
}

# ✅ Deploy the VM & Attach the Service Account
module "monitoring_vm" {
  source                 = "../../modules/compute"
  instance_name          = "monitoring-server"
  machine_type           = "e2-small"
  zone                   = "${var.region}-a"
  subnet_id              = module.network.subnet_id
  ssh_user               = var.ssh_user
  ssh_pub_key_path       = var.ssh_pub_key_path
  service_account_email  = google_service_account.vm_sa.email 
  service_account_scopes = ["cloud-platform"]

  startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
    gcloud auth configure-docker ${var.region}-docker.pkg.dev
    docker pull ${local.docker_image}
    docker run -d -p 80:8080 --name monitoring-service ${local.docker_image}
  EOF

  tags = ["monitoring", "http-server"]
}

resource "google_container_cluster" "primary" {
  name                     = "dev-monitoring-cluster"
  location                 = "europe-central2-a"  # ⬅️ Change from region to specific ZONE

  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  node_config {
    machine_type  = "e2-small"
    disk_size_gb  = 50  # ⬅️ Safe within quota
    oauth_scopes  = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}



resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = "europe-central2-a"
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 50  # total 100 GB, very safe
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
