#INCLUDE 'TOTVS.CH'

#DEFINE Usuario 'Andre'
#DEFINE Senha   'aluno123'

/*/{Protheus.doc} User Function LoginAlgtm
    Lista 04 - Interfaces Visuais | Exercício 06
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function LoginAlgtm()

    Local cTitle                 := "Login
    Local nJanAltu               := 270, nJanLarg := 270
    Local oGrpLog                := NIL
    Local oBtnConf               := NIL
    Private lRet                 := .F.
    Private oDlgPvt              := NIL
    //? Says e Gets
    Private oSayUsr              := NIL
    Private oGetUsr, cGetUsr     := SPACE(25)
    Private oSayPsw              := NIL
    Private oGetPsw, cGetPsw     := SPACE(20)
    Private oGetErr, cGetErr     := ""
    Private oGetSucss, cGetSucss := ""

    DEFINE MSDIALOG oDlgPvt TITLE cTitle FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL
        //?Grupo de Login
        @ 003, 003    GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3    PROMPT "Login: "    OF oDlgPvt COLOR 0, 16777215 PIXEL
            // !Label e Get de Usuário
            @ 023, 006   SAY   oSayUsr PROMPT "Usuários:"       SIZE 030, 007 OF oDlgPvt PIXEL
            @ 033, 006   MSGET oGetUsr VAR    cGetUsr           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL

            // !Label e Get da Senha
            @ 053, 006   SAY   oSayPsw PROMPT "Senha:"          SIZE 030, 007 OF oDlgPvt PIXEL
            @ 063, 006   MSGET oGetPsw VAR    cGetPsw           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD

            // !Get de Log, pois se for Say, não da para definir a cor
            @ 085, 006   MSGET oGetErr VAR    cGetErr           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 NO BORDER PIXEL
            oGetErr:lActive := .F.
            oGetErr:SetCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")

            // !Get de Log, pois se for Say, não da para definir a cor
            @ 095, 006   MSGET oGetSucss VAR    cGetSucss       SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 NO BORDER PIXEL
            oGetSucss:lActive := .F.
            oGetSucss:SetCSS("QLineEdit{color:#007DFA; background-color:#FEFEFE;}")

            // !Botões
            @ (nJanAltu/2)-18, 006 BUTTON oBtnConf PROMPT "Confirmar"             SIZE (nJanLarg/2)-12, 015 OF oDlgPvt ACTION (ValidUsr()) PIXEL
            oBtnConf:SetCSS("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDIALOG oDlgPvt CENTERED

    //? Se a rotina foi confirmada e deu certo, atualiza o usuário e a senha
    if lRet
        cUsrLog := Alltrim(cGetUsr)
        cPswLog := Alltrim(cGetPsw)
    endif

Return lRet

Static Function ValidUsr()

    Local cUsrAux := Alltrim(cGetUsr)
    Local cPswAux := Alltrim(cGetPsw)

    //? Pega o código do usuário
    if (cUsrAux == Usuario .AND. cPswAux == Senha .AND. !Empty(cUsrAux) .AND. !Empty(cPswAux))
        cGetSucss := "Usuário e senha permitido!"
        oGetSucss:Refresh() //* Refresh faz a mensagem dentro de cGetSucss aparecer na tela, pois acima o activate estava em .F.
        lRet := .T.
    else
        cGetErr := "Usuário inválido e/ou senha inválidos!"
        oGetErr:Refresh() //* Refresh faz a mensagem dentro de cGetErr aparecer na tela, pois acima o activate estava em .F.
    endif

    if (lRet)
        oDlgPvt:End()
    endif

Return
