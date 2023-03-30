#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function InvertNome
    Lista BD - Exercício 17
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
    @see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=24347107
/*/

User Function InvertNome()

    Local cTexto := ''
    Local nCont
    Local cInverte := ''

    cTexto := UPPER(FWInputBox(' Insira seu nome: ' , ' Digite aqui.. '))

    for nCont := LEN(cTexto) to 1 Step - 1
        cInverte += SUBSTR(cTexto, nCont, 1)
    next nCont

    FWAlertInfo(cInverte , ' Nome invertido: ')

Return 
