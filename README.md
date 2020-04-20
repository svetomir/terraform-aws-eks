# Terraform AWS EKS

 **terraform-aws-eks** is Terraform module for creating:
 * Elastic Kubernetes Service (EKS) cluster
 * (optionally) CloudWatch Log Group for EKS Cluster
 * (optionally) IAM Role for EKS Cluster
 * (optionally) Additional Security Group for EKS Cluster

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |
| aws provider | >= 2.47 |

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| cluster_name | Name of the cluster. | true
| subnet_ids | List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane. | true
| vpc_id | VPC ID. | true
| additional_security_group_ids | List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane. Defaults to **[]**. | false
| create_additional_security_group | Indicates whether or not to create additional security group. Defaults to **false**. | false
| enabled_cluster_log_types | A list of the desired control plane logging to enable. ['api','audit', 'authenticator', 'controllerManager', 'scheduler'] Defaults to **[]**. | false
| endpoint_private_access | Indicates whether or not the Amazon EKS private API server endpoint is enabled. Defaults to **false**. | false
| endpoint_public_access | Indicates whether or not the Amazon EKS public API server endpoint is enabled. Defaults to **true**. | false
| kubernetes_version | Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS. Defaults to **1.14**.| false
| public_access_cidrs | Indicates whether or not the Amazon EKS private API server endpoint is enabled.  Defaults to **["0.0.0.0/0"]**. | false
| role_arn | The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf. Defaults to **""**. | false
| tags | Key-value mapping of default tags for all IAM users. Defaults to **{}**. | false
| cloudwatch_kms_key_id | The ARN of the KMS Key to use when encrypting log data. Defaults to **null**. | false
| cloudwatch_log_retention_in_days | Number of days to retain log events. Defaults to **7**. | false
| iam_role_force_detach_policies | Specifies to force detaching any policies the role has before destroying it. Defaults to **true**. | false
| iam_role_path | Path in which to create EKS IAM role. Defaults to **/**. | false
| iam_role_permissions_boundary | The ARN of the policy that is used to set the permissions boundary for the role. Defaults to **""**. | false

## Outputs

| Name | Description |
|------|-------------|
| cluster_arn | The Amazon Resource Name (ARN) of the cluster. |
| cluster_certificate_authority | Nested attribute containing certificate-authority-data for your cluster. |
| cluster_endpoint | The endpoint for your Kubernetes API server. |
| cluster_id | The name of the cluster. |
| cluster_identity | Nested attribute containing identity provider information for your cluster. |
| cluster_platform_version | The platform version for the cluster. |
| cluster_status | The status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED. |
| cluster_version | The Kubernetes server version for the cluster. |
| cluster_vpc_config | The cluster security group that was created by Amazon EKS for the cluster. And, The VPC associated with your cluster. |
| cloudwatch_log_group | The Amazon Resource Name (ARN) specifying the log group. |
| iam_role_arn | The Amazon Resource Name (ARN) specifying the role. |
| iam_role_create_date | The creation date of the IAM role. |
| iam_role_description | The description of the role. |
| iam_role_id | The name of the role. |
| iam_role_name | The name of the role. |
| iam_role_unique_id | The stable and unique string identifying the role. |
| security_group_arn | The ARN of the security group. |
| security_group_description | The description of the security group. |
| security_group_egress | The egress rules. |
| security_group_id | The ID of the security group. |
| security_group_ingress | The ingress rules. |
| security_group_name | The name of the security group. |
| security_group_owner_id | The owner ID. |
| security_group_vpc_id | The VPC ID. |
