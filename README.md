### Sobre o projeto
O projeto de automação de testes tem como objetivo mostrar a funcionalidade do test template e a validação de contratos das APIs usando 
a library json validator, iremos abordar a utilização do mock server para subirmos nossa aplicação de teste mocada.  

### Instalação
Os pré-requisitos para rodar o projeto são:
- IDE configurada(utilizo como default o PyCharm)
- Instalar o python mais recente
- Executar as seguintes instalações no seu terminal:
    ```sh
    pip install robotframework-requests
    pip install mock-server
    pip install robotframework-jsonvalidator
    ```

### Subindo a aplicação com o mock server
Após a instalação do mock server, abra o terminal na sua máquina e execute os seguintes comandos:
```bash
1 cd C:\{PATH}\testCaseWithTestTemplate\jsonServer
2 json-server .\db.json
```

Após a execução deverá apresentar o seguinte resultado no terminal:
```shell
INFO:aiohttp.server:JSON Server v0.1.9/CPython 3.10.0 - by Gerald
====================
Local:  http://[::1]:3000
---
Local:  http://localhost:3000
Remote: http://192.168.0.103:3000
====================
```
Pronto, o nosso mock server foi iniciado e esta pronto para rodar as automações.


## Test Template
O test template trás a facilidade e costumização para colocarmos N validações dentro de um único cenário de teste,
no exemplo abaixo será executado duas validações para o mesmo cenário.
```robotframework
### validarTestTemplate.robot

*** Test Cases ***
Scenario Outline 01 - Validar response das informações do produto inserido no jsonServer
    [Template]      Template Scenario Outline 01 - Validar response das informações do produto inserido no jsonServer
    #NOME                       #PRECO
    Coca cola 600ml             7.5
    Refrigerantes               9.7
```

Após configurar o cenário de teste passando o template que será validado é necessário configurarmos as nossas keywords,
no exemplo abaixo é necessário passar o [ARGUMENTS] e as variáveis que aquela keyword vai precisar comparar
```robotframework
### validarTestTemplate.robot

*** Keywords ***
Template Scenario Outline 01 - Validar response das informações do produto inserido no jsonServer
    [ARGUMENTS]  ${NOME}  ${PRECO}
    Dado que leonardo efetuar um get na rota
    Então é retornado no response  ${NOME}  ${PRECO}
    E valido o schema da API
```

Dentro das keywords do arquivo ValidarJsonServer.robot validamos o step "Então é retornado no response...", 
passamos também o [ARGUMENTS] para recebermos os valores de nome e preço e assim fazermos as devidas comparações.
```robotframework
Então é retornado no response
    [ARGUMENTS]     ${NOME}  ${PRECO}
    Element should exist    ${RESPOSTA.json()}    .nome:contains("${NOME}")
    Element should exist    ${RESPOSTA.json()}    .preco:contains("${PRECO}")
```

### Validação de contrato da API
Para garantirmos que o contrato da API não vai ser quebrado utilizei a library do json validator e passei a keyword ***Validate Jsonschema From File***
essa keyword tem o intuito de comparar o jsonSchema do contrato com o retorno do schema da API, caso tenha alguma diferença é retornado um erro no cenário informando 
que o contrato esta diferente do que foi criado.
```robotframework
E valido o schema da API
    Validate Jsonschema From File	  ${RESPOSTA.json()}   ${CURDIR}/JsonSchema.json
```

## 🤖 Bora rodar a automação?

Para executar a automação basta executar os seguintes comandos no terminal:
```sh
  cd C:\{PATH}\testCaseWithTestTemplate
  robot -d ./results .\testCase\validarTestTemplate.robot
```
E devera aparecer a seguinte saída:
```robotframework
==============================================================================
validarTestTemplate
==============================================================================
Scenario Outline 01 - Validar response das informações do produto ... | PASS |
------------------------------------------------------------------------------
validarTestTemplate                                                   | PASS |
1 test, 1 passed, 0 failed
==============================================================================
```
