#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function REL_CABEC
    Lista 09 - PSAY | Exercício 02
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
/*/

User Function REL_CABEC()

    Private cTitulo   := 'Descrição Genérica do Produto'
    Private cNomeReal := 'REL_PRDT'
    Private cAlias    := 'SB1'
    Private cProgram  := 'REL_PRDT'
    Private cDesc1    := 'Exemplo de relatório'
    Private cDesc2    := 'usando a tabela SB1,'
    Private cDesc3    := 'fonte REL_PRDT'
    Private cSize     := 'M'
    Private cCabec1   := "   Código               Descrição                     Un. Med.       Preço           Armazém "
    Private cCabec2   := ""
    Private M_PAG     := 1
    Private aReturn   := {'Zebrado', 1, 'Administração', 1, 2, '', '', 1}
    Private cNomeRel  := SetPrint(cAlias, cProgram, '', @cTitulo, cDesc1, cDesc2, cDesc3, .F., NIL, .T., cSize, NIL, .F.)

    //?cNomeReal := SetPrint('SB1', 'REL_PRDT', '', @cTitulo, 'Exemplo de relatório', 'usando a tabela SB1', ', fonte REL_PRDT', .F., NIL, .T., 'M', NIL, .F.)

    SetDefault(aReturn, cAlias)

    RptStatus({|| Imprime()}, cTitulo, 'Gerando relatório...')

Return 

Static Function Imprime()

    Local nLinha     := 8
    Local cTraco     := Replicate('_', 132)
    Local aColunas   := {}

    //* Colunas da impressão
	Aadd(aColunas, 005)
	Aadd(aColunas, 026)
	Aadd(aColunas, 057)
	Aadd(aColunas, 071)
	Aadd(aColunas, 088)

    DBSelectArea('SB1')
    SB1->(DBSetOrder(1))

    Cabec(cTitulo,cCabec1,cCabec2,cProgram,cSize)

    while !EOF()

        @nLinha, aColunas[1] PSAY PADR(AllTrim(SB1->B1_COD), 20) 
        @nLinha, aColunas[2] PSAY PADR(AllTrim(SB1->B1_DESC), 20) 
        @nLinha, aColunas[3] PSAY PADR(AllTrim(SB1->B1_UM), 20) 

        if(!Empty(SB1->B1_PRV1))
            @nLinha, aColunas[4] PSAY PADR('R$ ' + StrTran(CValToChar(NoRound(SB1->B1_PRV1,2)),".",","), 20)             
        else
            @nLinha, aColunas[4] PSAY PADR('R$ 00,00', 20)
        endif

        @nLinha, aColunas[5] PSAY PADR(AllTrim(SB1->B1_LOCPAD), 20)
        @++nLinha, 00 PSAY cTraco + CRLF

        SB1->(DBSkip()) 

    enddo

    SET DEVICE TO SCREEN

    if aReturn[5] == 1
        SET PRINTER TO DBCOMMITALL()
        OurSpool(cNomeReal)
    endif

    MS_FLUSH()

Return
