#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function TMBCalculo
    Lista 04 - Interfaces Visuais | Exercício 09
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function TMBCalculo()

    Local cSex   := SPACE(1) 
    Local cPeso  := SPACE(5)
    Local cAlt   := SPACE(3)
    Local cIdade := SPACE(3)
    Local cTitle := 'Taxa Metabólica Basal (TMB)' 
    Local nPeso  := 0
    Local nAlt   := 0 
    Local nIdade := 0
    Local nOpcao := 0
    Local oDlg   := NIL 

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 175, 325 FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL 

    @ 014, 010 SAY 'Sexo (F ou M): '  SIZE 55, 10 OF oDlg PIXEL 
    @ 029, 010 SAY 'Peso (em Kg):'    SIZE 55, 10 OF oDlg PIXEL 
    @ 045, 010 SAY 'Altura (em cm): ' SIZE 55, 10 OF oDlg PIXEL
    @ 060, 010 SAY 'Idade: '          SIZE 55, 10 OF oDlg PIXEL
    @ 014, 065 MSGET cSex             SIZE 45, 10 OF oDlg PIXEL 
    @ 029, 065 MSGET cPeso            SIZE 45, 10 OF oDlg PIXEL 
    @ 045, 065 MSGET cAlt             SIZE 45, 10 OF oDlg PIXEL
    @ 060, 065 MSGET cIdade           SIZE 45, 10 OF oDlg PIXEL

    @ 019, 120 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 039, 120 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED   

    if nOpcao == 1
        cSex    := UPPER(cSex)
        nPeso   := VAL(cPeso)
        nAlt    := VAL(cAlt)
        nIdade  := VAL(cIdade)

        TMB(cSex, nPeso , nAlt , nIdade)
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif 

Return 

Static Function TMB(cSex, nPeso , nAlt, nIdade)

    Local nTaxa := 0

    if cSex == 'F'
        nTaxa := 655.1 + (9.563 * nPeso) + (1.850 * nAlt) - (4.676 * nIdade)
        FwAlertInfo(CRLF + CRLF + 'Sua taxa metabólica basal (TBM) é: ' + StrTran(Alltrim(Str(nTaxa , 20 , 2)),".",",") , ' TBM ')
    elseif cSex == 'M'
        nTaxa := 66.5 + (13.75 * nPeso) + (5.003 * nAlt) - (6.75 * nIdade)
        FwAlertInfo(CRLF + CRLF + 'Sua taxa metabólica basal (TBM) é: ' + StrTran(Alltrim(Str(nTaxa , 20 , 2)),".",",") , ' TBM ')
    else
        FwAlertError('Dados Inválidos!')
    endif

Return
