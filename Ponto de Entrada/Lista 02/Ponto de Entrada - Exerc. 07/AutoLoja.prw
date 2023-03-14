#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
/*/

User Function AutoLoja()

    Local nNum    := StrZero(Randomize(1,9),2)
    Local oObj    := PARAMIXB
    Local oView   := NIL

    oObj  := FWModelActive()
    oObj:GetModel('SA2MASTER'):LoadValue('A2_LOJA', nNum)
    oView := FWViewActive()
    oView:Refresh() 

Return
