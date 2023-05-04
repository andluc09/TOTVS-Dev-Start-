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
    Lista 13 - Manipula��o de Arquivos | Challenge
    @type  Function
    @author Andr� Lucas M. Santos
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
        Processa({|| MontaRel()}, 'Aguarde...', 'Imprimindo relat�rio', .T.) //? R�gua de Processamento
    else
        FWAlertInfo('Nenhum registro encontrado!', 'Aten��o')
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

    if(cAlias)->(EOF()) //! Caso n�o  haja retorno!
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
    Private oFont10 := TFont():New('Arial', /*Compatibilidade*/, 10, /*Compatibilidade*/, .F., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. �> (Negrito, Sublinhado e It�lico)
    Private oFont12 := TFont():New('Arial', /*Compatibilidade*/, 12, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. �> (Negrito, Sublinhado e It�lico)
    Private oFont14 := TFont():New('Arial', /*Compatibilidade*/, 14, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .F., .F.) //? .F. �> (Negrito, Sublinhado e It�lico)
    Private oFont16 := TFont():New('Arial', /*Compatibilidade*/, 16, /*Compatibilidade*/, .T., /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, /*Compatibilidade*/, .T., .F.) //? .F. �> (Negrito, Sublinhado e It�lico)

    AADD(aTexto, "[" + Time() + "] " + 'Definindo fonte e tamanho da fonte' + '..')

    oPrint := FWMSPrinter():New(cArquivo, IMP_PDF, .F., '', .T., /*TReport*/, @oPrint, '', /*lServer*/, /*lPDFAsPNG*/, /*RAW*/, .T.)
    //! FWSPrinter():New(NomeArquivo, , Impress�o no servidor, )
    oPrint:cPathPDF := cDir 

    AADD(aTexto, "[" + Time() + "] " + 'Definindo caminho do arquivo como: ' + cDir)

    oPrint:SetPortrait()
    oPrint:SetPaperSize(9) //? Tamanho A4

    oPrint:StartPage()

    AADD(aTexto, "[" + Time() + "] " + 'Come�ando a p�gina do relat�rio' + '..')

    VeriQuebPg(MAX_LINE, cAlias) 

    Cabecalho() 
    ImpDados()

    IncProc("Gerando arquivo PDF...")

    oPrint:EndPage()
    oPrint:Preview()

Return

Static Function Cabecalho()

    AADD(aTexto,  "[" + Time() + "] " + 'Iniciando cabe�alho do relat�rio: ')

    oPrint:Box(15, 15, 85, 580, '-8') //? Valores em Pixel
    oPrint:Line(50, 15, 50, 580, /*COR*/ AZUL, '-6')

    oPrint:Say(35, 20, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14, , PRETO)
    oPrint:Say(70, 220, 'Pedido de Venda', oFont16, , PRETO)

    AADD(aTexto,  "[" + Time() + "] " + 'Empresa/Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL) + CRLF + CRLF)

    AADD(aTexto,  "[" + Time() + "] " + 'Pedido de Venda: ')

    oPrint:Say(nLinha, 20, 'N� Pedido'          , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 140, 'Nome Cliente'      , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 250,  'Dta Emiss�o'      , oFont12, /*LargText*/, PRETO)
    oPrint:Say(nLinha, 450, 'Cond. Pagamento'   , oFont12, /*LargText*/, PRETO)

    AADD(aTexto, "[" + Time() + "] " + 'Impress�o dos t�picos do cabe�alho do pedido de venda' + ':')

    nLinha += 5

    oPrint:Line(nLinha, 15, nLinha, 580, PRETO, '-6')

    nLinha += 20

    oPrint:Say(nLinha, 20,  Alltrim((cAlias)->(C5_NUM)),     oFont10,/*LargText*/, PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'N� Pedido: ' +  Alltrim((cAlias)->(C5_NUM)))
    oPrint:Say(nLinha, 150, Alltrim((cAlias)->(A1_NOME)),    oFont10,/*LargText*/, PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Nome Cliente: ' +  Alltrim((cAlias)->(A1_NOME)))
    oPrint:Say(nLinha, 260, Alltrim(DToC(SToD((cAlias)->(C5_EMISSAO)))), oFont10,/*LargText*/, PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Data Emiss�o: ' +  Alltrim(DToC(SToD((cAlias)->(C5_EMISSAO)))))
    oPrint:Say(nLinha, 450, Alltrim((cAlias)->(E4_DESCRI)),  oFont10,/*LargText*/, PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Cond. Pagamento: ' + Alltrim((cAlias)->(E4_DESCRI)))

    nLinha += 40

    oPrint:Say(nLinha, 20,  'N� Item'         , oFont12, , PRETO)
    oPrint:Say(nLinha, 105, 'Cod. Produto'    , oFont12, , PRETO)
    oPrint:Say(nLinha, 205, 'Descri. Produto' , oFont12, , PRETO)
    oPrint:Say(nLinha, 320, 'Qtd. Vendida'    , oFont12, , PRETO)
    oPrint:Say(nLinha, 395, 'Valor Unit�rio'  , oFont12, , PRETO)
    oPrint:Say(nLinha, 475, 'VALOR TOTAL'     , oFont12, , PRETO)
    AADD(aTexto, "[" + Time() + "] " + 'Impress�o dos itens do pedido de venda, os produtos' + ':')

    nLinha += 5

    oPrint:Line(nLinha, 15, nLinha, 580, /*COR*/, '-6')

    nLinha += 20

    IncProc("Imprimindo Cabe�alho...")

Return 

Static Function ImpDados()

    Local cString := ''
    Local nValTot := 0

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    While (cAlias)->(!EOF())

        oPrint:Say(nLinha, 20, AllTrim((cAlias)->(C6_ITEM))    , oFont10, , PRETO) //? C�DIGO DO PRODUTO

        cString := AllTrim((cAlias)->(C6_PRODUTO)) //? DESCRI��O
        VeriQuebLin(cString, 20, 105) //? VERIFICA A QUEBRA DA DESCRI��O
        AADD(aTexto,  "[" + Time() + "] " + 'Produto: ' + AllTrim((cAlias)->(C6_PRODUTO)))

        cString := AllTrim((cAlias)->(CValToChar((C6_DESCRI))))//? QUANTIDADE
        VeriQuebLin(cString, 25, 210) //? VERIFICA A QUEBRA DA QUANTIDADE
        AADD(aTexto,  "[" + Time() + "] " + 'Descri��o: ' + AllTrim((cAlias)->(CValToChar((C6_DESCRI)))))

        if (cAlias)->(C6_QTDVEN) == 0
            cString := '00'
        else
            cString := AllTrim((cAlias)->(StrTran(CValToChar(C6_QTDVEN), ".", ","))) //? PRE�O UNIT�RIO
        endif

        VeriQuebLin(cString, 15, 345) //? VERIFICA A QUEBRA DO PRE�O UNIT�RIO
        AADD(aTexto,  "[" + Time() + "] " + 'Quantidade: ' + AllTrim((cAlias)->(StrTran(CValToChar(C6_QTDVEN), ".", ","))))

        if (cAlias)->(C6_PRCVEN) == 0
            cString := 'R$ 0,00'
        else
            cString := 'R$ ' + AllTrim((cAlias)->(StrTran(CValToChar(C6_PRCVEN), ".", ","))) //? PRE�O UNIT�RIO
        endif

        VeriQuebLin(cString, 15, 410) //? VERIFICA A QUEBRA DO PRE�O UNIT�RIO
        AADD(aTexto,  "[" + Time() + "] " + 'Pre�o: R$ ' + AllTrim((cAlias)->(StrTran(CValToChar(C6_PRCVEN), ".", ","))))

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

    AADD(aTexto, "[" + Time() + "] " + 'Impres�o do totalizador no relat�rio' + ';')
    AADD(aTexto, "[" + Time() + "] " + 'Totalizador: ' + "R$ " + (StrTran(CValToChar(nValTot), ".", ",")))
    AADD(aTexto, "[" + Time() + "] " + 'Relat�rio Finalizado' + '.')

    IncProc()

    (cAlias)->(DbCloseArea())

Return

Static Function VeriQuebLin(cString, nQtdChar, nCol)

    Local cTxtLinha  := ''
    Local lTemQuebra := .F.
    Local nQtdLinhas := MLCount(cString, nQtdChar, /*Tabula��o*/, .F.)
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

Static Function CriaDir()

    if !ExistDir(cDir)
        if MakeDir(cDir) == 0 //? Se a pasta n�o existir!
            FWAlertSuccess('Pasta criada com sucesso!', 'CONCLUIDO!')
        else
            FWAlertError('Houve um erro ao criar a pasta!' + CRLF + CRLF + cCaminho, 'ERRO!')
        endif
    else //? Se a pasta existir!
        if FWAlertYesNo('J� existe uma pasta neste local com o nome: ' + cNomePasta, 'Deseja sobrep�-la?')
            //? SIM, deleta a pasta
            DelPasta()
            //? Cria a mesma!
            if MakeDir(cDir) == 0 //? Se a pasta n�o existir!
                FWAlertSuccess('Pasta criada com sucesso!', 'CONCLUIDO!')
            else
                FWAlertError('Houve um erro ao criar a pasta!' + CRLF + CRLF + cCaminho, 'ERRO!')
            endif
        endif
        //? N�O, mant�m a mesma..
    endif

Return 

Static Function DelPasta()

    Local aArquivos := Directory(cDir + '*.*', 'D', /*Compatibilidade*/, /*ChangeCase*/, 1) //? Retorna o conte�do da pasta!
    Local nI        := 0

    if ExistDir(cDir)
        if FWAlertYesNo('Confirma a exclus�o da pasta? ', 'ATEN��O')
            if LEN(aArquivos) > 0
                for nI := 3 to LEN(aArquivos)
                    if FErase(cDir + aArquivos[nI][1]) == -1
                        FWAlertWarning('Houve um erro ao apagar o arquivo ' + aArquivos[nI][1])
                    endif
                next
            endif

            if DirRemove(cDir)
                FWAlertSuccess('Pasta apagada com sucesso', 'CONCLU�DO')
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
        FWAlertInfo('O arquivo j� existe!', 'ATEN��O')
        if !oWriter:Create()
            FWAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'ERRO!')
        else
            if FWAlertYesNo('Deseja sobrescrever o arquivo TXT?', 'PERGUNTA')
                //? Texto a ser escrito
                oWriter:Write(CRLF)
                oWriter:Write("C�digo do Usu�rio: " + RetCodUsr() + CRLF)
                oWriter:Write("Nome do Usu�rio:   " + UsrRetName(RetCodUsr()) + CRLF)
                oWriter:Write("Fun��o (FunName):  " + FunName() + CRLF)
                oWriter:Write("Ambiente:          " + GetEnvServer() + CRLF)
                oWriter:Write(CRLF)
                oWriter:Write(cTXTLog)
                oWriter:Write(CRLF + CRLF)
                oWriter:Write("Log conclu�do, data [" + dToC(Date()) + "] e hora [" + Time() + "]" + CRLF)
                oWriter:Write("_______________________________________________________________________________________________________________________________________________________________________________________________" + CRLF)
                oWriter:Write(CRLF)

                oWriter:Close()

                if FWAlertYesNo('Arquivo gerado com sucesso ('+ cDir +')!' + CRLF + 'Deseja abrir o arquivo?', 'ABRIR')
                    ShellExecute('OPEN', cLogTXT, /*Compatibilidade*/ '', cCaminho + cNomePasta, /*Modo de exibi��o*/ 1)
                endif
            endif
        endif
    else
        if !oWriter:Create()
            FWAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'ERRO!')
        else
            //? Texto a ser escrito
            oWriter:Write(CRLF)
            oWriter:Write("C�digo do Usu�rio: " + RetCodUsr() + CRLF)
            oWriter:Write("Nome do Usu�rio:   " + UsrRetName(RetCodUsr()) + CRLF)
            oWriter:Write("Fun��o (FunName):  " + FunName() + CRLF)
            oWriter:Write("Ambiente:          " + GetEnvServer() + CRLF)
            oWriter:Write(CRLF)
            oWriter:Write(cTXTLog)
            oWriter:Write(CRLF + CRLF)
            oWriter:Write("Log conclu�do, data [" + dToC(Date()) + "] e hora [" + Time() + "]" + CRLF)
            oWriter:Write("_______________________________________________________________________________________________________________________________________________________________________________________________" + CRLF)
            oWriter:Write(CRLF)

            oWriter:Close()

            if FWAlertYesNo('Arquivo gerado com sucesso ('+ cDir +')!' + CRLF + 'Deseja abrir o arquivo?', 'ABRIR')
                ShellExecute('OPEN', cLogTXT, /*Compatibilidade*/ '', cCaminho + cNomePasta, /*Modo de exibi��o*/ 1)
            endif
        endif
    endif

Return 
