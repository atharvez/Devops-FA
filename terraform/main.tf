terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "app_network" {
  name = "${var.network_name}-${var.environment}"
}

resource "docker_image" "backend" {
  name = "backend:${var.environment}"
  build {
    context = "${path.module}/../docker/backend"
  }
}

resource "docker_container" "backend" {
  name  = "${var.environment}-backend"
  image = docker_image.backend.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  ports {
    internal = 5000
    external = var.backend_host_port
  }

  env = ["ENVIRONMENT=${var.environment}"]
}

resource "docker_image" "frontend" {
  name = "frontend:${var.environment}"
  build {
    context = "${path.module}/../docker/frontend"
  }
}

resource "docker_container" "frontend" {
  name  = "${var.environment}-frontend"
  image = docker_image.frontend.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  ports {
    internal = 80
    external = var.frontend_host_port
  }
}