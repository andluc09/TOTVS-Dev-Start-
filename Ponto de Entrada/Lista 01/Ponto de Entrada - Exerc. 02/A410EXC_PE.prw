#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function A410EXC
    Lista 01: Pontos de Entrada - Exercício 02
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function A410EXC()
    
    Local aArea    := GetArea()
    Local aAreaSC5 := SC5->(GetArea())
    Local lBloq    := .T.
    Local cTexto   := SC5->C5_INCLUI

    if (AllTrim(cTexto) == 'Automático')
        lBloq := .F.
    endif

    RestArea(aArea)
    RestArea(aAreaSC5)
    
Return lBloq
