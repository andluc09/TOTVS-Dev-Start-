#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function Condominio
    MVC | Lista 08 - Parte 02 [ Exercício 01 ]
    @type  Function
    @author André Lucas M. Santos
    @since 08/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FwmBrowse
    @see https://tdn.totvs.com/display/public/framework/AdvPl+utilizando+MVC
/*/

User Function Condominio()

    Local cAlias    := 'ZBL'
    Local cTitle    := 'Blocos'
    Local oMark     := NIL 

    oMark := FWMarkBrowse():New()

    oMark:SetAlias(cAlias)
    oMark:SetDescription(cTitle)
    oMark:SetFieldMark('ZBL_MARC')

    oMark:AddButton('Marcar Todos', 'U_MarcCond', , 1)
    oMark:AddButton('Desmarcar Todos', 'U_DesmCond', , 1)
    oMark:AddButton('Inverter Todos', 'U_InvtCond', , 1)
    oMark:AddButton('Deletar Marcados', 'U_DeltCond', 5, 1)

    oMark:DisableDetails()
    oMark:DisableReports()

    oMark:Activate()

Return 

Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir' ACTION 'VIEWDEF.Condominio' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar' ACTION 'VIEWDEF.Condominio' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir' ACTION 'VIEWDEF.Condominio' OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.Condominio' OPERATION 2 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local oModel    := MPFormModel():New('Cond_geral')   // Alias ou apelido deve ser diferente da User Function
    Local oStruZBL  := FWFormStruct(1, 'ZBL')
    Local oStruZAP  := FWFormStruct(1, 'ZAP')
    Local aGatilho  := FwStruTrigger('ZBL_CAP', 'ZBL_NAP', 'ZAP->ZAP_NOPR', .T., 'ZBL', 1, 'xFilial("ZBL")+AllTrim(M->ZBL_CAP)')

    oStruZBL:AddTrigger(aGatilho[1], aGatilho[2], aGatilho[3], aGatilho[4])

    oStruZAP:SetProperty('ZAP_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GetSX8Num("ZAP", "ZAP_COD")'))

    oStruZBL:SetProperty('ZBL_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GetSX8Num("ZBL", "ZBL_COD")'))

    oModel:AddFields('ZBLMASTER', /*OWNER –> PAI*/, oStruZBL) //? PAI MODEL

    oModel:AddGrid('ZAPDETAIL', 'ZBLMASTER', oStruZAP) //? FILHO MODEL

    oModel:SetDescription('Modelo de Blocos do Condomínio')

    oModel:GetModel('ZBLMASTER'):SetDescription('Formulário - Blocos do Condomínio')

    oModel:GetModel('ZAPDETAIL'):SetDescription('Cadastro de Apartamento') 

    oModel:SetRelation('ZAPDETAIL', {{'ZAP_FILIAL', 'xFilial("ZAP")'},{'ZAP_COD', 'ZBL_CAP'}}, ZAP->(IndexKey(1))) //? RELAÇÃO

    oModel:GetModel('ZAPDETAIL'):SetOptional(.T.)

    oModel:SetPrimaryKey({'ZBL_COD', 'ZAP_COD'})

Return oModel

Static Function ViewDef()

    Local oModel    := FWLoadModel('Condominio')   // Passar o nome do Fonte ou User Function
    Local oStruZBL  := FWFormStruct(2, 'ZBL')    // 2 –> View
    Local oStruZAP  := FWFormStruct(2, 'ZAP')    // 2 –> View
    Local oView     := FWFormView():New()        // Instanciando o objeto da View

    oView:SetModel(oModel)

    oStruZBL:GetProperty('ZBL_CAP', MVC_VIEW_LOOKUP)

    oStruZBL:SetProperty('ZBL_CAP', MVC_VIEW_LOOKUP, "ZAP")

    oView:AddField('VIEW_ZBL', oStruZBL, 'ZBLMASTER')

    oView:AddGrid('VIEW_ZAP', oStruZAP, 'ZAPDETAIL')

    oView:CreateHorizontalBox('Formulário - Blocos do Condomínio', 30)
    oView:CreateHorizontalBox('Cadastro de Apartamento', 30)

    oView:SetOwnerView('VIEW_ZBL', 'Formulário - Blocos do Condomínio') //* PAI VIEW 
    oView:SetOwnerView('VIEW_ZAP', 'Cadastro de Apartamento') //* FILHO VIEW

    oView:EnableTitleView('VIEW_ZBL', 'Blocos do Condomínio')
    oView:EnableTitleView('VIEW_ZAP', 'Apartamentos')

Return oView

User Function MarcCond()

    DBSelectArea('ZBL')

    ZBL->(DBGoTop())

    while(ZBL->(!EOF()))
        if!(oMark:IsMark())
        oMark:MarkRec() //? Marcar Todos (contrário a inversão!)
        endif
        ZBL->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function DesmCond()

    DBSelectArea('ZBL')

    ZBL->(DBGoTop())

    while(ZBL->(!EOF()))
    if(oMark:IsMark())
      oMark:MarkRec() //? Desmarcar Todos (contrário a inversão!)
    endif
    ZBL->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function InvtCond()

    DBSelectArea('ZBL')

    ZBL->(DBGoTop())

    while(ZBL->(!EOF()))
      oMark:MarkRec() //? Inverter Todos
    ZBL->(DBSkip())
    enddo

    oMark:Refresh(.T.)

Return

User Function DeltCond()

    if(MsgYesNo('Confirma à exclusão dos apartamentos marcados? ', ''))
    DBSelectArea('ZBL')

    ZBL->(DBGoTop())

    while(ZBL->(!EOF()))
        if(oMark:IsMark())  
        RecLock('ZBL',.F.) //? .F. Alteração e .T. Inclusão
          ZBL->(DBDelete()) //? Marca como deletado no Banco de Dados (oculta o registros)
        ZBL->(MSUnlock())
        endif
        ZBL->(DBSkip())
    enddo
    endif
    oMark:Refresh(.T.)

Return
