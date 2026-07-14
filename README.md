# Orquestador de Infraestructura AWS - Evaluación Final Transversal

Repositorio principal para la asignatura **AUY1105 - Infraestructura como Código II**. Este proyecto actúa como un controlador central que orquesta la creación de infraestructura en AWS mediante el uso de módulos de Terraform desacoplados.

## 🏗️ Arquitectura Modular
Este repositorio no contiene definición de recursos directos, sino que invoca los siguientes módulos externos versionados:
1. **Módulo de Redes:** [Repositorio de VPC](https://github.com/Kuyime/EFT-Modulo-Redes) - Encargado de VPC, Subredes, NAT, IGW y seguridad (KMS, Security Groups).
2. **Módulo de Cómputo:** [Repositorio de EC2](https://github.com/Kuyime/EFT-Modulo-Computo) - Encargado del despliegue de instancias EC2 y perfiles IAM.

## ⚙️ Automatización (CI/CD)
El proyecto incluye un pipeline en GitHub Actions que realiza:
- Análisis de código estático (TFLint).
- Análisis de vulnerabilidades (Checkov).
- Validación de políticas de seguridad corporativas (OPA - Open Policy Agent).
- Despliegue automatizado (`terraform apply`).
- Mecanismo de **Rollback Automático**: Si el despliegue falla, ejecuta un destroy automático para evitar costos innecesarios en AWS.

## 🚀 Uso
Para inicializar este orquestador localmente:
```bash
terraform init
terraform plan
terraform apply