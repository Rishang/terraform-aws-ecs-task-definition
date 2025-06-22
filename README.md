<!-- BEGIN_TF_DOCS -->


![GitHub release](https://img.shields.io/github/release/mongodb/terraform-aws-ecs-task-definition.svg?style=flat-square) ![GitHub](https://img.shields.io/github/license/mongodb/terraform-aws-ecs-task-definition.svg?style=flat-square)

> A Terraform module for creating Amazon [ECS Task Definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html)

## NOTICE

**THIS MODULE IS NOT COMPATIBLE WITH VERSIONS OF TERRAFORM LESS THAN v0.12.x. PLEASE REFER TO THE OFFICIAL [DOCUMENTATION](https://www.terraform.io/upgrade-guides/0-12.html) FOR UPGRADING TO THE LATEST VERSION OF TERRAFORM.**

## Contents

- [Motivation](#motivation)
  - [Use Cases](#use-cases)
- [Requirements](#requirements)
- [Usage](#usage)
  - [Multiple Container Definitions](#multiple-container-definitions)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Testing](#testing)
- [License](#license)

## Motivation

The purpose of this module is to generate a valid Amazon [ECS Task Definition](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html) dynamically. A task definition is required to run Docker containers in Amazon ECS. A task definition contains a list of [container definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definitions) received by the Docker daemon to create a container instance.

### Use Cases

- Have Terraform generate valid task definitions dynamically
- Update the ECS task definition and trigger new [service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html) deployments automatically (see [examples/ecs_update_service.tf](examples/ecs_update_service.tf))

## Requirements

- [Terraform](https://www.terraform.io/downloads.html)
- [Go](https://golang.org/dl/) (for testing)
## Usage

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The full Amazon Resource Name (ARN) of the task definition |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | The name of the CloudWatch log group created if enable\_cloudwatch is true |
| <a name="output_container_definitions"></a> [container\_definitions](#output\_container\_definitions) | A list of container definitions in JSON format that describe the different containers that make up your task |
| <a name="output_ecr_repo_name"></a> [ecr\_repo\_name](#output\_ecr\_repo\_name) | The name of the ECR repository created if ecr\_create\_repo is true |
| <a name="output_family"></a> [family](#output\_family) | The family of your task definition, used as the definition name |
| <a name="output_revision"></a> [revision](#output\_revision) | The revision of the task in a particular family |

## available tfvar inputs

```hcl
# null are required inputs, 
# others are optional default values

cloudwatch_log_group_prefix      = ""
cloudwatch_log_retention_in_days = 30
command                          = []
cpu                              = 256
disableNetworking                = false
dnsSearchDomains                 = []
dnsServers                       = []
dockerLabels                     = {}
dockerSecurityOptions            = []
ecr_config                       = null
ecr_create_repo                  = false
enable_cloudwatch                = false
entryPoint                       = []
environment                      = {}
essential                        = true
execution_role_arn               = ""
extraHosts                       = []
family                           = null
healthCheck                      = {}
hostname                         = ""
image                            = "null"
interactive                      = false
ipc_mode                         = null
links                            = []
linuxParameters                  = {}
logConfiguration                 = {}
memory                           = 512
memoryReservation                = 0
mountPoints                      = []
name                             = ""
network_mode                     = "awsvpc"
pid_mode                         = null
placement_constraints            = []
portMappings = [{
  containerPort = 80
}]
privileged               = false
pseudoTerminal           = false
readonlyRootFilesystem   = false
register_task_definition = true
repositoryCredentials    = {}
requires_compatibilities = ["FARGATE"]
resourceRequirements     = []
runtime_platform = {
  cpu_architecture        = "X86_64"
  operating_system_family = "LINUX"
}
secrets          = []
systemControls   = []
tags             = {}
task_role_arn    = ""
track_latest     = false
ulimits          = []
user             = ""
volumes          = []
volumesFrom      = []
workingDirectory = ""
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_family"></a> [family](#input\_family) | You must specify a family for a task definition, which allows you to track multiple versions of the same task definition | `any` | n/a | yes |
| <a name="input_cloudwatch_log_group_prefix"></a> [cloudwatch\_log\_group\_prefix](#input\_cloudwatch\_log\_group\_prefix) | The prefix for the CloudWatch log group name eg: /project/environment/app | `string` | `""` | no |
| <a name="input_cloudwatch_log_retention_in_days"></a> [cloudwatch\_log\_retention\_in\_days](#input\_cloudwatch\_log\_retention\_in\_days) | The number of days to retain the CloudWatch log group | `number` | `30` | no |
| <a name="input_command"></a> [command](#input\_command) | The command that is passed to the container | `list(string)` | `[]` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of cpu units reserved for the container | `number` | `256` | no |
| <a name="input_disableNetworking"></a> [disableNetworking](#input\_disableNetworking) | When this parameter is true, networking is disabled within the container | `bool` | `false` | no |
| <a name="input_dnsSearchDomains"></a> [dnsSearchDomains](#input\_dnsSearchDomains) | A list of DNS search domains that are presented to the container | `list(string)` | `[]` | no |
| <a name="input_dnsServers"></a> [dnsServers](#input\_dnsServers) | A list of DNS servers that are presented to the container | `list(string)` | `[]` | no |
| <a name="input_dockerLabels"></a> [dockerLabels](#input\_dockerLabels) | A key/value map of labels to add to the container | `map(string)` | `{}` | no |
| <a name="input_dockerSecurityOptions"></a> [dockerSecurityOptions](#input\_dockerSecurityOptions) | A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems | `list(string)` | `[]` | no |
| <a name="input_ecr_config"></a> [ecr\_config](#input\_ecr\_config) | ECR repository configuration | <pre>object({<br/>    repo_name                 = optional(string, "")<br/>    task_definition_tag       = optional(string, "latest")<br/>    repo_remove_untagged_days = optional(number, 7)<br/>    scan_on_push              = optional(bool, false)<br/>    repo_max_images           = optional(number, 10)<br/>  })</pre> | `null` | no |
| <a name="input_ecr_create_repo"></a> [ecr\_create\_repo](#input\_ecr\_create\_repo) | Enable ECR repository creation | `bool` | `false` | no |
| <a name="input_enable_cloudwatch"></a> [enable\_cloudwatch](#input\_enable\_cloudwatch) | Whether to enable CloudWatch logging if false, the value of variable `logConfiguration` will be used | `bool` | `false` | no |
| <a name="input_entryPoint"></a> [entryPoint](#input\_entryPoint) | The entry point that is passed to the container | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment variables to pass to a container | `map(string)` | `{}` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped | `bool` | `true` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume | `string` | `""` | no |
| <a name="input_extraHosts"></a> [extraHosts](#input\_extraHosts) | A list of hostnames and IP address mappings to append to the /etc/hosts file on the container | <pre>list(object({<br/>    ipAddress = string<br/>    hostname  = string<br/>  }))</pre> | `[]` | no |
| <a name="input_healthCheck"></a> [healthCheck](#input\_healthCheck) | The health check command and associated configuration parameters for the container | `any` | `{}` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The hostname to use for your container | `string` | `""` | no |
| <a name="input_image"></a> [image](#input\_image) | The image used to start a container | `string` | `"null"` | no |
| <a name="input_interactive"></a> [interactive](#input\_interactive) | When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated | `bool` | `false` | no |
| <a name="input_ipc_mode"></a> [ipc\_mode](#input\_ipc\_mode) | The IPC resource namespace to use for the containers in the task | `any` | `null` | no |
| <a name="input_links"></a> [links](#input\_links) | The link parameter allows containers to communicate with each other without the need for port mappings | `list(string)` | `[]` | no |
| <a name="input_linuxParameters"></a> [linuxParameters](#input\_linuxParameters) | Linux-specific modifications that are applied to the container, such as Linux KernelCapabilities | `any` | `{}` | no |
| <a name="input_logConfiguration"></a> [logConfiguration](#input\_logConfiguration) | The log configuration specification for the container | `any` | `{}` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The hard limit (in MiB) of memory to present to the container | `number` | `512` | no |
| <a name="input_memoryReservation"></a> [memoryReservation](#input\_memoryReservation) | The soft limit (in MiB) of memory to reserve for the container | `number` | `0` | no |
| <a name="input_mountPoints"></a> [mountPoints](#input\_mountPoints) | The mount points for data volumes in your container | `list(any)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of a container | `string` | `""` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The Docker networking mode to use for the containers in the task | `string` | `"awsvpc"` | no |
| <a name="input_pid_mode"></a> [pid\_mode](#input\_pid\_mode) | The process namespace to use for the containers in the task | `any` | `null` | no |
| <a name="input_placement_constraints"></a> [placement\_constraints](#input\_placement\_constraints) | An array of placement constraint objects to use for the task | <pre>list(object({<br/>    type       = string<br/>    expression = string<br/>  }))</pre> | `[]` | no |
| <a name="input_portMappings"></a> [portMappings](#input\_portMappings) | The list of port mappings for the container | `list(any)` | <pre>[<br/>  {<br/>    "containerPort": 80<br/>  }<br/>]</pre> | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | When this parameter is true, the container is given elevated privileges on the host container instance (similar to the root user) | `bool` | `false` | no |
| <a name="input_pseudoTerminal"></a> [pseudoTerminal](#input\_pseudoTerminal) | When this parameter is true, a TTY is allocated | `bool` | `false` | no |
| <a name="input_readonlyRootFilesystem"></a> [readonlyRootFilesystem](#input\_readonlyRootFilesystem) | When this parameter is true, the container is given read-only access to its root file system | `bool` | `false` | no |
| <a name="input_register_task_definition"></a> [register\_task\_definition](#input\_register\_task\_definition) | Registers a new task definition from the supplied family and containerDefinitions | `bool` | `true` | no |
| <a name="input_repositoryCredentials"></a> [repositoryCredentials](#input\_repositoryCredentials) | The private repository authentication credentials to use | `map(string)` | `{}` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | The launch type required by the task (FARGATE, FARGATE\_SPOT, EC2) | `list(string)` | <pre>[<br/>  "FARGATE"<br/>]</pre> | no |
| <a name="input_resourceRequirements"></a> [resourceRequirements](#input\_resourceRequirements) | The type and amount of a resource to assign to a container | `list(string)` | `[]` | no |
| <a name="input_runtime_platform"></a> [runtime\_platform](#input\_runtime\_platform) | The runtime platform | <pre>object({<br/>    cpu_architecture        = string<br/>    operating_system_family = string<br/>  })</pre> | <pre>{<br/>  "cpu_architecture": "X86_64",<br/>  "operating_system_family": "LINUX"<br/>}</pre> | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The secrets to pass to the container | `list(map(string))` | `[]` | no |
| <a name="input_systemControls"></a> [systemControls](#input\_systemControls) | A list of namespaced kernel parameters to set in the container | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The metadata that you apply to the task definition to help you categorize and organize them | `map(string)` | `{}` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | The short name or full Amazon Resource Name (ARN) of the IAM role that containers in this task can assume | `string` | `""` | no |
| <a name="input_track_latest"></a> [track\_latest](#input\_track\_latest) | Whether should track latest ACTIVE task definition on AWS or the one created with the resource stored in state. Default is false. Useful in the event the task definition is modified outside of this resource. | `bool` | `false` | no |
| <a name="input_ulimits"></a> [ulimits](#input\_ulimits) | A list of ulimits to set in the container | `list(any)` | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | The user name to use inside the container | `string` | `""` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | A list of volume definitions in JSON format that containers in your task may use | `list(any)` | `[]` | no |
| <a name="input_volumesFrom"></a> [volumesFrom](#input\_volumesFrom) | Data volumes to mount from another container | <pre>list(object({<br/>    readOnly        = bool<br/>    sourceContainer = string<br/>  }))</pre> | `[]` | no |
| <a name="input_workingDirectory"></a> [workingDirectory](#input\_workingDirectory) | The working directory in which to run commands inside the container | `string` | `""` | no |

---
README.md created by: `terraform-docs`
<!-- END_TF_DOCS -->