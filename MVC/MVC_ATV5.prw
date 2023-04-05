#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MVC_ATV2
    MVC | Atividade 05 - Lista 08
    @type  Function
    @author André Lucas M. Santos
    @since 29/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FwmBrowse
    @see https://tdn.totvs.com/display/public/framework/AdvPl+utilizando+MVC
/*/

User Function MVC_ATV5()

    Local cAlias    := 'ZZ1'
    Local cTitle    := 'Categorias de CNH'
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

    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.MVC_ATV5' OPERATION 2 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local oModel    := MPFormModel():New('MATV5')   // Alias ou apelido deve ser diferente da User Function
    Local oStruZZ1  := FWFormStruct(1, 'ZZ1')
    Local oStruZZ3  := FWFormStruct(1, 'ZZ3')
    Local oStruZZ4  := FWFormStruct(1, 'ZZ4')

    oModel:AddFields('ZZ1MASTER', /*OWNER –> PAI*/, oStruZZ1) 

    oModel:AddGrid('ZZ3DETAIL', 'ZZ1MASTER', oStruZZ3)
    oModel:AddGrid('ZZ4DETAIL', 'ZZ3DETAIL', oStruZZ4)

    oModel:SetDescription('Modelo de Categorias de CNH')

    oModel:GetModel('ZZ1MASTER'):SetDescription('Formulário - Categorias de CNH')

    oModel:GetModel('ZZ3DETAIL'):SetDescription('Cadastro de Instrutor') 

    oModel:GetModel('ZZ4DETAIL'):SetDescription('Cadastro de Alunos') 

    oModel:SetRelation('ZZ3DETAIL', {{'ZZ3_FILIAL', 'xFilial("ZZ3")'},{'ZZ3_CATEG', 'ZZ1_SIGLA'}}, ZZ3->(IndexKey(1)))

    oModel:SetRelation('ZZ4DETAIL', {{'ZZ4_FILIAL', 'xFilial("ZZ4")'},{'ZZ4_CODINS', 'ZZ3_COD'}}, ZZ4->(IndexKey(1)))

    oModel:SetPrimaryKey({'ZZ1_COD', 'Z3_COD', 'Z4_COD'})

Return oModel

Static Function ViewDef()

    Local oModel    := FWLoadModel('MVC_ATV5')   // Passar o nome do Fonte ou User Function
    Local oStruZZ1  := FWFormStruct(2, 'ZZ1')    // 2 –> View
    Local oStruZZ3  := FWFormStruct(2, 'ZZ3')    // 2 –> View
    Local oStruZZ4  := FWFormStruct(2, 'ZZ4')    // 2 –> View
    Local oView     := FWFormView():New()        // Instanciando o objeto da View

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZ1', oStruZZ1, 'ZZ1MASTER')

    oView:AddGrid('VIEW_ZZ3', oStruZZ3, 'ZZ3DETAIL')
    oView:AddGrid('VIEW_ZZ4', oStruZZ4, 'ZZ4DETAIL')

    oView:CreateHorizontalBox('Formulário - Categorias de CNH', 30)
    oView:CreateHorizontalBox('Cadastro de Instrutor', 30)
    oView:CreateHorizontalBox('Cadastro de Alunos', 30)

    oView:SetOwnerView('VIEW_ZZ1', 'Formulário - Categorias de CNH') 
    oView:SetOwnerView('VIEW_ZZ3', 'Cadastro de Instrutor') 
    oView:SetOwnerView('VIEW_ZZ4', 'Cadastro de Alunos') 

    oView:EnableTitleView('VIEW_ZZ1', 'Categorias de CNH')
    oView:EnableTitleView('VIEW_ZZ3', 'Instrutor da Categoria')
    oView:EnableTitleView('VIEW_ZZ4', 'Alunos do Instrutor')

Return oView
