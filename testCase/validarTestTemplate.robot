*** Settings ***

Resource            ../resource/ValidarJsonServer.robot

*** Test Cases ***
Scenario Outline 01 - Validar response das informações do produto inserido no jsonServer
        [Template]      Scenario Outline 01 - Validar response das informações do produto inserido no jsonServer
        #NOME                       #PRECO
        Coca cola 600ml             7.5
        Refrigerantes               9.7