# EC2 Instance 
resource "aws_instance" "dd" {
  ami = "ami-01e3c4a339a264cc9"  # Replace with your preferred AMI ID
  instance_type   = "t2.micro"
  key_name        = "jj"  # Existing Key Pair
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "dd-EC2"
  }
}