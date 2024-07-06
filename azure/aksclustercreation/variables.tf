variable "resource_group_location" {
  type        = string
  default     = "Central India"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = "test-kubernetes-rg"
  description = "Resource group name that is unique in your Azure subscription."
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "cluster_name" {
  default = "Nimbusk8s"
}

variable "dns_prefix" {
  default = "Nimbusk8s"
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}
