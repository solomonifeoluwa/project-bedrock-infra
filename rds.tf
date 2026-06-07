#################################################
# DB Subnet Group
#################################################

resource "aws_db_subnet_group" "db_subnets" {
  name = "project-bedrock-db-subnets"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name    = "project-bedrock-db-subnets"
    Project = "karatu-2025-capstone"
  }
}

#################################################
# Security Group
#################################################

resource "aws_security_group" "rds_sg" {
  name        = "project-bedrock-rds-sg"
  description = "Allow DB access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name    = "project-bedrock-rds-sg"
    Project = "karatu-2025-capstone"
  }
}

#################################################
# MySQL RDS Instance
#################################################

resource "aws_db_instance" "mysql" {
  identifier     = "project-bedrock-mysql"
  engine         = "mysql"
  engine_version = "8.0"

  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "retaildb"
  username = "admin"
  password = random_password.mysql_password.result

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible        = false
  skip_final_snapshot        = true
  storage_encrypted          = true
  auto_minor_version_upgrade = true

  tags = {
    Name    = "project-bedrock-mysql"
    Project = "karatu-2025-capstone"
  }
}

#################################################
# PostgreSQL RDS Instance
#################################################

resource "aws_db_instance" "postgres" {
  identifier     = "project-bedrock-postgres"
  engine         = "postgres"
  engine_version = "17"

  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "retaildb"
  username = "admin"
  password = random_password.postgres_password.result

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible        = false
  skip_final_snapshot        = true
  storage_encrypted          = true
  auto_minor_version_upgrade = true

  tags = {
    Name    = "project-bedrock-postgres"
    Project = "karatu-2025-capstone"
  }
}