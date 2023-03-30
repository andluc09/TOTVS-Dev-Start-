#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function VerticalTXT
    Lista BD - Exercício 16
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
    @see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=24347107
/*/

//? F
//? U
//? L
//? A
//? N
//? O

User Function VerticalTXT()

    Local cNome   := ''
    Local cTexto  := ''
    Local nCont   := 0

    cNome := UPPER(FWInputBox(' Insira seu nome: ' , ' Digite aqui.. '))

    for nCont := 1 to LEN(cNome)
        cTexto += (SUBSTR(cNome, nCont, 1) + CRLF)
    next nCont

    FWAlertInfo(cTexto, 'Nome Invertido: ')

Return 
