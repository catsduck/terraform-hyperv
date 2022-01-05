variable "ubuntu_packer_path" {}

variable "hyperv_host" {}

variable "hyperv_user" {
  sensitive = true
}

variable "hyperv_password" {
  sensitive = true
}
