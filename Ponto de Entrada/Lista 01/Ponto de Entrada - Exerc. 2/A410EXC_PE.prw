#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 1 - Lista: Pontos de Entrada
/*/

User Function A410EXC()
    
    Local aArea    := GetArea()
    Local aAreaSC5 := SC5->(GetArea())
    Local lBloq    := .T.
    Local cTexto   := SC5->C5_INCLUI

    if (AllTrim(cTexto) == 'Autom�tico')
        lBloq := .F.
    endif

    RestArea(aArea)
    RestArea(aAreaSC5)
    
Return lBloq
