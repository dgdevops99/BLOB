## Azure Blob Storage Deployment using Terraform

This Terraform configuration provisions Azure resources in the following order:

1. **Resource Group**
2. **Storage Account** (defined elsewhere in the configuration)
3. **Storage Container**
4. **Storage Blob**

### Resource Details

* **Resource Group**

  * Creates a resource group named `blob_main_rg` in the `Central India` region.

* **Storage Container**

  * Creates a container named `blobmaincontainer` inside the storage account.
  * Uses `depends_on` to ensure the container is created **after the storage account**.

* **Storage Blob**

  * Uploads a file as a blob named `blobmainblob` inside the container.
  * Uses `depends_on` to ensure the blob is created **after the container**.

### depends_on Usage

`depends_on` is a Terraform meta-argument used to control the order of resource creation.
Without it, Terraform may attempt to create resources simultaneously, which can cause errors if dependent resources (like the storage account or container) are not yet created.

### Blob Source File

The `source` argument specifies the file to upload to the blob.

Terraform supports:

* **Relative path**

  ```
  /../Codes/STORAGE_ACCOUNT/variable.tf
  ```
* **Absolute path**

  ```
  C:/Codes/STORAGE_ACCOUNT/variable.tf
  ```

By default, Terraform looks for the file in the same directory as `main.tf`.
If the file is located elsewhere, a relative or absolute path must be provided.

Terraform uploads the specified file to the storage container and creates the blob accordingly.

* **Notes**
1. I have skipped the provider in the configuration file, the provider can be used in seperate files as **provider.tf**  and the required details can be added there. 
2. The relative/absolute paths I have used above is of my laptop where the files are present, you can use yours instead.