provider "vsphere" {
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

locals {
  domain = "mydomain.com"
}

module "default_dc" {
  source = "./datacenter"
}

module "ubuntu_16" {
  source        = "./vm_template"
  datacenter_id = "${module.default_dc.datacenter_id}"
}

resource "vsphere_tag_category" "category" {
  name        = "terraform-category"
  cardinality = "SINGLE"
  description = "Managed by Terraform"

  associable_types = [
    "VirtualMachine",
    "Datastore",
  ]
}

resource "vsphere_tag" "web" {
  name        = "web"
  category_id = "${vsphere_tag_category.category.id}"
  description = "Managed by Terraform"
}

module "kubemaster1" {
  source              = "./vm"
  name                = "terraform-kubemaster1"
  host_name           = "kubemaster1"
  domain              = "${local.domain}"
  datacenter_id       = "${module.default_dc.datacenter_id}"
  cluster_resource_id = "${module.default_dc.cluster_resource_id}"
  datastore_id        = "${module.default_dc.datastore_id}"
  network_id          = "${module.default_dc.network_id}"
  tags                = ["${vsphere_tag.web.id}"]
  ipv4_address        = "10.0.10.10"
  ipv4_gateway        = "10.0.10.1"
  disk_size           = 30
  num_cpus            = 4
  memory              = 8096
}

module "kubemaster2" {
  source              = "./vm"
  name                = "terraform-kubemaster2"
  host_name           = "kubemaster2"
  domain              = "${local.domain}"
  datacenter_id       = "${module.default_dc.datacenter_id}"
  cluster_resource_id = "${module.default_dc.cluster_resource_id}"
  datastore_id        = "${module.default_dc.datastore_id}"
  network_id          = "${module.default_dc.network_id}"
  tags                = ["${vsphere_tag.web.id}"]
  ipv4_address        = "10.0.10.11"
  ipv4_gateway        = "10.0.10.1"
  disk_size           = 30
  num_cpus            = 4
  memory              = 8096
}

module "kubenode3" {
  source              = "./vm"
  name                = "terraform-kubenode3"
  host_name           = "kubenode3"
  domain              = "${local.domain}"
  datacenter_id       = "${module.default_dc.datacenter_id}"
  cluster_resource_id = "${module.default_dc.cluster_resource_id}"
  datastore_id        = "${module.default_dc.datastore_id}"
  network_id          = "${module.default_dc.network_id}"
  tags                = ["${vsphere_tag.web.id}"]
  ipv4_address        = "10.0.10.12"
  ipv4_gateway        = "10.0.10.1"
  disk_size           = 30
  num_cpus            = 4
  memory              = 8096
}

module "kubenode4" {
  source              = "./vm"
  name                = "terraform-kubenode4"
  host_name           = "kubenode4"
  domain              = "${local.domain}"
  datacenter_id       = "${module.default_dc.datacenter_id}"
  cluster_resource_id = "${module.default_dc.cluster_resource_id}"
  datastore_id        = "${module.default_dc.datastore_id}"
  network_id          = "${module.default_dc.network_id}"
  tags                = ["${vsphere_tag.web.id}"]
  ipv4_address        = "10.0.10.13"
  ipv4_gateway        = "10.0.10.1"
  disk_size           = 30
  num_cpus            = 4
  memory              = 8096
}
