#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ArqTXT
    Lista 13 - Manipulação de Arquivos | Exercício 02
    @type  Function
    @author André Lucas M. Santos
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

User Function ArqTXT()

    Local cPasta    := GetTempPath() //? Determina o diretório da pasta temporária do Windows: C:\Users\André Lucas\AppData\Local\Temp\
    Local cArquivo  := 'Lista 13 - Exerc. 02.txt'
    Local cDir      := cPasta + "Lista 13 - Exerc. 01\" + cArquivo
    Local oWriter   := FWFileWriter():New(cDir, .T.)

    if File(cDir)
        FWAlertInfo('O arquivo já existe!', 'ATENÇÃO')
        if !oWriter:Create()
            FWAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'ERRO!')
        else
            if FWAlertYesNo('Deseja sobrescrever o arquivo TXT?', 'PERGUNTA')
                oWriter:Write(CRLF + ' Olá, ' + CRLF + CRLF + ' Você é o 0 "Não" ou 1 " Sim " ?' + CRLF + CRLF + CRLF + '         TOTVS IP')

                oWriter:Close()

                if FWAlertYesNo('Arquivo gerado com sucesso ('+ cDir +')!' + CRLF + 'Deseja abrir o arquivo?', 'ABRIR')
                    ShellExecute('OPEN', cArquivo, /*Compatibilidade*/ '', cPasta + "Lista 13 - Exerc. 01\", /*Modo de exibição*/ 1)
                endif
            endif
        endif
    else
        if !oWriter:Create()
            FWAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'ERRO!')
        else
            oWriter:Write(CRLF + ' Olá, ' + CRLF + CRLF + ' Você é o 1 " Sim " ou 0 "Não" ?' + CRLF + CRLF + CRLF + '         TOTVS IP')

            oWriter:Close()

            if FWAlertYesNo('Arquivo gerado com sucesso ('+ cDir +')!' + CRLF + 'Deseja abrir o arquivo?', 'ABRIR')
                ShellExecute('OPEN', cArquivo, /*Compatibilidade*/ '', cPasta + "Lista 13 - Exerc. 01\", /*Modo de exibição*/ 1)
            endif
        endif
    endif

Return 
