#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CleanDir
    Lista 13 - Manipula��o de Arquivos | Exerc�cio 05
    @type  Function
    @author Andr� Lucas M. Santos
    @since 26/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FWFileWriter
    @see https://tdn.totvs.com/display/public/framework/FWFileReader
    @see https://tdn.totvs.com/display/tec/ExistDir
    @see https://tdn.totvs.com/display/tec/MakeDir
    @see https://tdn.totvs.com/display/tec/DirRemove
    @see https://tdn.totvs.com/display/tec/Directory
    @see https://tdn.totvs.com/display/tec/FErase
/*/

User Function CleanDir()

    Local cCaminho   := GetTempPath() //? Determina o diret�rio da pasta tempor�ria do Windows: C:\Users\Andr� Lucas\AppData\Local\Temp\
    Local cNomePasta := 'Lista 13 - Exerc. 01/'
    Local cDir       := cCaminho + cNomePasta
    Local aArquivos  := Directory(cDir + '*.*', 'D', /*Compatibilidade*/, /*ChangeCase*/, 1) //? Retorna o conte�do da pasta!
    Local nI         := 0

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
