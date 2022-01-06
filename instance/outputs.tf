output "name-and-ip-address" {
  value       = { for x in hyperv_machine_instance.hyperv_instance[*] : x.name => x.network_adaptors[0].ip_addresses[0] }
  description = "The name and IP address of the VM"
}