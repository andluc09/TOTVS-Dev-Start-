#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MA410MNU
    Lista 10.2 - TReport | Exerc�cio 01
    @type  Function
    @author Andr� Lucas M. Santos
    @since 20/04/2024
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function MA410MNU()

    Local aArea := GetArea()

    AADD(aRotina,{"Relat�rio pedido selecionado","U_RelPdVnd", 0 , 6, 0 , NIL})

    RestArea(aArea)

Return
