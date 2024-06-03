# Provider Configuration
provider "aws" {
  #This will fetch AWS acces keys and secrate key from AWS profile that is genrated in ".aws" directory when we configure our aws-cli.
  profile = var.aws_profile
  region  = var.aws_region
}

#Helm to install grafana 
provider "helm" {
  kubernetes {
    host                   = module.EKS.cluster_endpoint
    cluster_ca_certificate = module.EKS.cluster_ca_certificate

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.EKS.cluster_name]
      command     = "aws"
    }
  }
} 

# Kubernetes provider configuration using EKS
provider "kubernetes" {
  host                   = module.EKS.cluster_endpoint
  cluster_ca_certificate = module.EKS.cluster_ca_certificate

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.EKS.cluster_name]
    command     = "aws"
  }
}
