variable "name" {
  default = "templates/ubuntu-16.04"
}

variable "datacenter_id" {}

data "vsphere_virtual_machine" "main" {
  name          = "${var.name}"
  datacenter_id = "${var.datacenter_id}"
}

output "id" {
  value = "${data.vsphere_virtual_machine.main.id}"
}

output "disk_size" {
  value = "${data.vsphere_virtual_machine.main.disks.0.size}"
}

output "eagerly_scrub" {
  value = "${data.vsphere_virtual_machine.main.disks.0.eagerly_scrub}"
}

output "thin_provisioned" {
  value = "${data.vsphere_virtual_machine.main.disks.0.thin_provisioned}"
}
