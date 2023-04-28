#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

//? Cores
#DEFINE PRETO    RGB(000, 000, 000)
#DEFINE VERMELHO RGB(255, 000, 000)
#DEFINE AZUL     RGB(000, 125, 255)

#DEFINE MAX_LINE  770

/*/{Protheus.doc} User Function RelPrdt
    Lista 11 - FWMSPrinter | Exerc�cio 01
    @type  Function
    @author Andr� Lucas M. Santos
    @since 25/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/TMSPrinter
    @see https://tdn.totvs.com.br/display/public/framework/FWMsPrinter
/*/

User Function RelPrdt()

    Local cAlias := GeraCons()

    if(!Empty(cAlias))
        Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo relat�rio', .T.) //? R�gua de Processamento
    else
        FWAlertInfo('Nenhum registro encontrado!', 'Aten��o')
    endif

Return 

Static Function GeraCons()

    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''

    cQuery := 'SELECT DISTINCT B1_COD, B1_DESC, B1_UM, B1_PRV1, B1_LOCPAD, B1_MSBLQL' + CRLF
    cQuery += 'FROM ' + RETSQLNAME('SB1') + ' AS SB1 ' + CRLF
    cQuery += "WHERE SB1.D_E_L_E_T_ = '' "

    TCQuery cQuery ALIAS(cAlias) NEW 

    (cAlias)->(DBGoTop())

    if(cAlias)->(EOF()) //! Caso n�o  haja retorno!
        cAlias := ''
    endif

    RestArea(aArea)

Return cAlias

Static Function MontaRel(cAlias)

    Local cCaminho := 'C:\Users\Andr� Lucas\OneDrive\�rea de Trabalho\'
    Local cArquivo := 'Relat�rio Exer. 01 - Cadastro de Produtos.pdf'

    Private nLinha  := 105
    Private nCol    := 20
    Private nColFim := 820
    Private oPrint  := NIL
     //! TFont():New(cNomeFont,/Compat./, nFontSize, /Compat./, lBold,/Compat./,/Compat./,/Compat./,/Compat./, lUnderline, lItalic)
    Private oFont10 := TFont():New('Arial', /*Compatibilidade*/, 10, /*Compatibilidade*/, .F., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. �> (Negrito, Sublinhado e It�lico)
    Private oFont12 := TFont():New('Arial', /*Compatibilidade*/, 12, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. �> (Negrito, Sublinhado e It�lico)
    Private oFont14 := TFont():New('Arial', /*Compatibilidade*/, 14, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. �> (Negrito, Sublinhado e It�lico)
    Private oFont16 := TFont():New('Arial', /*Compatibilidade*/, 16, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .T., .F.) //? .F. �> (Negrito, Sublinhado e It�lico)

    oPrint := FWMSPrinter():New(cArquivo, IMP_PDF, .F., '', .T., /*TReport*/, @oPrint, '', /*lServer*/, /*lPDFAsPNG*/, /*RAW*/, .T., /*QtdC�pias*/)
    //! FWSPrinter():New(NomeArquivo, , Impress�o no servidor, )
    oPrint:cPathPDF := cCaminho

    oPrint:SetPortrait()
    oPrint:SetPaperSize(9) //? Tamanho A4

    oPrint:StartPage()

    VeriQuebPg(MAX_LINE, cAlias) 

    Cabecalho()
    ImpDados(cAlias)

    IncProc("Gerando arquivo PDF...")

    oPrint:EndPage()
    oPrint:Preview() //? Exibi relat�rio

Return

Static Function Cabecalho(cAlias)

    //* Cria Caixa
    oPrint:Box(15, 15, 85, 580, '-8') //? Valores em Pixel
    //*Cria uma Linha
    oPrint:Line(50, 15, 50, 580, /*COR*/ AZUL, '-6')

    oPrint:Say(35, 20, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14, /*LargText*/, PRETO)
    oPrint:Say(70, 220, ' Cadastro de Produtos ', oFont16, /*LargText*/, PRETO)

    oPrint:Say(nLinha, 20,  'C�DIGO'            , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 100,  'DESCRI��O'        , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 200, 'UNIDADE DE MEDIDA' , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 320, 'PRE�O'             , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 400, 'ARMAZ�M'           , oFont12, /*LargText*/, PRETO)

    nLinha += 5

    oPrint:Line(nLinha, 15, nLinha, 580, /*COR*/, '-6')

    nLinha += 20

    IncProc("Imprimindo Cabe�alho...")

Return 

Static Function ImpDados(cAlias)

    Local cString := ''
    Private nMax  := MAX_LINE
    Private nCor  := 0
    
    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())

        VeriQuebPg(MAX_LINE)

        if AllTrim((cAlias)->((B1_MSBLQL))) == '1'
            nCor := VERMELHO
        else
            nCor := PRETO
        endif
        
        //? C�DIGO
        oPrint:Say(nLinha, 20, AllTrim((cAlias)->(B1_COD))    , oFont10, , PRETO)

        cString := AllTrim((cAlias)->(B1_DESC)) //? DESCRI��O
        VeriQuebLin(cString, 20, 100) //? VERIFICA A QUEBRA DA DESCRI��O

        //? UNIDADE DE MEDIDA
        oPrint:Say(nLinha, 250, AllTrim((cAlias)->(B1_UM))   , oFont10, , PRETO) //! N�o precisa, pois t�m quantidade fixa de caracteres

        //? PRE�O DE VENDA
        if (cAlias)->(B1_PRV1) == 0
            cString := '0,00'
        else
            cString := cValToChar((cAlias)->(B1_PRV1)) 
        endif

        oPrint:Say(nLinha, 320, 'R$ ' + cString, oFont10, , PRETO) //! N�o precisa, pois t�m quantidade fixa de caracteres

        //? ARMAZ�M
        oPrint:Say(nLinha, 420, AllTrim((cAlias)->(B1_LOCPAD))   , oFont10, , PRETO) //! N�o precisa, pois t�m quantidade fixa de caracteres

        nLinha += 30

        IncProc("Imprimindo Dados...")

        (cAlias)->(DBSkip())

    enddo

    (cAlias)->(DbCloseArea())

    IncProc()

Return

Static Function VeriQuebLin(cString, nQtdChar, nCol)

    Local cTxtLinha  := ''
    Local lTemQuebra := .F.
    Local nQtdLinhas := MLCount(cString, nQtdChar, /*Tabula��o*/, .F.)
    Local nI         := 0

    if(nQtdLinhas > 1)
        lTemQuebra := .T.

        for nI := 1 to nQtdLinhas
            cTxtLinha := MemoLine(cString, nQtdChar, nI)

            oPrint:Say(nLinha, nCol, cTxtLinha, oFont10, , PRETO)
            nLinha += 10
        next

    else
        oPrint:Say(nLinha, nCol, cString, oFont10, , PRETO)
    endif

    if lTemQuebra
        nLinha -= nQtdLinhas * 10
    endif

Return 

//? Fun��o para fazer a quebra de p�gina
Static Function VeriQuebPg(nMax, cAlias)

    if nLinha > nMax

        //? Encerrando a p�gina atual
        oPrint:EndPage()
        //? Iniciando uma nova p�gina
        oPrint:StartPage()
        nLinha := 105
        //? Imprimindo o cabe�alho
        Cabecalho()

    endif

Return
