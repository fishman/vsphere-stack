variable "name" {}
variable "domain" {}
variable "host_name" {}

variable "num_cpus" {
  default = 1
}

variable "memory" {
  default = 1024
}

variable "guest_id" {
  default = "ubuntu64Guest"
}

variable "ipv4_gateway" {
  default = ""
}

variable "ipv4_address" {
  default = ""
}

variable "ipv4_netmask" {
  default = 24
}

variable "datacenter_id" {}
variable "cluster_resource_id" {}
variable "datastore_id" {}
variable "network_id" {}

variable "tags" {
  default = []
  type    = "list"
}

variable "disk_size" {
  default = 1
}

module "main_vm" {
  source        = "../vm_template"
  datacenter_id = "${var.datacenter_id}"
}

resource "vsphere_virtual_machine" "main" {
  name             = "${var.name}"
  resource_pool_id = "${var.cluster_resource_id}"
  datastore_id     = "${var.datastore_id}"

  num_cpus = "${var.num_cpus}"
  memory   = "${var.memory}"
  guest_id = "${var.guest_id}"

  tags = ["${var.tags}"]

  network_interface {
    network_id = "${var.network_id}"
  }

  disk {
    label            = "disk0"
    size             = "${module.main_vm.disk_size}"
    eagerly_scrub    = "${module.main_vm.eagerly_scrub}"
    thin_provisioned = "${module.main_vm.thin_provisioned}"
  }

  disk {
    label       = "disk1"
    size        = "${var.disk_size}"
    unit_number = 1
  }

  clone {
    template_uuid = "${module.main_vm.id}"

    customize {
      linux_options {
        host_name = "${var.host_name}"
        domain    = "${var.domain}"
      }

      network_interface {
        ipv4_address = "${var.ipv4_address}"
        ipv4_netmask = "${var.ipv4_netmask}"
      }

      ipv4_gateway = "${var.ipv4_gateway}"
    }
  }
}
