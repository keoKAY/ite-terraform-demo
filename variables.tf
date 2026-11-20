variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  type    = string
  default = "asia-southeast1"
}

variable "zone" {
  type    = string
  default = "asia-southeast1-b"
}

variable "network" {
  type    = string
  default = "default"
}
variable "credentials_file" {
  description = "Path to the ADC / service account JSON file"
  type        = string
  default     = "./credentials/adc.json"
}
