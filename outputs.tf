output "vpc_id" {
  value = aws_vpc.main.id
}

output "load_balancer_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "bastion_public_ip" {
  value = aws_eip.bastion_eip.public_ip
}
