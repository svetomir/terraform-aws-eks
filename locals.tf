locals {
    eks_security_group_ids = length(var.eks_security_group_ids) == 0 ? aws_security_group.main.*.id : var.eks_security_group_ids
}