provider "azurerm" {
    version = "2.5.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tf-rg-blobstore"
        storage_account_name = "tfstorageaccountlh"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfluhuang"
  location = "East US 2"
}

resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapi"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "public"
  dns_name_label = "essappeu"
  os_type = "Linux"

  container {
      name            = "weatherapi"
      image           = "lhuang1962/weatherapi"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}