*** Settings ***
Documentation    Automação De Back End na ViaCEP
Library          SeleniumLibrary
Library          BuiltIn
Library          RequestsLibrary
Library          Collections
Library          String
Variables        variables-back.yaml

*** Keywords ***
Abertura de Sessão ViaCEP
    Create Session    viacep    ${BASE_URL}
Validar CEP Correto
    [Arguments]    ${cep}
    ${resp}=    GET On Session    viacep    /${cep}/json/
    Should Be Equal As Strings    ${resp.status_code}    200
    Dictionary Should Contain Key    ${resp.json()}    logradouro
    Dictionary Should Contain Key    ${resp.json()}    bairro
    Dictionary Should Contain Key    ${resp.json()}    localidade
    Dictionary Should Contain Key    ${resp.json()}    estado
    Dictionary Should Contain Key    ${resp.json()}    uf

Validar CEP Incorreto
    [Arguments]    ${cep}
    ${resp}=    GET On Session    viacep    /${cep}/json/
    Should Be Equal As Strings    ${resp.status_code}    200
    Dictionary Should Contain Item    ${resp.json()}    erro    true

Validar CEP com Formato Incorreto
    [Arguments]    ${cep}
    ${resp}=    GET On Session    viacep    /${cep}/json/    expected_status=400
    Should Be Equal As Strings    ${resp.status_code}    400

Validar CEP com Caracters Especiais
    [Arguments]    ${cep}
    ${resp}=    GET On Session    viacep    /${cep}/json/    expected_status=400
    Should Be Equal As Strings    ${resp.status_code}    400