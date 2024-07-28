variable "resource_group_location" {
  type        = string
  default     = "Central India"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = "test-kubernetes-rg"
  description = "Resource group name that is unique in your Azure subscription."
}
