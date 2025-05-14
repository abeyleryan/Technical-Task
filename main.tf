# terraform {
#   required_providers {
#     vsphere = {
#       source  = "hashicorp/vsphere"
#       version = "~> 2.0"
#     }
#   }

#   required_version = ">= 1.3.0"
# }

# provider "vsphere" {
#   user           = var.vsphere_user
#   password       = var.vsphere_password
#   vsphere_server = var.vsphere_server

#   allow_unverified_ssl = true
# }

# data "vsphere_datacenter" "dc" {
#   name = var.datacenter
# }

# data "vsphere_datastore" "datastore" {
#   name          = var.datastore
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

# data "vsphere_compute_cluster" "cluster" {
#   name          = var.cluster
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

# data "vsphere_network" "network" {
#   name          = var.network
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

# data "vsphere_virtual_machine" "template" {
#   name          = var.template
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

# resource "vsphere_virtual_machine" "vm" {
#   name             = var.vm_name
#   resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
#   datastore_id     = data.vsphere_datastore.datastore.id

#   num_cpus = 2
#   memory   = 4096
#   guest_id = data.vsphere_virtual_machine.template.guest_id

#   network_interface {
#     network_id   = data.vsphere_network.network.id
#     adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
#   }

#   disk {
#     label            = "disk0"
#     size             = data.vsphere_virtual_machine.template.disks.0.size
#     eagerly_scrub    = false
#     thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
#   }

#   clone {
#     template_uuid = data.vsphere_virtual_machine.template.id
#   }

#   #customization {
#     windows_options {
#       computer_name  = var.vm_name
#       admin_password = var.vm_password
#     }

#     network_interface {
#       ipv4_address = var.vm_ip
#       ipv4_netmask = 24
#     }

#     ipv4_gateway = var.gateway
#   }
# }