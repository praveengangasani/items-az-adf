terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "item_rg" {
  name     = "item-rg"
  location = "East US 2"
}

resource "azurerm_data_factory" "item_eus_adf" {
  name                = "item-eus-adf"
  location            = azurerm_resource_group.item_rg.location
  resource_group_name = azurerm_resource_group.item_rg.name
}

resource "azurerm_storage_account" "commoneusadls" {
  name                     = "commoneusadls"
  location                 = azurerm_resource_group.item_rg.location
  resource_group_name      = azurerm_resource_group.item_rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "items" {
  name                  = "items"
  storage_account_name  = azurerm_storage_account.commoneusadls.name
  container_access_type = "private"
}
