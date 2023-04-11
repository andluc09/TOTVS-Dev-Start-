#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function ToDoList
    MVC | Lista 08 - Parte 02 [ Exercício 02 ]
    @type  Function
    @author André Lucas M. Santos
    @since 10/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FwmBrowse
    @see https://tdn.totvs.com/display/public/framework/AdvPl+utilizando+MVC
/*/

User Function ToDoList()

    Local cAlias    := 'ZFZ'
    Local cTitle    := 'Blocos'
    Local oMark     := NIL 

    oMark := FWMarkBrowse():New()

    oMark:SetAlias(cAlias)
    oMark:SetDescription(cTitle)
    oMark:SetFieldMark('ZFZ_MARC')

    oMark:AddButton('Marcar Todos', 'U_MarcToDo', , 1)
    oMark:AddButton('Desmarcar Todos', 'U_DesmToDo', , 1)
    oMark:AddButton('Inverter Todos', 'U_InvtToDo', , 1)
    oMark:AddButton('Deletar Marcados', 'U_DeltToDo', 5, 1)

    oMark:DisableDetails()
    oMark:DisableReports()

    oMark:Activate()

Return 

Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.ToDoList' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir' ACTION 'VIEWDEF.ToDoList' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar' ACTION 'VIEWDEF.ToDoList' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir' ACTION 'VIEWDEF.ToDoList' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local bModelPos := {|oModel| ValidPos(oModel)} //? Tipo b (bloco de código)
    Local oModel    := MPFormModel():New('List_model', NIL, bModelPos)   // Alias ou apelido deve ser diferente da User Function
    Local oStruZFZ  := FWFormStruct(1, 'ZFZ')
    Local oStruZFT  := FWFormStruct(1, 'ZFT')

    oStruZFT:SetProperty('ZFT_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GetSX8Num("ZFT", "ZFT_COD")'))

    oStruZFZ:SetProperty('ZFZ_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GetSX8Num("ZFZ", "ZFZ_COD")'))

    oModel:AddFields('ZFZMASTER', /*OWNER –> PAI*/, oStruZFZ) //? PAI MODEL
    oModel:SetDescription('Modelo de Atividades a se Fazer')
    oModel:GetModel('ZFZMASTER'):SetDescription('Formulário - Atividades a se Fazer')

    oModel:AddGrid('ZFTDETAIL', 'ZFZMASTER', oStruZFT) //? FILHO MODEL
    oModel:GetModel('ZFTDETAIL'):SetDescription('Cadastro de Atividades já realizadas') 
    oModel:SetRelation('ZFTDETAIL', {{'ZFT_FILIAL', 'xFilial("ZFT")'},{'ZFT_COD', 'ZFZ_COD'}}, ZFT->(IndexKey(1))) //? RELAÇÃO
    oModel:GetModel('ZFTDETAIL'):SetOptional(.T.)

    oModel:SetPrimaryKey({'ZFZ_COD', 'ZFT_COD'})

Return oModel

Static Function ViewDef()

    Local oModel    := FWLoadModel('ToDoList')   // Passar o nome do Fonte ou User Function
    Local oStruZFZ  := FWFormStruct(2, 'ZFZ')    // 2 –> View
    Local oStruZFT  := FWFormStruct(2, 'ZFT')    // 2 –> View
    Local oView     := FWFormView():New()        // Instanciando o objeto da View

    oView:SetModel(oModel)

    oStruZFZ:SetProperty('ZFZ_CLF' , MVC_VIEW_COMBOBOX, {'Importante', 'Urgente', 'Circunstancial', ''})
    oStruZFZ:SetProperty('ZFZ_RLZ' , MVC_VIEW_COMBOBOX, {'Não', 'Sim', ''})

    oView:AddField('VIEW_ZFZ', oStruZFZ, 'ZFZMASTER')
    oView:CreateHorizontalBox('Formulário - Atividades a se Fazer', 30)
    oView:SetOwnerView('VIEW_ZFZ', 'Formulário - Atividades a se Fazer') //* PAI VIEW 
    oView:EnableTitleView('VIEW_ZFZ', 'Atividades a se Fazer')

    oView:AddGrid('VIEW_ZFT', oStruZFT, 'ZFTDETAIL')
    oView:CreateHorizontalBox('Cadastro de Atividades já realizadas', 30)
    oView:SetOwnerView('VIEW_ZFT', 'Cadastro de Atividades já realizadas') //* FILHO VIEW
    oView:EnableTitleView('VIEW_ZFT', 'Atividades já realizadass')

Return oView

Static Function ValidPos(oModel)

    Local nOperation  := oModel:GetOperation()
    Local cCod        := oModel:GetValue('ZFZMASTER', 'ZFZ_COD')
    Local cAtv        := oModel:GetValue('ZFZMASTER', 'ZFZ_ATV')
    Local cClass      := oModel:GetValue('ZFZMASTER', 'ZFZ_CLF')
    Local cRealiz     := oModel:GetValue('ZFZMASTER', 'ZFZ_RLZ')
    Local lOk         := .T.

    ZFT->(GetArea())
    ZFT->(DBSelectArea('ZFT'))
    ZFT->(DBSetOrder(1))
    ZFT->(DBGoTop())

    if(nOperation == 3 .OR. nOperation == 4)
        if(cRealiz == 'Sim')
            //! Grava as informações dos campos do registro atual na Tabela ZFT "FEITO"
            ZFT->(RecLock('ZFT', .T.)) //? .T. –> Incluir
            ZFT->ZFT_COD := cCod
            ZFT->ZFT_ATV := cAtv
            ZFT->ZFT_CLF := cClass
            ZFT->ZFT_RLZ := cRealiz     
            ZFT->(MsUnlock())
            //! Deleta a linha do registro posicionado!
            if(ZFZ->(DBSeek(xFilial('ZFZ')+cCod)))
                ZFZ->(GetArea())
                ZFZ->(DBSelectArea('ZFZ'))
                ZFZ->(DBSetOrder(1))
                ZFZ->(DBGoTop())
                ZFZ->(RecLock('ZFZ',.F.))
                ZFZ->(DBDelete())
                ZFZ->(MsUnlock())
            endif
        endif
    elseif(nOperation == 5)
        //! Grava as informações dos campos do registro atual na Tabela ZFT "FEITO"
        ZFT->(RecLock('ZFT', .T.)) //? .T. –> Incluir
        ZFT->ZFT_COD := cCod
        ZFT->ZFT_ATV := cAtv
        ZFT->ZFT_CLF := cClass
        ZFT->ZFT_RLZ := 'Sim' //? Muda o campo "REALIZADO" ZFT_RLZ para: Sim    
        ZFT->(MsUnlock())
        //! Deleta a linha do registro posicionado!
        if(ZFZ->(DBSeek(xFilial('ZFZ')+cCod)))
            ZFZ->(GetArea())
            ZFZ->(DBSelectArea('ZFZ'))
            ZFZ->(DBSetOrder(1))
            ZFZ->(DBGoTop())
            ZFZ->(RecLock('ZFZ',.F.))
            ZFZ->ZFZ_RLZ := 'Sim' //? Muda o campo "REALIZADO" ZFT_RLZ para: Sim, antes da deleção!
            ZFZ->(DBDelete())
            ZFZ->(MsUnlock())
        endif
    endif

    ZFZ->(DBCloseArea())
    ZFT->(DBCloseArea())

Return  lOk

User Function MarcToDo()

    DBSelectArea('ZFZ')

    ZFZ->(DBGoTop())

    while(ZFZ->(!EOF()))
        if!(oMark:IsMark())
        oMark:MarkRec() //? Marcar Todos (contrário a inversão!)
        endif
        ZFZ->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function DesmToDo()

    DBSelectArea('ZFZ')

    ZFZ->(DBGoTop())

    while(ZFZ->(!EOF()))
    if(oMark:IsMark())
      oMark:MarkRec() //? Desmarcar Todos (contrário a inversão!)
    endif
    ZFZ->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function InvtToDo()

    DBSelectArea('ZFZ')

    ZFZ->(DBGoTop())

    while(ZFZ->(!EOF()))
      oMark:MarkRec() //? Inverter Todos
    ZFZ->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function DeltToDo()

    if(MsgYesNo('Confirma à exclusão das tarefas marcadas? ', ''))
    DBSelectArea('ZFZ')

    ZFZ->(DBGoTop())

    while(ZFZ->(!EOF()))
        if(oMark:IsMark())  
        RecLock('ZFZ',.F.) //? .F. Alteração e .T. Inclusão
          ZFZ->(DBDelete()) //? Marca como deletado no Banco de Dados (oculta o registros)
        ZFZ->(MSUnlock())
        endif
        ZFZ->(DBSkip())
    enddo
    endif
    oMark:Refresh(.T.)

Return
