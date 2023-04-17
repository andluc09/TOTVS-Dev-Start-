#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function FolPagmto
    Lista 04 - Interfaces Visuais | Exercício 10
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function FolPagmto()

    Local cTitle      := 'Desconto IR (Imposto de Renda)'
    Local nOpcao      := 0
    Local oDlg        := NIL
    Private nHora     := SPACE(10)
    Private nQtdHoras := SPACE(3)

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 200, 350 FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL

    @ 014, 010 SAY   'Informe o valor da hora: '        SIZE 120, 12 OF oDlg PIXEL
    @ 034, 010 SAY   'Informe a quantidade de horas: '  SIZE 120, 12 OF oDlg PIXEL
    @ 010, 105 MSGET nHora                              SIZE 55, 11  OF oDlg PIXEL
    @ 030, 105 MSGET nQtdHoras                          SIZE 55, 11  OF oDlg PIXEL

    @ 070, 045 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 070, 095 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED

    if nOpcao == 1
        Pagamento(VAL(nHora), VAL(nQtdHoras))
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif

Return

Static Function Pagamento(nHora, nQtdHoras)

    Local nIR:= 0
    Local nINSS:= 0
    Local nFGTS:= 0
    Local nTotalDesc:= 0
    Local nSalBruto:= 0
    Local nSalLiq:= 0
    Local cIR := ''

    nSalBruto := nHora * nQtdHoras

    if nSalBruto > 1200 .and. nSalBruto <= 1800  
        nIR := 0.05 * nSalBruto         
        cIR := '5%'
    elseif nSalBruto > 1800 .and. nSalBruto <= 2500 
        nIR := 0.10 * nSalBruto 
        cIR := '10%'
    elseif nSalBruto > 2500 
        nIR := 0.20 * nSalBruto 
        cIR := '20%'
    else
        FwAlertSuccess('O salário informado é <b>isento</b>, não tem <i>desconto</i> de IR!')
        nIR := 0 * nSalBruto
    endif

    nINSS := 0.10 * nSalBruto     

    nFGTS := 0.11 * nSalBruto 

    nTotalDesc := nIR + nINSS 

    nSalLiq := nSalBruto - nTotalDesc

    FwAlertInfo(CRLF + CRLF + 'Salário bruto R$: ' + StrTran(ALLTRIM(Str(nSalBruto,15,2)),".",",") + CRLF + CRLF + ;
                'IR ('+ALLTRIM(cIR)+'): R$ '+ StrTran(ALLTRIM(Str(nIR,15,2)),".",",")+ CRLF + CRLF + ;
                'INSS (10%): R$ '+ StrTran(ALLTRIM(Str(nINSS,15,2)),".",",")+ CRLF + CRLF + ;
                'FGTS (11%): R$ '+ StrTran(ALLTRIM(Str(nFGTS,15,2)),".",",")+ CRLF + CRLF + ;
                'Total de descontos: R$ '+ StrTran(ALLTRIM(Str(nTotalDesc,15,2)),".",",")+ CRLF + CRLF + ;
                'Salário Líquido: R$ '+ StrTran(ALLTRIM(Str(nSalLiq,15,2)),".",","), 'Folha de Pagamento')

Return
