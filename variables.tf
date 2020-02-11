variable "tags" {
    type        = map(string)
    default     = {}
    description = "Key-value mapping of default tags for all IAM users."
}
# EKS
variable "eks_cluster_name" {
    type        = string
    description = "Name of the cluster."
}
variable "eks_subnet_ids" {
    type        = list(string)
    description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}
variable "eks_vpc_id" {
    type        = string
    description = "VPC ID."
}
variable "eks_enabled_cluster_log_types" {
    type        = list(string)
    default     = []
    description = "A list of the desired control plane logging to enable. ['api','audit', 'authenticator', 'controllerManager', 'scheduler']"
}
variable "eks_role_arn" {
    type        = string
    default     = ""
    description = " The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf."
}
variable "eks_version" {
    type        = string
    default     = "1.14"
    description = "Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
}
variable "eks_endpoint_private_access" {
    type        = bool
    default     = false
    description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}
variable "eks_endpoint_public_access" {
    type        = bool
    default     = true
    description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}
variable "eks_public_access_cidrs" {
    type        = list(string)
    default     = ["0.0.0.0/0"]
    description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}
variable "eks_security_group_ids" {
    type        = list(string)
    default     = []
    description = "List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
}
# CLOUDWATCH
variable "eks_cloudwatch_kms_key_id" {
    type        = string
    default     = ""
    description = "The ARN of the KMS Key to use when encrypting log data."
}
variable "eks_cloudwatch_log_retention_in_days" {
    type        = number
    default     = 7
    description = "Number of days to retain log events."
}
# IAM
variable "eks_iam_role_path" {
    type        = string
    default     = "/"
    description = "Path in which to create EKS IAM role."
}

variable "eks_iam_role_permissions_boundary" {
    type        = string
    default     = ""
    description = "The ARN of the policy that is used to set the permissions boundary for the role."
}
