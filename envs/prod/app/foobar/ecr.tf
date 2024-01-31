resource "aws_ecr_repository" "nginx" {
  name = "exapmle-prod-foobar-nginx"

  tags = {
    Name = "exapmle-prod-foobar-nginx"
  }
}

resource "aws_ecr_lifecycle_policy" "nginx" {
  policy = jsonencode(
    {
        "rules": [
           { 
                "rulePriority": 1,
                "description": "Hold only 10 images, expire all others",
                "selection": {
                    "tagStatus": "any",
                    "countType": "imageCountMoreThan",
                    "countNumber": 10
                }
                "action": {
                    "type": "expire"
                }
           }
        ]
    }
  )

  repository = aws_ecr_repository.nginx.name
}

module "nginx" {
  source = "../../../../modules/ecr"
  
  name = "example-prod-foobar-nginx"
}