output "name-and-ip-address" {
  value       = join(" ", [hyperv_machine_instance.hyperv_instance.name, hyperv_machine_instance.hyperv_instance.network_adaptors[0].ip_addresses[0]])
  description = "The name and IP address of the VM"
}