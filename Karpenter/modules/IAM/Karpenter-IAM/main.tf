#Create Karpenter Controller Role
resource "aws_iam_role" "karpenter_controller" {
  #trustrelanship policy
  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume_role_policy.json
  name               = var.karpenter_controller_name
}

#Attach custom made policy to the katpenter controller role
resource "aws_iam_policy" "karpenter_controller" {
  policy = file("./modules/IAM/Karpenter-IAM/controller-trust-policy.json")
  name   = var.karpenter_controller_policy_name
}

#Attach trust policy to the katpenter controller role
resource "aws_iam_role_policy_attachment" "karpenter_policy_attach" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = aws_iam_policy.karpenter_controller.arn
}

