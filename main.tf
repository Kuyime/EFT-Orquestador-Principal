# ==============================================================================
# Repositorio Principal - Orquestador de Infraestructura
# ==============================================================================

# Obtenemos el LabRole de AWS Academy para pasarlo a los módulos
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

# 1. Llamada al Módulo de Redes (VPC)
module "redes" {
  # Apuntamos a la última versión con la documentación corregida
  source = "git::https://github.com/Ignaciov1/terraform-aws-vpc-AUY1105-grupo-3.git?ref=v1.1.0"

  # Pasamos la variable obligatoria
  lab_role_arn = data.aws_iam_role.lab_role.arn
}

# 2. Llamada al Módulo de Cómputo (EC2)
module "computo" {
  # Apuntamos a la última versión con la documentación corregida
  source = "git::https://github.com/Ignaciov1/terraform-aws-ec2-AUY1105-grupo-3.git?ref=v0.1.1"

  # Conectamos EC2 con las salidas (outputs) del módulo de red
  subnet_id         = module.redes.public_subnet_1_id
  security_group_id = module.redes.id_sg_ssh
}