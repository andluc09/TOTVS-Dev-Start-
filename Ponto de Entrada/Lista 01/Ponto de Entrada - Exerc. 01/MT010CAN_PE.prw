#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MT010CAN
    Lista 01: Pontos de Entrada - Exercício 01
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function MT010CAN()
    
    Local nOp := PARAMIXB[1]

    if (INCLUI .OR. ALTERA) .AND. (nOp == 1)
        if ExistBlock('InclAltrCadast')
            ExecBlock('InclAltrCadast', .F., .F.)
        endif
    endif

Return  
