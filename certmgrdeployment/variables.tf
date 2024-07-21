variable "helm_release_name" {
  description = "Release name (Name used when creating the helm chart)"
  type        = string
  default     = "cert-manager"
}

variable "helm_repository_url" {
  description = "Repository URL to locate the requested chart"
  type        = string
  default     = "https://charts.jetstack.io"
}

variable "helm_chart_name" {
  description = "Chart name to be installed (Name of the chart to source/install)"
  type        = string
  default     = "cert-manager"
}

variable "namespace" {
  description = "Namespace to install the release into"
  type        = string
  default     = "cert-mgr"
}

variable "replica_count" {
  description = "Number of replica pods to create"
  type        = number
  default     = 1
}

variable "kubectl_config_context_name" {
  description = "The config context to use when authenticating to the Kubernetes cluster. If empty, defaults to the current context specified in the kubeconfig file."
  type        = string
  default     = "DevTestK8s"
  # Change to your AKS cluster name / "docker-desktop" 
}

variable "kubectl_config_path" {
  description = "The path to the config file to use for kubectl. If empty, defaults to $HOME/.kube/config"
  type        = string
  default     = "c:\\users\\mukund.vaidya\\.kube\\config"
}

variable "labels" {
  description = "Map of string key value pairs that can be used to organize and categorize the namespace and roles. See the Kubernetes Reference for more info (https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)."
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Map of string key default pairs that can be used to store arbitrary metadata on the namespace and roles. See the Kubernetes Reference for more info (https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)."
  type        = map(string)
  default     = {
           release-namespace = "cert-mgr" 
           release-name ="cert-manager"
           managed-by = "Helm"
     }
}
