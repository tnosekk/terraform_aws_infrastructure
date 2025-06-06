data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "web_server" {
  name_prefix = "${var.project_name}-${var.environment}-web-"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-web-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_server_http" {
  description       = "HTTP"
  security_group_id = aws_security_group.web_server.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_ingress_rule" "web_server_https" {
  description       = "HTTPS"
  security_group_id = aws_security_group.web_server.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "web_server" {
  security_group_id = aws_security_group.web_server.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  to_port     = 0
  ip_protocol = -1

}

resource "aws_security_group" "app_server" {
  name_prefix = "${var.project_name}-${var.environment}-app-"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-app-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_server_http" {
  description       = "HTTP"
  security_group_id = aws_security_group.app_server.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8080
  to_port     = 8080
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_ingress_rule" "app_server_ssh" {
  description       = "SSH form web server"
  security_group_id = aws_security_group.app_server.id

  cidr_ipv4   = aws_security_group.web_server.id
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "app_server" {
  security_group_id = aws_security_group.app_server.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  to_port     = 0
  ip_protocol = -1

}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.web_server.id]
  subnet_id              = var.public_subnet_ids[0]
  iam_instance_profile   = var.iam_instance_profile

  user_data = base64encode(templatefile("${path.module}/user_data_web.sh", {
    project_name = var.project_name
    environment  = var.environment
  }))

  tags = {
    Name = "${var.project_name}-${var.environment}-web-server"
    Tier = "Web"
  }
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.app_server.id]
  subnet_id              = var.private_subnet_ids[0]
  iam_instance_profile   = var.iam_instance_profile

  user_data = base64encode(templatefile("${path.module}/user_data_app.sh", {
    project_name = var.project_name
    environment  = var.environment
  }))

  tags = {
    Name = "${var.project_name}-${var.environment}-app-server"
    Tier = "Application"
  }
}
