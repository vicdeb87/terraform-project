output "instance_public_ip" {
  value       = aws_instance.dd.public_ip
  description = "Public IP of the EC2 instance"
}
