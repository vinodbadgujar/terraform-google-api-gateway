resource "google_api_gateway_api" "api_gw" {
  
  provider          = google-beta
  api_id            = var.api_id
  display_name      = var.api_display_name
  labels            = var.labels
  project           = var.project
  managed_service   = var.api_managed_service

}

resource "google_api_gateway_api_config" "api_gw" {

    provider              = google-beta
    api                   = google_api_gateway_api.api_gw.api_id
    display_name          = var.config_display_name
    labels                = var.labels
    api_config_id         = var.api_config_id 
    project               = var.project
    api_config_id_prefix  = var.api_config_id_prefix

    dynamic "gateway_config" {
      for_each = var.gateway_config
      content {
        backend_config {
          google_service_account = gateway_config.backend_config.google_service_account  
        } 
      }
    }

    dynamic "openapi_documents" {
      for_each = var.openapi_documents
      content {
        document {
          path      = openapi_documents.document.open_api_document_path
          contents  = base64encode(openapi_documents.document.open_api_document_path)
        }
      }
    }

    dynamic "grpc_services" {
      for_each = var.grpc_services
      content {
        file_descriptor_set {
          path      = grpc_services.file_descriptor_set.path
          contents  = grpc_services.file_descriptor_set.contents
        }
        dynamic "source" {
          for_each = grpc_services.source
          content {
            path      = source.path
            contents  = source.contents
          }
        }
      }
    }

    dynamic "managed_service_configs" {
      for_each = var.managed_service_configs

      content {
        path      = managed_service_configs.path
        contents  = managed_service_configs.contents
      }
    }

    lifecycle {
      create_before_destroy = true
    }
  
}

resource "google_api_gateway_gateway" "api_gw" {
  
  provider      = google-beta
  api_config    = google_api_gateway_api_config.api_gw.id
  gateway_id    = var.gateway_id
  display_name  = var.gateway_display_name
  project       = var.project
  region        = var.region
  labels        = var.labels
}