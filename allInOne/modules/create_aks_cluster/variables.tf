
variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 4
}

variable "cluster_name" {
  default = "NimbusK8s"
}

variable "dns_prefix" {
  default = "nimbusdns"
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
