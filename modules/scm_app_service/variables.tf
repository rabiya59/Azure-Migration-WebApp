variable "app_id"{
    type = string
    description = "The App service ID"
}
variable "repo_url"{
    type = string
    description = "Repository's URL"
}
variable "main_branch"{
    type = string
    description = "The branch to pull"
}
variable "use_manual_integration" {
  type = bool
}
variable "type" {
    type = string
}
variable "token" {
    type = string
}