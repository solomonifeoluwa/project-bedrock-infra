#################################################
# MYSQL PASSWORD
#################################################

resource "random_password" "mysql_password" {
  length  = 20
  special = true
}

resource "aws_secretsmanager_secret" "mysql_secret" {
  name = "project-bedrock-mysql-password"
}

resource "aws_secretsmanager_secret_version" "mysql_secret_value" {
  secret_id = aws_secretsmanager_secret.mysql_secret.id

  secret_string = random_password.mysql_password.result
}

#################################################
# POSTGRES PASSWORD
#################################################

resource "random_password" "postgres_password" {
  length  = 20
  special = true
}

resource "aws_secretsmanager_secret" "postgres_secret" {
  name = "project-bedrock-postgres-password"
}

resource "aws_secretsmanager_secret_version" "postgres_secret_value" {
  secret_id = aws_secretsmanager_secret.postgres_secret.id

  secret_string = random_password.postgres_password.result
}