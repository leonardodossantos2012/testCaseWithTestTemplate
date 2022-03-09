*** Settings ***
Library         RequestsLibrary
Library         JsonValidator

*** Variables ***
${URL}              http://localhost:3000
${MY_SCHEMA}

*** Keywords ***
Dado que leonardo efetuar um get na rota
    ${headers}=               Create Dictionary        Content-Type=application/json
    Create Session  data        ${URL}
    ${RESPOSTA}  Get on Session     data     ${URL}/data    headers=${headers}
    SET GLOBAL VARIABLE  ${RESPOSTA}

Então é retornado no response
    [ARGUMENTS]     ${NOME}  ${PRECO}
    Element should exist    ${RESPOSTA.json()}    .nome:contains("${NOME}")
    Element should exist    ${RESPOSTA.json()}    .preco:contains("${PRECO}")

E valido o schema da API
    Validate Jsonschema From File	  ${RESPOSTA.json()}   ${CURDIR}/JsonSchema.json