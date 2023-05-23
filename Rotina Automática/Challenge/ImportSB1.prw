#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function ImportSB1
    Rotina Automática | Challenge
    @type   Function
    @author André Lucas M. Santos
    @since 19/05/2023
    @version 0.1
    @see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=566489232
    @see https://terminaldeinformacao.com/2021/07/14/voce-sabe-o-que-significam-as-letras-na-chamada-de-um-msexecauto/
    @see https://terminaldeinformacao.com/2015/12/01/vd-advpl-011/
/*/

User Function ImportSB1()

    Local aArea     := GetArea()
    Private cArqOri := ""

    //? Mostra o Prompt para selecionar arquivos
    cArqOri := tFileDialog( "CSV files (*.csv) ", 'Seleção de Arquivos', , , .F., )

    //? Se tiver o arquivo de origem
    if ! Empty(cArqOri)

        //? Somente se existir o arquivo e for com a extensão CSV
        if File(cArqOri) .And. Upper(SubStr(cArqOri, RAt('.', cArqOri) + 1, 3)) == 'CSV'
            Processa({|| Importa() }, "Importando...")
        else
            FWAlertWarning("Arquivo e/ou extensão inválida!", "ATENÇÃO")
        endif
    endif

    RestArea(aArea)

Return

Static Function Importa()

    Local aArea      := GetArea()
    Local cArqLog    := "ImportSB1_" + dToS(Date()) + "_" + StrTran(Time(), ':', '-') + ".log"
    Local nTotLinhas := 0
    Local cLinAtu    := ""
    Local nLinhaAtu  := 0
    Local aLinha     := {}
    Local aDados     := {}
    Local nOper      := 3 //? Inclusão
    Local oArquivo   := NIL
    Local aLinhas    := 0
    Local cTexto     := ""
    Local nNum       := 0
    Local nTotal     := 0 
    Private lMsErroAuto := .F.
    Private cDirLog  := GetTempPath() + "x_importacao\"
    Private cLog     := ""

    //? Se a pasta de log não existir, cria ela
    if ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    endif

    //? Definindo o arquivo a ser lido
    oArquivo := FWFileReader():New(cArqOri)

    //? Se o arquivo pode ser aberto
    if (oArquivo:Open())

        //? Se não for fim do arquivo
        if ! (oArquivo:EoF())

            //? Definindo o tamanho da régua
            aLinhas := oArquivo:GetAllLines()
            nTotLinhas := Len(aLinhas)
            ProcRegua(nTotLinhas)

            //? Método GoTop não funciona (dependendo da versão da LIB), deve fechar e abrir novamente o arquivo
            oArquivo:Close()
            oArquivo := FWFileReader():New(cArqOri)
            oArquivo:Open()

            //? Enquanto tiver linhas
            while (oArquivo:HasLine())

                //? Incrementa na tela a mensagem
                nLinhaAtu++
                IncProc("Analisando linha " + cValToChar(nLinhaAtu) + " de " + cValToChar(nTotLinhas) + "...")

                //? Pegando a linha atual e transformando em array
                cLinAtu := oArquivo:GetLine()
                aLinha  := StrTokArr(cLinAtu, ";")

                for nNum := 1 to LEN(aLinha[1])
                    if SUBSTR(aLinha[1], nNum, 1) == ','
                        nTotal++
                    endif
                next

                if (nTotal > 5)

                    cTexto := SUBSTR(aLinha[1], 08, LEN(aLinha[1]))
                    cTexto := StrTran(cTexto,',','.', 1, 1)
                    cTexto := SUBSTR(aLinha[1], 01, 07) + cTexto
                    cTexto := StrTran(cTexto, '"', "")

                    aLinha := StrTokArr(cTexto, ",")
                    nTotal := 0

                else
                    aLinha[1] := StrTran(aLinha[1], '"', "")
                    aLinha := StrTokArr(aLinha[1], ",")
                    nTotal := 0
                endif

                PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'

                //* VERIFICAR OS CAMPOS OBRIGATÓRIOS //

                //*     Filial
                //*     Código do Produto
                //*     Descrição
                //*     Tipo
                //*     Unidade de Medida
                //*     Armazem Padrão

                if ((nLinhaAtu > 1) .AND. (aLinha[6] == 'A'))
                    AADD(aDados, {'B1_FILIAL', xFilial('SB1')                                         , NIL}) //? FwFilial() mais recente!!
                    AADD(aDados, {'B1_COD'   , CValToChar(aLinha[1])                                  , NIL}) 
                    AADD(aDados, {'B1_DESC'  , RIGHT(StrTran(CValToChar(aLinha[2]),'.',',', 1, 1), 30), NIL}) 
                    AADD(aDados, {'B1_TIPO'  , CValToChar(aLinha[3])                                  , NIL})
                    AADD(aDados, {'B1_UM'    , CValToChar(aLinha[4])                                  , NIL}) 
                    AADD(aDados, {'B1_LOCPAD', '01'                                                   , NIL})
                    AADD(aDados, {'B1_PRV1'  , VAL(aLinha[5])                                         , NIL})
                    AADD(aDados, {'B1_ATIVO' , CValToChar(aLinha[6])                                  , NIL})
                endif

                //?                                      x   ,   y
                //? MsExecAuto({|x, y| MATA010(x, y)}, aDados, nOper)
                //?                                      a   ,   b
                //? MsExecAuto({|a, b| MATA010(a, b)}, aDados, nOper)
                MsExecAuto({|aDados, nOper| MATA010(aDados, nOper)}, aDados, nOper)

                if (nLinhaAtu > 1)
                    for nNum = 1 to LEN(aDados)
                        ADEL(aDados, nNum)
                    next
                endif

                if lMsErroAuto
                    MostraErro()
                else
                    FWAlertInfo("Incluído com sucesso!", "RESULTADO")
                endif

            enddo

            //? Se tiver log, mostra ele
            if ! Empty(cLog)
                cLog := "Processamento finalizado, abaixo as mensagens de log: " + CRLF + cLog
                MemoWrite(cDirLog + cArqLog, cLog)
                ShellExecute("OPEN", cArqLog, "", cDirLog, 1)
            endif

        else
            MsgStop("Arquivo não tem conteúdo!", "Atenção")
        endif

        //? Fecha o arquivo
        oArquivo:Close()
    else
        MsgStop("Arquivo não pode ser aberto!", "Atenção")
    endif

    RestArea(aArea)

    RESET ENVIRONMENT 

Return
