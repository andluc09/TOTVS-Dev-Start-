#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MT010CAN
    Lista 01: Pontos de Entrada - Exercício 05
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function MT010CAN()
    
    Local nOp := PARAMIXB[1]

    if(INCLUI == .T.) .AND. (nOp == 1)
        if ExistBlock('BloqProduto')
            ExecBlock('BloqProduto', .F., .F.)
        endif
    endif

Return 
