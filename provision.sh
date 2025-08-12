#!/bin/bash

# Atualizar os pacotes
apt-get update

# Instalar o Nginx
apt-get install -y nginx

# Iniciar o serviço do Nginx
systemctl start nginx
systemctl enable nginx

# Instalar dependências
apt-get install -y wget sed

# Criar diretório web
mkdir -p /var/www/html
cd /var/www/html

# Baixar jQuery diretamente do CDN
wget https://code.jquery.com/jquery-3.7.1.min.js -O jquery.min.js

# Criar arquivo HTML completo
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>ViaCEP Webservice - CEP do Brasil</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        :root {
            --verde-brasil: #009C3B;
            --amarelo-brasil: #FFDF00;
            --azul-brasil: #002776;
            --branco: #FFFFFF;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        
        .container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            background: var(--branco);
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            border: 2px solid var(--verde-brasil);
        }
        
        h1 {
            color: var(--verde-brasil);
            text-align: center;
            margin-bottom: 10px;
            font-size: 28px;
        }
        
        .subtitle {
            text-align: center;
            color: var(--azul-brasil);
            margin-bottom: 30px;
            font-size: 16px;
        }
        
        form {
            display: flex;
            flex-direction: column;
        }
        
        label {
            margin-bottom: 5px;
            font-weight: bold;
            color: var(--azul-brasil);
        }
        
        input {
            padding: 12px;
            margin-bottom: 15px;
            border: 2px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border 0.3s;
        }
        
        input:focus {
            border-color: var(--amarelo-brasil);
            outline: none;
        }
        
        #cep {
            background-color: rgba(0, 156, 59, 0.1);
            font-weight: bold;
        }
        
        .btn-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        
        button {
            background-color: var(--amarelo-brasil);
            color: var(--azul-brasil);
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        
        button:hover {
            background-color: #e6c900;
        }
        
        footer {
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 14px;
        }
        
        .brasil-flag {
            height: 20px;
            vertical-align: middle;
            margin-left: 5px;
        }
    </style>
    <script src="/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            function limpa_formulário_cep() {
                $("#rua").val("");
                $("#bairro").val("");
                $("#cidade").val("");
                $("#uf").val("");
                $("#ibge").val("");
            }
            
            $("#cep").blur(function() {
                var cep = $(this).val().replace(/\D/g, '');
                if (cep != "") {
                    var validacep = /^[0-9]{8}$/;
                    if(validacep.test(cep)) {
                        $("#rua").val("...");
                        $("#bairro").val("...");
                        $("#cidade").val("...");
                        $("#uf").val("...");
                        $("#ibge").val("...");
                        
                        $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {
                            if (!("erro" in dados)) {
                                $("#rua").val(dados.logradouro);
                                $("#bairro").val(dados.bairro);
                                $("#cidade").val(dados.localidade);
                                $("#uf").val(dados.uf);
                                $("#ibge").val(dados.ibge);
                            } else {
                                limpa_formulário_cep();
                                alert("CEP não encontrado.");
                            }
                        });
                    } else {
                        limpa_formulário_cep();
                        alert("Formato de CEP inválido.");
                    }
                } else {
                    limpa_formulário_cep();
                }
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h1>Consulta de CEP <span style="color:var(--amarelo-brasil)">do Brasil</span></h1>
        <p class="subtitle">Digite o CEP e o endereço será completado automaticamente</p>
        
        <form method="get" action=".">
            <label for="cep">CEP:</label>
            <input name="cep" type="text" id="cep" value="" placeholder="Ex: 01001000" maxlength="9" />
            
            <label for="rua">Rua:</label>
            <input name="rua" type="text" id="rua" readonly />
            
            <label for="bairro">Bairro:</label>
            <input name="bairro" type="text" id="bairro" readonly />
            
            <label for="cidade">Cidade:</label>
            <input name="cidade" type="text" id="cidade" readonly />
            
            <label for="uf">Estado:</label>
            <input name="uf" type="text" id="uf" readonly />
            
            <label for="ibge">Código IBGE:</label>
            <input name="ibge" type="text" id="ibge" readonly />
            
            <div class="btn-container">
                <button type="button" onclick="$('#cep').val('').focus();">Nova Consulta</button>
            </div>
        </form>
        
        <footer>
            <p>Serviço utilizando a API do ViaCEP | Cores temáticas da bandeira brasileira</p>
        </footer>
    </div>
</body>
</html>
EOF


# Ajustar permissões
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Reiniciar Nginx
systemctl restart nginx