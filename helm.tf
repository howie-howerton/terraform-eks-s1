provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        data.aws_eks_cluster.cluster.name
      ]
    }
  }
}

resource "helm_release" "s1" {
  name             = var.helm_release_name
  chart            = "./cwpp_agent/helm_charts/sentinelone"
  namespace        = kubernetes_namespace.s1.id
  create_namespace = true
  set {
    name  = "image.imagePullSecrets[0].name"
    value = var.k8s_secret_for_s1_github
  }
  set {
    name  = "helper.image.repository"
    value = var.s1_helper_image_repository
  }
  set {
    name  = "helper.image.tag"
    value = var.s1_helper_image_tag
  }
  set {
    name  = "helper.env.cluster"
    value = local.cluster_name
  }
  set {
    name  = "agent.image.repository"
    value = var.s1_agent_image_repository
  }
  set {
    name  = "agent.image.tag"
    value = var.s1_agent_image_tag
  }
  set {
    name  = "agent.env.site_key"
    value = var.s1_site_key
  }
  depends_on = [kubernetes_secret.k8s_secret_for_s1_github]
}