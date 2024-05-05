output "hostname" {
  description = "The default API Gateway host name of the form {gatewayId}-{hash}.{region_code}.gateway.dev."
  value = google_api_gateway_gateway.api_gw.default_hostname
}