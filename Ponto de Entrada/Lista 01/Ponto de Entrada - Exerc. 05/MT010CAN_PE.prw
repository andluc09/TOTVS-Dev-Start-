#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 1 - Lista: Pontos de Entrada
/*/

User Function MT010CAN()
    
    Local nOp := PARAMIXB[1]

    if(INCLUI == .T.) .AND. (nOp == 1)
        if ExistBlock('BloqProduto')
            ExecBlock('BloqProduto', .F., .F.)
        endif
    endif

Return 
