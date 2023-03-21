#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MA410LEG
    Lista 01: Pontos de Entrada - Exercício 04
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function MA410LEG()

    Local aLeg := PARAMIXB

    Alert("MA410LEG")

    aLeg := { {'CHECKOK' ,"Pedido de Venda em aberto"},;
    {'BR_CANCEL' ,"Pedido de Venda encerrado"},;
    {'GCTPIMSE',"Pedido de Venda liberado" },;
    {'BR_AZUL' ,"Pedido Bloqueado por Regra"},;
    {'BR_LARANJA',"Pedido Bloqueado por Verba" }}

Return aLeg
