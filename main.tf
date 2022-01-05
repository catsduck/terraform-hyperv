resource "hyperv_vhd" "node-1-vhd" {
  path   = "E:\\hyperv\\node-1.vhdx"
  source = var.ubuntu_packer_path
}

resource "hyperv_machine_instance" "node-1" {
  name                   = "node-1"
  automatic_start_action = "Start"
  automatic_start_delay  = 15
  automatic_stop_action  = "ShutDown"
  checkpoint_type        = "Disabled"
  memory_maximum_bytes   = 17179869184 #16GB
  memory_startup_bytes   = 1073741824  #1GB
  processor_count        = 4
  dynamic_memory         = true

  hard_disk_drives {
    controller_number   = 0
    controller_location = 0
    path                = resource.hyperv_vhd.node-1-vhd.path
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
}

output "name-and-ip-address" {
  value       = join(" ", [hyperv_machine_instance.node-1.name, hyperv_machine_instance.node-1.network_adaptors[0].ip_addresses[0]])
  description = "The name and IP address of the VM"
}