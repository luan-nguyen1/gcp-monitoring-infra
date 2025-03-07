resource "google_service_account" "vm_sa" {
  account_id   = "monitoring-vm-sa"
  display_name = "Monitoring VM Service Account"
}

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

output "vm_sa_email" {
  value = google_service_account.vm_sa.email
}