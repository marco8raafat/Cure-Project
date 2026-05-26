# UBUNTU 24.04 LTS

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# APP SERVERS

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"

  subnet_id = aws_subnet.public_1.id

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.profile.name

  user_data = file("user-data.sh")

  tags = {
    Name = "cure-app"
  }
}

resource "aws_instance" "app2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"

  subnet_id = aws_subnet.public_1.id

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.profile.name

  user_data = file("user-data.sh")

  tags = {
    Name = "cure-app2"
  }
}

# JENKINS SERVER

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"

  subnet_id = aws_subnet.public_1.id

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  tags = {
    Name = "jenkins-server"
  }
}