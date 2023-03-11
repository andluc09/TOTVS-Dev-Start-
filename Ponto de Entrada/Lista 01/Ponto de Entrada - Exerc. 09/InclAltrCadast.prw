#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
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
