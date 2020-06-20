provider "aws" {
  region = "us-east-1"  
}

module "servico_wordpress" {
  source                = "git::https://github.com/joaquimpedrooliveira/infra-modulo-app-php.git?ref=v0.3.0"

  project_name          = "blog"

  db_name               = "wordpress_db"
  db_user               = "wordpress_user"
  db_password           = "stupid_pass"  # No mundo real, deve estar externalizado
  db_instance_type      = "t2.micro"

  app_instance_type     = "t2.micro"
  app_playbook_filename = "provision_wordpress.yml"
  app_config_dir        = "ansible"

  ssh_key_name          = "aula-terraform"
  allowed_ssh_ips       = ["192.168.1.1/32"]
}

output "endereco_wordpress" {
  value = module.servico_wordpress.app_public_dns
}