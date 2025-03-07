output "vpc_name" {
  description = "Name of the VPC network"
  value       = module.network.vpc_name
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = module.network.subnet_name
}

output "monitoring_vm_ip" {
  description = "Public IP of the monitoring VM"
  value       = module.monitoring_vm.instance_ip
}
