#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CvertMoeda
    Lista 04 - Interfaces Visuais | Exercício 02
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function CvertMoeda()

    Local nCotacao := SPACE(9)
    Local nQtd     := SPACE(9)
    Local cTitle   := ' Conversão Moeda ' //* Título
    Local cTexto   := ' Insira o valor da cotação do dolár e a quantidade: '
    Local nOpcao   := 0
    Local nJanAltu := 245
    Local nJanLarg := 327
    Private oDlg   := NIL //* Variável objeto que recebe os componentes da caixa de diálogo.


    //* Cria uma caixa de diálogo no padrão Windows com o título da variável cTítulo que começa no canto (FROM) que define a alta e a largura. 
    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanAltu, nJanLarg  FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL

    //*Item que ficará dentro da janela de diálogo ('OF' define o componente pai)
    @ 014, 010  SAY cTexto              SIZE 150, 10 OF oDlg PIXEL
    @ 035, 020  SAY 'Cotação USD (R$)'  SIZE 75, 10  OF oDlg PIXEL
    @ 035, 081  MSGET nCotacao          SIZE 55, 15  OF oDlg PIXEL PICTURE '@# 999999999'//* MSGET irá abrir uma área de input que salvará a informação dentro de uma variável.
    @ 055, 020  SAY 'Quantidade'        SIZE 75, 10  OF oDlg PIXEL
    @ 055, 081  MSGET nQtd              SIZE 55, 15  OF oDlg PIXEL PICTURE '@# 999999999'

    @ 085, 036 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 085, 085 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED //* Ativa a caixa de diálogo oDlg centralizada.     

    if nOpcao == 1
        ConversaoM(Val(nCotacao), Val(nQtd))
    Else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif

Return

Static Function ConversaoM(nCotacao, nQtd)

    Local nReais := 0

    nReais := nCotacao * nQtd

    FWAlertInfo(CRLF + CRLF +' No dia de hoje: <b>U$</b> ' + Alltrim(Str(nQtd, 10, 2)) + CRLF + CRLF + ' Equivalem a: <b>R$</b> ' + StrTran(Alltrim(Str(nReais, 10, 2)),".",","), 'Hoje: ' + FWTimeStamp(2, Date(), Time()))

Return
