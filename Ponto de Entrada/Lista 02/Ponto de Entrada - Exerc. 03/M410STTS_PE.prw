#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 2 - Lista: Pontos de Entrada
/*/

User Function M410STTS()

Local nOper     := PARAMIXB[1]
Local cPedido   := SC5->C5_NUM

    if (nOper == 3 .OR. nOper == 4)  //3 - Inclus�o, 4 - Altera��o
        if ExistBlock('InclAltrPedVend')
            ExecBlock('InclAltrPedVend', .F., .F., cPedido)
        endif
    endif

Return 
