#Resource Group Name
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "rg-InT-Tmgmt"
}

#Resource Group Location
variable "resource_group_location" {
  description = "Resource Group Location"
  type = string
  default = "westeurope"
}

#Virtual Network Name
variable "virtual_network_name" {
  description = "Virtual Network Name"
  type = string
  default = "vnet-InT-Tmgmt2"
}

#Subnet Name
variable "subnet_name" {
  description = "Subnet Name"
  type = string
  default = "Subnet-InT-TestVMs-new"
}

