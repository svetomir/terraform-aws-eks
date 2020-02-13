resource "aws_eks_cluster" "main" {
    name     = var.cluster_name

    enabled_cluster_log_types = var.enabled_cluster_log_types
    role_arn                  = local.role_arn
    version                   = var.kubernetes_version
    
    vpc_config {
        endpoint_private_access = var.endpoint_private_access
        endpoint_public_access  = var.endpoint_public_access
        public_access_cidrs     = var.public_access_cidrs
        security_group_ids      = local.additional_security_group_ids
        subnet_ids              = var.subnet_ids
    }

    tags = merge(
        var.tags,
        {"Name" = var.cluster_name}
    )
    
    depends_on = [
        aws_cloudwatch_log_group.main,
        aws_iam_role_policy_attachment.main_AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.main_AmazonEKSServicePolicy
    ]
}

# CLOUDWATCH

resource "aws_cloudwatch_log_group" "main" {
    count             = length(var.enabled_cluster_log_types) > 0 ? 1 : 0

    name              = "/aws/eks/${var.cluster_name}/cluster"
    kms_key_id        = var.cloudwatch_kms_key_id
    retention_in_days = var.cloudwatch_log_retention_in_days
    
    tags = merge(
        var.tags,
        {"Name" = var.cluster_name}
    )
}

# IAM

resource "aws_iam_role" "main" {
    count = var.role_arn == "" ? 1 : 0

    name                  = format("%s-eks-cluster-role", var.cluster_name)
    assume_role_policy    = data.aws_iam_policy_document.main_assume_role_policy.json
    description           = format("Role for %s EKS cluster.", var.cluster_name)
    force_detach_policies = var.iam_role_force_detach_policies
    path                  = var.iam_role_path
    permissions_boundary  = var.iam_role_permissions_boundary
    
    tags = merge(
        var.tags,
        {"Name" = format("%s-eks-cluster-role", var.cluster_name)}
    )
}

data "aws_iam_policy_document" "main_assume_role_policy" {
    statement {
        actions = [
            "sts:AssumeRole",
        ]
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["eks.amazonaws.com"]
        }
        sid = "EKSClusterAssumeRole"
    }
}

resource "aws_iam_role_policy_attachment" "main_AmazonEKSClusterPolicy" {
    count = var.role_arn == "" ? 1 : 0

    role       = aws_iam_role.main[0].name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "main_AmazonEKSServicePolicy" {
    count = var.role_arn == "" ? 1 : 0

    role       = aws_iam_role.main[0].name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

# SECURITY GROUP

resource "aws_security_group" "main" {
    count = length(var.additional_security_group_ids) == 0 ? 1 : 0
    
    name        = format("%s-eks-cluster-additional-sg", var.cluster_name)
    description = format("Additional security sroup for %s EKS cluster.", var.cluster_name)
    vpc_id      = var.vpc_id
    
    tags = merge(
        var.tags,
        {"Name" = format("%s-eks-cluster-additional-sg", var.cluster_name)},
    )
}

resource "aws_security_group_rule" "cluster_ingress_internet" {
    count = length(var.additional_security_group_ids) == 0 ? 1 : 0

    protocol          = "-1"
    security_group_id = aws_security_group.main[0].id
    source_security_group_id = aws_security_group.main[0].id
    from_port         = 0
    to_port           = 0
    type              = "ingress"
}

resource "aws_security_group_rule" "cluster_egress_internet" {
    count = length(var.additional_security_group_ids) == 0 ? 1 : 0

    protocol          = "-1"
    security_group_id = aws_security_group.main[0].id
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 0
    type              = "egress"
}
