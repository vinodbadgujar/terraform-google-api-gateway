# GCP API Gateway Terraform module

----------

This module creates a API gateway using google-beta provider templates specified in  [Terraform registry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources)

----------

## Usage

Basic usage of this module is as follows:

```hcl
module "api-gateway" {
  source  = "github.com/vinodbadgujar/terraform-google-api-gateway"
  
  project = "<project_id>"
    labels = {
        "key1" : "value1",
        "key2" : "value2",
    }
    api_id = "<api_id>"

    gateway_config = [
        {
            backend_config = {
                google_service_account = "<service_account>"
            }
        }
    ]

    openapi_documents = [
        {
            document = {
                open_api_document_path = "<path of openapi.yaml>"
            }
        }
    ]

    gateway_id = "<gateway_id>"
    region = "<region>"

}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | (Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| labels | (Optional) Resource labels to represent user-provided metadata. (key-value pairs). | `map(string)` | `{}` | no |
| api_id | (Required) Identifier to assign to the API. Must be unique within scope of the parent resource(project) | `string` | `NA` | yes |
| api_display_name | (Optional) A user-visible name for the API. | `string` | `null` | no |
| api_managed_service | (Optional) Immutable. The name of a Google Managed Service ( https://cloud.google.com/service-infrastructure/docs/glossary#managed). If not specified, a new Service will automatically be created in the same project as this API. | `string` | `null` | no |
| config_display_name | (Optional) A user-visible name for the API config. | `string` | `null` | no |
| api_config_id | (Optional) Identifier to assign to the API Config. Must be unique within scope of the parent resource(api). | `string` | `null` | no |
| api_config_id_prefix | (Optional) Creates a unique name beginning with the specified prefix. If this and api_config_id are unspecified, a random value is chosen for the name. | `string` | `null` | no |
| gateway_config | (Optional) Immutable. Gateway specific configuration. If not specified, backend authentication will be set to use OIDC authentication using the default compute service account | <pre>type = list(<br>  object(<br>    {<br>      backend_config = object(<br>        {<br>          google_service_account = string<br>        }<br>      )<br>    }<br>  )<br>) | `[]` | no |
| openapi_documents | (Optional) OpenAPI specification documents. If specified, grpcServices and managedServiceConfigs must not be included. | <pre>type = list(<br>  object(<br>    {<br>      document = object(<br>        {<br>          open_api_document_path  = string<br>        }<br>      )<br>    }<br>  )<br>) | `[]` | no |
| grpc_services | (Optional) gRPC service definition files. If specified, openapiDocuments must not be included. | <pre>type = list(<br>  object(<br>    {<br>      file_descriptor_set = object(<br>        {<br>          path      = string,<br>          contents  = string<br>        }<br>      ),<br>      source = object(<br>        {<br>          path      = string,<br>          contents  = string<br>        }<br>      )<br>    }<br>  )<br>) | `[]` | no |
| managed_service_configs | (Optional) Optional. Service Configuration files. At least one must be included when using gRPC service definitions. See https://cloud.google.com/endpoints/docs/grpc/grpc-service-config#service_configuration_overview for the expected file contents. If multiple files are specified, the files are merged with the following rules: * All singular scalar fields are merged using 'last one wins' semantics in the order of the files uploaded. * Repeated fields are concatenated. * Singular embedded messages are merged using these rules for nested fields. | <pre>type = list(<br>  object(<br>    {<br>      path      = string<br>      contents  = string<br>    }<br>  )<br>) | `[]` | no |
| gateway_id | (Required) Identifier to assign to the Gateway. Must be unique within scope of the parent resource(project). | `string` | `NA` | yes |
| gateway_display_name | (Optional) A user-visible name for the API gateway. | `string` | `null` | no |
| region | (Optional) The region of the gateway for the API. | `string` | `null` | no |

----------

## Outputs

| Name | Description |
|------|-------------|
| hostname | The default API Gateway host name of the form {gatewayId}-{hash}.{region_code}.gateway.dev.|
----------


