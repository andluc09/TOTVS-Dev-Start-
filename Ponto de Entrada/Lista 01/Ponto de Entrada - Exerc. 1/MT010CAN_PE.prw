#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 1 - Lista: Pontos de Entrada
/*/

User Function MT010CAN()
    
    Local nOp := PARAMIXB[1]

    if (INCLUI .OR. ALTERA) .AND. (nOp == 1)
        if ExistBlock('InclAltrCadast')
            ExecBlock('InclAltrCadast', .F., .F.)
        endif
    endif

Return  
