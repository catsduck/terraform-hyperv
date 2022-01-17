resource "hyperv_vhd" "vhd" {
  path   = "${local.vhd_path}\\${var.name_in}.vhdx"
  source = lookup(local.base_vhds, var.distro_in, "ubuntu")
}

resource "hyperv_machine_instance" "hyperv_instance" {
  name                   = var.name_in
  automatic_start_action = "Start"
  automatic_start_delay  = 15
  automatic_stop_action  = "ShutDown"
  checkpoint_type        = "Disabled"
  memory_maximum_bytes   = var.mem_max_in
  processor_count        = var.proc_count_in
  dynamic_memory         = true

  hard_disk_drives {
    controller_number   = 0
    controller_location = 0
    path                = resource.hyperv_vhd.vhd.path
  }

  network_adaptors {
    name        = "eth0"
    iov_weight  = 0
    switch_name = data.hyperv_network_switch.external_network_switch.name
  }

  vm_firmware {
    enable_secure_boot   = "On"
    secure_boot_template = "MicrosoftUEFICertificateAuthority"
  }

  # provider isn't setting any of these values on VM creation
  # and tries to change to null on future plan/applies
  vm_processor {
    compatibility_for_migration_enabled               = false
    compatibility_for_older_operating_systems_enabled = false
    hw_thread_count_per_core                          = 0
    maximum                                           = 100
    reserve                                           = 0
    relative_weight                                   = 100
    maximum_count_per_numa_node                       = 24
    maximum_count_per_numa_socket                     = 1
    enable_host_resource_protection                   = false
    expose_virtualization_extensions                  = false
  }

  connection {
    type = "ssh"
    user = "ansible"
    private_key = "${file(var.ssh_key_path)}"
    host = self.network_adaptors[0].ip_addresses[0]
  }
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${var.name_in}",
      "sudo dhclient -r",
      "sudo dhclient"
    ]
  }
}
