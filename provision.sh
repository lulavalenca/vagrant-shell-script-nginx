#!/bin/bash

# Atualizar o sistema
sudo apt-get update -y
sudo apt-get upgrade -y

# Instalar o Nginx
sudo apt-get install -y nginx

# Configurar o Nginx para servir o conteúdo da pasta sincronizada
sudo rm -rf /var/www/html/*
sudo cp -r /vagrant/* /var/www/html/

# Configurar o Nginx para iniciar automaticamente
sudo systemctl enable nginx
sudo systemctl start nginx

# Baixar arquivos de exemplo do site
wget -P /var/www/html https://viacep.com.br/exemplo/jquery/

# Permissões corretas para os arquivos
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

echo "Provisionamento completo!"
