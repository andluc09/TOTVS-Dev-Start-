#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MVC_ATV3
    MVC | Atividade 03 - Lista 08
    @type  Function
    @author Andr� Lucas M. Santos
    @since 29/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FwmBrowse
    @see https://tdn.totvs.com/display/public/framework/AdvPl+utilizando+MVC
/*/

User Function MVC_ATV3()

    Local cAlias   := 'ZZ3'
    Local cTitle   := 'Cadastro de Instrutor' 
    Local oMark    := FWMarkBrowse():New()

    oMark:SetAlias(cAlias)
    oMark:SetDescription(cTitle)
    oMark:SetFieldMark('ZZ3_MARC')

    oMark:AddButton('Marcar Todos', 'U_MarcaIns', , 1)
    oMark:AddButton('Desmarcar Todos', 'U_DesmarcIns', , 1)
    oMark:AddButton('Inverter Todos', 'U_InvertIns', , 1)
    oMark:AddButton('Deletar Marcados', 'U_DeletIns', 5, 1)

    oMark:DisableDetails()
    oMark:DisableReport()
    oMark:Activate()

Return()

Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir' ACTION 'VIEWDEF.MVC_ATV3' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar' ACTION 'VIEWDEF.MVC_ATV3' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir' ACTION 'VIEWDEF.MVC_ATV3' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local bModelPos := {|oModel| ValidPos(oModel)} //? Tipo b (bloco de c�digo)
    Local oModel    := MPFormModel():New('MATV3', NIL, bModelPos)
    Local oStruZZ3  := FWFormStruct(1, 'ZZ3')

    oStruZZ3:SetProperty('ZZ3_ESCOL', MODEL_FIELD_VALUES, {'ENSINO FUNDAMENTAL', 'ENSINO M�DIO', 'ENSINO SUPERIOR', ''})

    oModel:SetDescription('Modelo de Cadastro de Instrutor')

    oModel:AddFields('ZZ3MASTER', /*COMPONENTE PAI*/, oStruZZ3)

    oModel:GetModel('ZZ3MASTER'):SetDescription('Formul�rio - Cadastro de Instrutor')

    oModel:SetPrimaryKey({'ZZ3_COD'})

Return oModel

Static Function ViewDef()

    Local oModel       := FWLoadModel('MVC_ATV3')
    Local oStructZZ3   := FWFormStruct(2, 'ZZ3')
    Local oView        := FWFormView():New()

    oStructZZ3:SetProperty('ZZ3_ESCOL', MVC_VIEW_COMBOBOX, {'ENSINO FUNDAMENTAL', 'ENSINO M�DIO', 'ENSINO SUPERIOR', ''})

    oStructZZ3:GetProperty('ZZ3_CATEG', MVC_VIEW_LOOKUP)

    oStructZZ3:SetProperty('ZZ3_CATEG', MVC_VIEW_LOOKUP, "ZZ1")

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZ3', oStructZZ3, 'ZZ3MASTER')

    oView:CreateHorizontalBox('Cadastro de Instrutor', 100)

    oView:SetOwnerView('VIEW_ZZ3', 'Cadastro de Instrutor') //* Demonstra a quem essa view pertence

    oView:EnableTitleView('VIEW_ZZ3', 'Cadastro de Alunos')

Return oView

Static Function ValidPos(oModel)

    Local nOperation  := oModel:GetOperation()
    Local dDtHabl     := oModel:GetValue('ZZ3MASTER', 'ZZ3_DTHABL')
    Local dDtNasc     := oModel:GetValue('ZZ3MASTER', 'ZZ3_DTNASC')
    Local cEscolar    := oModel:GetValue('ZZ3MASTER', 'ZZ3_ESCOL')
    Local nQtdAlunos  := oModel:GetValue('ZZ3MASTER', 'ZZ3_QTDALU')
    Local lOk         := .T.

    if(nOperation == 5 .AND. nQtdAlunos > 0)
        lOk := .F.
        HELP(NIL, NIL, 'N�o � poss�vel excluir o instrutor!', NIL, 'O instrutor possu� aluno(os).', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Contate o Administrativo.'})
    elseif(nOperation == 3 .OR. nOperation == 4)
        if (DateDiffDay(dDtNasc, Date()) < 7665)
            lOk := .F.
            HELP(NIL, NIL, 'N�o � poss�vel incluir/alterar o instrutor!', NIL, 'O instrutor n�o possu� idade suficiente: <b>21 anos</b>.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Consulte os requisitos.'})
        elseif (DateDiffDay(dDtHabl, Date()) < 730)
            lOk := .F.
            HELP(NIL, NIL, 'N�o � poss�vel incluir/alterar o instrutor!', NIL, 'O instrutor n�o atende requisito: <b>2 anos habilitado</b>.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Consulte os requisitos.'})        
        elseif (AllTrim(cEscolar) == UPPER('Ensino Fundamental'))
            lOk := .F.
            HELP(NIL, NIL, 'N�o � poss�vel incluir/alterar o instrutor!', NIL, 'O instrutor n�o possu� escolaridade m�nima: <b>Ensino M�dio</b>.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Consulte os requisitos.'})        
        endif
    endif

Return lOk

User Function MarcaIns()

    DBSelectArea('ZZ3')

    ZZ3->(DBGoTop())

    while(ZZ3->(!EOF()))
        if!(oMark:IsMark())
            oMark:MarkRec() //? Marcar Todos (contr�rio a invers�o!)
        endif
    ZZ3->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function DesmarcIns()

    DBSelectArea('ZZ3')

    ZZ3->(DBGoTop())

    while(ZZ3->(!EOF()))
        if(oMark:IsMark())
            oMark:MarkRec() //? Desmarcar Todos (contr�rio a invers�o!)
        endif
    ZZ3->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function InvertIns()

    DBSelectArea('ZZ3')

    ZZ3->(DBGoTop())

    while(ZZ3->(!EOF()))
        oMark:MarkRec() //? Inverter Todos
        ZZ3->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function DeletIns()

    if(MsgYesNo('Confirma a exclus�o dos instrutores selecionados? ', ''))
    DBSelectArea('ZZ3')

    ZZ3->(DBGoTop())

        while(ZZ3->(!EOF()))
            if(oMark:IsMark()) .AND. (ZZ3->ZZ3_QTDALU == 0)  
                RecLock('ZZ3',.F.) //? .F. Altera��o e .T. Inclus�o
                ZZ3->(DBDelete()) //? Marca como deletado no Banco de Dados (oculta o registros)
                ZZ3->(MSUnlock())
            else
                HELP(NIL, NIL, 'N�o � <b>poss�vel excluir</b> o instrutor!', NIL, 'O instrutor possu� aluno(os).', 1, 0, NIL, NIL, NIL, NIL, NIL, 'Contate o Administrativo.')
            endif
            ZZ3->(DBSkip())
        enddo
    endif
    oMark:Refresh(.T.)

Return
