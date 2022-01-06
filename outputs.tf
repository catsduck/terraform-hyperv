output "name-and-ip-address" {
  value       = flatten([for x in module.instance : values(x)])
  description = "The name and IP address of the VM"
}