#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 2 - Lista: Pontos de Entrada
/*/

User Function M410STTS()

Local nOper     := PARAMIXB[1]
Local cPedido   := SC5->C5_NUM

    if (nOper == 3 .OR. nOper == 4)  //3 - Inclusão, 4 - Alteração
        if ExistBlock('InclAltrPedVend')
            ExecBlock('InclAltrPedVend', .F., .F., cPedido)
        endif
    endif

Return 
