*** Settings ***
Documentation    Automação De Front End no kABUM
Library          SeleniumLibrary
Resource         ../resources/automatefront-resources.robot

*** Test Cases ***
[Setup]    Inicializar Ambientes 
    Realizar busca de produto    NOTEBOOK    ${URL}
    Consultar os valores de frete 
    Inserir o produto no carrinho 
    Definir o tipo de garantia extendida
    Validar o produto no carrinho
[Teardown]    Finalizar Teste     