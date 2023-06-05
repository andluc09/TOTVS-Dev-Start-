#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function AutMul13
    Lista 02 - Fundamentos da Linguagem ADVPL | Exerc�cio 13
    @type  Function
    @author Andr� Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function AutMul13()

    Local nI     := 1
    Local nNum   := 0
    Local nLim   := 0
    Local cExibe := ''

//*Colocar valida��o num�rica, depois

    nNum := Val(FwInputBox('Digite o n�mero que voc� deseja saber seus m�ltiplos:'))

    nLim := Val(FwInputBox('Digite o limite m�ximo de n�meros a serem analisados:'))

    for nI := 1 to nLim 
        if (nI % nNum) == 0
            cExibe := cExibe + cValToChar(nI) + CRLF
        endif
    next 

    cExibe := 'Os n�meros entre 1 e ' + cValToChar(nLim) + ' divis�veis por ' + cValToChar(nNum) + ' s�o: '+ CRLF + CRLF + cExibe

    TScrollArea(cExibe)

Return

Static Function TScrollArea(cExibe)

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
    TSay():New(15,12,{||cExibe},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlg CENTERED

Return
