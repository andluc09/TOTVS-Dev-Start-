#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CvertMoeda
    Lista 04 - Interfaces Visuais | Exerc�cio 02
    @type  Function
    @author Andr� Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function CvertMoeda()

    Local nCotacao := SPACE(9)
    Local nQtd     := SPACE(9)
    Local cTitle   := ' Convers�o Moeda ' //* T�tulo
    Local cTexto   := ' Insira o valor da cota��o do dol�r e a quantidade: '
    Local nOpcao   := 0
    Local nJanAltu := 245
    Local nJanLarg := 327
    Private oDlg   := NIL //* Vari�vel objeto que recebe os componentes da caixa de di�logo.


    //* Cria uma caixa de di�logo no padr�o Windows com o t�tulo da vari�vel cT�tulo que come�a no canto (FROM) que define a alta e a largura. 
    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanAltu, nJanLarg  FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL

    //*Item que ficar� dentro da janela de di�logo ('OF' define o componente pai)
    @ 014, 010  SAY cTexto              SIZE 150, 10 OF oDlg PIXEL
    @ 035, 020  SAY 'Cota��o USD (R$)'  SIZE 75, 10  OF oDlg PIXEL
    @ 035, 081  MSGET nCotacao          SIZE 55, 15  OF oDlg PIXEL PICTURE '@# 999999999'//* MSGET ir� abrir uma �rea de input que salvar� a informa��o dentro de uma vari�vel.
    @ 055, 020  SAY 'Quantidade'        SIZE 75, 10  OF oDlg PIXEL
    @ 055, 081  MSGET nQtd              SIZE 55, 15  OF oDlg PIXEL PICTURE '@# 999999999'

    @ 085, 036 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 085, 085 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED //* Ativa a caixa de di�logo oDlg centralizada.     

    if nOpcao == 1
        ConversaoM(Val(nCotacao), Val(nQtd))
    Else
        FwAlertWarning('<b>Cancelado</b> pelo usu�rio!', 'CANCELADO')
    endif

Return

Static Function ConversaoM(nCotacao, nQtd)

    Local nReais := 0

    nReais := nCotacao * nQtd

    FWAlertInfo(CRLF + CRLF +' No dia de hoje: <b>U$</b> ' + Alltrim(Str(nQtd, 10, 2)) + CRLF + CRLF + ' Equivalem a: <b>R$</b> ' + StrTran(Alltrim(Str(nReais, 10, 2)),".",","), 'Hoje: ' + FWTimeStamp(2, Date(), Time()))

Return
