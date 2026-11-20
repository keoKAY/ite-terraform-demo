output "vm_details" {
  value = {
    for name, vm in google_compute_instance.vms :
    name => {
      id         = vm.id
      name       = vm.name
      private_ip = vm.network_interface[0].network_ip
      public_ip  = vm.network_interface[0].access_config[0].nat_ip
      machine    = vm.machine_type
    }
  }
}