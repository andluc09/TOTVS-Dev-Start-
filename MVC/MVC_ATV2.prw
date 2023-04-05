#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MVC_ATV2
    MVC | Atividade 02 - Lista 08
    @type  Function
    @author Andr� Lucas M. Santos
    @since 29/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FwmBrowse
    @see https://tdn.totvs.com/display/public/framework/AdvPl+utilizando+MVC
/*/

User Function MVC_ATV2()

    Local cAlias    := 'ZZ2'
    Local cTitle    := 'Cadastro de Ve�culos'
    Local oBrowse   := NIL

    oBrowse := FWMBrowse():New()

    oBrowse:SetAlias(cAlias)

    oBrowse:SetDescription(cTitle)

    oBrowse:DisableDetails()

    oBrowse:DisableReports()

    oBrowse:Activate()

Return 

Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.MVC_ATV2' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.MVC_ATV2' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.MVC_ATV2' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local oModel    := MPFormModel():New('MATV2')   // Alias ou apelido deve ser diferente da User Function
    Local oStruZZ2  := FWFormStruct(1, 'ZZ2')

    oStruZZ2:SetProperty('ZZ2_CAMBIO', MODEL_FIELD_VALUES, {'MANUAL', 'AUTOM�TICO', ''})

    oModel:AddFields('ZZ2MASTER', /*OWNER �> PAI*/, oStruZZ2) 

    oModel:SetDescription('Modelo de Cadastro de Ve�culos')

    oModel:GetModel('ZZ2MASTER'):SetDescription('Formul�rio - Cadastro de Ve�culos')

    oModel:SetPrimaryKey({'ZZ2_COD'})

Return oModel

Static Function ViewDef()

    Local oModel    := FWLoadModel('MVC_ATV2')   // Passar o nome do Fonte ou User Function
    Local oStruZZ2  := FWFormStruct(2, 'ZZ2')    // 2 �> View
    Local oView     := FWFormView():New()        // Instanciando o objeto da View
    //TODO: Lista de Op��es em MVC �> oObjeto:SetProperty('Campo ou Field', MVC_VIEW_COMBOBOX, {'aArray[1], aArray[2], ...'})
    oStruZZ2:SetProperty('ZZ2_CAMBIO' , MVC_VIEW_COMBOBOX, {'MANUAL', 'AUTOM�TICO',''}) //! Array com as op��es incluindo a em branco!

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZ2', oStruZZ2, 'ZZ2MASTER')

    oView:CreateHorizontalBox('Cadastro de Ve�culos', 100)

    oView:SetOwnerView('VIEW_ZZ2', 'Cadastro de Ve�culos') //* Demonstra a quem essa view pertence

    oView:EnableTitleView('VIEW_ZZ2', 'Cadastro de Ve�culos')

Return oView
