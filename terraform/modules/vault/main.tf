terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
    vault = {
        source = "hashicorp/vault"
        version = "3.17.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "vault_image" {
  name = "vault:1.13.3"
}

resource "docker_container" "vault_container" {
  image = docker_image.vault_image.name
  name  = "vault"
}

resource "docker_volume" "vault_log" {
  name = "vault_log"
}

resource "docker_network" "vault_network" {
    name = "vault_network"
}

provider "vault" {
  address = "http://${docker_container.vault_container.network_data[0].ip_address}:8200"
}

#resource "vault_auth_backend" "userpass" {
#  type = "userpass"
#}

resource "vault_policy" "admin_policy" {
  name   = "admins"
  policy = file("policies/admin_policy.hcl")
}

resource "vault_generic_endpoint" "steph" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/steph"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["fpe-client", "admins"],
  "password": "password"
}
EOT
}

