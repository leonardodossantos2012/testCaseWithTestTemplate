*** Settings ***
Resource            ../resource/ValidarJsonServer.robot

*** Test Cases ***
Scenario Outline 01 - Validar response das informações do produto inserido no jsonServer
    [Template]      Template Scenario Outline 01 - Validar response das informações do produto inserido no jsonServer
    #NOME                       #PRECO
    Coca cola 600ml             7.5
    Refrigerantes               9.7

*** Keywords ***
### Escrita do cenário em Gherkin
Template Scenario Outline 01 - Validar response das informações do produto inserido no jsonServer
    [ARGUMENTS]  ${NOME}  ${PRECO}
    Dado que leonardo efetuar um get na rota
    Então é retornado no response  ${NOME}  ${PRECO}
    E valido o schema da API
