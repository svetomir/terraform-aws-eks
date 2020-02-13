locals {
    additional_security_group_ids = length(var.additional_security_group_ids) == 0 ? aws_security_group.main.*.id : var.additional_security_group_ids
    role_arn = var.role_arn == "" ? aws_iam_role.main[0].arn : var.role_arn
}