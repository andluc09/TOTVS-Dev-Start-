#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function REL_PRDT
    Lista 09 - PSAY | Exercício 01 
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
/*/

User Function REL_PRDT()

    Private cTitulo     := 'Descrição Genérica do Produto'
    Private cNomeReal := 'REL_PRDT'
    Private cAlias    := 'SB1'
    Private cProgram  := 'REL_PRDT'
    Private cDesc1    := 'Exemplo de relatório'
    Private cDesc2    := 'usando a tabela SB1,'
    Private cDesc3    := 'fonte REL_PRDT'
    Private cSize     := 'M'
    Private aReturn   := {'Zebrado', 1, 'Administração', 1, 2, '', '', 1}
    Private cNomeRel  := SetPrint(cAlias, cProgram, '', @cTitulo, cDesc1, cDesc2, cDesc3, .F., NIL, .T., cSize, NIL, .F.)

    //?cNomeReal := SetPrint('SB1', 'REL_PRDT', '', @cTitulo, 'Exemplo de relatório', 'usando a tabela SB1', ', fonte REL_PRDT', .F., NIL, .T., 'M', NIL, .F.)

    SetDefault(aReturn, cAlias)

    RptStatus({|| Imprime()}, cTitulo, 'Gerando relatório...')

Return 

Static Function Imprime()

    Local nLinha := 2

    DBSelectArea('SB1')
    SB1->(DBSetOrder(1))

    while !EOF()

        @++nLinha, 00 PSAY PADR('Código: ', 25) + AllTrim(SB1->B1_COD)

        @++nLinha, 00 PSAY PADR('Descrição: ', 25) + AllTrim(SB1->B1_DESC)

        @++nLinha, 00 PSAY PADR('Unidade de Medida: ', 25) + AllTrim(SB1->B1_UM)

        if(Empty(SB1->B1_PRV1))
            @++nLinha, 00 PSAY PADR('Preço de Venda: ', 25) + 'R$ 00,00'
        else
            @++nLinha, 00 PSAY PADR('Preço de Venda: ', 25) + 'R$ ' + StrTran(CValToChar(NoRound(SB1->B1_PRV1,2)),".",",")
        endif

        @++nLinha, 00 PSAY PADR('Armazém: ', 25) + AllTrim(SB1->B1_LOCPAD)

        @++nLinha, 00 PSAY Replicate('_', 132) + CRLF

        SB1->(DBSkip()) 

    enddo

    SET DEVICE TO SCREEN

    if aReturn[5] == 1
        SET PRINTER TO DBCOMMITALL()
        OurSpool(cNomeReal)
    endif

    MS_FLUSH()

Return
