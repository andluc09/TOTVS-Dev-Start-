#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
/*/

User Function BloqCliente()
    
    Local aArea       := GetArea()
    Local aAreaSA1    := SA1->(GetArea())

    RecLock('SA1', .F.)
        SA1->A1_MSBLQL := "1"
    SA1->(MSUnlock())

    RestArea(aArea)
    RestArea(aAreaSA1)

Return 
