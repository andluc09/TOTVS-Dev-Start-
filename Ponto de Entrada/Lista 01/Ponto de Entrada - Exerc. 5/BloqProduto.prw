#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
/*/

User Function BloqProduto()
    
    Local aArea       := GetArea()
    Local aAreaSB1    := SB1->(GetArea())

    RecLock('SB1', .F.)
        SB1->B1_MSBLQL := "1"
    SB1->(MSUnlock())

    RestArea(aArea)
    RestArea(aAreaSB1)

Return 
