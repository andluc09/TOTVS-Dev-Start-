#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function AutoLoja
    Lista 02: Pontos de Entrada - Exerc�cio 07
    @type  Function
    @author Andr� Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
/*/

User Function AutoLoja()

    Local nNum    := StrZero(Randomize(1,9),2)
    Local oObj    := PARAMIXB
    Local oView   := NIL

    oObj:GetModel('SA2MASTER'):LoadValue('A2_LOJA', cValToChar(nNum)) //Inst�ncia modelo ativo SA2
    oView := FWViewActive()
    oView:Refresh() 

Return
