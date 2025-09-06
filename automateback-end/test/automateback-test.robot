*** Settings ***
Documentation    Automação De Back End na ViaCEP
Library          SeleniumLibrary
Resource         ../resources/automateback-resources.robot


*** Test Cases ***
Validar CEP Correto
    Abertura de Sessão ViaCEP
    Validar CEP Correto    53640083

Validar CEP Incorreto
    Abertura de Sessão ViaCEP
    Validar CEP Incorreto    00000000

Validar CEP com Formato Incorreto
    Abertura de Sessão ViaCEP
    Validar CEP com Formato Incorreto    5364578
    Validar CEP com Formato Incorreto    53645789855

Validar CEP com Caracters Especiais
    Abertura de Sessão ViaCEP
    Validar CEP com Caracters Especiais    536$5685