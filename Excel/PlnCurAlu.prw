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

/*/{Protheus.doc} User Function PlnCurAlu
    Lista 11 - Excel | Exercício 03
    @type  Function
    @author André Lucas 
    @since 24/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FWMsExcel
/*/

User Function PlnCurAlu()

    Local aArea    := GetArea()
    Local cQuery   := ''
    Private cAlias := GetNextAlias()

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'ZCS, ZAL' MODULO 'FAT'

    cQuery := 'SELECT DISTINCT ZCS_COD, ZCS_NOME, ZAL_COD, ZAL_NOME, ZAL_IDADE, ZAL_DATAM, ZAL_CODCS ' + CRLF
    cQuery += ' FROM ' + RETSQLNAME('ZCS') + ' AS ZCS ' + CRLF
    cQuery += ' INNER JOIN ' + RETSQLNAME('ZAL') + ' AS ZAL ON ZAL.ZAL_CODCS = ZCS.ZCS_NOME ' + CRLF
    cQuery += " WHERE ZCS.D_E_L_E_T_ = '' AND ZAL.D_E_L_E_T_ = '' "

    TCQUERY cQuery ALIAS &(cAlias) NEW
    (cAlias)->(DbGoTop())

    RestArea(aArea)

    PlanImp()

    RESET ENVIRONMENT

Return

Static Function PlanImp()

    Local cPath      := 'C:\Users\André Lucas\OneDrive\Área de Trabalho\'
    Local cArq       := 'Planilha - Exercício 03.xls'
    Local cWorkSheet := ''
    Local cTable     := 'Alunos do Curso'
    Local cAbaCriada := ''
    Local oExcel     := FwMSExcelEx():New()

    //? Colunas

    DBSelectArea(cAlias)

    While (cAlias)->(!EOF())

        if (cAbaCriada != ((cAlias)->(ZCS_COD)))

            cWorkSheet := Alltrim((cAlias)->(ZCS_NOME))

            oExcel:AddWorkSheet(cWorkSheet)
            oExcel:AddTable(cWorkSheet, cTable)

            oExcel:AddColumn(cWorkSheet, cTable, 'Código'           , LEFT,   GERAL)
            oExcel:AddColumn(cWorkSheet, cTable, 'Nome'             , LEFT,   GERAL)
            oExcel:AddColumn(cWorkSheet, cTable, 'Idade'            , CENTER, NUMERO)
            oExcel:AddColumn(cWorkSheet, cTable, 'Data da Matrícula', CENTER, DATETIME)

            cAbaCriada := ((cAlias)->(ZCS_COD)) 

        endif
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

        oExcel:AddRow(cWorkSheet, cTable, {AllTrim((cAlias)->(ZAL_COD)), AllTrim((cAlias)->(ZAL_NOME)), (AllTrim((cAlias)->(CValToChar(ZAL_IDADE)))), SToD(AllTrim((cAlias)->(ZAL_DATAM)))})

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
