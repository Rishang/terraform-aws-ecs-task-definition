# Container definitions are used in task definitions to describe the different containers that are launched as part of a task.
# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html

variable "command" {
  default     = []
  description = "The command that is passed to the container"
  type        = list(string)
}

variable "cpu" {
  default     = 256
  description = "The number of cpu units reserved for the container"
  type        = number
}

variable "disableNetworking" {
  default     = false
  description = "When this parameter is true, networking is disabled within the container"
}

variable "dnsSearchDomains" {
  default     = []
  description = "A list of DNS search domains that are presented to the container"
  type        = list(string)
}

variable "dnsServers" {
  default     = []
  description = "A list of DNS servers that are presented to the container"
  type        = list(string)
}

variable "dockerLabels" {
  default     = {}
  description = "A key/value map of labels to add to the container"
  type        = map(string)
}

variable "dockerSecurityOptions" {
  default     = []
  description = "A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems"
  type        = list(string)
}

variable "entryPoint" {
  default     = []
  description = "The entry point that is passed to the container"
  type        = list(string)
}

variable "environment" {
  default     = {}
  description = "The environment variables to pass to a container"
  type        = map(string)
}

variable "essential" {
  default     = true
  description = "If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped"
}

variable "execution_role_arn" {
  default     = ""
  description = "The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
}

variable "extraHosts" {
  default     = []
  description = "A list of hostnames and IP address mappings to append to the /etc/hosts file on the container"

  type = list(object({
    ipAddress = string
    hostname  = string
  }))
}

variable "family" {
  description = "You must specify a family for a task definition, which allows you to track multiple versions of the same task definition"
}

variable "healthCheck" {
  default     = {}
  description = "The health check command and associated configuration parameters for the container"
  type        = any
}

variable "hostname" {
  default     = ""
  description = "The hostname to use for your container"
}

variable "image" {
  default     = "null"
  description = "The image used to start a container"
}

variable "interactive" {
  default     = false
  description = "When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated"
}

variable "ipc_mode" {
  default     = null
  description = "The IPC resource namespace to use for the containers in the task"
}

variable "links" {
  default     = []
  description = "The link parameter allows containers to communicate with each other without the need for port mappings"
  type        = list(string)
}

variable "linuxParameters" {
  default     = {}
  description = "Linux-specific modifications that are applied to the container, such as Linux KernelCapabilities"
  type        = any
}

variable "logConfiguration" {
  default     = {}
  description = "The log configuration specification for the container"
  type        = any
}

variable "memory" {
  default     = 512
  description = "The hard limit (in MiB) of memory to present to the container"
  type        = number
}

variable "memoryReservation" {
  default     = 0
  description = "The soft limit (in MiB) of memory to reserve for the container"
}

variable "mountPoints" {
  default     = []
  description = "The mount points for data volumes in your container"
  type        = list(any)
}

variable "name" {
  default     = ""
  description = "The name of a container"
}

variable "network_mode" {
  default     = "awsvpc"
  description = "The Docker networking mode to use for the containers in the task"
}

variable "pid_mode" {
  default     = null
  description = "The process namespace to use for the containers in the task"
}

variable "placement_constraints" {
  default     = []
  description = "An array of placement constraint objects to use for the task"
  type = list(object({
    type       = string
    expression = string
  }))
}

variable "portMappings" {
  default     = [{ containerPort = 80 }]
  description = "The list of port mappings for the container"
  type        = list(any)
}

variable "privileged" {
  default     = false
  description = "When this parameter is true, the container is given elevated privileges on the host container instance (similar to the root user)"
}

variable "pseudoTerminal" {
  default     = false
  description = "When this parameter is true, a TTY is allocated"
}

variable "readonlyRootFilesystem" {
  default     = false
  description = "When this parameter is true, the container is given read-only access to its root file system"
}

variable "register_task_definition" {
  default     = true
  description = "Registers a new task definition from the supplied family and containerDefinitions"
}

variable "repositoryCredentials" {
  default     = {}
  description = "The private repository authentication credentials to use"
  type        = map(string)
}

variable "requires_compatibilities" {
  default     = ["FARGATE"]
  description = "The launch type required by the task"
  type        = list(string)
}

variable "resourceRequirements" {
  default     = []
  description = "The type and amount of a resource to assign to a container"
  type        = list(string)
}

variable "secrets" {
  default     = []
  description = "The secrets to pass to the container"
  type        = list(map(string))
}

variable "systemControls" {
  default     = []
  description = "A list of namespaced kernel parameters to set in the container"
  type        = list(string)
}

variable "tags" {
  default     = {}
  description = "The metadata that you apply to the task definition to help you categorize and organize them"
  type        = map(string)
}

variable "task_role_arn" {
  default     = ""
  description = "The short name or full Amazon Resource Name (ARN) of the IAM role that containers in this task can assume"
}

variable "ulimits" {
  default     = []
  description = "A list of ulimits to set in the container"
  type        = list(any)
}

variable "user" {
  default     = ""
  description = "The user name to use inside the container"
}

variable "volumes" {
  default     = []
  description = "A list of volume definitions in JSON format that containers in your task may use"
  type        = list(any)
}

variable "volumesFrom" {
  default     = []
  description = "Data volumes to mount from another container"

  type = list(object({
    readOnly        = bool
    sourceContainer = string
  }))
}

variable "workingDirectory" {
  default     = ""
  description = "The working directory in which to run commands inside the container"
}

variable "runtime_platform" {
  type = object({
    cpu_architecture        = string
    operating_system_family = string
  })
  nullable    = true
  description = "The runtime platform"
  default = {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}

variable "track_latest" {
  type        = bool
  default     = false
  description = "Whether should track latest ACTIVE task definition on AWS or the one created with the resource stored in state. Default is false. Useful in the event the task definition is modified outside of this resource."
}


variable "ecr_create_repo" {
  type        = bool
  default     = false
  description = "Enable ECR repository creation"
}

variable "ecr_scan_on_push" {
  type        = bool
  default     = false
  description = "Enable ECR repository scanning on push"
}

variable "ecr_repo_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "ecr_repo_remove_untagged_days" {
  type        = number
  default     = 7
  description = "Number of days to keep untagged images"
}

variable "ecr_task_definition_tag" {
  type        = string
  default     = "latest"
  description = "Tag to use for the ECR task definition"
}

variable "enable_cloudwatch" {
  type        = bool
  default     = false
  description = "Whether to enable CloudWatch logging if false, the value of variable `logConfiguration` will be used"
}

variable "cloudwatch_log_group_prefix" {
  type        = string
  default     = ""
  description = "The prefix for the CloudWatch log group name eg: /project/environment/app"
}

variable "cloudwatch_log_retention_in_days" {
  type        = number
  default     = 30
  description = "The number of days to retain the CloudWatch log group"
}
