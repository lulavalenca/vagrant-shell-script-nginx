# vagrant-shell-script-nginx

## Descrição
Este projeto utiliza o Vagrant para criar uma máquina virtual Ubuntu 20.04, instalar o Nginx e configurar o servidor para hospedar um site simples. O site é armazenado em uma pasta sincronizada entre o host e a máquina virtual, permitindo edição fácil diretamente no sistema host.

## Passos para Subir a VM
1. Certifique-se de que o Vagrant e o VirtualBox estão instalados em seu sistema.
2. No diretório do projeto, execute o seguinte comando para iniciar a máquina virtual:
    ```bash
    vagrant up
    ```

3. O Vagrant irá baixar a box do Ubuntu 20.04, configurar o Nginx, e sincronizar a pasta local com o servidor web.

## Provisionamento
O script `provision.sh` realiza os seguintes passos:
1. Instala o Nginx na máquina virtual.
2. Configura o Nginx para servir os arquivos da pasta sincronizada (`/var/www/html`).
3. Baixa os arquivos do exemplo de site do `viacep.com.br`.
4. Inicia o Nginx e o configura para iniciar automaticamente.

## Acessando o Site
Depois que a máquina virtual estiver em execução, você pode acessar o site através do IP da máquina virtual. O comando a seguir pode ser usado para verificar o IP:

```bash
vagrant ssh
ifconfig
