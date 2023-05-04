#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

//? Cores
#DEFINE PRETO    RGB(000,000,000)
#DEFINE VERMELHO RGB(255,000,000)
#DEFINE AZUL     RGB(000, 125, 255)

#DEFINE MAX_LINE  770

/*/{Protheus.doc} User Function RelPDFDir
    Lista 13 - Manipulação de Arquivos | Challenge
    @type  Function
    @author André Lucas M. Santos
    @since 30/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/TMSPrinter
    @see https://tdn.totvs.com.br/display/public/framework/FWMsPrinter
    @see https://tdn.totvs.com/display/public/framework/FWFileWriter
    @see https://tdn.totvs.com/display/public/framework/FWFileReader
    @see https://tdn.totvs.com/display/tec/ExistDir
    @see https://tdn.totvs.com/display/tec/MakeDir
    @see https://tdn.totvs.com/display/tec/DirRemove
    @see https://tdn.totvs.com/display/tec/Directory
    @see https://tdn.totvs.com/display/tec/FErase
/*/

User Function RelPDFDir()

    Local cLogTXT      := AllTrim(M->C5_NUM) + '.txt'
    Private cCaminho   := 'C:\TOTVS1212210\Protheus\protheus_data\'
    Private cNomePasta := 'Pedidos de Venda\'
    Private cDir       := cCaminho + cNomePasta
    Private aTexto     := {}
    Private cAlias     := GeraCons()

    CriaDir()

    if(!Empty(cAlias))
        Processa({|| MontaRel()}, 'Aguarde...', 'Imprimindo relatório', .T.) //? Régua de Processamento
    else
        FWAlertInfo('Nenhum registro encontrado!', 'Atenção')
    endif

    CriaLog(cLogTXT)

Return 

Static Function GeraCons()

    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''

    cQuery := 'SELECT DISTINCT C5_NUM, C5_EMISSAO, A1_NOME, E4_DESCRI, C6_ITEM, C6_PRODUTO, C6_DESCRI, C6_QTDVEN, C6_PRCVEN, C6_VALOR ' + CRLF
    cQuery += ' FROM ' + RETSQLNAME('SC5') + ' AS SC5 ' + CRLF
    cQuery += " INNER JOIN  " + RETSQLNAME('SE4') + " AS SE4 ON SE4.E4_CODIGO = SC5.C5_CONDPAG  " + CRLF    
    cQuery += " INNER JOIN  " + RETSQLNAME('SA1') + " AS SA1 ON SA1.A1_COD = SC5.C5_CLIENTE " + CRLF    
    cQuery += " INNER JOIN  " + RETSQLNAME('SC6') + " AS SC6 ON SC6.C6_NUM = SC5.C5_NUM " + CRLF    
    cQuery += " WHERE SC5.D_E_L_E_T_ = '' AND SE4.D_E_L_E_T_ = '' AND SA1.D_E_L_E_T_ = '' AND SC5.D_E_L_E_T_ = '' " + CRLF
    cQuery += " AND SC5.C5_NUM = '" + AllTrim(SC5->C5_NUM) + "' "

    TCQuery cQuery ALIAS(cAlias) NEW 

    (cAlias)->(DBGoTop())

    if(cAlias)->(EOF()) //! Caso não  haja retorno!
        cAlias := ''
    endif

    RestArea(aArea)

    AADD(aTexto, "Log iniciado, data [" + dToC(Date()) + "] e hora [" + Time() + "]" + CRLF)

Return cAlias

Static Function MontaRel()

    Local cArquivo := AllTrim(M->C5_NUM) + '.pdf'

    Private nMax    := 0
    Private nLinha  := 105
    Private nCol    := 20
    Private nColFim := 820
    Private oPrint  := NIL

    //? Fontes a serem utilizadas
    Private oFont10 := TFont():New('Arial', /*Compatibilidade*/, 10, /*Compatibilidade*/, .F., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. –> (Negrito, Sublinhado e Itálico)
    Private oFont12 := TFont():New('Arial', /*Compatibilidade*/, 12, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. –> (Negrito, Sublinhado e Itálico)
    Private oFont14 := TFont():New('Arial', /*Compatibilidade*/, 14, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. –> (Negrito, Sublinhado e Itálico)
    Private oFont16 := TFont():New('Arial', /*Compatibilidade*/, 16, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .T., .F.) //? .F. –> (Negrito, Sublinhado e Itálico)

    AADD(aTexto, "[" + Time() + "] " + 'Definindo fonte e tamanho da fonte' + '..')

    oPrint := FWMSPrinter():New(cArquivo, IMP_PDF, .F., '', .T., /*TReport*/, @oPrint, '', /*lServer*/, /*lPDFAsPNG*/, /*RAW*/, .T.)
    //! FWSPrinter():New(NomeArquivo, , Impressão no servidor, )
    oPrint:cPathPDF := cDir 

    AADD(aTexto, "[" + Time() + "] " + 'Definindo caminho do arquivo como: ' + cDir)

    oPrint:SetPortrait()
    oPrint:SetPaperSize(9) //? Tamanho A4

    oPrint:StartPage()

    AADD(aTexto, "[" + Time() + "] " + 'Começando a página do relatório' + '..')

    VeriQuebPg(MAX_LINE, cAlias) 

    Cabecalho() 
    ImpDados()

    IncProc("Gerando arquivo PDF...")

    oPrint:EndPage()
    oPrint:Preview()

Return

Static Function Cabecalho()

    AADD(aTexto,  "[" + Time() + "] " + 'Iniciando cabeçalho do relatório: ')

    oPrint:Box(15, 15, 85, 580, '-8') //? Valores em Pixel
    oPrint:Line(50, 15, 50, 580, /*COR*/ AZUL, '-6')

    oPrint:Say(35, 20, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14, , PRETO)
    oPrint:Say(70, 220, 'Pedido de Venda', oFont16, , PRETO)

    AADD(aTexto,  "[" + Time() + "] " + 'Empresa/Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL) + CRLF + CRLF)

    AADD(aTexto,  "[" + Time() + "] " + 'Pedido de Venda: ')

    oPrint:Say(nLinha, 20, 'Nº Pedido'          , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 140, 'Nome Cliente'      , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 250,  'Dta Emissão'      , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 450, 'Cond. Pagamento'   , oFont12, /*LargText*/, PRETO)

    AADD(aTexto, "[" + Time() + "] " + 'Impressão dos tópicos do cabeçalho do pedido de venda' + ':')

    nLinha += 5

    oPrint:Line(nLinha, 15, nLinha, 580, PRETO, '-6')

    nLinha += 20

    oPrint:Say(nLinha, 20,  Alltrim((cAlias)->(C5_NUM)),     oFont10,/*LargText*/, PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Nº Pedido: ' +  Alltrim((cAlias)->(C5_NUM)))
    oPrint:Say(nLinha, 150, Alltrim((cAlias)->(A1_NOME)),    oFont10,/*LargText*/, PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Nome Cliente: ' +  Alltrim((cAlias)->(A1_NOME)))
    oPrint:Say(nLinha, 260, Alltrim(DToC(SToD((cAlias)->(C5_EMISSAO)))), oFont10,/*LargText*/, PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Data Emissão: ' +  Alltrim(DToC(SToD((cAlias)->(C5_EMISSAO)))))
    oPrint:Say(nLinha, 450, Alltrim((cAlias)->(E4_DESCRI)),  oFont10,/*LargText*/, PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Cond. Pagamento: ' + Alltrim((cAlias)->(E4_DESCRI)))

    nLinha += 40

    oPrint:Say(nLinha, 20,  'Nº Item'         , oFont12, , PRETO)
    oPrint:Say(nLinha, 105, 'Cod. Produto'    , oFont12, , PRETO)
    oPrint:Say(nLinha, 205, 'Descri. Produto' , oFont12, , PRETO)
    oPrint:Say(nLinha, 320, 'Qtd. Vendida'    , oFont12, , PRETO)
    oPrint:Say(nLinha, 395, 'Valor Unitário'  , oFont12, , PRETO)
    oPrint:Say(nLinha, 475, 'VALOR TOTAL'     , oFont12, , PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Impressão dos itens do pedido de venda, os produtos' + ':')

    nLinha += 5

    oPrint:Line(nLinha, 15, nLinha, 580, /*COR*/, '-6')

    nLinha += 20

    IncProc("Imprimindo Cabeçalho...")

Return 

Static Function ImpDados()

    Local cString := ''
    Local nValTot := 0

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    While (cAlias)->(!EOF())

        oPrint:Say(nLinha, 20, AllTrim((cAlias)->(C6_ITEM))    , oFont10, , PRETO) //? CÓDIGO DO PRODUTO

        cString := AllTrim((cAlias)->(C6_PRODUTO)) //? DESCRIÇÃO
        VeriQuebLin(cString, 20, 105) //? VERIFICA A QUEBRA DA DESCRIÇÃO
        AADD(aTexto,  "[" + Time() + "] " + 'Produto: ' + AllTrim((cAlias)->(C6_PRODUTO)))

        cString := AllTrim((cAlias)->(CValToChar((C6_DESCRI))))//? QUANTIDADE
        VeriQuebLin(cString, 25, 210) //? VERIFICA A QUEBRA DA QUANTIDADE
        AADD(aTexto,  "[" + Time() + "] " + 'Descrição: ' + AllTrim((cAlias)->(CValToChar((C6_DESCRI)))))

        if (cAlias)->(C6_QTDVEN) == 0
            cString := '00'
        else
            cString := AllTrim((cAlias)->(StrTran(CValToChar(C6_QTDVEN), ".", ","))) //? PREÇO UNITÁRIO
        endif

        VeriQuebLin(cString, 15, 345) //? VERIFICA A QUEBRA DO PREÇO UNITÁRIO
        AADD(aTexto,  "[" + Time() + "] " + 'Quantidade: ' + AllTrim((cAlias)->(StrTran(CValToChar(C6_QTDVEN), ".", ","))))

        if (cAlias)->(C6_PRCVEN) == 0
            cString := 'R$ 0,00'
        else
            cString := 'R$ ' + AllTrim((cAlias)->(StrTran(CValToChar(C6_PRCVEN), ".", ","))) //? PREÇO UNITÁRIO
        endif

        VeriQuebLin(cString, 15, 410) //? VERIFICA A QUEBRA DO PREÇO UNITÁRIO
        AADD(aTexto,  "[" + Time() + "] " + 'Preço: R$ ' + AllTrim((cAlias)->(StrTran(CValToChar(C6_PRCVEN), ".", ","))))

        if (cAlias)->(C6_VALOR) == 0
            cString := 'R$ 0,00'
        else
            cString := 'R$ ' + AllTrim((cAlias)->(StrTran(CValToChar(C6_VALOR), ".", ","))) //? VALOR TOTAL
        endif

        VeriQuebLin(cString, 15, 490) //? VERIFICA A QUEBRA DO VALOR TOTAL
        AADD(aTexto,  "[" + Time() + "] " + 'Valor Total: R$ ' + AllTrim((cAlias)->(StrTran(CValToChar(C6_VALOR), ".", ","))))

        //? Totalizador

        nValTot += ((cAlias)->(C6_VALOR)) //! Soma todos os valores totais para o totalizador

        nLinha += 30

        IncProc("Imprimindo Dados...")

        (cAlias)->(DBSkip())

    Enddo

    oPrint:Line(nLinha, 15, nLinha, 580)

    nLinha += 10

    oPrint:Say(nLinha, 445, "TOTAL", oFont12,, PRETO)
    oPrint:Say(nLinha, 515, "R$ " + (StrTran(CValToChar(nValTot), ".", ",")), oFont12,, PRETO)

    AADD(aTexto, "[" + Time() + "] " + 'Impresão do totalizador no relatório' + ';')
    AADD(aTexto, "[" + Time() + "] " + 'Totalizador: ' + "R$ " + (StrTran(CValToChar(nValTot), ".", ",")))
    AADD(aTexto, "[" + Time() + "] " + 'Relatório Finalizado' + '.')

    IncProc()

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

Static Function CriaDir()

    if !ExistDir(cDir)
        if MakeDir(cDir) == 0 //? Se a pasta não existir!
            FWAlertSuccess('Pasta criada com sucesso!', 'CONCLUIDO!')
        else
            FWAlertError('Houve um erro ao criar a pasta!' + CRLF + CRLF + cCaminho, 'ERRO!')
        endif
    else //? Se a pasta existir!
        if FWAlertYesNo('Já existe uma pasta neste local com o nome: ' + cNomePasta, 'Deseja sobrepô-la?')
            //? SIM, deleta a pasta
            DelPasta()
            //? Cria a mesma!
            if MakeDir(cDir) == 0 //? Se a pasta não existir!
                FWAlertSuccess('Pasta criada com sucesso!', 'CONCLUIDO!')
            else
                FWAlertError('Houve um erro ao criar a pasta!' + CRLF + CRLF + cCaminho, 'ERRO!')
            endif
        endif
        //? NÃO, mantém a mesma..
    endif

Return 

Static Function DelPasta()

    Local aArquivos := Directory(cDir + '*.*', 'D', /*Compatibilidade*/, /*ChangeCase*/, 1) //? Retorna o conteúdo da pasta!
    Local nI        := 0

    if ExistDir(cDir)
        if FWAlertYesNo('Confirma a exclusão da pasta? ', 'ATENÇÃO')
            if LEN(aArquivos) > 0
                for nI := 3 to LEN(aArquivos)
                    if FErase(cDir + aArquivos[nI][1]) == -1
                        FWAlertWarning('Houve um erro ao apagar o arquivo ' + aArquivos[nI][1])
                    endif
                next
            endif

            if DirRemove(cDir)
                FWAlertSuccess('Pasta apagada com sucesso', 'CONCLUÍDO')
            else
                FWAlertError('Houve um erro ao excluir a pasta!', 'ERRO')
            endif
        endif
    endif

Return 

Static Function CriaLog(cLogTXT)

    Local cDir      := cCaminho + cNomePasta + cLogTXT
    Local oWriter   := FWFileWriter():New(cDir, .T.)
    Local cTXTLog   := ArrTokStr(aTexto, CRLF)

    if File(cDir)
        FWAlertInfo('O arquivo já existe!', 'ATENÇÃO')
        if !oWriter:Create()
            FWAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'ERRO!')
        else
            if FWAlertYesNo('Deseja sobrescrever o arquivo TXT?', 'PERGUNTA')
                //? Texto a ser escrito
                oWriter:Write(CRLF)
                oWriter:Write("Código do Usuário: " + RetCodUsr() + CRLF)
                oWriter:Write("Nome do Usuário:   " + UsrRetName(RetCodUsr()) + CRLF)
                oWriter:Write("Função (FunName):  " + FunName() + CRLF)
                oWriter:Write("Ambiente:          " + GetEnvServer() + CRLF)
                oWriter:Write(CRLF)
                oWriter:Write(cTXTLog)
                oWriter:Write(CRLF + CRLF)
                oWriter:Write("Log concluído, data [" + dToC(Date()) + "] e hora [" + Time() + "]" + CRLF)
                oWriter:Write("_______________________________________________________________________________________________________________________________________________________________________________________________" + CRLF)
                oWriter:Write(CRLF)

                oWriter:Close()

                if FWAlertYesNo('Arquivo gerado com sucesso ('+ cDir +')!' + CRLF + 'Deseja abrir o arquivo?', 'ABRIR')
                    ShellExecute('OPEN', cLogTXT, /*Compatibilidade*/ '', cCaminho + cNomePasta, /*Modo de exibição*/ 1)
                endif
            endif
        endif
    else
        if !oWriter:Create()
            FWAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'ERRO!')
        else
            //? Texto a ser escrito
            oWriter:Write(CRLF)
            oWriter:Write("Código do Usuário: " + RetCodUsr() + CRLF)
            oWriter:Write("Nome do Usuário:   " + UsrRetName(RetCodUsr()) + CRLF)
            oWriter:Write("Função (FunName):  " + FunName() + CRLF)
            oWriter:Write("Ambiente:          " + GetEnvServer() + CRLF)
            oWriter:Write(CRLF)
            oWriter:Write(cTXTLog)
            oWriter:Write(CRLF + CRLF)
            oWriter:Write("Log concluído, data [" + dToC(Date()) + "] e hora [" + Time() + "]" + CRLF)
            oWriter:Write("_______________________________________________________________________________________________________________________________________________________________________________________________" + CRLF)
            oWriter:Write(CRLF)

            oWriter:Close()

            if FWAlertYesNo('Arquivo gerado com sucesso ('+ cDir +')!' + CRLF + 'Deseja abrir o arquivo?', 'ABRIR')
                ShellExecute('OPEN', cLogTXT, /*Compatibilidade*/ '', cCaminho + cNomePasta, /*Modo de exibição*/ 1)
            endif
        endif
    endif

Return 
