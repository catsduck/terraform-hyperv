variable "hyperv_host" {}

variable "hyperv_user" {
  sensitive = true
}

variable "hyperv_password" {
  sensitive = true
}

variable "ssh_key_path" {
  sensitive = true
}
