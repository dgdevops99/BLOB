resource "azurerm_resource_group" "rg-blob" {
  name     = "blob_main_rg"
  location = "central india"
}

# Here we will be using depends_on to create the resources in order as we have to create storage account first then container and then blob. if we do not use depends_on then terraform will try to create all the resources at the same time and it will give error because storage account is not created yet.
# depends_on is a meta-argument that can be used to specify that the creation of a resource depends on the creation of another resource. This is useful when you have resources that need to be created in a specific order.
resource "azurerm_storage_container" "container" {
  depends_on = [ azurerm_storage_account.storage ]
  name                  = "blobmaincontainer"
  storage_account_id  = azurerm_storage_account.storage.id
  container_access_type = "private"
}
resource "azurerm_storage_blob" "blob" {
  depends_on = [ azurerm_storage_container.container ]
  name                   = "blobmainblob"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source = "/../Codes/STORAGE_ACCOUNT/variable.tf"
  #relative path = "/../Codes/STORAGE_ACCOUNT/variable.tf"
  #absolute path = "C:/Codes/STORAGE_ACCOUNT/variable.tf"
  # By default, terraform will look for the file in the same directory where the main.tf file is located. if the file is located in a different directory then we can use relative path or absolute path to specify the location of the file.
  # when we specify the source of the blob, terraform will upload the file to the storage account and create a blob with the same name as the file as the name of the blob. if we want to specify a different name for the blob then we can use the name argument to specify the name of the blob.
  # we can also use url of the file if it is hosted on github or any other platform.
  }

