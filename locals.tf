locals {
    eks_security_group_ids = length(var.eks_security_group_ids) == 0 ? aws_security_group.main.*.id : var.eks_security_group_ids
    eks_role_arn = var.eks_role_arn == "" ? aws_iam_role.main[0].arn : var.eks_role_arn
}