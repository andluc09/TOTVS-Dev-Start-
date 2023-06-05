#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Fibona15
    Lista 02 - Fundamentos da Linguagem ADVPL | Exercício 15
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Fibona15()

    nNum   := 0

    nNum := FwInputBox('Digite quantos números da série Fibonacci quer ver: ')
    nNum:= val(nNum)

    CalcFib(nNum)

Return

Static Function CalcFib(nNum)

    Local nA    := 0
    Local nB    := 1
    Local nC    := 0
    Local nCont := 1
    Local aC    := {}
    Local cShow := ""

    if nNum = 0
        FwAlertSuccess("Os números da série Fibonacci é: " + alltrim(Str(nA)))
    elseif  nNum = 1
        FwAlertSuccess("Os números da série Fibonacci é: " + alltrim(Str(nB)))
    else
        while (nCont < nNum)
            nC := nA + nB
            nA := nB
            nB := nC

            AADD(aC, nC)

            cShow += (' , ' + Alltrim(STR(aC[nCont])))

            nCont++ 
        enddo 
    endif

    cExibe := 'Os números da série fibonacci são: 0 , 1' + cShow

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

    // Define as características de texto incluindo a sujeição como filho do painel 
    TSay():New(15,12,{||cExibe},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlg CENTERED

Return
