#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function EscadaTXT
    Lista BD - Exercício 18
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
    @see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=24347107
/*/

//? F
//? FU
//? FUL
//? FULA
//? FULAN
//? FULANO

User Function EscadaTXT()

    Local cNome     := ''
    Local cTexto    := ''
    Local cEscada   := ''
    Local nCont     := 0

    cNome := UPPER(FWInputBox(' Insira seu nome: ' , ' Digite aqui.. '))

    for nCont := 1 to LEN(cNome)
        cTexto += SUBSTR(cNome, nCont, 1)
        cEscada += cTexto + CRLF
    next nCont

    FWAlertInfo(cEscada , ' Nome em escada: ')

Return 
