#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function MedQtdPed
    Lista BD - Exerc�cio 10
    @type  Function
    @author Andr� Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function MedQtdPed()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""
    Local cBusca    := ""
    Local cOk       := ""

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SC6" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SC6')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conex�o Banco de Dados)

    cBusca := FWInputBox("Insira o c�digo do produto a ser buscado: ", "Digite o c�digo do produto.")

    /*SELECT DISTINCT C6_PRODUTO
    FROM SC6990 AS SC6
    WHERE 
    EXISTS(SELECT C6_PRODUTO FROM SC6990 WHERE SC6.C6_PRODUTO = '000001')*/

    cQuery := "SELECT DISTINCT C6_PRODUTO "
    cQuery += "FROM " + RETSQLNAME("SC6") + " AS SC6 "
    cQuery += "WHERE "
    cQuery += "EXISTS(SELECT C6_PRODUTO FROM SC6990 WHERE SC6.C6_PRODUTO = '" + cBusca + "') "

    TCQuery cQuery ALIAS &(cAlias) new
    
    while !(&(cAlias)->(EOF()))
        cOk += &(cAlias)->(C6_PRODUTO) 
        &(cAlias)->(DBSkip())
    enddo

    if(!Empty(cOk))

        /*SELECT DISTINCT C6_PRODUTO, AVG(C6_QTDVEN) AS MEDIA_QUANT, AVG(C6_VALOR) AS MEDIA_VALTOTAL
        FROM SC6990 AS SC6
        WHERE SC6.C6_PRODUTO = '000001' AND -- Introduza o c�digo de produto para direcionar a busca --
        SC6.D_E_L_E_T_ = ''
        GROUP BY SC6.C6_PRODUTO*/

        cAlias := GETNEXTALIAS()

        cQuery := "SELECT DISTINCT C6_PRODUTO, AVG(C6_QTDVEN) AS MEDIA_QUANT, AVG(C6_VALOR) AS MEDIA_VALTOTAL "
        cQuery += "FROM " + RETSQLNAME("SC6") + " AS SC6 "
        cQuery += "WHERE SC6.C6_PRODUTO = '" + cBusca + "' AND "
        cQuery += "SC6.D_E_L_E_T_ = '' "
        cQuery += "GROUP BY SC6.C6_PRODUTO "

        TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICA��O COM SERVIDOR
        cMSG += 'M�dia quantidade item (Pedido de venda) - C�digo do Produto:' + Space(1) + 'C6_PRODUTO' + Space(1) + ' - M�dia quantidade: ' + 'MEDIA_QUANT' + Space(1) + ' - M�dia valor total: ' + 'MEDIA_VALTOTAL' + Space(1) + CRLF + CRLF 

        while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre at� o fim do arquivo
            cMSG += 'M�dia quantidade item (Pedido de venda) - C�digo do Produto:' + Space(1) + &(cAlias)->(C6_PRODUTO) + Space(1) + ' - M�dia quantidade: ' + CValToChar(MEDIA_QUANT) + Space(1) + ' - M�dia valor total: ' + CValToChar(MEDIA_VALTOTAL) + Space(1) + CRLF + CRLF //CRLF -- pula linha      
            &(cAlias)->(DBSkip()) //DB (Banco de Dados) SKIP (pular) pula linha at� encontrar linha em branco: fim do arquivo
        end do
        &(cAlias)->(DBCloseArea()) //ENCERRA COMUNICA��O COM SERVIDOR

        FWAlertInfo(cMSG, "<b> Query: </b>")

        TScrollArea(cMSG)

    else
        FWAlertWarning(" O c�digo do produto informado n�o foi encontrado! ","ATEN��O")
    endif

    RESET ENVIRONMENT

Return 

Static Function TScrollArea(cMSG)

    DEFINE DIALOG oDlg TITLE " Query: " FROM 180,180 TO 700,950 PIXEL;
    FONT oFont :=  TFont():New('Arial',,-14,.T.)

    // Cria objeto Scroll
    oScroll := TScrollArea():New(oDlg,01,01,100,100)
    oScroll:Align := CONTROL_ALIGN_ALLCLIENT

    // Cria painel
    @ 000,000 MSPANEL oPanel OF oScroll SIZE 1000,1000 COLOR CLR_HRED

    // Define objeto painel como filho do scroll
    oScroll:SetFrame( oPanel )

    // Define as caracter�sticas de texto incluindo a sujei��o como filho do painel 
    TSay():New(15,12,{||cMSG},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlg CENTERED

Return
