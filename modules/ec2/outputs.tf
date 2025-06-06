output "web_server_id" {
  description = "ID of the web server"
  value       = aws_instance.web_server.id
}

output "web_server_public_ip" {
  description = "Public ip of web server"
  value       = aws_instance.web_server.public_ip
}

output "web_server_private_it" {
  description = "Private ip of web server"
  value       = aws_instance.web_server.private_ip
}

output "app_server_id" {
  description = "ID of the app server"
  value       = aws_instance.app_server.id
}

output "app_server_private_ip" {
  description = "Private ip of app server"
  value       = aws_instance.app_server.private_ip
}

output "web_server_group_id" {
  description = "ID of web server security group"
  value       = aws_security_group.web_server.id
}

output "app_server_group_id" {
  description = "ID of app server security group"
  value       = aws_security_group.app_server.id
}
