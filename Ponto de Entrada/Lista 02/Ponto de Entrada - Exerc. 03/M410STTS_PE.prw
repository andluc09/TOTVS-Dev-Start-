#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function M410STTS
    Lista 02: Pontos de Entrada - Exerc�cio 03
    @type  Function
    @author Andr� Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
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
