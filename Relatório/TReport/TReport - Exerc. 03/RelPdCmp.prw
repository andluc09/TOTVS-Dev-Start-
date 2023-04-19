#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

#DEFINE AZUL RGB(000, 125, 255)

/*/{Protheus.doc} User Function RelPdCmp
    Lista 10 - TReport | Exercício 03
    @type  Function
    @author André Lucas M. Santos
    @since 15/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/TReport
    @see https://tdn.totvs.com/display/public/framework/TRCell
/*/

//? Função Principal
User Function RelPdCmp()

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
    oRel:= TReport():New('TREPORT', 'Relatório de Pedido de Compra', /**/, {|oRel| Imprime(oRel, cAlias)}, 'Esse relatório imprimirá todos as informações de Pedido de Compra.', .F.)

    //? Criando o objeto da seção (Retângulos dentro da folha)
    oSection1 := TRSection():New(oRel, 'Cadastro de Pedido de Compra', /*Table*/, /*Order*/)
    oSection2 := TRSection():New(oSection1, 'Itrens do Pedido de Compra', /*Table*/, /*Order*/)

//? Pedidos de Compra

    //? Coluna Númeo do Pedido
    TRCell():New(oSection1, 'C7_NUM', 'SC7', 'Nº Pedido', /*Picture*/, 8, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Data de Emissão
    TRCell():New(oSection1, 'C7_EMISSAO', 'SC7', 'Dta Emissão', /*Picture*/, 14, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Código do Fornecedor
    TRCell():New(oSection1, 'C7_FORNECE', 'SC7', 'Cod. Fornecedor', /*Picture*/, 8, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Loja do Fornecedor
    TRCell():New(oSection1, 'C7_LOJA', 'SC7', 'Loja Fornecedor', /*Picture*/, 7, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Condição de Pagamento
    TRCell():New(oSection1, 'C7_COND', 'SC7', 'Condição de Pagamento', /*Picture*/, 7, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

//? Itens do Pedido de Compra

    //? Coluna Código do Produto
    TRCell():New(oSection2, 'C7_PRODUTO', 'SC7', 'Cod. Produto', /*Picture*/, 8, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Descrição do Produto
    TRCell():New(oSection2, 'C7_DESCRI', 'SC7', 'Descri. Produto', /*Picture*/, 30, /*Pixel*/, /*Bloco de Código*/, 'LEFT', .F., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Quantidade Vendida
    TRCell():New(oSection2, 'C7_QUANT', 'SC7', 'Qtd. Vendida', /*Picture*/, 5, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Valor Unitário
    TRCell():New(oSection2, 'C7_PRECO', 'SC7', 'Valor Unitário', /*Picture*/, 11, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Valor Total
    TRCell():New(oSection2, 'C7_TOTAL', 'SC7', 'Valor Total', /*Picture*/, 11, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

Return oRel

//? Seção Impressão
Static Function Imprime(oRel, cAlias)

    Local oSection1 := oRel:Section(1)
    Local oSection2 := oSection1:Section(1)
    Local nTotReg   := 0
    Local cQuery    := GeraQuery()

    DBUseArea(.T., 'TOPCONN', TCGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)

    Count TO nTotReg

    oRel:SetMeter(nTotReg)

    oRel:SetTitle('Relatório de Pedido de Compra')

    oRel:StartPage()

    oSection1:Init()

    (cAlias)->(DBGoTop())

    oSection1:Cell('C7_NUM'):SetValue((cAlias)->(C7_NUM))
    oSection1:Cell('C7_EMISSAO'):SetValue((cAlias)->(C7_EMISSAO))
    oSection1:Cell('C7_FORNECE'):SetValue((cAlias)->(C7_FORNECE))
    oSection1:Cell('C7_LOJA'):SetValue((cAlias)->(C7_LOJA))
    oSection1:Cell('C7_COND'):SetValue((cAlias)->(C7_COND))

    oSection1:PrintLine()

    while (cAlias)->(!EOF())
        if oRel:Cancel()
            Exit
        endif

        oSection2:Init()

        oSection2:Cell('C7_PRODUTO'):SetValue((cAlias)->(C7_PRODUTO))
        oSection2:Cell('C7_DESCRI'):SetValue((cAlias)->(C7_DESCRI))
        oSection2:Cell('C7_QUANT'):SetValue((cAlias)->(C7_QUANT))
        oSection2:Cell('C7_PRECO'):SetValue((cAlias)->(C7_PRECO))
        oSection2:Cell('C7_TOTAL'):SetValue((cAlias)->(C7_TOTAL))

        oSection2:PrintLine()

        oRel:ThinLine()

        oRel:IncMeter()

        (cAlias)->(DBSkip())

    enddo

    (cAlias)->(DBCloseArea())

    oSection2:Finish()

    oSection1:Finish()

    oRel:EndPage()

Return

//? Função de Consulta
Static Function GeraQuery()

    Local cQuery := ''

    cQuery := 'SELECT DISTINCT C7_NUM, C7_EMISSAO, C7_FORNECE, C7_LOJA, C7_COND, C7_PRODUTO, C7_DESCRI, C7_QUANT, C7_PRECO, C7_TOTAL' + CRLF
    cQuery += ' FROM ' + RetSQLName('SC7') + ' AS SC7 ' + CRLF
    cQuery += " WHERE SC7.D_E_L_E_T_ = '' AND SC7.C7_NUM = '" + SC7->C7_NUM + "' "

Return cQuery
