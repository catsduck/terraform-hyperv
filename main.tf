module "instance" {
  source        = "./instance"
  name_in       = "testnode"
  source_vhd_in = local.base_vhds.ubuntu
  mem_max_in    = 1073741824
  proc_count_in = 4
}