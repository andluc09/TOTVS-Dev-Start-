#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Cadast16
    Lista 02 - Fundamentos da Linguagem ADVPL | Exercício 16
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Cadast16()

    Local nI      := 0 
    Local lNum    := .F.
    Local lUp     := .F.
    Local lSymb   := .F.
    Local lUser   := .F.
    Local lPass   := .F.
    Local cUser   := ''
    Local cSenha1 := ''
    Local cSenha2 := ''

    cUser := FWInputBox('Digite o seu usarname: ', 'nickname')

    cSenha1 := FWInputBox('Digite a sua senha: ', 'password')

    cSenha2 := FWInputBox('Confirme a senha: ', 'password')

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
