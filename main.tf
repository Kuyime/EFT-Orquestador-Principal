# ==============================================================================
# Repositorio Principal - Orquestador de Infraestructura
# ==============================================================================

# Obtenemos el LabRole de AWS Academy para pasarlo a los módulos
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

# 1. Llamada a TU Módulo de Redes
module "redes" {
  source = "git::https://github.com/Kuyime/EFT-Modulo-Redes.git?ref=v1.0.0"
  lab_role_arn = data.aws_iam_role.lab_role.arn
}

# 2. Llamada a TU Módulo de Cómputo
module "computo" {
  source = "git::https://github.com/Kuyime/EFT-Modulo-Computo.git?ref=v1.0.0"
  
  # Y aquí mantenemos la corrección que hicimos antes
  subnet_id         = module.redes.public_subnet_1_id
  security_group_id = module.redes.id_sg_ssh
}