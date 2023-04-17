#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CadstSistm
    Lista 04 - Interfaces Visuais | Exercício 07
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function CadstSistm()

    Local cUser   := SPACE(30)
    Local cSenha1 := SPACE(30)
    Local cSenha2 := SPACE(30)
    Private oDlg 

    DEFINE MSDIALOG oDlg TITLE "Login" FROM 000, 000 to 225, 330 FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL 

    @ 007, 010 SAY "Faça login"              SIZE 75, 11 OF oDlg PIXEL
    @ 025, 010 SAY "Digite o seu usarname: " SIZE 80, 14 OF oDlg PIXEL
    @ 022, 090 MSGET cUser                   SIZE 60, 11 OF oDlg PIXEL 

    @ 045, 010 SAY "Digite a sua senha: "    SIZE 80, 14 OF oDlg PIXEL
    @ 042, 090 MSGET cSenha1                 SIZE 60, 11 OF oDlg PIXEL PASSWORD

    @ 065, 010 SAY "Confirme a senha: "      SIZE 80, 14 OF oDlg PIXEL
    @ 062, 090 MSGET cSenha2                 SIZE 60, 11 OF oDlg PIXEL PASSWORD

    @ 090, 025 BUTTON "Realizar Cadastro!"   SIZE 120, 14 OF oDlg PIXEL;
    ACTION (ConfirmCad(Alltrim(cUser), Alltrim(cSenha1), Alltrim(cSenha2)))

    ACTIVATE MSDIALOG oDlg CENTERED

Return 

Static Function ConfirmCad(cUser, cSenha1, cSenha2)

    Local nI    := 0 
    Local lNum  := .F.
    Local lUp   := .F.
    Local lSymb := .F.
    Local lUser := .F.
    Local lPass := .F.

    //? O “username” deve possuir mais do que 5 caracteres.
    if  LEN(cUser) < 5 
        FWAlertError("Username deve ter mais de 5 caracteres!")
    else
        lUser := .T.
    endif

    //? A senha deve possuir ao menos 6 caracteres.
    if len(cSenha1) < 6  
        FwAlertError("Senha inválida!" +CRLF+CRLF+ "A senha deve conter 6 ou mais caracteres!")
    else
        lPass := .T.
    endif

    //? Ao menos uma letra maiúscula.
    for nI := 1 TO len(cSenha1)
        if isUpper(SubStr(cSenha1, nI , 1))
            lUp := .T.
            Exit
        endif
    next nI

    //? Ao menos um dígito numérico.
    for nI := 1 to len(cSenha1)
        if IsDigit(SubStr(cSenha1, nI , 1))
            lNum := .T.
            Exit 
        endif
    next nI

    //? Ao menos um símbolo.
    for nI := 1 to len(cSenha1)
        if (ASC(SubStr(cSenha1, nI, 1)) >= 33 .AND. ASC(SubStr(cSenha1, nI, 1)) <= 47) .OR. (ASC(SubStr(cSenha1, nI, 1)) >=58 .AND. ASC(SubStr(cSenha1, nI, 1)) <=64) .OR. (ASC(SubStr(cSenha1, nI, 1)) >= 91 .AND. ASC(SubStr(cSenha1, nI, 1)) <= 96) .OR. (ASC(SubStr(cSenha1, nI, 1)) >= 123 .AND. ASC(SubStr(cSenha1, nI, 1)) <= 126)
            lSymb := .T.
            Exit  
        endif 
    next nI

    //? Validação Total
    if (lUser .AND. lPass .AND. lUp .AND. lNum .AND. lSymb)
        //? A senha e a confirmação da senha devem ser idênticas.
        if (cSenha1 == cSenha2 .AND. !Empty(cSenha1) .AND. !Empty(cSenha2))
            FwAlertSuccess("Usuário cadastrado com sucesso!")
            oDlg:END()
        else
            FWAlertError("As senhas não coincidem!") 
        endif
    elseif (lUp == .F. .AND. lNum == .F. .AND. lSymb == .F.)
        FWAlertError("A senha deve possuir pelo menos uma letra maiúscula, um número e um símbolo!")
    elseif (lUp == .F.)
        FWAlertError("A senha deve possuir pelo menos uma letra maiúscula!")      
    elseif (lNum == .F.)
        FWAlertError("A senha deve possuir pelo menos um número!")      
    elseif (lSymb == .F.)
        FWAlertError("A senha deve possuir pelo menos um símbolo!")      
    endif

Return
