locals {
  containers = flatten([
    for sc_key, sc in try(var.storage.blob_properties.containers, {}) : {

      sc_key                = sc_key
      name                  = try(sc.name, join("-", [var.naming.storage_container, sc_key]))
      container_access_type = try(sc.access_type, "private")
      storage_account_name  = azurerm_storage_account.sa.name
      metadata              = try(sc.metadata, {})
    }
  ])
}

locals {
  shares = flatten([
    for fs_key, fs in try(var.storage.share_properties.shares, {}) : {

      fs_key               = fs_key
      name                 = try(fs.name, join("-", [var.naming.storage_share, fs_key]))
      quota                = fs.quota
      storage_account_name = azurerm_storage_account.sa.name
      metadata             = try(fs.metadata, {})
      access_tier          = try(fs.access_tier, "Hot")
      enabled_protocol     = try(fs.protocol, "SMB")
    }
  ])
}

locals {
  queues = flatten([
    for sq_key, sq in try(var.storage.queue_properties.queues, {}) : {

      sq_key               = sq_key
      name                 = try(sq.name, join("-", [var.naming.storage_queue, sq_key]))
      storage_account_name = azurerm_storage_account.sa.name
      metadata             = try(sq.metadata, {})
    }
  ])
}

locals {
  tables = flatten([
    for st_key, st in try(var.storage.tables, {}) : {

      st_key               = st_key
      name                 = try(st.name, join("-", [var.naming.storage_table, st_key]))
      storage_account_name = azurerm_storage_account.sa.name
    }
  ])
}
