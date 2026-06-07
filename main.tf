locals {
  name_prefix      = "${var.project_name}-${var.environment}"
  eks_cluster_name = "project-bedrock-cluster"

  # Sanitise student_id for use in S3 bucket names:
  # lowercase, replace every non-alphanumeric/hyphen character (including "/") with "-"
  safe_student_id = lower(replace(var.student_id, "/[^a-z0-9-]/", "-"))
}
