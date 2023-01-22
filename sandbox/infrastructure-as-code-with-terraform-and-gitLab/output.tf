output "project_id" {
  value = {
    vpc_id = aws_vpc.vpc.id
  }
}