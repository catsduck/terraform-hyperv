terraform {
  required_providers {
    hyperv = {
      version = "1.0.3"
      source  = "registry.terraform.io/taliesins/hyperv"
    }
  }
}

provider "hyperv" {
  host     = var.hyperv_host
  user     = var.hyperv_user
  password = var.hyperv_password
}