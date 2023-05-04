#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function DirTemp
    Lista 13 - Manipula��o de Arquivos | Challenge
    @type  Function
    @author Andr� Lucas M. Santos
    @since 30/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/CpyS2T
    @see https://tdn.totvs.com/display/public/framework/FWFileWriter
    @see https://tdn.totvs.com/display/public/framework/FWFileReader
    @see https://tdn.totvs.com/display/tec/ExistDir
    @see https://tdn.totvs.com/display/tec/MakeDir
    @see https://tdn.totvs.com/display/tec/DirRemove
    @see https://tdn.totvs.com/display/tec/Directory
    @see https://tdn.totvs.com/display/tec/FErase
    @see https://tdn.totvs.com.br/display/tec/GetTempPath
/*/

User Function CopiPDF()

    CriaDir()

    CopiArq()

Return 

Static Function CriaDir()

    Local cCaminho   := 'C:\'
    Local cNomePasta := 'Vendas Protheus\'
    Private cDir     := cCaminho + cNomePasta

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
                        MSGStop('Houve um erro ao apagar o arquivo ' + aArquivos[nI][1])
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

Static Function CopiArq()

    Local cCaminho   := '\'
    Local cNomePasta := 'Pedidos de venda\'
    Local cPastaOrig := cCaminho + cNomePasta
    Local cPastaDest := 'C:\Vendas Protheus\'
    Local aArquivos  := Directory(cPastaOrig + '*.*', 'D', /*Compatibilidade*/, /**/, 1) 
    Local nI         := 0
    Local nTamanho   := LEN(aArquivos)

    if nTamanho > 0 
        for nI := 3 to nTamanho
            if !CpyS2T(cPastaOrig + aArquivos[nI][1], cPastaDest, .T., .T.) //! Copia do Servidor to Terminal (Cliente)
                FWAlertWarning('Houve um erro ao copiar o arquivo ' + aArquivos[nI][1])
            endif
        next 
            FWAlertSuccess('Arquivo(s) copiado com sucesso!', 'CONCLU�DO')
        else
            FWAlertInfo('A pasta n�o cont�m nenhum arquivo ou subpasta!', 'ATEN��O')
    endif

Return 
