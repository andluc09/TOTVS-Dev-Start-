#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function InclAltrCadast
    Lista 02: Pontos de Entrada - Exercício 03
    @type  Function
    @author André Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function InclAltrCadast()
    
    Local aArea       := GetArea()
    Local aAreaSC5    := SC5->(GetArea())  
    Local aAreaSC6    := SC6->(GetArea())    
    Local cTexto      := 'Inc. PE - '
    Local cPedido     := PARAMIXB
    Local cTextoFinal := cTexto + SC6->C6_DESCRI

    DBSelectArea('SC6') 
    DBSetOrder(1)

    if(DBSeek(xFilial('SC6') + cPedido))
        while(SC6->C6_NUM == cPedido)
            RecLock('SC6', .F.)
                SC6->C6_DESCRI := cTextoFinal
            SC6->(MSUnlock())

            SC6->(DBSkip())
        enddo
    endif

    SC6->(DbCloseArea())

    RestArea(aArea)
    RestArea(aAreaSC5)    
    RestArea(aAreaSC6)

Return 
