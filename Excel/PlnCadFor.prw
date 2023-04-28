#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

//? Alinhamento
#DEFINE LEFT    1 //* Pode colocar ESQUERDA
#DEFINE RIGHT   3 //* Pode colocar DIREITA
#DEFINE CENTER  2 //* Pode colocar CENTRO

//? Formatação
#DEFINE GERAL      1 //* Texto 
#DEFINE NUMERO     2 //* 1
#DEFINE MONETARIO  3 //* R$
#DEFINE DATETIME   4 //* 00/00/0000 - 00:00

/*/{Protheus.doc} User Function PlnCadFor
    Lista 11 - Excel | Exercício 01
    @type  Function
    @author André Lucas 
    @since 24/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FWMsExcel
    @see https://tdn.totvs.com/display/public/framework/FWMsExcelEx
/*/

User Function PlnCadFor()

    Local aArea    := GetArea()
    Local cQuery   := ''
    Private cAlias := GetNextAlias()

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'

    cQuery := 'SELECT DISTINCT A2_COD, A2_NOME, A2_LOJA, A2_CGC, A2_END, A2_BAIRRO, A2_MUN, A2_EST ' + CRLF
    cQuery += ' FROM ' + RETSQLNAME('SA2') + ' AS SA2 ' + CRLF
    cQuery += " WHERE SA2.D_E_L_E_T_ = ' ' " 

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
    Local cArq       := 'Planilha - Exercício 01.xls'
    Local cWorkSheet := 'Fornecedores'
    Local cTable     := 'Dados dos Fornecedores'
    Local cTexto     := ''
    Local oExcel     := FwMSExcelEx():New()

    //? Colunas

    oExcel:AddWorkSheet(cWorkSheet)
    oExcel:AddTable(cWorkSheet, cTable)
    oExcel:AddColumn(cWorkSheet, cTable, 'Código'  , LEFT,   GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Nome'    , LEFT,   GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Loja'    , CENTER, GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'CNPJ'    , CENTER, GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Endereço', LEFT  , GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Bairro'  , LEFT  , GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'Cidade'  , LEFT  , GERAL)
    oExcel:AddColumn(cWorkSheet, cTable, 'UF'      , CENTER, GERAL)

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

        If Empty((cAlias)->(A2_CGC))
            cTexto := 'Não Informado'
        Elseif Len(AllTrim((cAlias)->(A2_CGC))) == 11
            cTexto := Alltrim(Transform((cAlias)->(A2_CGC), "@R 999.999.999-99"))
        Elseif Len(AllTrim((cAlias)->(A2_CGC))) == 14
            cTexto := Alltrim(Transform((cAlias)->(A2_CGC), "@R 99.999.999/9999-99"))
        Endif
        //? Adicionando linhas com dados em cada coluna
        oExcel:AddRow(cWorkSheet, cTable, {AllTrim((cAlias)->(A2_COD)), AllTrim((cAlias)->(A2_NOME)), AllTrim((cAlias)->(A2_LOJA)), cTexto, AllTrim((cAlias)->(A2_END)), AllTrim((cAlias)->(A2_BAIRRO)), AllTrim((cAlias)->(A2_MUN)), AllTrim((cAlias)->(A2_EST))})

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
