#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MA410COR
    Lista 01: Pontos de Entrada - Exercício 03
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function MA410COR()

Local aCores := {} 

    Alert("MA410COR")

    aAdd(aCores, {"Empty(C5_LIBEROK).And.Empty(C5_NOTA) .And. Empty(C5_BLQ)", "CHECKOK", "Pedido em aberto"})
    aAdd(aCores, {"!Empty(C5_NOTA).Or.C5_LIBEROK=='E' .And. Empty(C5_BLQ)", "BR_CANCEL", "Pedido encerrado"})
    aAdd(aCores, {"!Empty(C5_LIBEROK).And.Empty(C5_NOTA).And. Empty(C5_BLQ)", "GCTPIMSE", "Pedido Liberado"})

Return aCores
