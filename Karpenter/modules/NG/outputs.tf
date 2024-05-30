#Karpeneer install after node gorup is created
output "node_group" {
  value = aws_eks_node_group.node-grp.arn
}