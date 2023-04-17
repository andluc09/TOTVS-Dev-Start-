#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function IMCalculo
    Lista 04 - Interfaces Visuais | Exercício 08
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function IMCalculo()

    Local nPeso    := SPACE(5)
    Local nAltura  := SPACE(3)
    Local cTitle   := 'Cálculo IMC' 
    Local nOpcao   := 0
    Local nJanLarg := 250
    Local nJanAltu := 200
    Local oGrpLog  := NIL
    Private oDlg   := NIL 

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanAltu, 250 FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL

        @ 003, 003  GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3    PROMPT "IMC:  "    OF oDlg PIXEL

        @ 030, 010  SAY 'Peso Kg:'   SIZE 55, 10 OF oDlg PIXEL
        @ 030, 045  MSGET nPeso      SIZE 55, 11 OF oDlg PIXEL PICTURE '@# 99999'
        @ 050, 010  SAY 'Altura cm:' SIZE 55, 10 OF oDlg PIXEL
        @ 050, 045  MSGET nAltura    SIZE 55, 11 OF oDlg PIXEL PICTURE '@# 999'

        @ 077, 020  BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
        @ 077, 070  BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED      

    if nOpcao == 1
        IMC(Val(nPeso), Val(nAltura))
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif

Return

Static Function IMC(nPeso, nAltura)

    Local nIMC := 0

    nIMC := nPeso / ((nAltura/100)^2)

    if nIMC < 18.5
        FwAlertInfo(CRLF + CRLF + 'IMC: ' + StrTran(cValtoChar(nIMC),".",",") + CRLF + CRLF + ' Magreza - Obesidade (Grau): 0', 'RESULTADO')
    elseif nIMC <= 24.9 
        FwAlertInfo(CRLF + CRLF + 'IMC: ' + StrTran(cValtoChar(nIMC),".",",") + CRLF + CRLF + ' Normal - Obesidade (Grau): 0', 'RESULTADO')
    elseif nIMC <= 29.9
        FwAlertInfo(CRLF + CRLF + 'IMC: ' + StrTran(cValtoChar(nIMC),".",",") + CRLF + CRLF + ' Sobrepeso - Obesidade (Grau): I', 'RESULTADO')
    elseif nIMC <= 39.9
        FwAlertInfo(CRLF + CRLF + 'IMC: ' + StrTran(cValtoChar(nIMC),".",",") + CRLF + CRLF + ' Obesidade - Obesidade (Grau): II', 'RESULTADO')
    else 
        FwAlertInfo(CRLF + CRLF + 'IMC: ' + StrTran(cValtoChar(nIMC),".",",") + CRLF + CRLF + ' Obesidade Grave - Obesidade (Grau): III', 'RESULTADO')
    endif

Return
