#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MA410MNU
    Lista 10.2 - TReport | Exercício 01
    @type  Function
    @author André Lucas M. Santos
    @since 20/04/2024
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function MA410MNU()

    Local aArea := GetArea()

    AADD(aRotina,{"Relatório pedido selecionado","U_RelPdVnd", 0 , 6, 0 , NIL})

    RestArea(aArea)

Return
