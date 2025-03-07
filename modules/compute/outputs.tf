output "instance_id" {
  description = "ID of the VM instance"
  value       = google_compute_instance.vm.id
}

output "instance_name" {
  description = "Name of the VM instance"
  value       = google_compute_instance.vm.name
}

output "instance_ip" {
  description = "Public IP of the VM instance"
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
