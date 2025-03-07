output "grafana_ip" {
  description = "Public IP or hostname of the Grafana service"
  value       = module.monitoring.grafana_ip
}