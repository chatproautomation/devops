#!/bin/bash

echo "============================================"
echo "  🚀 Instalador de Serviços OpenSource"
echo "============================================"

# 📌 Solicitar dados ao usuário
read -p "Digite o domínio principal: " DOMINIO
read -p "Digite seu e-mail para SSL (Let's Encrypt): " EMAIL
read -p "Digite um usuário padrão para os serviços: " USUARIO
read -s -p "Digite uma senha padrão para os serviços: " SENHA
echo ""

# 🌍 Atualizar o sistema e instalar dependências
echo "📦 Atualizando pacotes e instalando dependências..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git docker.io docker-compose

# 🔄 Iniciar e habilitar o Docker
sudo systemctl start docker
sudo systemctl enable docker

# 📥 Clonar repositório com os arquivos YAML
echo "📂 Baixando configuração do GitHub..."
git clone https://github.com/chatproautomation/infra-installer.git
cd /opt/devops

# 📝 Substituir variáveis no arquivo docker-compose.yml
sed -i "s/DOMINIO_AQUI/$DOMINIO/g" docker-compose.yml
sed -i "s/EMAIL_AQUI/$EMAIL/g" docker-compose.yml
sed -i "s/USUARIO_AQUI/$USUARIO/g" docker-compose.yml
sed -i "s/SENHA_AQUI/$SENHA/g" docker-compose.yml

# 🚀 Subir os serviços com Docker Compose
echo "🚀 Iniciando os serviços..."
docker-compose up -d

echo "✅ Instalação concluída!"
echo "Acesse: https://$DOMINIO"
