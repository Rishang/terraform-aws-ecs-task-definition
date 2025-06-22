output "arn" {
  description = "The full Amazon Resource Name (ARN) of the task definition"
  value       = join("", aws_ecs_task_definition.ecs_task_definition.*.arn)
}

output "container_definitions" {
  description = "A list of container definitions in JSON format that describe the different containers that make up your task"
  value       = local.container_definitions
}

output "family" {
  description = "The family of your task definition, used as the definition name"
  value       = join("", aws_ecs_task_definition.ecs_task_definition.*.family)
}

output "revision" {
  description = "The revision of the task in a particular family"
  value       = join("", aws_ecs_task_definition.ecs_task_definition.*.revision)
}

output "ecr_repo_name" {
  description = "The name of the ECR repository created if ecr_create_repo is true"
  value       = var.ecr_create_repo == true ? aws_ecr_repository.service[0].name : null
}

output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group created if enable_cloudwatch is true"
  value       = var.enable_cloudwatch ? aws_cloudwatch_log_group.ecs_task_definition[0].name : null
}
