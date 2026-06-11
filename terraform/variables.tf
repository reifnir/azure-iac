variable "location" {
  description = "The default Azure Region"
  default     = "East US"
}

variable "azure_subscription" {
  description = "Azure Subscription GUID where all resources will reside"
}

variable "gitlab_group_id" {
  description = "Group ID that GitLab variables will be saved to"
}
