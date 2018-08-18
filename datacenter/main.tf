variable "datacenter_name" {
  default = "Datacenter"
}

variable "datastore_name" {
  default = "datastore1"
}

variable "cluster_name" {
  default = "Cluster"
}

variable "network_name" {
  default = "VM Network"
}

data "vsphere_datacenter" "main" {
  name = "${var.datacenter_name}"
}

data "vsphere_datastore" "main" {
  name          = "${var.datastore_name}"
  datacenter_id = "${data.vsphere_datacenter.main.id}"
}

data "vsphere_compute_cluster" "main" {
  name          = "${var.cluster_name}"
  datacenter_id = "${data.vsphere_datacenter.main.id}"
}

data "vsphere_network" "main" {
  name          = "${var.network_name}"
  datacenter_id = "${data.vsphere_datacenter.main.id}"
}

output "datacenter_id" {
  value = "${data.vsphere_datacenter.main.id}"
}

output "cluster_resource_id" {
  value = "${data.vsphere_compute_cluster.main.resource_pool_id}"
}

output "datastore_id" {
  value = "${data.vsphere_datastore.main.id}"
}

output "network_id" {
  value = "${data.vsphere_network.main.id}"
}
