#INCLUDE 'TOTVS.CH'

User Function MA410MNU()

    Local aArea := GetArea()

    AADD(aRotina,{"Relat�rio pedido selecionado","U_RelPdVnd", 0 , 6, 0 , NIL})

    RestArea(aArea)

Return
