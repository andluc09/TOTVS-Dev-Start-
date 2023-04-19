#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

#DEFINE AZUL RGB(000, 125, 255)

/*/{Protheus.doc} User Function RelProdt
    Lista 10 - TReport | Exerc�cio 01
    @type  Function
    @author Andr� Lucas M. Santos
    @since 15/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/TReport
    @see https://tdn.totvs.com/display/public/framework/TRCell
/*/

//? Fun��o Principal
User Function RelProdt()

    Local oReport := GeraReport()

    //? Exibi tela respons�vel pela configura��o de impress�o
    oReport:PrintDialog()

Return

//? Se��o de Apresenta��o dos Dados
Static Function GeraReport()

    Local cAlias   := GetNextAlias()
    Local oRel     := NIL
    Local oSection := NIL 

    //? Criando o objeto do RELAT�RIO (Folha de papel)
    oRel:= TReport():New('TREPORT', 'Relat�rio de Produtos', /**/, {|oRel| Imprime(oRel, cAlias)}, 'Esse relat�rio imprimir� todos os cadastros de produtos.', .F.)

    //? Criando o objeto da se��o (Ret�ngulos dentro da folha)
    oSection := TRSection():New(oRel, 'Cadastro de Produtos', /*Table*/, /*Order*/)

    //? Coluna C�digo
    TRCell():New(oSection, 'B1_COD', 'SB1', 'C�digo', /*Picture*/, 9, /*Pixel*/, /*Bloco de C�digo*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Descri��o
    TRCell():New(oSection, 'B1_DESC', 'SB1', 'Descri��o', /*Picture*/, 25, /*Pixel*/, /*Bloco de C�digo*/, 'LEFT', .T., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Unidade de Medida
    TRCell():New(oSection, 'B1_UM', 'SB1', 'Un. Med.', /*Picture*/, 4, /*Pixel*/, /*Bloco de C�digo*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Pre�o de Venda
    TRCell():New(oSection, 'B1_PRV1', 'SB1', 'Pre�o', /*Picture*/, 10, /*Pixel*/, /*Bloco de C�digo*/, 'LEFT', .T., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Armaz�m
    TRCell():New(oSection, 'B1_LOCPAD', 'SB1', 'Armaz�m', /*Picture*/, 4, /*Pixel*/, /*Bloco de C�digo*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

Return oRel

//? Se��o Impress�o
Static Function Imprime(oRel, cAlias)

    Local oSection := oRel:Section(1)
    Local nTotReg  := 0
    Local cQuery   := GeraQuery()

    DBUseArea(.T., 'TOPCONN', TCGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)

    Count TO nTotReg

    oRel:SetMeter(nTotReg)

    oRel:SetTitle('Relat�rio de Produtos')

    oRel:StartPage()

    oSection:Init()

    (cAlias)->(DBGoTop())

    while (cAlias)->(!EOF())
        if oRel:Cancel()
            Exit
        endif

        oSection:Cell('B1_COD'):SetValue((cAlias)->(B1_COD))
        oSection:Cell('B1_DESC'):SetValue((cAlias)->(B1_DESC))
        oSection:Cell('B1_UM'):SetValue((cAlias)->(B1_UM))
        //oSection:Cell('B1_PRV1'):SetValue((cAlias)->(B1_PRV1))

        if!Empty((cAlias)->(B1_PRV1))
            oSection:Cell('B1_PRV1'):SetType('R$ 0,00')
        endif

        oSection:Cell('B1_LOCPAD'):SetValue((cAlias)->(B1_LOCPAD))

        oSection:PrintLine()

        oRel:ThinLine()

        oRel:IncMeter()

        (cAlias)->(DBSkip())
    enddo

    (cAlias)->(DBCloseArea())

    oSection:Finish()

    oRel:EndPage()

Return

//? Fun��o de Consulta
Static Function GeraQuery()

    Local cQuery := ''

    cQuery := 'SELECT DISTINCT B1_COD, B1_DESC, B1_UM, B1_PRV1, B1_LOCPAD ' + CRLF
    cQuery += ' FROM ' + RetSQLName('SB1') + ' AS SB1 ' + CRLF
    cQuery += " WHERE SB1.D_E_L_E_T_ = '' "

Return cQuery

