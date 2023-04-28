#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

//? Cores
#DEFINE PRETO    RGB(000,000,000)
#DEFINE VERMELHO RGB(255,000,000)
#DEFINE AZUL     RGB(000, 125, 255)

#DEFINE MAX_LINE  770

/*/{Protheus.doc} User Function RelPdCmp
    Lista 11 - FWMSPrinter | Exercício 03
    @type  Function
    @author André Lucas M. Santos
    @since 25/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/TMSPrinter
    @see https://tdn.totvs.com.br/display/public/framework/FWMsPrinter
/*/

User Function RelPdCmp()

    Local cAlias := GeraCons()

    if(!Empty(cAlias))
        Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo relatório', .T.) //? Régua de Processamento
    else
        FWAlertInfo('Nenhum registro encontrado!', 'Atenção')
    endif

Return 

Static Function GeraCons()

    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''

    cQuery := 'SELECT DISTINCT C7_NUM, C7_EMISSAO, C7_FORNECE, C7_LOJA, C7_COND, C7_PRODUTO, C7_DESCRI, C7_QUANT, C7_PRECO, C7_TOTAL ' + CRLF
    cQuery += ' FROM ' + RETSQLNAME('SC7') + ' AS SC7 ' + CRLF
    cQuery += " WHERE SC7.C7_NUM = '" + AllTrim(SC7->C7_NUM) + "' AND SC7.D_E_L_E_T_ = '' "

    TCQuery cQuery ALIAS(cAlias) NEW 

    (cAlias)->(DBGoTop())

    if(cAlias)->(EOF()) //! Caso não  haja retorno!
        cAlias := ''
    endif

    RestArea(aArea)

Return cAlias

Static Function MontaRel(cAlias)

    Local cCaminho := 'C:\Users\André Lucas\OneDrive\Área de Trabalho\'
    Local cArquivo := 'Relatório Exer. 03 - Pedido de Compra.pdf'

    Private nLinha  := 105
    Private nCol    := 20
    Private nColFim := 820
    Private oPrint  := NIL

    //? Fontes a serem utilizadas
    Private oFont10 := TFont():New('Arial', /*Compatibilidade*/, 10, /*Compatibilidade*/, .F., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. –> (Negrito, Sublinhado e Itálico)
    Private oFont12 := TFont():New('Arial', /*Compatibilidade*/, 12, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. –> (Negrito, Sublinhado e Itálico)
    Private oFont14 := TFont():New('Arial', /*Compatibilidade*/, 14, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. –> (Negrito, Sublinhado e Itálico)
    Private oFont16 := TFont():New('Arial', /*Compatibilidade*/, 16, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .T., .F.) //? .F. –> (Negrito, Sublinhado e Itálico)

    oPrint := FWMSPrinter():New(cArquivo, IMP_PDF, .F., '', .T., /*TReport*/, @oPrint, '', /*lServer*/, /*lPDFAsPNG*/, /*RAW*/, .T.)
    //! FWSPrinter():New(NomeArquivo, , Impressão no servidor, )
    oPrint:cPathPDF := cCaminho

    oPrint:SetPortrait()
    oPrint:SetPaperSize(9) //? Tamanho A4

    oPrint:StartPage()

    VeriQuebPg(MAX_LINE, cAlias) 

    Cabecalho(cAlias)
    ImpDados(cAlias)

    IncProc("Gerando arquivo PDF...")

    oPrint:EndPage()
    oPrint:Preview()

Return

Static Function Cabecalho(cAlias)

    oPrint:Box(15, 15, 85, 580, '-8') //? Valores em Pixel
    oPrint:Line(50, 15, 50, 580, /*COR*/ AZUL, '-6')

    oPrint:Say(35, 20, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14, , PRETO)
    oPrint:Say(70, 220, 'Pedido de Compra', oFont16, , PRETO)

    oPrint:Say(nLinha, 20, 'Número Pedido '          , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 150, 'Data: '                 , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 250,  'Fornecedor'            , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 350, 'Loja'                   , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 450, 'Condição de Pagamento'  , oFont12, /*LargText*/, PRETO)

    nLinha += 5

    oPrint:Line(nLinha, 15, nLinha, 580, PRETO, '-6')

    nLinha += 20

    oPrint:Say(nLinha, 20,  Alltrim((cAlias)->(C7_NUM))                 , oFont10,/*LargText*/, PRETO)
    oPrint:Say(nLinha, 140, (DToC(SToD(Alltrim((cAlias)->C7_EMISSAO)))) , oFont10,/*LargText*/, PRETO)
    oPrint:Say(nLinha, 260, Alltrim((cAlias)->(C7_FORNECE))             , oFont10,/*LargText*/, PRETO)
    oPrint:Say(nLinha, 355, Alltrim((cAlias)->(C7_LOJA))                , oFont10,/*LargText*/, PRETO)
    oPrint:Say(nLinha, 500, Alltrim((cAlias)->(C7_COND))                , oFont10,/*LargText*/, PRETO)
    
    nLinha += 40

    oPrint:Say(nLinha, 20,  'CÓDIGO'            , oFont12, , PRETO)
    oPrint:Say(nLinha, 105, 'DESCRIÇÃO'         , oFont12, , PRETO)
    oPrint:Say(nLinha, 235, 'QUANTIDADE VENDIDA', oFont12, , PRETO)
    oPrint:Say(nLinha, 385, 'VALOR UNITÁRIO'    , oFont12, , PRETO)
    oPrint:Say(nLinha, 500, 'VALOR TOTAL'       , oFont12, , PRETO)

    nLinha += 5

    oPrint:Line(nLinha, 15, nLinha, 580, /*COR*/, '-6')

    nLinha += 20

    IncProc("Imprimindo Cabeçalho...")

Return 

Static Function ImpDados(cAlias)

    Local cString := ''

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    While (cAlias)->(!EOF())

        oPrint:Say(nLinha, 20, AllTrim((cAlias)->(C7_PRODUTO))    , oFont10, , PRETO) //? CÓDIGO DO PRODUTO

        cString := AllTrim((cAlias)->(C7_DESCRI)) //? DESCRIÇÃO
        VeriQuebLin(cString, 20, 105) //? VERIFICA A QUEBRA DA DESCRIÇÃO

        if (cAlias)->(C7_QUANT) == 0
            cString := '00'
        else
            cString := AllTrim((cAlias)->(CValToChar((C7_QUANT))))//? QUANTIDADE
        endif

        VeriQuebLin(cString, 25, 285) //? VERIFICA A QUEBRA DA QUANTIDADE

        if (cAlias)->(C7_PRECO) == 0
            cString := 'R$ 0,00'
        else
            cString := 'R$ ' + AllTrim((cAlias)->(StrTran(CValToChar(C7_PRECO), ".", ","))) //? PREÇO UNITÁRIO
        endif

        VeriQuebLin(cString, 15, 410) //? VERIFICA A QUEBRA DO PREÇO UNITÁRIO

        if (cAlias)->(C7_TOTAL) == 0
            cString := 'R$ 0,00'
        else
            cString := 'R$ ' + AllTrim((cAlias)->(StrTran(CValToChar(C7_TOTAL), ".", ","))) //? VALOR TOTAL
        endif

        VeriQuebLin(cString, 15, 515) //? VERIFICA A QUEBRA DO VALOR TOTAL

        nLinha += 30

        IncProc()

        (cAlias)->(DBSkip())

    Enddo

    IncProc("Imprimindo Dados...")

    (cAlias)->(DbCloseArea())

Return

Static Function VeriQuebLin(cString, nQtdChar, nCol)

    Local cTxtLinha  := ''
    Local lTemQuebra := .F.
    Local nQtdLinhas := MLCount(cString, nQtdChar, /*Tabulação*/, .F.)
    Local nI         := 0

    if(nQtdLinhas > 1)
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

//? Função para fazer a quebra de página
Static Function VeriQuebPg(nMax, cAlias)

    if nLinha > nMax

        //? Encerrando a página atual
        oPrint:EndPage()
        //? Iniciando uma nova página
        oPrint:StartPage()
        nLinha := 105
        //? Imprimindo o cabeçalho
        Cabecalho()

    endif

Return
