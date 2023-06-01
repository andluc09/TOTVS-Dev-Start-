#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CmpArr32
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 32
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function CmpArr32()

    Local nNum    := 0
    Local aArray1 := {}
    Local aArray2 := {}
    Local aValor  := {}
    Local aPosi   := {}
    Local nI      := 0
    Local nJ      := 0
    Local nCont   := 0
    Local cMostra := ''

//* Tratamento numérico

    for nI := 1 to 15
        nNum := VAL(FwInputBox('Digite aqui o ' + AllTrim(STR(nI)) + 'º número do Array 1: '))
        AADD(aArray1, nNum)
        nNum := VAL(FwInputBox('Digite aqui o ' + AllTrim(STR(nI)) + 'º número do Array 2: '))
        AADD(aArray2, nNum)
    next

    for nI := 1 to LEN(aArray1)
        for nj := nI to LEN(aArray2)
            if aArray1[nI] == aArray2[nJ]
                AADD(aPosi, nI)
                AADD(aPosi, nJ)
                AADD(aValor, aArray1[nI])
                AADD(aValor, aArray2[nJ])
                nCont++
            endif
        next
    next

    for nJ := 1 to LEN(aPosi)
        cMostra += 'O número ' + cValToChar(aValor[nJ]) + ', se repeta nas posições: ' + cValToChar(aPosi[nJ]) + CRLF + CRLF
    next

    cMostra := cMostra + CRLF + 'Número total de repetição: ' + cValToChar(nCont)

    if(nCont <> 0)
        TScrollArea(cMostra)
    else
        FwAlertError('Não existem números que se repetem entre os arrays!', 'ATENÇÃO')
    endif

Return

Static Function TScrollArea(cMostra)

    DEFINE DIALOG oDlg TITLE " Resultado: " FROM 180,180 TO 700,950 PIXEL;
    FONT oFont :=  TFont():New('Arial',,-14,.T.)

    // Cria objeto Scroll
    oScroll := TScrollArea():New(oDlg,01,01,100,100)
    oScroll:Align := CONTROL_ALIGN_ALLCLIENT

    // Cria painel
    @ 000,000 MSPANEL oPanel OF oScroll SIZE 1000,1000 COLOR CLR_HRED

    // Define objeto painel como filho do scroll
    oScroll:SetFrame( oPanel )

    // Define as características de texto incluindo a sujeição como filho do painel 
    TSay():New(15,12,{||cMostra},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlg CENTERED

Return
