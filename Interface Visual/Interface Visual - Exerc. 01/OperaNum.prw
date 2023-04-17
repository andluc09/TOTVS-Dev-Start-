#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function OperaNum
    Lista 04 - Interfaces Visuais | Exercício 01
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function OperaNum()

    Local nNum1    := SPACE(9)
    Local nNum2    := SPACE(9)
    Local cTitle   := ' Operações Básicas ' // *Título
    Local cTexto   := ' Insira dois números para efetuar as operações: '
    Local nOpcao   := 0    
    Local nJanAltu := 245
    Local nJanLarg := 313
    Local oBtnConf := NIL
    Private oDlg   := NIL //* Variável objeto que recebe os componentes da caixa de diálogo.

    //* Cria uma caixa de diálogo no padrão Windows com o título da variável cTítulo que começa no canto (FROM) que define a alta e a largura. 
    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanAltu, nJanLarg FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL

    //* Item que ficará dentro da janela de diálogo ('OF' define o componente pai PAI: oDlg)
    @ 014, 010  SAY cTexto       SIZE 150, 10 OF oDlg PIXEL
    @ 035, 025  SAY ' Número 1 ' SIZE 75, 10  OF oDlg PIXEL
    @ 035, 065  MSGET nNum1      SIZE 55, 11  OF oDlg PIXEL PICTURE '@# 999999999'//* MSGET irá abrir uma área de input que salvará a informação dentro de uma variável.
    @ 055, 025  SAY ' Número 2 ' SIZE 75, 10  OF oDlg PIXEL
    @ 055, 065  MSGET nNum2      SIZE 55, 11  OF oDlg PIXEL PICTURE '@# 999999999'

    @ 085, 036 BUTTON oBtnConf PROMPT 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 085, 085 BUTTON oBtnConf PROMPT 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())
    oBtnConf:SetCSS("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDIALOG oDlg CENTERED //* Ativa a caixa de diálogo oDlg centralizada.     

    if nOpcao == 1
        Operacoes(Val(nNum1), Val(nNum2))
    Else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif

Return

//? Função que chamará os cálculos e irá trazer a mensagem com a resposta.
Static Function Operacoes(nNum1, nNum2)
    Local aNums := {}

    AADD(aNums, nNum1 )
    AADD(aNums, nNum2 )

    FwAlertInfo( CRLF + CRLF +;
                cValToChar(aNums[1]) + ' + ' + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Soma(aNums)),".",",") + CRLF +;
                cValToChar(aNums[1]) + ' - ' + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Diferenca(aNums)),".",",") + CRLF +;
                cValToChar(aNums[1]) +' * '  + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Produto(aNums)),".",",") + CRLF +;
                cValToChar(aNums[1]) +' / '  + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Quociente(aNums)),".",","), 'Operações Básicas' )

Return

//? Adição
Static Function Soma(aNums)
    Local nSoma := 0

    nSoma := aNums[1] + aNums[2]

Return nSoma

//? Subtração
Static Function Diferenca(aNums)
    Local nDiferenca := 0

    nDiferenca := aNums[1] - aNums[2]

Return nDiferenca

//? Multiplicação
Static Function Produto(aNums)
    nProduto := 0

    nProduto := (aNums[1] * aNums[2])

Return nProduto

//? Divisão
Static Function Quociente(aNums)
    nQuociente := 0

    nQuociente := (aNums[1] / aNums[2])

Return nQuociente
