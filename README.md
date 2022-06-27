# README.md
Arquivo com informações pertinentes ao projeto, como estrutura, fluxo de informação, etc..

# Bot do Telegram da Financial Move

O sistema foi feito em python, utilizando o flask para o desenvolvimento da api do sistema e a biblioteca mysql para conexão com o banco de dados.

Inicial foi inspirado no atual [bot da Financial](https://t.me/Cryptointeliggencebot), com a implementação de todos os comandos e a expansão conforme demanda.

Atualmente possui endpoints para tratamento dos webhooks do telegram (bot), stripe e evermart (gateways de pagamento) e processamento interno (admin)

## Estrutura

Na pasta raiz `./` terá informações pertinentes ao sistema, como configurações de projeto, editor, deploy, etc... <br/>

Dentro da pasta `./src/` está orquestado a lógica do sistema e as rotas.

No arquivo `main.py` está instanciado o servidor flask, além disto, nele ocorre a estruturação de log e definição de arquivos auxiliares.

Na pasta `api` estarão todas as funções que fazem requisições para api externas.

Na pasta `commands` estarão todos os comandos aceito pelo bot do Telegram. <br/>
Para os arquivos em pastas, ao ser importado o arquivo, será chamado o método `__init__.py` que inicia o comando base, os outros arquivos na pasta são referentes a callbacks. <br/>
Para os arquivos em pastas sem o método `__init__.py`, são callbacks enviados por rotas que não são do telegram. <br/>
Para os arquivos com nome de comando, será chamado eles diretamente e os mesmos não possuem callback.

Na pasta `controllers` estarão todas as rotas do sistema e suas tratativas.

Na pasta `database` estará o arquivo `connection.py` que contém as configurações de conexão e execução no banco de dados. <br/>
Nesta pasta também há o arquivo `script.py` que contém o script de drop e recreate do banco de dados e a pasta queries.
Na pasta `queries` estarão todos as funções que executam um SQL no banco, separado entre cada tabela.

Na pasta `json` estarão todos os arquivos auxiliares do sistema.

Na pasta `logs` estarão os arquivos de logs do sistema.

Na pasta `middleware` estará todas as funções que tratam as requisições do sistema.

Na pasta `public` estarão os arquivos diversos do sistema.

Já a pasta `server` possui o objeto do servidor.

Por fim, a pasta `utils` contém todas as funções que auxiliam no desenvolvimento do sistema, como validações e formatações.

## Fluxos do servidor

### **Telegram**

O [bot do telegram](https://t.me/WTLLBot) é o responsável pelo principal fluxo do sistema. <br/>
Ao receber uma mensagem por chat direto ou em um canal, o telegram irá enviar um webhook com as informações para a rota `/telegram` do sistema. <br/>
Essa rota possui um middleware que irá primeiramente o tipo de mensagem recebida, atualmente se aceita três tipos, sendo eles: </br>
- `message`: Mensagem de um chat direto, irá validar o usuário e executar o comando. <br/>
- `callback`: Callback do click de um botão enviado para o cliente, irá validar o usuário e executar o callback presente dentro de uma pasta na pasta `commands`.<br/>
- `channel_post`: Mensagem de um canal, irá verificar se o canal está salvo no banco de dados. <br/>

### **Stripe**

Quando o usuário vai no bot /pagamento, no cartão ou boleto, ao confirmar
- Vai criar o usuário na Stripe e atualizar o id dele no banco pelo webhook. <br/>
- Devido a recorrência criada no produto, é feito uma subscription relacioando o usuário com o produto recorrente. <br/>
- Vai criar uma session para o checkout do usuário. <br/>
- Tudo relacionado após o pagamento, é tratado na controller de webhook da Stripe. <br/>
Existem algumas sincronizações que são feitas pelo webhook, como ao criar um produto é sincronizado o id do produto no banco de dados. <br/>

### **Evermart**


## Deploy
O deploy foi realizado na heroku e setado as variáveis de ambiente via CLI.

