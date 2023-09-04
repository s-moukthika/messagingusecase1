terraform {

  required_providers {

    azurerm = {

      source = "hashicorp/azurerm"

      version = "3.64.0"

    }

  }

}



provider "azurerm" {

 features{}

 client_id = var.secret1_value

 client_secret = var.secret2_value

 tenant_id = var.secret3_value

 subscription_id = var.secret4_value

}
module "RG" {

    source = "./modules/RG"

    resource_group_name = var.resource_group_name

    resource_group_location = var.resource_group_location

}

module "NETWORKING" {
    source = "./modules/NETWORKING"
    
    
    resource_group_location            = var.resource_group_location
    resource_group_name                = var.resource_group_name

    virtual_network_name                = var.virtual_network_name
    
    virtual_network_address_space       = var.virtual_network_address_space

    subnet_name                         = var.subnet_name
    subnet_address_prefixes             = var.subnet_address_prefixes
    service_endpoints                   = var.service_endpoints
    
    network_security_group_name                = var.network_security_group_name

    
    network_security_rule_name                        = var.network_security_rule_name
    network_security_rule_priority                    = var.network_security_rule_priority
    network_security_rule_direction                   = var.network_security_rule_direction
    network_security_rule_access                      = var.network_security_rule_access
    network_security_rule_protocol                    = var.network_security_rule_protocol
    network_security_rule_source_port_range           = var.network_security_rule_source_port_range
    network_security_rule_destination_port_range      = var.network_security_rule_destination_port_range
    network_security_rule_source_address_prefix       = var.network_security_rule_source_address_prefix
    network_security_rule_destination_address_prefix  = var.network_security_rule_destination_address_prefix

  
}

module "STORAGE" {
  source = "./modules/STORAGE" 

  storage_account_name                     = var.storage_account_name
  resource_group_name                      = var.resource_group_name
  storage_account_location                 = var.resource_group_location
  storage_account_tier                     = var.storage_account_tier
  storage_account_replication_type         = var.storage_account_replication_type
  resource_group_location                  = var.resource_group_location

  storage_queue_name                        = var.storage_queue_name

  mssql_server_name                         = var.mssql_server_name
  mssql_server_location                     = var.mssql_server_location
  mssql_server_version                      = var.mssql_server_version
  secret5_value                             = var.secret5_value
  secret6_value                             = var.secret6_value

  mssql_database_name                       = var.mssql_database_name
  mssql_database_collation                  = var.mssql_database_collation
  mssql_database_license_type               = var.mssql_database_license_type
  mssql_database_max_size_gb                = var.mssql_database_max_size_gb
  mssql_database_sku_name                   = var.mssql_database_sku_name
  mssql_database_zone_redundant             = var.mssql_database_zone_redundant
}

module "MESSAGING" {
  source = "./modules/MESSAGING"

  eventgrid_topic_name                      = var.eventgrid_topic_name
  eventgrid_location                        = var.resource_group_location
  resource_group_name                       = var.resource_group_name
  resource_group_location                   = var.resource_group_location

  event_subscription_name                   = var.event_subscription_name
  rg_id                                     = module.RG.rg_id
  account_id                                = module.STORAGE.account_id
  storage_queue_name                        = var.storage_queue_name
  

 servicebus_namespace_name                 = var.servicebus_namespace_name
 servicebus_namespace_location             = var.resource_group_location
 servicebus_namespace_sku                  = var.servicebus_namespace_sku
 
 servicebus_queue_name                     = var.servicebus_queue_name
 servicebus_queue_enable_partitioning      = var.servicebus_queue_enable_partitioning
}


module "COMPUTE" {
  source = "./modules/COMPUTE"

  logic_app_workflow_name                = var.logic_app_workflow_name
  logic_app_workflow_location            = var.resource_group_location
  resource_group_name                    = var.resource_group_name
  resource_group_location                = var.resource_group_location
}

module "SECURITYSERVICES" {
  source = "./modules/SECURITYSERVICES" 

   public_ip_name                         = var.public_ip_name
   public_ip_location                     = var.resource_group_location
   public_ip_allocation_method            = var.public_ip_allocation_method
   public_ip_sku                          = var.public_ip_sku
   resource_group_name                    = var.resource_group_name
   resource_group_location                = var.resource_group_location
   virtual_network_name                   = var.virtual_network_name

   firewall_name                          = var.firewall_name
   firewall_location                      = var.resource_group_location
   firewall_sku_name                      = var.firewall_sku_name
   firewall_sku_tier                      = var.firewall_sku_tier
   ip_configuration_name                  = var.ip_configuration_name

   azurefirewallsubnet_name                = var.azurefirewallsubnet_name
   
   azurefirewallsubnet_address_prefixes    = var.azurefirewallsubnet_address_prefixes
   


   firewall_policy_name                                  = var.firewall_policy_name
   firewall_policy_rule_collection_group_name            = var.firewall_policy_rule_collection_group_name
   firewall_policy_rule_collection_group_priority        = var.firewall_policy_rule_collection_group_priority

   app_rule_collection_name                              = var.app_rule_collection_name
   app_rule_collection_priority                          = var.app_rule_collection_priority
   app_rule_collection_action                            = var.app_rule_collection_action
   app_rule_collection_rule1                             = var.app_rule_collection_rule1
   app_rule_collection_rule1_protocol1                   = var.app_rule_collection_rule1_protocol1
   app_rule_collection_rule1_port1                       = var.app_rule_collection_rule1_port1
   app_rule_collection_rule1_protocol2                   = var.app_rule_collection_rule1_protocol2
   app_rule_collection_rule1_port2                       = var.app_rule_collection_rule1_port2
   app_rule_collection_source_addresses                  = var.app_rule_collection_source_addresses
   app_rule_collection_destination_fqdns                 = var.app_rule_collection_destination_fqdns




    network_rule_collection_name                         = var.network_rule_collection_name
    network_rule_collection_priority                     = var.network_rule_collection_priority
    network_rule_collection_action                       = var.network_rule_collection_action
    
    network_rule_collection_rule1_name                   = var.network_rule_collection_rule1_name
    network_rule_collection_rule1_protocols              = var.network_rule_collection_rule1_protocols
    network_rule_collection_rule1_source_addresses       = var.network_rule_collection_rule1_source_addresses
    network_rule_collection_rule1_destination_addresses  = var.network_rule_collection_rule1_destination_addresses
    network_rule_collection_rule1_destination_ports      = var.network_rule_collection_rule1_destination_ports


    nat_rule_collection_rule_name                        = var.nat_rule_collection_rule_name
    nat_rule_collection_rule_priority                    = var.nat_rule_collection_rule_priority
    nat_rule_collection_rule_action                      = var.nat_rule_collection_rule_action

    nat_rule_collection_rule1_name                       = var.nat_rule_collection_rule1_name
    nat_rule_collection_rule1_protocols                  = var.nat_rule_collection_rule1_protocols
    nat_rule_collection_rule1_source_addresses           = var.nat_rule_collection_rule1_source_addresses
    nat_rule_collection_rule1_destination_address        = var.nat_rule_collection_rule1_destination_address
    nat_rule_collection_rule1_destination_ports          = var.nat_rule_collection_rule1_destination_ports
    nat_rule_collection_rule1_translated_address         = var.nat_rule_collection_rule1_translated_address
    nat_rule_collection_rule1_translated_port            = var.nat_rule_collection_rule1_translated_port
   

   key_vault_name                                        = var.key_vault_name
   soft_delete_retention_days                            = var.soft_delete_retention_days
   purge_protection_enabled                              = var.purge_protection_enabled
   sku_name                                              = var.sku_name
   key_permissions                                       = var.key_permissions
   secret_permissions                                    = var.secret_permissions
   storage_permissions                                   = var.storage_permissions
   secret1_name                                          = var.secret1_name
   secret1_value                                         = var.secret1_value
   secret2_name                                          = var.secret2_name
   secret2_value                                         = var.secret2_value
   secret3_name                                          = var.secret3_name
   secret3_value                                         = var.secret3_value
   secret4_name                                          = var.secret4_name
   secret4_value                                         = var.secret4_value
   object_id                                             = var.object_id
   secret5_name                                          = var.secret5_name
   secret5_value                                         = var.secret5_value
   secret6_name                                          = var.secret6_name
   secret6_value                                         = var.secret6_value


 }





module "ManagementGroup" {
  source = "./modules/ManagementGroup" 

     display_name = var.display_name

}








   





