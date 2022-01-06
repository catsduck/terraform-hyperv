locals {
  base_vhds = {
    ubuntu = "D:\\packer\\output-ubuntu\\Virtual Hard Disks\\ubuntu-build.vhdx"
  }
  instances = {
    "test1" = {
      source_vhd = local.base_vhds.ubuntu
      mem_max    = 1073741824
      proc_count = 4
    }
    "test2" = {
      source_vhd = local.base_vhds.ubuntu
      mem_max    = 2147483648
      proc_count = 2
    }
  }
}