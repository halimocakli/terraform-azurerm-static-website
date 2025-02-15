# Create Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Create Azure Storage account
resource "azurerm_storage_account" "storage_account" {
  name                = "${var.storage_account_name}${random_string.myRandom.id}"
  resource_group_name = azurerm_resource_group.resource_group.name

  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind

  static_website {
    index_document     = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
}

resource "azurerm_storage_blob" "storage_blob_index" {
  name                   = var.storage_blob_index_document_name
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = var.storage_blob_container_name_index
  type                   = var.storage_blob_type_index
  content_type           = var.storage_blob_content_type_index
  source                 = var.storage_blob_index_document_source
}

resource "azurerm_storage_blob" "storage_blob_error" {
  name                   = var.storage_blob_error_document_name
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = var.storage_blob_container_name_error
  type                   = var.storage_blob_type_error
  content_type           = var.storage_blob_content_type_error
  source                 = var.storage_blob_error_document_source
}
