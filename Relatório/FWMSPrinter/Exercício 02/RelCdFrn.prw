#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

//? Cores
#DEFINE PRETO    RGB(000,000,000)
#DEFINE VERMELHO RGB(255,000,000)
#DEFINE AZUL     RGB(000, 125, 255)

#DEFINE MAX_LINE  770

/*/{Protheus.doc} User Function RelCdFrn
    Lista 11 - FWMSPrinter | Exercício 02
    @type  Function
    @author André Lucas M. Santos
    @since 25/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/TMSPrinter
    @see https://tdn.totvs.com.br/display/public/framework/FWMsPrinter
/*/

User Function RelCdFrn()

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

    cQuery := 'SELECT DISTINCT A2_COD, A2_NOME, A2_END, A2_BAIRRO, A2_MUN, A2_EST, A2_CEP, A2_MSBLQL ' + CRLF
    cQuery += ' FROM ' + RETSQLNAME('SA2') + ' AS SA2 ' + CRLF
    cQuery += " WHERE SA2.A2_COD = '" + AllTrim(SA2->A2_COD) + "' AND SA2.D_E_L_E_T_ = '' "

    TCQuery cQuery ALIAS(cAlias) NEW 

    (cAlias)->(DBGoTop())

    if(cAlias)->(EOF()) //! Caso não  haja retorno!
        cAlias := ''
    endif

    RestArea(aArea)

Return cAlias

Static Function MontaRel(cAlias)

    Local cCaminho := 'C:\Users\André Lucas\OneDrive\Área de Trabalho\'
    Local cArquivo := 'Relatório Exer. 02 - Cadastro de Fornecedor.pdf'

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

    Cabecalho()
    ImpDados(cAlias)

    IncProc("Gerando arquivo PDF...")

    oPrint:EndPage()
    oPrint:Preview()

Return

Static Function Cabecalho(cAlias)

    oPrint:Box(15, 15, 85, 580, '-8') //? Valores em Pixel
    oPrint:Line(50, 15, 50, 580, /*COR*/ AZUL, '-6')

    oPrint:Say(35, 20, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14, , PRETO)
    oPrint:Say(70, 220, 'Cadastro de Fornecedor', oFont16, , PRETO)

    oPrint:Say(nLinha, 20,  'CÓDIGO'   , oFont12, , PRETO)
    oPrint:Say(nLinha, 80,  'NOME'     , oFont12, , PRETO)
    oPrint:Say(nLinha, 200, 'ENDEREÇO' , oFont12, , PRETO)
    oPrint:Say(nLinha, 320, 'BAIRRO'   , oFont12, , PRETO)
    oPrint:Say(nLinha, 400, 'CIDADE'   , oFont12, , PRETO)
    oPrint:Say(nLinha, 485, 'UF'       , oFont12, , PRETO)
    oPrint:Say(nLinha, 545, 'CEP'      , oFont12, , PRETO)

    nLinha += 5

    oPrint:Line(nLinha, 15, nLinha, 580, /*COR*/, '-6')

    nLinha += 20

    IncProc("Imprimindo Cabeçalho...")

Return 

Static Function ImpDados(cAlias)

    Local cString := ''

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    oPrint:Say(nLinha, 20, AllTrim((cAlias)->(A2_COD))    , oFont10, , PRETO)

    cString := AllTrim((cAlias)->(A2_NOME)) //? NOME
    VeriQuebLin(cString, 20, 80) //? VERIFICA A QUEBRA DO NOME

    cString := AllTrim((cAlias)->(A2_END)) //? ENDEREÇO
    VeriQuebLin(cString, 25, 200) //? VERIFICA A QUEBRA DO ENDEREÇO

    cString := AllTrim((cAlias)->(A2_BAIRRO)) //? BAIRRO
    VeriQuebLin(cString, 15, 320) //? VERIFICA A QUEBRA DO BAIRRO

    cString := AllTrim((cAlias)->(A2_MUN)) //? CIDADE
    VeriQuebLin(cString, 15, 400) //? VERIFICA A QUEBRA DO CIDADE

    oPrint:Say(nLinha, 485, AllTrim((cAlias)->(A2_EST))   , oFont10, , PRETO) //! Não precisa, pois têm quantidade fixa de caracteres
    oPrint:Say(nLinha, 545, AllTrim((cAlias)->(A2_CEP))   , oFont10, , PRETO) //! Não precisa, pois têm quantidade fixa de caracteres

    nLinha += 30

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
