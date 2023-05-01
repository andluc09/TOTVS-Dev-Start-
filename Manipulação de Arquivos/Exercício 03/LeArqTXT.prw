#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function LeArqTXT
    Lista 13 - Manipulação de Arquivos | Exercício 03
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

User Function LeArqTXT()

    Local cPasta    := GetTempPath()
    Local cArquivo  := 'Lista 13 - Exerc. 02.txt'
    Local cTXTLinha := ''
    Local nCont     := 1
    Local cDir      := cPasta + "Lista 13 - Exerc. 01\" + cArquivo
    Local oArq      := FWFileReader():New(cDir)

    if oArq:Open()
        if !oArq:EOF() //! Arquivo está vazio?
            while oArq:HasLine() //* Enquanto houver linha, grave na variável cTxtLinha
                cTxtLinha += 'Linha ' + cValToChar(nCont) + ': ' + oArq:GetLine(.T.) //? .F. não pula linha!
                nCont++
            enddo
        endif
        oArq:Close()
    endif

    FWAlertInfo(cTxtLinha, 'Conteúdo do Arquivo: ')

Return
