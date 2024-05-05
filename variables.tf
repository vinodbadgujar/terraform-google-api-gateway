# generic variables

variable "project" {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type    = string
  default = null
}

variable "labels" {
  description = "(Optional) Resource labels to represent user-provided metadata. (key-value pairs)."
  type    = map(string)
  default = {}
}

# google_api_gateway_api variables

variable "api_id" {
  description = "(Required) Identifier to assign to the API. Must be unique within scope of the parent resource(project)"
  type      = string
  nullable  = false
}

variable "api_display_name" {
  description = "(Optional) A user-visible name for the API."
  type    = string
  default = null
}

variable "api_managed_service" {
  description = "(Optional) Immutable. The name of a Google Managed Service ( https://cloud.google.com/service-infrastructure/docs/glossary#managed). If not specified, a new Service will automatically be created in the same project as this API."
  type    = string
  default = null
}

# google_api_gateway_api_config variables

variable "config_display_name" {
  description = "(Optional) A user-visible name for the API config."
  type    = string
  default = null
}

variable "api_config_id" {
  description = "(Optional) Identifier to assign to the API Config. Must be unique within scope of the parent resource(api)."
  type    = string
  default = null
}

variable "api_config_id_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. If this and api_config_id are unspecified, a random value is chosen for the name."
  type    = string
  default = null
}

variable "gateway_config" {
  description = "(Optional) Immutable. Gateway specific configuration. If not specified, backend authentication will be set to use OIDC authentication using the default compute service account"
  type = list(
    object(
      {
        backend_config = object(
          {
            google_service_account = string
          }
        )
      }
    )
  )
  default   = []
  sensitive = true
}

variable "openapi_documents" {
    description = "(Optional) OpenAPI specification documents. If specified, grpcServices and managedServiceConfigs must not be included."
    type = list(
      object(
        {
          document = object(
            {
              open_api_document_path  = string
            }
          )
        }
      )
    )
    default   = []
    sensitive = true
}

variable "grpc_services" {
  description = "(Optional) gRPC service definition files. If specified, openapiDocuments must not be included."
  type = list(
    object(
      {
        file_descriptor_set = object(
          {
            path      = string,
            contents  = string 
          }
        ),
        source = object(
          {
            path      = string,
            contents  = string
          }
        )
      }
    )
  )
  default = []
  sensitive = true
}

variable "managed_service_configs" {
  description = "(Optional) Optional. Service Configuration files. At least one must be included when using gRPC service definitions. See https://cloud.google.com/endpoints/docs/grpc/grpc-service-config#service_configuration_overview for the expected file contents. If multiple files are specified, the files are merged with the following rules: * All singular scalar fields are merged using 'last one wins' semantics in the order of the files uploaded. * Repeated fields are concatenated. * Singular embedded messages are merged using these rules for nested fields."
  type = list(
    object(
      {
        path      = string
        contents  = string
      }
    )
  )
  default = []
}

# google_api_gateway_gateway variables

variable "gateway_id" {
  description = "(Required) Identifier to assign to the Gateway. Must be unique within scope of the parent resource(project)."
  type = string
  nullable = false
}

variable "gateway_display_name" {
  description = "(Optional) A user-visible name for the API gateway."
  type = string
  default = null
}

variable "region" {
  description = "(Optional) The region of the gateway for the API."
  type = string
  default = null
}