# # EKS

resource "aws_eks_cluster" "main" {
    name     = var.eks_cluster_name

    enabled_cluster_log_types = var.eks_enabled_cluster_log_types
    role_arn = aws_iam_role.main.arn
    version = var.eks_version
    vpc_config {
        endpoint_private_access = var.eks_endpoint_private_access
        endpoint_public_access  = var.eks_endpoint_public_access
        public_access_cidrs     = var.eks_public_access_cidrs
        security_group_ids      = local.eks_security_group_ids
        subnet_ids              = var.eks_subnet_ids
    }

    tags = merge(
        var.tags,
        {"Name" = var.eks_cluster_name}
    )
    
    depends_on = [
        aws_iam_role_policy_attachment.main_AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.main_AmazonEKSServicePolicy,
    ]
}

# IAM

resource "aws_iam_role" "main" {
    name                  = format("%s-eks-cluster-role", var.eks_cluster_name)
    assume_role_policy    = data.aws_iam_policy_document.main_assume_role_policy.json
    force_detach_policies = true
    path                  = var.eks_iam_role_path
    permissions_boundary  = var.eks_iam_role_permissions_boundary
    
    tags = merge(
        var.tags,
        {"Name" = format("%s-eks", var.eks_cluster_name)}
    )
}

data "aws_iam_policy_document" "main_assume_role_policy" {
    statement {
        actions = [
            "sts:AssumeRole",
        ]
        principals {
            type        = "Service"
            identifiers = ["eks.amazonaws.com"]
        }
        sid = "EKSClusterAssumeRole"
    }
}

resource "aws_iam_role_policy_attachment" "main_AmazonEKSClusterPolicy" {
    role       = aws_iam_role.main.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "main_AmazonEKSServicePolicy" {
    role       = aws_iam_role.main.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

# # SECURITY GROUP

resource "aws_security_group" "main" {
    count = length(var.eks_security_group_ids) == 0 ? 1 : 0
    
    name = format("%s-eks-cluster-sg", var.eks_cluster_name)
    vpc_id = var.eks_vpc_id
    tags = merge(
        var.tags,
        {"Name" = format("%s-eks-cluster-sg", var.eks_cluster_name)},
    )
}

resource "aws_security_group_rule" "cluster_ingress_internet" {
    count = length(var.eks_security_group_ids) == 0 ? 1 : 0

    protocol          = "-1"
    security_group_id = aws_security_group.main[0].id
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 0
    type              = "ingress"
}

resource "aws_security_group_rule" "cluster_egress_internet" {
    count = length(var.eks_security_group_ids) == 0 ? 1 : 0

    protocol          = "-1"
    security_group_id = aws_security_group.main[0].id
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 0
    type              = "egress"
}
