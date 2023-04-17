#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function OperaNum
    Lista 04 - Interfaces Visuais | Exerc�cio 01
    @type  Function
    @author Andr� Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function OperaNum()

    Local nNum1    := SPACE(9)
    Local nNum2    := SPACE(9)
    Local cTitle   := ' Opera��es B�sicas ' // *T�tulo
    Local cTexto   := ' Insira dois n�meros para efetuar as opera��es: '
    Local nOpcao   := 0    
    Local nJanAltu := 245
    Local nJanLarg := 313
    Local oBtnConf := NIL
    Private oDlg   := NIL //* Vari�vel objeto que recebe os componentes da caixa de di�logo.

    //* Cria uma caixa de di�logo no padr�o Windows com o t�tulo da vari�vel cT�tulo que come�a no canto (FROM) que define a alta e a largura. 
    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanAltu, nJanLarg FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL

    //* Item que ficar� dentro da janela de di�logo ('OF' define o componente pai PAI: oDlg)
    @ 014, 010  SAY cTexto       SIZE 150, 10 OF oDlg PIXEL
    @ 035, 025  SAY ' N�mero 1 ' SIZE 75, 10  OF oDlg PIXEL
    @ 035, 065  MSGET nNum1      SIZE 55, 11  OF oDlg PIXEL PICTURE '@# 999999999'//* MSGET ir� abrir uma �rea de input que salvar� a informa��o dentro de uma vari�vel.
    @ 055, 025  SAY ' N�mero 2 ' SIZE 75, 10  OF oDlg PIXEL
    @ 055, 065  MSGET nNum2      SIZE 55, 11  OF oDlg PIXEL PICTURE '@# 999999999'

    @ 085, 036 BUTTON oBtnConf PROMPT 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 085, 085 BUTTON oBtnConf PROMPT 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())
    oBtnConf:SetCSS("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDIALOG oDlg CENTERED //* Ativa a caixa de di�logo oDlg centralizada.     

    if nOpcao == 1
        Operacoes(Val(nNum1), Val(nNum2))
    Else
        FwAlertWarning('<b>Cancelado</b> pelo usu�rio!', 'CANCELADO')
    endif

Return

//? Fun��o que chamar� os c�lculos e ir� trazer a mensagem com a resposta.
Static Function Operacoes(nNum1, nNum2)
    Local aNums := {}

    AADD(aNums, nNum1 )
    AADD(aNums, nNum2 )

    FwAlertInfo( CRLF + CRLF +;
                cValToChar(aNums[1]) + ' + ' + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Soma(aNums)),".",",") + CRLF +;
                cValToChar(aNums[1]) + ' - ' + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Diferenca(aNums)),".",",") + CRLF +;
                cValToChar(aNums[1]) +' * '  + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Produto(aNums)),".",",") + CRLF +;
                cValToChar(aNums[1]) +' / '  + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Quociente(aNums)),".",","), 'Opera��es B�sicas' )

Return

//? Adi��o
Static Function Soma(aNums)
    Local nSoma := 0

    nSoma := aNums[1] + aNums[2]

Return nSoma

//? Subtra��o
Static Function Diferenca(aNums)
    Local nDiferenca := 0

    nDiferenca := aNums[1] - aNums[2]

Return nDiferenca

//? Multiplica��o
Static Function Produto(aNums)
    nProduto := 0

    nProduto := (aNums[1] * aNums[2])

Return nProduto

//? Divis�o
Static Function Quociente(aNums)
    nQuociente := 0

    nQuociente := (aNums[1] / aNums[2])

Return nQuociente
