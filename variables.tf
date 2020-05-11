
variable "environment" {}

variable "environment_id" {}

variable "parent_service_short" {}

variable "project_short" {}

variable "project_id" {}

variable "management_plane_id" {}

variable "azure_location" {}

variable "azure_subscription_id" {}

variable "azure_tenant_id" {}

variable "azure_client_id" {}

#variable "azure_client_secret" {}

variable "azure_client_object_id" {}

variable "cloud_environment" {}

variable "secrets_key_vault_id" {}

variable "azure_key_vault_name" {}

variable "key_vault_log_retention_days" {
  type = number
}

variable "project_prefix" {}
variable "project_tag_component" {}
variable "project_shortname" {}


variable "tags_value_default" {}


variable "azure_client_secret" {}



