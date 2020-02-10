# output "aws_eks_cluster" {
#     value = aws_eks_cluster.main
# }

output "eks_security_group_ids" {
    value = var.eks_security_group_ids
}

output "local_eks_security_group_ids" {
    value = local.eks_security_group_ids
}