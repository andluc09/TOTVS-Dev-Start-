#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MT120LOK
    Lista 02: Pontos de Entrada - Exerc�cio 01
    @type  Function
    @author Andr� Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function  MT120LOK()

    Local nPosC7_TES   := aScan(aHeader,{|x| AllTrim(x[2]) == 'C7_TES'})
    Local lValido   := .T.

    if Empty(aCols[n][nPosC7_TES])     
        FWAlertErro('Campo Tipo de Entrada (TES de entrada) n�o foi preenchido!', 'ERRO')         
        lValido := .F.     
    endif

Return(lValido) 
