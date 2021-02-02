variable "aws_region" {
  description = "The preferred AWS Region into which to launch the resources outlined in this template."
  default     = "us-east-1"
}

/* variable "key_name" {} */

/* variable "cluster_name" {
  description = "EKS cluster name."
  default     = "eks_basic_demo"
} */

variable "k8s_secret_for_s1_github" {
  description = "This is the NAME of the K8s secret that stores your GitHub token (that is used to authenticate to the S1 GitHub packages repository (where the s1-agent and s1-helper Docker images are stored.))"
  # ie: You need to get your gihub token via your account team (as of March 6th 2020)
}

/* variable "service_account_name" {
  description = "Service Account Name to use"
  default     = "sentinelone"
} */

variable "s1_helper_image_repository" {
  description = "The image/package repository where the s1_helper image is located."
  default     = "docker.pkg.github.com/s1-agents/cwpp_agent/s1helper"
}

variable "s1_helper_image_tag" {
  description = "Tag name (version) of the s1_helper image we want to use"
  default     = "ea-4.1.1"
}

variable "s1_agent_image_repository" {
  description = "The image/package repository where the s1_agent image is located."
  default     = "docker.pkg.github.com/s1-agents/cwpp_agent/s1agent"
}

variable "s1_agent_image_tag" {
  description = "Tag name (version) of the s1_agent image we want to use"
  default     = "ea-4.1.1"
}

variable "s1_site_key" {
  description = "The Sentinel One Site Key that the CWPP agent will use when communicating with the S1 portal."
}

variable "s1_namespace" {
  description = "K8s namespace into which we will place the S1 cwpp agent(s)"
  default     = "s1"
}

variable "registry_server" {
  description = "Base Repo that houses S1 container images"
  default     = "docker.pkg.github.com"
}

variable "registry_username" {
  description = "Need more info as to why this is necessary.  It seems to be the username you use for Git when accessing GitHub." # ToDo:  Investigate why/if this is needed.
}

variable "registry_password" {
  description = "GitHub access token to access the GitHub package/image repository (where the s1-agent and s1-helper images live)."
}

variable "helm_release_name" {
  description = "Helm Releaes Name to use for the Helm deployment"
  default     = "s1"
}