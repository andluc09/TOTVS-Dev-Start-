#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE 'REPORT.CH'

#DEFINE AZUL RGB(000, 125, 255)

/*/{Protheus.doc} User Function CdtForn
    Lista 10 - TReport | Exercício 02
    @type  Function
    @author André Lucas M. Santos
    @since 15/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/TReport
    @see https://tdn.totvs.com/display/public/framework/TRCell
/*/

//? Função Principal
User Function CdtForn()

    Local cAlias  := 'SA2'
    Local cTitle  := 'Cadastro de Fornecedores'
    Local oBrowse := NIL

    oBrowse := FWMBrowse():New() //* Criação da tela em MVC 

    oBrowse:AddButton('Relatório', {|| GeraForn()})

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)

    oBrowse:DisableDetails() //* Desabilitar a aba Detalhes
    oBrowse:DisableReport()  //* Desabilitar o botão Imprime Broswe

    oBrowse:Activate() //* Ativação da tela

Return

Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.CdtForn' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Cadastrar'    ACTION 'VIEWDEF.CdtForn' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.CdtForn' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.CdtForn' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local oModel   := NIL
    Local oStruSA2 := NIL

    oModel   := MPFormModel():New('CdtFornMVC')
    oStruSA2 := FWFormStruct(1, 'SA2')

    oModel:AddFields('SA2MASTER', /*OWNER*/, oStructureSA2)

    oModel:SetDescription('Modelo de Cadastro de Fornecedores')

    oModel:GetModel('SA2MASTER'):SetDescription('Formulário do Cadastro de Fornecedores')

    oModel:SetPrimaryKey({'SA2_COD'})

Return oModel

Static Function ViewDef()

    Local oModel   := NIL
    Local oStruSA2 := NIL
    Local oView    := NIL

    oModel   := FWLoadModel('CdtForn')
    oStruSA2 := FWFormStruct(2, 'SA2')

    oView:= FWFormView():New()

    oView:SetModel(oModel)

    oView:AddField('VIEW_SA2', oStruSA2, 'SA2MASTER')

    oView:CreateHorizontalBox('TELA', 100)

    oView:SetOwnerView('VIEW_SA2', 'TELA')

Return oView

Static Function GeraForn()

    Local oReport := GeraReport()

    //? Exibi tela responsável pela configuração de impressão
    oReport:PrintDialog()

Return

//? Seção de Apresentação dos Dados
Static Function GeraReport()

    Local cAlias   := GetNextAlias()
    Local oRel     := NIL
    Local oSection := NIL 

    //? Criando o objeto do RELATÓRIO (Folha de papel)
    oRel:= TReport():New('TREPORT', 'Relatório de Clientes', /**/, {|oRel| Imprime(oRel, cAlias)}, 'Esse relatório imprimirá todos os cadastros de clientes.', .F.)

    //? Criando o objeto da seção (Retângulos dentro da folha)
    oSection := TRSection():New(oRel, 'Cadastro de Clientes', /*Table*/, /*Order*/)

    //? Coluna Código
    TRCell():New(oSection, 'A2_COD', 'SA1', 'Código', /*Picture*/, 8, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .F., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Nome
    TRCell():New(oSection, 'A2_NOME', 'SA1', 'Razão Social', /*Picture*/, 25, /*Pixel*/, /*Bloco de Código*/, 'LEFT', .T., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Nome Fantasia
    TRCell():New(oSection, 'A2_NREDUZ', 'SA1', 'N. Fantasia', /*Picture*/, 20, /*Pixel*/, /*Bloco de Código*/, 'LEFT', .T., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Endereço
    TRCell():New(oSection, 'A2_END', 'SA1', 'Endereço', /*Picture*/, 30, /*Pixel*/, /*Bloco de Código*/, 'LEFT', .T., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Tipo
    TRCell():New(oSection, 'A2_TIPO', 'SA1', 'Tipo', /*Picture*/, 5, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna CNPJ/CPF	
    TRCell():New(oSection, 'A2_CGC', 'SA1', 'CNPJ/CPF', /*Picture*/, 15, /*Pixel*/, /*Bloco de Código*/, 'CENTER', .T., 'CENTER', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

    //? Coluna Limite Crédito
    TRCell():New(oSection, 'A2_LC', 'SA1', 'Lim. Credito', /*Picture*/, 15, /*Pixel*/, /*Bloco de Código*/, 'LEFT', .T., 'LEFT', /*Compat.*/, /*ColSpace*/, .T., /*Cor Fundo*/, AZUL, .T.)

Return oRel

//? Seção Impressão
Static Function Imprime(oRel, cAlias)

    Local oSection := oRel:Section(1)
    Local nTotReg  := 0
    Local cQuery   := GeraQuery()

    DBUseArea(.T., 'TOPCONN', TCGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)

    Count TO nTotReg

    oRel:SetMeter(nTotReg)

    oRel:SetTitle('Relatório de Clientes')

    oRel:StartPage()

    oSection:Init()

    (cAlias)->(DBGoTop())

    while (cAlias)->(!EOF())
        if oRel:Cancel()
            Exit
        endif

        oSection:Cell('A2_COD'):SetValue((cAlias)->(A2_COD))
        oSection:Cell('A2_NOME'):SetValue((cAlias)->(A2_NOME))
        oSection:Cell('A2_NREDUZ'):SetValue((cAlias)->(A2_NREDUZ))
        oSection:Cell('A2_END'):SetValue((cAlias)->(A2_END))
        oSection:Cell('A2_TIPO'):SetValue((cAlias)->(A2_TIPO))
        oSection:Cell('A2_CGC'):SetValue((cAlias)->(A2_CGC))
        oSection:Cell('A2_LC'):SetValue((cAlias)->(A2_LC))

        oSection:PrintLine()

        oRel:ThinLine()

        oRel:IncMeter()

        (cAlias)->(DBSkip())
    enddo

    (cAlias)->(DBCloseArea())

    oSection:Finish()

    oRel:EndPage()

Return

//? Função de Consulta
Static Function GeraQuery()

    Local cQuery := ''

    cQuery := 'SELECT DISTINCT A2_COD, A2_NOME, A2_NREDUZ, A2_END, A2_TIPO, A2_CGC, A2_LC' + CRLF
    cQuery += ' FROM ' + RetSQLName('SA2') + ' AS SA2 ' + CRLF
    cQuery += " WHERE SA2.D_E_L_E_T_ = '' "

Return cQuery
