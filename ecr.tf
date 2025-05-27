resource "aws_ecr_repository" "service" {
  count = var.ecr_create_repo ? 1 : 0
  name  = var.ecr_repo_name

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }
}

resource "aws_ecr_lifecycle_policy" "service" {
  count      = var.ecr_create_repo ? 1 : 0
  repository = aws_ecr_repository.service[0].name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than ${var.ecr_repo_remove_untagged_days} days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": ${var.ecr_repo_remove_untagged_days}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
