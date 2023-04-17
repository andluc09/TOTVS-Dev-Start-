#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function BuscaPrdt
    Lista 04 - Interfaces Visuais | Exercício 11
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function BuscaPrdt()

    Local cTitle     := 'Consulta Produto' 
    Local nOpcao     := 0
    Local oDlg       := NIL 
    Private cProduto := SPACE(6) 

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 090, 347 FONT oFont := TFont():New('Arial',,-13,.T.) PIXEL 

    @ 014, 010 SAY 'Código do Produto: ' SIZE 75, 10 OF oDlg PIXEL 
    @ 014, 075 MSGET cProduto            SIZE 20, 10 OF oDlg PIXEL 

    @ 010, 120  BUTTON 'Ok'      SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 027, 120 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED   

    if nOpcao == 1
        ProcuPrdt()
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif 

Return 

Static Function ProcuPrdt()
    Local aArea   := GetArea()
    Local cAlias  := GetNextAlias()
    Local cQuery  := ''
    Local cMSG    := ''
    Local lFlag   := .F.

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'FAT'

    cQuery := "SELECT DISTINCT B1_COD, B1_DESC, B1_PRV1 FROM " + RETSQLNAME("SB1") + " AS SB1 "
    cQuery += "WHERE SB1.B1_COD = '" + cProduto + "' AND SB1.D_E_L_E_T_ = '' "

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())

        if cProduto == ALLTRIM(&(cAlias)->(B1_COD))
            cMSG += CRLF + CRLF + 'Código: ' + &(cAlias)->(B1_COD) + CRLF
            cMSG += 'Descrição: ' + &(cAlias)->(B1_DESC) + CRLF
            cMSG += 'Preço de Venda: R$' + Alltrim(STR(&(cAlias)->(B1_PRV1))) + CRLF
            cMSG += '_________________________________________________' + CRLF + CRLF

            lFlag := .T.
        endif

        &(cAlias)->(DbSkip())
    enddo

    if lFlag
        FwAlertSuccess(cMSG, 'Produto encontrado')
    else
        FwAlertError(CRLF + CRLF + 'Código de produto <b>inexistente</b> no sistema!', 'Produto não foi encontrado')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

    RESET ENVIRONMENT

Return
