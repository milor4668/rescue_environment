terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "vault" {
  name = "vault:1.13.3"
}

resource "docker_container" "vault" {
  image = docker_image.vault
  name  = "vault"
}

