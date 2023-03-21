#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function BloqCliente
    Lista 01: Pontos de Entrada - Exercício 06
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
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
