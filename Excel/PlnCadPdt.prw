#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

//? Cores
#DEFINE VERMELHO '#ff2525'
#DEFINE CINZA    '#646264'

//? Alinhamento
#DEFINE LEFT    1 //* Pode colocar ESQUERDA
#DEFINE RIGHT   3 //* Pode colocar DIREITA
#DEFINE CENTER  2 //* Pode colocar CENTRO

//? Formatação
#DEFINE GERAL      1 //* Texto 
#DEFINE NUMERO     2 //* 1
#DEFINE MONETARIO  3 //* R$
#DEFINE DATETIME   4 //* 00/00/0000 - 00:00

/*/{Protheus.doc} User Function PlnCadPdt
    Lista 11 - Excel | Exercício 02
    @type  Function
    @author André Lucas 
    @since 24/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FWMsExcel
    @see https://tdn.totvs.com/display/public/framework/FWMsExcelEx
/*/

User Function PlnCadPdt()

    Local aArea    := GetArea()
    Local cQuery   := ''
    Private cAlias := GetNextAlias()

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := 'SELECT DISTINCT  B1_COD, B1_DESC, B1_TIPO, B1_UM, B1_PRV1, SB1.D_E_L_E_T_ AS DELET ' + CRLF
    cQuery += ' FROM ' + RETSQLNAME('SB1') + ' AS SB1 '

    TCQUERY cQuery ALIAS &(cAlias) NEW
    (cAlias)->(DbGoTop())

    if(cAlias)->(EOF()) //! Caso não  haja retorno!
        cAlias := ''
    endif

    RestArea(aArea)

    PlanImp()

    RESET ENVIRONMENT

Return

Static Function PlanImp()

    Local cPath      := 'C:\Users\André Lucas\OneDrive\Área de Trabalho\'
    Local cArq       := 'Planilha - Exercício 02.xls'
    Local cWorkSheet := 'Produtos'
    Local cTable     := 'Dados dos Produtos'
    Local cTexto     := ''
    Local oExcel     := FwMSExcelEx():New()

    //? Colunas

    oExcel:AddWorkSheet(cWorkSheet)
    oExcel:AddTable(cWorkSheet, cTable)
    oExcel:AddColumn(cWorkSheet, cTable, 'Código'             , LEFT,   GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Descrição'          , LEFT,   GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Tipo'               , CENTER, GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Unidade de Medida'  , CENTER, GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Preço de Venda'     , CENTER, MONETARIO)

//!_____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

    //? Estilização da Planilha

    oExcel:SetLineFont('Arial')
    oExcel:SetLineSizeFont(12)
    oExcel:SetLineBGColor('#007bff') //* BG Background (Fundo'')
    oExcel:SetLineFrColor('#000000') //* Cor da Fonte

    oExcel:Set2LineFont('Arial')
    oExcel:Set2LineSizeFont(12)
    oExcel:Set2LineBGColor('#00aeff') //* BG Background (Fundo'')
    oExcel:Set2LineFrColor('#000000') //* Cor da Fonte

    oExcel:SetHeaderFont('Arial')
    oExcel:SetHeaderSizeFont(12)
    oExcel:SetHeaderBold(.T.)
    oExcel:SetBgColorHeader('#5f9cca') //* BG Background (Fundo'')
    oExcel:SetFrColorHeader('#FFFFFF') //* Cor da Fonte

    oExcel:SetTitleFont('Arial')
    oExcel:SetTitleSizeFont(14)
    oExcel:SetTitleBold(.T.)
    oExcel:SetTitleBgColor('#FFFFFF') //* BG Background (Fundo'')
    oExcel:SetTitleFrColor('#5fcdc9') //* Cor da Fonte 

//!_____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

    //?Linhas

    DBSelectArea(cAlias)

    While (cAlias)->(!EOF())

        if ((cAlias)->(B1_PRV1)) == 0
            cTexto := '0,00'
        else
            cTexto := ((cAlias)->(B1_PRV1))
        endif

        if (((cAlias)->(DELET)) == '*')
            oExcel:SetCelFont('Arial')
            oExcel:SetCelSizeFont(12)
            oExcel:SetCelFrColor(VERMELHO)
            oExcel:SetCelBgColor(CINZA)
            oExcel:AddRow(cWorkSheet, cTable, {AllTrim((cAlias)->(B1_COD)), AllTrim((cAlias)->(B1_DESC)), AllTrim((cAlias)->(B1_TIPO)), AllTrim((cAlias)->(B1_UM)), cTexto}, {1, 2, 3, 4, 5})
        endif

        oExcel:AddRow(cWorkSheet, cTable, {AllTrim((cAlias)->(B1_COD)), AllTrim((cAlias)->(B1_DESC)), AllTrim((cAlias)->(B1_TIPO)), AllTrim((cAlias)->(B1_UM)), cTexto})

        DbSkip()

//!_____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

    Enddo

    oExcel:Activate() //* Ativação do Método

    oExcel:GetXMLFile(cPath + cArq)

    if ApOleClient('MSExcel') //* Verifica se está instalado o Excel no Sistema Operacional
        oExec := MsExcel():New()
        oExec:WorkBooks:Open(cPath + cArq) //? WorkBooks: Propriedade 
        oExec:SetVisible(.T.)
        oExec:Destroy()
    else
        FWAlertError('Excel não encontrado no Sistema Operacional!', 'Excel não econtrado')
    endif

    FWAlertSuccess('Arquivo gerado com sucesso!' + CRLF + CRLF + 'Arquivo salvo em: ' + cPath + cArq, 'Concluído!')

    oExcel:DeActivate() //* Desativação do Método

    DBCloseArea()

Return
