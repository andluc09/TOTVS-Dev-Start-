#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
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
