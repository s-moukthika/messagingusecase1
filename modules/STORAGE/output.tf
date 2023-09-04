output "server_id" {
description = "id of your server"
value = azurerm_mssql_server.mssqlserver.id
}
output "account_id" {
    description = "id of your storage account"
    value = azurerm_storage_account.storageaccount.id
}


