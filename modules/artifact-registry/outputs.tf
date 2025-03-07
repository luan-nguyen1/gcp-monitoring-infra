output "repository_id" {
  description = "The ID of the artifact registry repository"
  value       = google_artifact_registry_repository.monitoring_repo.id
}

output "repo_name" {
  description = "The name of the artifact registry repository"
  value       = google_artifact_registry_repository.monitoring_repo.repository_id
}
