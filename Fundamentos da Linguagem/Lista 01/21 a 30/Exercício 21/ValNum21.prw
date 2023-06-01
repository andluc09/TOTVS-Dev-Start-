#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ValNum21
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 21
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function ValNum21()

	Local nNum    := 1
	Local cN      := ''
    Local cMostra := ''
    Local cInfo   := ''
    Local lNum    := .F.

//* Tratamento numérico

	while lNum == .F.
        cN := FwInputBox("Digite o valor de N: ", cN)
        if cN != '0' .AND. (VAL(cN) > 0)
            lNum := .T.
            cN := VAL(cN)
        endif
    enddo

	while nNum <= cN
        if nNum < cN
            cMostra := cMostra + Alltrim(Str(nNum) + ',')
        else
            cMostra := cMostra + Alltrim(Str(nNum) + '.')
        endif
		nNum++
	enddo

    cInfo := 'Os números entre 1 e ' + cValToChar(cN) + ' são: ' + CRLF + CRLF + cMostra

    TScrollArea(cInfo)

Return

Static Function TScrollArea(cInfo)

    DEFINE DIALOG oDlg TITLE " EXIBE CONTAGEM: " FROM 180,180 TO 900,1500 PIXEL;
    FONT oFont :=  TFont():New('Arial',,-14,.T.)

    // Cria objeto Scroll
    oScroll := TScrollArea():New(oDlg,01,01,100,100)
    oScroll:Align := CONTROL_ALIGN_ALLCLIENT

    // Cria painel
    @ 000,000 MSPANEL oPanel OF oScroll SIZE 1000,1000 COLOR CLR_HRED

    // Define objeto painel como filho do scroll
    oScroll:SetFrame( oPanel )

    // Define as características de texto incluindo a sujeição como filho do painel 
    TSay():New(15,12,{||cInfo},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlg CENTERED

Return
