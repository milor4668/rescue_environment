module "spVault" {
  source = "./modules/vault"
  vault_username_default = var.vault_username_default
  vault_password_default = var.vault_password_default
}
