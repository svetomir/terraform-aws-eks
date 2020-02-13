output "cluster_id" {
    value       = aws_eks_cluster.main.id
    description = "The name of the cluster."
}

output "cluster_arn" {
    value       = aws_eks_cluster.main.arn
    description = "The Amazon Resource Name (ARN) of the cluster."
}

output "cluster_certificate_authority" {
    value       = aws_eks_cluster.main.certificate_authority
    description = "Nested attribute containing certificate-authority-data for your cluster."
}

output "cluster_endpoint" {
    value       = aws_eks_cluster.main.endpoint
    description = "The endpoint for your Kubernetes API server."
}

output "cluster_identity" {
    value       = aws_eks_cluster.main.identity
    description = "Nested attribute containing identity provider information for your cluster."
}

output "cluster_platform_version" {
    value       = aws_eks_cluster.main.platform_version
    description = "The platform version for the cluster."
}

output "cluster_status" {
    value       = aws_eks_cluster.main.status
    description = "The status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED."
}

output "cluster_version" {
    value       = aws_eks_cluster.main.version
    description = "The Kubernetes server version for the cluster."
}

output "cluster_vpc_config" {
    value       = aws_eks_cluster.main.vpc_config
    description = "The cluster security group that was created by Amazon EKS for the cluster. And, The VPC associated with your cluster."
}

output "cloudwatch_log_group" {
    value       = aws_cloudwatch_log_group.main.*.arn
    description = "The Amazon Resource Name (ARN) specifying the log group."
}

output "iam_role_arn" {
    value       = aws_iam_role.main.*.arn
    description = "The Amazon Resource Name (ARN) specifying the role."
}

output "iam_role_create_date" {
    value       = aws_iam_role.main.*.create_date
    description = "The creation date of the IAM role."
}

output "iam_role_description" {
    value       = aws_iam_role.main.*.description
    description = "The description of the role."
}

output "iam_role_id" {
    value       = aws_iam_role.main.*.id
    description = "The name of the role."
}

output "iam_role_name" {
    value       = aws_iam_role.main.*.name
    description = "The name of the role."
}

output "iam_role_unique_id" {
    value       = aws_iam_role.main.*.name
    description = "The stable and unique string identifying the role."
}

output "security_group_id" {
    value       = aws_security_group.main.*.id
    description = "The ID of the security group."
}

output "security_group_arn" {
    value       = aws_security_group.main.*.arn
    description = "The ARN of the security group."
}

output "security_group_vpc_id" {
    value       = aws_security_group.main.*.vpc_id
    description = "The VPC ID."
}

output "security_group_owner_id" {
    value       = aws_security_group.main.*.owner_id
    description = "The owner ID."
}

output "security_group_name" {
    value       = aws_security_group.main.*.name
    description = "The name of the security group."
}

output "security_group_description" {
    value       = aws_security_group.main.*.description
    description = "The description of the security group."
}

output "security_group_ingress" {
    value       = aws_security_group.main.*.ingress
    description = "The ingress rules."
}

output "security_group_egress" {
    value       = aws_security_group.main.*.egress
    description = "The egress rules."
}
