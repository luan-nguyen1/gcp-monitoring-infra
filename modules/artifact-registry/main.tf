resource "google_artifact_registry_repository" "monitoring_repo" {
  location      = var.region
  repository_id = var.repository_id
  format        = var.format
  description   = var.description
}
