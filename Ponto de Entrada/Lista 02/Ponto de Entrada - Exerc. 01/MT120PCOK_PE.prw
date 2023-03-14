#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 2 - Lista: Pontos de Entrada
/*/

User Function  MT120LOK()

    Local nPosC7_TES   := aScan(aHeader,{|x| AllTrim(x[2]) == 'C7_TES'})
    Local lValido   := .T.

    if Empty(aCols[n][nPosC7_TES])     
        FWAlertErro('Campo Tipo de Entrada (TES de entrada) n�o foi preenchido!', 'ERRO')         
        lValido := .F.     
    endif

Return(lValido) 

