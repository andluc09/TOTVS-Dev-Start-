#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function BloqProduto
    Lista 01: Pontos de Entrada - Exercício 05
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
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
