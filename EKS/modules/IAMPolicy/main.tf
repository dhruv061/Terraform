#----------------------------------EksClusterServiceRole------------------------------------#
#Create EKS Cluster Role
resource "aws_iam_role" "EksClusterServiceRole" {
  name = var.eks_cluster_role_name

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

#Attach AmazonEKSClusterPolicy to above created EKS Cluster Role
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = data.aws_iam_policy.AmazonEKSClusterPolicy.arn
  role       = aws_iam_role.EksClusterServiceRole.name
}

#----------------------------------AmazonEKSNodeRole------------------------------------#
#Create EKS Node Role
resource "aws_iam_role" "AmazonEKSNodeRole" {
  name = var.eks_node_group_name

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

#Attach diffrent Policies to above cretaed EKS Node Role
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = data.aws_iam_policy.AmazonEKSWorkerNodePolicy.arn
  role       = aws_iam_role.AmazonEKSNodeRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = data.aws_iam_policy.AmazonEKS_CNI_Policy.arn
  role       = aws_iam_role.AmazonEKSNodeRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn
  role       = aws_iam_role.AmazonEKSNodeRole.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchLogsFullAccess" {
  policy_arn = data.aws_iam_policy.CloudWatchLogsFullAccess.arn
  role       = aws_iam_role.AmazonEKSNodeRole.name
}

