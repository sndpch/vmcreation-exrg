# refer to a resource group
data "azurerm_resource_group" "sandy_rg" {
  name = var.resource_group_name
}

#refer to a subnet
data "azurerm_subnet" "sandy_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}
/*
# Create public IPs
resource "azurerm_public_ip" "test" {
    name                         = "myPublicIP-test"
    location                     = "${data.azurerm_resource_group.test.location}"
    resource_group_name          = "${data.azurerm_resource_group.test.name}"
    public_ip_address_allocation = "dynamic"

}
*/
# Create Network Interface
resource "azurerm_network_interface" "sandyvmnic" {
  name                = "sandy-vmnic"
  location            = "${data.azurerm_resource_group.sandy_rg.location}"
  resource_group_name = "${data.azurerm_resource_group.sandy_rg.name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${data.azurerm_subnet.sandy_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  #  public_ip_address_id = azurerm_public_ip.mypublicip.id 
  }
}

# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "sandylinuxvm" {
    admin_username = "azureuser"
    admin_password = "Password@12345"
    disable_password_authentication = false
    location = "${data.azurerm_resource_group.sandy_rg.location}"
    name = "sandylinuxvm-1"
    computer_name = "sandylinuxvm-1" # Hostname for the VM
    network_interface_ids = [ azurerm_network_interface.sandyvmnic.id ]
    resource_group_name = "${data.azurerm_resource_group.sandy_rg.name}"
    size = "Standard_D2s_v3"
    os_disk {
        name = "osdisk"
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
    }
    
}


/*
resource "azurerm_virtual_machine_extension" "sandytest" {
  name                 = "hostname"
  location             = "${data.azurerm_resource_group.sandy_rg.location}"
  resource_group_name  = "${data.azurerm_resource_group.sandy_rg.name}"
  virtual_machine_name = "${azurerm_virtual_machine.sandylinuxvm.name}"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${filebase64("${path.module}/qualys_script.sh")}"
    }
SETTINGS
}
*/
