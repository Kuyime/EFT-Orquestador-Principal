# Módulo de Redes (VPC) - Infraestructura en AWS

Este módulo de Terraform está diseñado para desplegar una arquitectura de red base segura y de alta disponibilidad en Amazon Web Services (AWS). Cumple con los estándares de seguridad mediante la integración de cifrado KMS, monitoreo de tráfico y control de accesos.

## Características de la Arquitectura

* Creación de una VPC principal con soporte DNS.
* Despliegue de 2 Subredes Públicas y 2 Subredes Privadas distribuidas lógicamente.
* Implementación de Internet Gateway (IGW) para tráfico externo y un NAT Gateway con IP Elástica (EIP) para dar salida segura a las subredes privadas.
* Monitoreo de red integral mediante VPC Flow Logs centralizados en CloudWatch.
* Cifrado de registros automatizado utilizando llaves gestionadas por AWS KMS con rotación automática habilitada.
* Grupo de seguridad preconfigurado para restringir el acceso SSH a una IP específica y permitir salida HTTPS.

## Dependencias

Para el correcto funcionamiento de este módulo, el entorno de ejecución debe contar con:
* **AWS Provider:** Para la orquestación de la infraestructura en la nube.
* **Random Provider:** Utilizado para generar sufijos aleatorios en la nomenclatura de los recursos (ej. KMS y CloudWatch).
* **IAM Role (AWS Academy):** Se requiere inyectar un ARN válido del `LabRole` para que el servicio de Flow Logs tenga permisos de escritura en CloudWatch.

## Ejemplo Práctico de Uso

A continuación, se presenta un ejemplo de cómo invocar este módulo desde un archivo de orquestación principal (`main.tf`):

```hcl
# Obtener el rol de AWS Academy existente
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

module "redes" {
  source = "git::[https://github.com/TU_USUARIO/EFT-Modulo-Redes.git?ref=v1.0.0](https://github.com/TU_USUARIO/EFT-Modulo-Redes.git?ref=v1.0.0)"

  # Parámetro obligatorio
  lab_role_arn = data.aws_iam_role.lab_role.arn

  # Parámetros opcionales (sobreescribiendo valores por defecto)
  vpc_cidr             = "10.1.0.0/16"
  public_subnet_1_cidr = "10.1.1.0/24"
  my_ip                = "201.189.206.99/32"
}
