#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
/*/

User Function MT010CAN()
    
    Local nOp := PARAMIXB[1]

    if (INCLUI .OR. ALTERA) .AND. (nOp == 1)
        if ExistBlock('InclAltrCadast')
            ExecBlock('InclAltrCadast', .F., .F.)
        endif
    endif

Return  
