module "instance" {
  source        = "./instance"
  for_each      = local.instances
  name_in       = each.key
  distro_in     = each.value.distro
  mem_max_in    = each.value.mem_max
  proc_count_in = each.value.proc_count
  ssh_key_path  = var.ssh_key_path
}
