terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "tf_rg" {
  name     = "tf_rg"
  location = "east us"
  tags = {
    environment = "dev"
    source      = "terraform"
  }
}

resource "azurerm_virtual_network" "tf_vnet" {
  name                = "tf_vnet"
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.tf_rg.name
  tags = {
    environment = "dev"
    source      = "terraform"
  }
}

resource "azurerm_subnet" "tf_subnet" {
  name                 = "tf_subnet"
  resource_group_name  = azurerm_resource_group.tf_rg.name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "tf_public_ip" {
  name                = "tf_public_ip"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.tf_rg.name
  allocation_method   = "Dynamic"
  tags = {
    environment = "dev"
    source      = "terraform"
  }
}

resource "azurerm_network_security_group" "tf_network_sec_grp" {
  name                = "tf_network_sec_grp"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.tf_rg.name
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "dev"
    source      = "terraform"
  }
}

# Create network interface
resource "azurerm_network_interface" "tf_nic" {
  name                = "tf_nic"
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name

  ip_configuration {
    name                          = "tf_nic_configuration"
    subnet_id                     = azurerm_subnet.tf_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "tf_sec_grp_assoc" {
  network_interface_id      = azurerm_network_interface.tf_nic.id
  network_security_group_id = azurerm_network_security_group.tf_network_sec_grp.id
}

# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.tf_rg.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "tf_storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = azurerm_resource_group.tf_rg.location
  resource_group_name      = azurerm_resource_group.tf_rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create (and display) an SSH key
resource "tls_private_key" "tf_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "terraform_vm" {
  name                  = "TF_VM"
  location              = azurerm_resource_group.tf_rg.location
  resource_group_name   = azurerm_resource_group.tf_rg.name
  network_interface_ids = [azurerm_network_interface.tf_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.tf_ssh_key.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.tf_storage_account.primary_blob_endpoint
  }
}



