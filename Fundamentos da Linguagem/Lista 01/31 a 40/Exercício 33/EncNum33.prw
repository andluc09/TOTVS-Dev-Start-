#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function EncNum33
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 33
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function EncNum33()

    Local nNum    := 0
    Local aArray  := {}
    Local aValor  := {}
    Local aPosi   := {}
    Local nI      := 0
    Local nJ      := 0
    Local nCont   := 0
    Local cMostra := ''

//* Tratamento num�rico

    for nI := 1 to 20
        nNum := VAL(FwInputBox('Digite aqui o ' + AllTrim(STR(nI)) + '� n�mero do array: '))
        AADD(aArray, nNum)
    next

    for nI := 1 to LEN(aArray)-1
        for nJ := nI+1 to LEN(aArray)
            if aArray[nI] == aArray[nJ]
                AADD(aPosi, nI)
                AADD(aPosi, nJ)
                AADD(aValor, aArray[nI])
                AADD(aValor, aArray[nJ])
                nCont++
            endif
        next
    next

    for nJ := 1 to LEN(aPosi)
        cMostra += 'O n�mero ' + cValToChar(aValor[nJ]) + ', se repeta nas posi��es: ' + cValToChar(aPosi[nJ]) + CRLF + CRLF
    next

    cMostra := cMostra + CRLF + 'N�mero total de repeti��o: ' + cValToChar(nCont)

    if(nCont <> 0)
        TScrollArea(cMostra)
    else
        FwAlertError('N�o existem n�meros que se repetem no array!', 'ATEN��O')
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

    // Define as caracter�sticas de texto incluindo a sujei��o como filho do painel 
    TSay():New(15,12,{||cMostra},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlg CENTERED

Return
