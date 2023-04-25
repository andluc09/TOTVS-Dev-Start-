#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

#DEFINE AZUL RGB(000, 125, 255)

/*/{Protheus.doc} User Function RelPdVnd
    Lista 10.2 - TReport | Exercício 01
    @type  Function
    @author André Lucas M. Santos
    @since 20/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/TReport
    @see https://tdn.totvs.com/display/public/framework/TRCell
    @see https://tdn.totvs.com/display/public/framework/TRBreak
    @see https://tdn.totvs.com/display/public/framework/TRFunction
/*/

//? Função Principal
User Function RelPdVnd()

    Local oReport := GeraReport()

    //? Exibi tela responsável pela configuração de impressão
    oReport:PrintDialog()

Return

//? Seção de Apresentação dos Dados
Static Function GeraReport()

    Local cAlias   := GetNextAlias()
    Local oRel     := NIL
    Local oSection1 := NIL 
    Local oSection2 := NIL 

    //? Criando o objeto do RELATÓRIO (Folha de papel)
    oRel:= TReport():New('TREPORT', 'Relatório de Pedido de Venda', /**/, {|oRel| Imprime(oRel, cAlias)}, 'Esse relatório imprimirá as informações do Pedido de Venda selecionado.', .F.)

    //? Criando o objeto da seção (Retângulos dentro da folha)
    oSection1 := TRSection():New(oRel, 'Cadastro de Pedido de Venda', /*Table*/, /*Order*/)
    oSection2 := TRSection():New(oSection1, 'Itens do Pedido de Venda', /*Table*/, /*Order*/)

//? Pedidos de Compra

    //? Coluna Númeo do Pedido
    TRCell():New(oSection1, 'C5_NUM', 'SC5', 'Nº Pedido', /*Picture*/, 8, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Nome do Cliente
    TRCell():New(oSection1, 'A1_NOME', 'SA1', 'Nome Cliente', /*Picture*/, 25, /*Pixel*/, /*Bloco de Código*/, 'LEFT', .T., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Data de Emissão
    TRCell():New(oSection1, 'C5_EMISSAO', 'SC5', 'Dta Emissão', /*Picture*/, 8, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Descrição da Condição de Pagamento
    TRCell():New(oSection1, 'E4_DESCRI', 'SE4', 'Cond. Pagamento', /*Picture*/, 20, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

//? Itens do Pedido de Compra

    //? Coluna Nº do Item
    TRCell():New(oSection2, 'C6_ITEM', 'SC7', 'Nº Item', /*Picture*/, 8, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Código do Produto
    TRCell():New(oSection2, 'C6_PRODUTO', 'SC7', 'Cod. Produto', /*Picture*/, 8, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Descrição do Produto
    TRCell():New(oSection2, 'C6_DESCRI', 'SC7', 'Descri. Produto', /*Picture*/, 30, /*Pixel*/, /*Bloco de Código*/, 'LEFT', .T., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Quantidade Vendida
    TRCell():New(oSection2, 'C6_QTDVEN', 'SC7', 'Qtd. Vendida', /*Picture*/, 5, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Valor Unitário
    TRCell():New(oSection2, 'C6_PRCVEN', 'SC7', 'Valor Unitário', /*Picture*/, 10, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Valor Total
    TRCell():New(oSection2, 'C6_VALOR', 'SC7', 'Valor Total', /*Picture*/, 10, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    oBreak := TRBreak():New(oSection1, oSection1:Cell('C5_NUM'), , .T.)

	//? Faz a soma de todos os valores da coluna 'TOTAL'
	TRFunction():New(oSection2:Cell('C6_VALOR'), 'VALTOT', 'SUM', oBreak, 'VALOR TOTAL',,, .F., .F., .F.) 

Return oRel

//? Seção Impressão
Static Function Imprime(oRel, cAlias)

    Local oSection1 := oRel:Section(1)
    Local oSection2 := oSection1:Section(1)
    Local nTotReg   := 0
    Local cQuery    := GeraQuery()
    Local cPedFinal := ''

    DBUseArea(.T., 'TOPCONN', TCGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)

    Count TO nTotReg

    oRel:SetMeter(nTotReg)

    oRel:SetTitle('Relatório do Pedido de Venda')

    oRel:StartPage()

    (cAlias)->(DBGoTop())

    while (cAlias)->(!EOF())
        if oRel:Cancel()
            Exit
        endif

        if AllTrim(cPedFinal) <> AllTrim((cAlias)->(C5_NUM))

            if !Empty(cPedFinal)
                oSection2:Finish() //? Finaliza Seção 2
                oSection1:Finish() //? Finaliza Seção 1
                oRel:EndPage(.T.)  //? Finaliza a página na impressão (se True imprime rodapé na finalização da página)
			endif

            oSection1:Init()

            oSection1:Cell('C5_NUM'):SetValue((cAlias)->(C5_NUM))
            oSection1:Cell('A1_NOME'):SetValue((cAlias)->(A1_NOME))
            oSection1:Cell('C5_EMISSAO'):SetValue(DToC(StoD((cAlias)->(C5_EMISSAO))))
            oSection1:Cell('E4_DESCRI'):SetValue((cAlias)->(E4_DESCRI))

            cPedFinal := ((cAlias)->(C5_NUM))

            oSection1:PrintLine()

        endif

        oSection2:Init()

        oSection2:Cell('C6_ITEM'):SetValue((cAlias)->(C6_ITEM))
        oSection2:Cell('C6_PRODUTO'):SetValue((cAlias)->(C6_PRODUTO))
        oSection2:Cell('C6_DESCRI'):SetValue((cAlias)->(C6_DESCRI))
        oSection2:Cell('C6_QTDVEN'):SetValue((cAlias)->(C6_QTDVEN))
        oSection2:Cell('C6_PRCVEN'):SetValue((cAlias)->(C6_PRCVEN))
        oSection2:Cell('C6_VALOR'):SetValue((cAlias)->(C6_VALOR))

        oSection2:PrintLine()

        oRel:SkipLine(1)

        oRel:ThinLine()

        oRel:IncMeter()

        (cAlias)->(DBSkip())

    enddo

    (cAlias)->(DBCloseArea())

    oSection2:Finish()
    oSection1:Finish()

    oRel:SkipLine(1)

    oRel:EndPage()

Return

//? Função de Consulta
Static Function GeraQuery()

    Local cQuery := ''

    cQuery := 'SELECT DISTINCT C5_NUM, C5_EMISSAO, A1_NOME, E4_DESCRI, C6_ITEM, C6_PRODUTO, C6_DESCRI, C6_QTDVEN, C6_PRCVEN, C6_VALOR ' + CRLF
    cQuery += ' FROM ' + RETSQLNAME('SC5') + ' AS SC5 ' + CRLF
    cQuery += " INNER JOIN  " + RETSQLNAME('SE4') + " AS SE4 ON SE4.E4_CODIGO = SC5.C5_CONDPAG  " + CRLF    
    cQuery += " INNER JOIN  " + RETSQLNAME('SA1') + " AS SA1 ON SA1.A1_COD = SC5.C5_CLIENTE " + CRLF    
    cQuery += " INNER JOIN  " + RETSQLNAME('SC6') + " AS SC6 ON SC6.C6_NUM = SC5.C5_NUM " + CRLF    
    cQuery += " WHERE SC5.D_E_L_E_T_ = '' AND SE4.D_E_L_E_T_ = '' AND SA1.D_E_L_E_T_ = '' AND SC5.D_E_L_E_T_ = '' " + CRLF
    cQuery += " AND SC5.C5_NUM = '" + AllTrim(SC5->C5_NUM) + "' "

Return cQuery
