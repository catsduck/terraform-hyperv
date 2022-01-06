locals {
  instances = {
    "test1" = {
      distro = "ubuntu"
      mem_max    = 1073741824
      proc_count = 4
    }
    "test2" = {
      distro = "ubuntu"
      mem_max    = 2147483648
      proc_count = 2
    }
  }
}