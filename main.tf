module "instance" {
  source        = "./instance"
  for_each      = local.instances
  name_in       = each.key
  source_vhd_in = each.value.source_vhd
  mem_max_in    = each.value.mem_max
  proc_count_in = each.value.proc_count
}