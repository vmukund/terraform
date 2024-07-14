variable "name" {
  description = "Name of the namespace to be created"
  type        = string
  default     = "application-ns"
}

variable "kubectl_config_context_name" {
  description = "The config context to use when authenticating to the Kubernetes cluster. If empty, defaults to the current context specified in the kubeconfig file."
  type        = string
  default     = "DevTestK8s"
}

variable "kubectl_config_path" {
  description = "The path to the config file to use for kubectl. If empty, defaults to $HOME/.kube/config"
  type        = string
  default     = "c:\\users\\mukund.vaidya\\.kube\\config"
}

variable "create_resources" {
  description = "Set to false to have this module skip creating resources."
  type        = bool
  default     = true
}

variable "labels" {
  description = "Map of string key value pairs that can be used to organize and categorize the namespace and roles. See the Kubernetes Reference for more info (https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)."
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Map of string key default pairs that can be used to store arbitrary metadata on the namespace and roles. See the Kubernetes Reference for more info (https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)."
  type        = map(string)
  default     = {}
}
