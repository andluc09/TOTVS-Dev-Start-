#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function InclAltrCadast
    Lista 01: Pontos de Entrada - Exercício 09
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
/*/

User Function InclAltrCadast()
    
    Local aArea       := GetArea()
    Local aAreaSB1    := SB1->(GetArea())
    Local cTexto      := 'Cad Manual - '
    Local cTextoFinal := cTexto + SB1->B1_DESC

    RecLock('SB1', .F.)
        SB1->B1_DESC := cTextoFinal
    SB1->(MSUnlock())

    RestArea(aArea)
    RestArea(aAreaSB1)

Return 
