output "instance_id" {
  description = "The ID of the compute instance"
  value       = google_compute_instance.vm.id
}

output "instance_self_link" {
  description = "The self-link of the compute instance"
  value       = google_compute_instance.vm.self_link
}

output "instance_external_ip" {
  description = "The external IP address of the compute instance"
  value       = google_compute_instance.vm.network_interface.0.access_config.0.nat_ip
}

output "instance_internal_ip" {
  description = "The internal IP address of the compute instance"
  value       = google_compute_instance.vm.network_interface.0.network_ip
}
