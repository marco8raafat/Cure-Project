resource "aws_db_subnet_group" "db_subnet" {
  name = "cure-db-subnet"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

resource "aws_db_instance" "postgres" {
  identifier = "cure-postgres"

  engine            = "postgres"
  engine_version    = "17.1"
  instance_class    = "db.t3.micro"

  allocated_storage = 20

  db_name  = "curedb"
  username = var.db_username
  password = var.db_password

  publicly_accessible = false

  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  multi_az = false
}