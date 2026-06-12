variable "location" {
  description = "The default Azure Region"
  type        = string
  nullable    = false
}

variable "azure_subscription" {
  description = "Azure Subscription GUID where all resources will reside"
  type        = string
  nullable    = false
}

variable "gitlab_group_id" {
  description = "Group ID that GitLab variables will be saved to"
  type        = string
  nullable    = false
}

variable "gitlab_token" {
  description = "GitLab API token for authentication"
  type        = string
  nullable    = false
}
