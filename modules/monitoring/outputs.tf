# modules/monitoring/outputs.tf
output "grafana_ip" {
  description = "Hostname of the Grafana service"
  value       = "grafana.${var.domain_name}"  # Static hostname from Ingress
}