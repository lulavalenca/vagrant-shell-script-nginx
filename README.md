# Projeto Vagrant com Nginx para Hospedagem de Site

Este projeto automatiza a criação de uma máquina virtual com Vagrant, configurando um servidor Nginx para hospedar um site de exemplo.

## Descrição

O projeto consiste em:
- Uma máquina virtual Ubuntu 20.04 configurada com Vagrant
- Servidor Nginx instalado automaticamente via script de provisionamento
- Site de exemplo (do ViaCEP) hospedado no Nginx
- Sincronização de pastas entre o host e a VM

## Pré-requisitos

- Vagrant instalado
- VirtualBox ou outro provedor de virtualização suportado

## Como usar

1. Clone este repositório
2. Navegue até o diretório do projeto
3. Execute `vagrant up`
   - Isso irá:
     - Baixar a imagem Ubuntu
     - Criar a VM
     - Executar o script de provisionamento
4. Acesse o site em http://192.168.33.10 no seu navegador

## Estrutura de Arquivos

- `Vagrantfile`: Configuração da máquina virtual
- `provision.sh`: Script de provisionamento para instalar e configurar o Nginx
- `site/`: Diretório sincronizado com /var/www/html na VM (opcional para conteúdo customizado)

## Sincronização de Pastas

O diretório `site/` no host é sincronizado com `/var/www/html` na VM. Qualquer alteração nos arquivos neste diretório será refletida imediatamente no servidor web.

## Comandos Úteis

- `vagrant up`: Inicia a VM
- `vagrant halt`: Desliga a VM
- `vagrant destroy`: Remove a VM
- `vagrant ssh`: Acessa a VM via SSH