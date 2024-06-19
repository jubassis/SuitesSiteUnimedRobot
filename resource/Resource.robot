*** Settings ***
Library               SeleniumLibrary

*** Variables ***
${BROWSER}            chrome
${URL}                https://www.unimed.coop.br/

*** Keyword ***
### Setup e Teardowon ###
Abrir o navegador
    Open Browser    browser=${BROWSER}

Fechar navegador
    Close All Browsers


###Caso de Teste 01 - Validar apresentação de resultados com a Especilidade e resultado
### Passo a Passo -
Dado que eu estou logado no site Unimed
    Go To    ${URL}
    Title Should Be    Portal Nacional de Saúde - Unimed - Institucional

Quando eu acessar o guia médico
    #Clicar no botão do site inicial "Guia Médico"
    Click Link    /guia-medico
    Wait Until Page Contains     REDE ASSISTENCIAL

E pesquisar pela especialidade "${especilidade}" para o estado "${estado}" e cidade "${cidade}"
    #Informar todas as informações necessárias
    Input Text      name=pesquisa     ${especilidade}
    Click Button    id=btn_pesquisar
    Wait Until Page Contains    Selecione o estado e a cidade para localizar a Unimed onde você deseja ser atendido
    Wait Until Element Is Visible    xpath=//div[@class='s-field control-group selecione-rede big-field pesquisa-avancada']
    Click Element   xpath=//div[@class='s-field control-group selecione-rede big-field pesquisa-avancada']
    Press Keys      None  ${estado}
    Press Keys      None  RETURN
    Sleep           5s
    Click Element   xpath=//div[contains(@class,'-placeholder')][contains(.,'Cidade')]
    Press Keys      None  ${cidade}
    Press Keys      None  RETURN
    Sleep           1s
    Wait Until Page Contains    Essa região é atendida pelas Unimeds abaixo. Selecione a de sua preferência:

E selecionar a opção "${unimed}"
    #Escolher a UNIMED
    Page Should Contain Radio Button    xpath=//input[contains(@type,'radio')]
    Click Element    xpath=//input[contains(@type,'radio')]

E confirmar a pesquisa
    #Apertar Continuar
    Click Button    xpath=//button[@class='btn btn-success']


    Então sistema deve apresentar os resultados corretamente
        #Conferir os nomes dos médicos conforme resultado
        Wait Until Page Contains    JORGE LUIS OLIVEIRA AJUB (CRM 40266)   timeout=15s
        Page Should Contain    JORGE LUIS OLIVEIRA AJUB (CRM 40266)
        Page Should Contain    MARIA DE LOURDES GOULART BASTOS (CRM 321720)

        #Fechar navegador
        Close All Browsers
