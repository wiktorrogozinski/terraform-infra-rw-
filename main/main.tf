terraform {

  backend "azurerm" {
    subscription_id      = "38207137-94d1-401e-932e-a4f45f771f1c"
    resource_group_name  = "wiktor-terra-playground"
    storage_account_name = "terraformstatestoragerw"
    container_name       = "states"
    key                  = "testapp/dev/dev.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.50.0"
    }
  }
  required_version = ">= 1.4.2"
}


provider "azurerm" {
  features {}
}


module "resource_group" {
  source = "../modules/azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
  env                 = var.env
}

module "azure-container-registry" {
  source = "../modules/azure-container-registry"

  acr_name            = "${var.acr_config.acr_name}${var.env}"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  depends_on = [module.resource_group]
}

module "azure-container-instance" {
  source = "../modules/azure-container-instances"

  name                = var.aci_config.aci_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  os_type             = var.aci_config.os_type
  ip_address_type     = var.aci_config.ip_address.type
  dns_name_label      = var.aci_config.ip_address.dns_name_label
  image               = var.aci_config.image
  port                = var.aci_config.ports[0].port
  protocol            = var.aci_config.ports[0].protocol

}
