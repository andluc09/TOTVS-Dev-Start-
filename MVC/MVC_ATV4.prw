#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MVC_ATV4
    MVC | Atividade 04 - Lista 08
    @type  Function
    @author André Lucas M. Santos
    @since 29/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FwmBrowse
    @see https://tdn.totvs.com/display/public/framework/AdvPl+utilizando+MVC
/*/

User Function MVC_ATV4()

    Local cAlias       := 'ZZ4'
    Local cTitle       := 'Cadastro de Alunos' 
    Local oMark        := FWMarkBrowse():New()
    Private cInstAtual := ''

    oMark:SetAlias(cAlias)
    oMark:SetDescription(cTitle)
    oMark:SetFieldMark('ZZ4_MARC')

    oMark:AddButton('Marcar Todos', 'U_MarcaAlu', , 1)
    oMark:AddButton('Desmarcar Todos', 'U_DesmarcAlu', , 1)
    oMark:AddButton('Inverter Todos', 'U_InvertAlu', , 1)
    oMark:AddButton('Deletar Marcados', 'U_DeletAlu', 5, 1)

    oMark:DisableDetails()
    oMark:DisableReport()
    oMark:Activate()

Return()

Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir' ACTION 'VIEWDEF.MVC_ATV4' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar' ACTION 'VIEWDEF.MVC_ATV4' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir' ACTION 'VIEWDEF.MVC_ATV4' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local bModelPos := {|oModel| ValidPos(oModel)} //? Tipo b (bloco de código)
    Local oModel    := MPFormModel():New('MATV4', NIL, bModelPos)
    Local oStruZZ4  := FWFormStruct(1, 'ZZ4')
    Local aGatNome  := FwStruTrigger('ZZ4_CODINS', 'ZZ4_NOMINS', 'ZZ3->ZZ3_NOME', .T., 'ZZ3', 1, 'xFilial("ZZ3")+AllTrim(M->ZZ4_CODINS)')
                    //?FwStruTrigger: ( cDom, cCDom, cRegra, lSeek, cAlias, nOrdem, cChave, cCondic )

    oStruZZ4:AddTrigger(aGatNome[1], aGatNome[2], aGatNome[3], aGatNome[4])

    oStruZZ4:SetProperty('ZZ4_AULAS', MODEL_FIELD_VALUES, {'SIM', 'NÃO', ''})

    oStruZZ4:SetProperty('ZZ4_AULAS', MODEL_FIELD_VALID, { |oModel| ValidInst(oModel)})

    oStruZZ4:SetProperty('ZZ4_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GetSX8Num("ZZ4", "ZZ4_COD")'))

    oModel:SetDescription('Modelo de Cadastro de Alunos')

    oModel:AddFields('ZZ4MASTER', /*COMPONENTE PAI*/, oStruZZ4)

    oModel:GetModel('ZZ4MASTER'):SetDescription('Formulário - Cadastro de Alunos')

    oModel:SetPrimaryKey({'ZZ4_COD'})

Return oModel

Static Function ViewDef()

    Local oModel       := FWLoadModel('MVC_ATV4')
    Local oStructZZ4   := FWFormStruct(2, 'ZZ4')
    Local oView        := FWFormView():New()

    oStructZZ4:SetProperty('ZZ4_AULAS' , MVC_VIEW_COMBOBOX, {'SIM', 'NÃO',''})

    oStructZZ4:GetProperty('ZZ4_CODINS', MVC_VIEW_LOOKUP)

    oStructZZ4:SetProperty('ZZ4_CODINS', MVC_VIEW_LOOKUP, "ZZ3")

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZ4', oStructZZ4, 'ZZ4MASTER')

    oView:CreateHorizontalBox('Cadastro de Alunos', 100)

    oView:SetOwnerView('VIEW_ZZ4', 'Cadastro de Alunos') //* Demonstra a quem essa view pertence

    oView:EnableTitleView('VIEW_ZZ4', 'Cadastro de Alunos')
    
    oView:SetAfterViewActivate({|oView| InstAtual(oView)})

Return oView

Static Function ValidPos(oModel)

    Local nOperation  := oModel:GetOperation()
    Local cAulas      := oModel:GetValue('ZZ4MASTER', 'ZZ4_AULAS')
    Local cCodInst    := oModel:GetValue('ZZ4MASTER', 'ZZ4_CODINS')
    Local nQtdAluno   := 0
    Local nQtdAtual   := 0
    Local lOk         := .T.

    ZZ3->(GetArea())
    ZZ3->(DBSelectArea('ZZ3'))
    ZZ3->(DBSetOrder(1))
    ZZ3->(DBGoTop())

    if(nOperation == 5 .AND. cAulas == "SIM")
        lOk := .F.
        HELP(NIL, NIL, 'Não é possível excluir o aluno!', NIL, 'O aluno possuí aula(as).', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Alterar o campo "Aula" para <b>NÃO</b>.'})
    elseif(nOperation == 5 .AND. cAulas <> "SIM")
        If (ZZ3->(DBSeek(xFilial('ZZ3')+(cCodInst))))
            nQtdAluno := ZZ3->ZZ3_QTDALU
            nQtdAluno--
            ZZ3->(RecLock('ZZ3', .F.))
            ZZ3->ZZ3_QTDALU := nQtdAluno
            ZZ3->(MSUnlock())
        endif
    elseif(nOperation == 3)
        if(ZZ3->(DBSeek(xFilial('ZZ3')+cCodInst)))
            nQtdAluno := ZZ3->ZZ3_QTDALU
            if(nQtdAluno < 5 .AND. !Empty(cCodInst))
                nQtdAluno++
                ZZ3->(RecLock('ZZ3', .F.))
                ZZ3->ZZ3_QTDALU := nQtdAluno
                ZZ3->(MSUnlock())
            else
                lOk := .F.
                HELP(NIL, NIL, 'Não é possível adicionar alunos a este instrutor!', NIL, 'O instrutor já possuí <b>5 alunos</b>, está indisponível.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Escolha outro instrutor disponível.'})            
            endif
        endif
    elseif(nOperation == 4)
        if(ZZ3->(DBSeek(xFilial('ZZ3')+cCodInst)))
            nQtdAluno := ZZ3->ZZ3_QTDALU    
            if(nQtdAluno < 5 .AND. !Empty(cCodInst))
                //! Incrementa em uma unidade os alunos do instrutor escolhido
                nQtdAluno++
                ZZ3->(RecLock('ZZ3', .F.))
                ZZ3->ZZ3_QTDALU := nQtdAluno
                ZZ3->(MSUnlock())
                //! Decrementa em uma unidade os alunos do instrutor anterior
                ZZ3->(DBSeek(xFilial('ZZ3')+cInstAtual))
                nQtdAtual := ZZ3->ZZ3_QTDALU
                nQtdAtual--
                ZZ3->(RecLock('ZZ3', .F.))
                ZZ3->ZZ3_QTDALU := nQtdAtual
                ZZ3->(MSUnlock())
            else
                lOk := .F.
                HELP(NIL, NIL, 'Não é possível adicionar alunos a este instrutor!', NIL, 'O instrutor já possuí <b>5 alunos</b>, está indisponível.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Escolha outro instrutor disponível.'})            
            endif 
        endif
    endif

    ZZ3->(DBCloseArea())

Return lOk

Static Function InstAtual(oView) //* Captura o código do instrutor anterior na hora da alteração.
    cInstAtual := ZZ4->ZZ4_CODINS
Return

Static Function ValidInst(oModel) //? Validação de campo

    Local cAulas      := oModel:GetValue('ZZ4_AULAS')
    Local cCodInst    := oModel:GetValue('ZZ4_CODINS')
    Local lOk := .T.

    if !Empty(cAulas) 
        if Empty(cCodInst)
            lOk := .F.
            HELP(NIL, NIL, 'Campo do instrutor está vazio!', NIL, 'O campo de instrutor <b>NÃO</b> foi preenchido.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Selecione um instrutor dentre os disponíveis.'})            
            oModel:LoadValue('ZZ4_AULAS', Space(TamSX3('ZZ4_AULAS')[1]))
        endif
    endif

Return lOk

User Function MarcaAlu()

    DBSelectArea('ZZ4')

    ZZ4->(DBGoTop())

    while(ZZ4->(!EOF()))
        if!(oMark:IsMark())
            oMark:MarkRec() //? Marcar Todos (contrário a inversão!)
        endif
    ZZ4->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function DesmarcAlu()

    DBSelectArea('ZZ4')

    ZZ4->(DBGoTop())

    while(ZZ4->(!EOF()))
        if(oMark:IsMark())
            oMark:MarkRec() //? Desmarcar Todos (contrário a inversão!)
        endif
    ZZ4->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function InvertAlu()

    DBSelectArea('ZZ4')

    ZZ4->(DBGoTop())

    while(ZZ4->(!EOF()))
        oMark:MarkRec() //? Inverter Todos
        ZZ4->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function DeletAlu()

    if(MsgYesNo('Confirma a exclusão dos alunos selecionados? ', ''))
    DBSelectArea('ZZ4')

    ZZ4->(DBGoTop())

        while(ZZ4->(!EOF()))
            if((oMark:IsMark()) .AND. (ZZ4->ZZ4_AULAS <> 'SIM'))
                RecLock('ZZ4',.F.) //? .F. Alteração e .T. Inclusão
                ZZ4->(DBDelete()) //? Marca como deletado no Banco de Dados (oculta o registros)
                ZZ4->(MSUnlock())
            else
                HELP(NIL, NIL, 'Não é <b>possível excluir</b> o aluno!', NIL, 'O aluno possuí aula(as).', 1, 0, NIL, NIL, NIL, NIL, NIL, 'Contate o Administrativo.')
            endif
            ZZ4->(DBSkip())
        enddo
    endif
    oMark:Refresh(.T.)

Return
