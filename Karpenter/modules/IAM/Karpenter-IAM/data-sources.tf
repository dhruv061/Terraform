#trustrelanship policy for karpeter controller role
data "aws_iam_policy_document" "karpenter_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test = "StringEquals"
      variable = "${replace(var.openid_connect_provider_url, "https://", "")}:aud"
      values = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.openid_connect_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:karpenter:karpenter"]
    }

    principals {
      identifiers = [var.openid_connect_provider_arn]
      type        = "Federated"
    }
  }
}