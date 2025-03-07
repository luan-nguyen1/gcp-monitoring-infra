resource "google_artifact_registry_repository" "monitoring_repo" {
  provider      = google
  location      = "eu-central2"
  repository_id = "monitoring-repo"
  format        = "DOCKER"
  description   = "Docker repository for monitoring service"
}
