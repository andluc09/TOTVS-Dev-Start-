#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ArqTXT
    Lista 13 - Manipula��o de Arquivos | Exerc�cio 02
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

User Function ArqTXT()

    Local cPasta    := GetTempPath() //? Determina o diret�rio da pasta tempor�ria do Windows: C:\Users\Andr� Lucas\AppData\Local\Temp\
    Local cArquivo  := 'Lista 13 - Exerc. 02.txt'
    Local cDir      := cPasta + "Lista 13 - Exerc. 01\" + cArquivo
    Local oWriter   := FWFileWriter():New(cDir, .T.)

    if File(cDir)
        FWAlertInfo('O arquivo j� existe!', 'ATEN��O')
        if !oWriter:Create()
            FWAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'ERRO!')
        else
            if FWAlertYesNo('Deseja sobrescrever o arquivo TXT?', 'PERGUNTA')
                oWriter:Write(CRLF + ' Ol�, ' + CRLF + CRLF + ' Voc� � o 0 "N�o" ou 1 " Sim " ?' + CRLF + CRLF + CRLF + '         TOTVS IP')

                oWriter:Close()

                if FWAlertYesNo('Arquivo gerado com sucesso ('+ cDir +')!' + CRLF + 'Deseja abrir o arquivo?', 'ABRIR')
                    ShellExecute('OPEN', cArquivo, /*Compatibilidade*/ '', cPasta + "Lista 13 - Exerc. 01\", /*Modo de exibi��o*/ 1)
                endif
            endif
        endif
    else
        if !oWriter:Create()
            FWAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'ERRO!')
        else
            oWriter:Write(CRLF + ' Ol�, ' + CRLF + CRLF + ' Voc� � o 1 " Sim " ou 0 "N�o" ?' + CRLF + CRLF + CRLF + '         TOTVS IP')

            oWriter:Close()

            if FWAlertYesNo('Arquivo gerado com sucesso ('+ cDir +')!' + CRLF + 'Deseja abrir o arquivo?', 'ABRIR')
                ShellExecute('OPEN', cArquivo, /*Compatibilidade*/ '', cPasta + "Lista 13 - Exerc. 01\", /*Modo de exibi��o*/ 1)
            endif
        endif
    endif

Return 
