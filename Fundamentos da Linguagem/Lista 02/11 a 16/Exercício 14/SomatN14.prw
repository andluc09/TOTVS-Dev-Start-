#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function SomatN14
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 14
    @type  Function
    @author Andr� Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function SomatN14()

    Local nI := 0
    Local nN := 0
    Local aTipo := {'Impares', 'Pares'}
    Local nTipo := 0
    Local nSoma := 0
    Local cNum  := ''
    
    //? Usu�rio escolhe quantos n�meros pretende somar.
    nN := val(FwInputBox('Digite a quantidade de n�meros desejada:'))

    //? Usu�rio decide se os n�meros somados ser�o pares ou �mpares.
    nTipo := Aviso('Escolha o tipo de n�mero:', 'Fa�a sua escolha..', aTipo, 1)

    if nTipo == 1
        for nI := 1 to nN step 2 //* Aqui s�o somados apenas os n�meros �mpares.
            nSoma += nI
            cNum := cNum + cValToChar(nI) + CRLF
        next
    else
        for nI := 2 to nN  step 2 //* Aqui, somente os pares
            nSoma += nI
            cNum := cNum + cValToChar(nI) + CRLF        
        next
    endif

    cExibe := 'A soma dos ' + cValToChar(nN) + ' primeiros n�meros ' + aTipo[nTipo] + ' �: ' + cValToChar(nSoma) + ' (Somat�rio)' + CRLF  + CRLF + cNum

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
