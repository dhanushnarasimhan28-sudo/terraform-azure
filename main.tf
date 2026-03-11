terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "centralindia"
}

module "network" {
  source = "./Modules/network"

  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "VM" {
  source = "./Modules/VM"

  vm_name = "windows-vm"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_username = var.admin_username
  admin_password = var.admin_password
  subnet_id = module.network.subnet_id
  
}