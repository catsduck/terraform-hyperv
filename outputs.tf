output "name-and-ip-address" {
  value       = [for x in module.instance : x]
  description = "The name and IP address of the VM"
}