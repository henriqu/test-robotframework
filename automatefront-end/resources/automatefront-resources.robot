*** Settings ***
Documentation    Automação De Front End no KABUM
Library          SeleniumLibrary
Library          BuiltIn
Variables        variables-front.yaml

*** Keywords ***
Inicializar Ambientes
    Open Browser    about:blank    ${BROWSER}    #options=add_argument("--headless")
    Maximize Browser Window
Finalizar Teste
    Close Browser
Realizar busca de produto
    [Arguments]    ${produto}    ${url}
    Log    Verificando se o produto ${produto} no site {url}
    Go to    ${url}

    #Tempo pra carregamento da página inicial
    Sleep    5s

    #Fechar a NewsLetter
    Click Element    xpath=//span[@class="ins-web-opt-in-reminder-close-button"]
    Sleep    2s

    #Aceitar os Cookies
    Click Element    onetrust-accept-btn-handler
    Sleep    3s

    #Realizar a validação do campo pesquisar, inserir as palavras uma por uma, pois é um autocomplete. E Clicar no botão Buscar.
    Wait Until Element Is Visible    ${SEARCH}    5s
    Click Element    ${SEARCH} 
    Press Keys    ${SEARCH}    n
    Sleep    0.1s
    Press Keys    ${SEARCH}    o
    Sleep    0.1s
    Press Keys    ${SEARCH}    t
    Sleep    0.1s
    Press Keys    ${SEARCH}    e
    Sleep    0.1s
    Press Keys    ${SEARCH}    b
    Sleep    0.1s
    Press Keys    ${SEARCH}    o
    Sleep    0.1s
    Press Keys    ${SEARCH}    o
    Sleep    0.1s
    Press Keys    ${SEARCH}    k
    Sleep    0.1s
    Click Element    ${BUTTON_SEARCH}
    Sleep    3s

    #Visualizar e Clicar no primeiro item da listavisualizar o primeiro produto da lista
    Wait Until Page Contains Element    xpath=//button[@data-testid="tooltip"]
    Go To    ${URL_GARANTIA}

    #Visualizar se está visivel o local para consultar o frete.
    Wait Until Element Is Visible    ${CONSULTE_FRETE}

Consultar os valores de frete
    #Nessa etapa irá validar se o campo CEP existe, existindo, irá preenhecer com um CEP pre definido e validar após ele carregar automaticamente.
    Wait Until Element Is Visible    ${CALCULAR_FRETE}
    Sleep    5s
    Click Element    ${CALCULAR_FRETE}
    Input Text    ${CALCULAR_FRETE}    ${CEP}
    Sleep    5s

Inserir o produto no carrinho
    #Inserindo o produto no carrinho após ele realizar a busca do CEP
    Wait Until Element Is Visible    ${BUTTON_COMPRAR}
    Click Element    ${BUTTON_COMPRAR}
    Sleep    5s
Definir o tipo de garantia extendida
    #Validar se os valores de 12 meses estão selecionados, caso estejam ir para a tela de resumo de pedido.
    Wait Until Element Is Visible    ${GARANTIA_ESTENTIDA}
    Wait Until Element Is Visible    ${ROUBO_FURTO}
    Radio Button Should Be Set To    garantia    4152720
    Radio Button Should Be Set To    seguro    4152722
    Wait Until Element Is Visible    ${BUTTON_ADICIONAR_SERVICO}
    Click Element    ${BUTTON_ADICIONAR_SERVICO}

Validar o produto no carrinho
    #Apenas validar se está na tela correta.
    Wait Until Element Is Visible    ${RESUMO_COMPRA}
    Wait Until Element Is Visible    ${VALOR_PRODUTOS}
    Wait Until Element Is Visible    ${SERVIÇOS_ADICIONAIS}