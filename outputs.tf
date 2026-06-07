# ─── Required grading outputs (names must match exactly) ──────────────────────

output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "EKS cluster API server endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "assets_bucket_name" {
  description = "S3 assets bucket name"
  value       = aws_s3_bucket.assets.bucket
}

# ─── Additional useful outputs ─────────────────────────────────────────────────

output "cluster_version" {
  description = "EKS cluster Kubernetes version"
  value       = aws_eks_cluster.main.version
}

output "public_subnet_1" {
  value = aws_subnet.public_1.id
}

output "public_subnet_2" {
  value = aws_subnet.public_2.id
}

output "private_subnet_1" {
  value = aws_subnet.private_1.id
}

output "private_subnet_2" {
  value = aws_subnet.private_2.id
}

output "mysql_endpoint" {
  description = "MySQL RDS connection endpoint"
  value       = aws_db_instance.mysql.endpoint
  sensitive   = true
}

output "postgres_endpoint" {
  description = "PostgreSQL RDS connection endpoint"
  value       = aws_db_instance.postgres.endpoint
  sensitive   = true
}

output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = aws_dynamodb_table.retail_products.name
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.asset_processor.function_name
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN (needed for ALB Controller IRSA setup)"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "dev_view_access_key_id" {
  description = "Access Key ID for bedrock-dev-view — include in grading doc"
  value       = aws_iam_access_key.dev_view.id
  sensitive   = true
}

output "dev_view_secret_access_key" {
  description = "Secret Access Key for bedrock-dev-view — include in grading doc"
  value       = aws_iam_access_key.dev_view.secret
  sensitive   = true
}

output "dev_view_console_password" {
  description = "Initial console password for bedrock-dev-view — user must change on first login"
  value       = aws_iam_user_login_profile.dev_view.password
  sensitive   = true
}
