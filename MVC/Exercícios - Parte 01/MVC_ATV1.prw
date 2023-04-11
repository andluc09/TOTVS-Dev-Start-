#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MVC_ATV1
    MVC | Atividade 01 - Lista 08
    @type  Function
    @author André Lucas M. Santos
    @since 29/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/framework/FwmBrowse
    @see https://tdn.totvs.com/display/public/framework/AdvPl+utilizando+MVC
/*/

User Function MVC_ATV1()

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

    ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.MVC_ATV1' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.MVC_ATV1' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.MVC_ATV1' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local oModel    := MPFormModel():New('MATV1')   // Alias ou apelido deve ser diferente da User Function
    Local oStruZZ1  := FWFormStruct(1, 'ZZ1')
    //TODO: Gatilho em MVC –> FWStruTigger() 
    Local aGatilho  := FwStruTrigger('ZZ1_CODVL', 'ZZ1_NOMEVL', 'ZZ2->ZZ2_NOME', .T., 'ZZ2', 1, 'xFilial("ZZ2")+AllTrim(M->ZZ1_CODVL)')
                    //?FwStruTrigger: ( cDom, cCDom, cRegra, lSeek, cAlias, nOrdem, cChave, cCondic )

    oStruZZ1:AddTrigger(aGatilho[1], aGatilho[2], aGatilho[3], aGatilho[4])

    //TODO: Campo Sequencial –> SetProperty('', '', FWBuildFeature(STRUCT_FEATURE_INIPAD,''))
    oStruZZ1:SetProperty('ZZ1_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GetSX8Num("ZZ1", "ZZ1_COD")'))
                     //?(Campo alvo: ID Campo, Inicializador do Campo, xValue: FWBuildFeature([ nTipo ], [ cExprAdvPL ]))
                                                    //*Tipo de caracteristica ( 1-Valid Model ; 2-When Model ; 3-Inic.Padrao Model; 4-PictVar View )
                                                        //*Podem ser utilizados os DEFINEs:
                                                        //*STRUCT_FEATURE_VALID 1
                                                        //*STRUCT_FEATURE_WHEN 2
                                                        //*STRUCT_FEATURE_INIPAD 3 –> para o inicializador padrão
                                                        //*STRUCT_FEATURE_PICTVAR 4
                                //*Nome da Propriedade, ela pode ser(lembre-se de incluir o FWMVCDEF.CH no fonte):
                                    //*MODEL_FIELD_TITULO C Titulo
                                    //*MODEL_FIELD_TOOLTIP C Descrição completa do campo
                                    //*MODEL_FIELD_IDFIELD C Nome (ID)
                                    //*MODEL_FIELD_TIPO C Tipo
                                    //*MODEL_FIELD_TAMANHO N Tamanho
                                    //*MODEL_FIELD_DECIMAL N Decimais
                                    //* MODEL_FIELD_VALID B Validação
                                    //*MODEL_FIELD_WHEN B Modo de edição
                                    //*MODEL_FIELD_VALUES A Lista de valores permitido do campo (combo)
                                    //*MODEL_FIELD_OBRIGAT L Indica se o campo tem preenchimento obrigatório
                                    //*MODEL_FIELD_INIT B Inicializador padrão
                                    //*MODEL_FIELD_KEY L Indica se o campo é chave
                                    //*MODEL_FIELD_NOUPD L Indica se o campo pode receber valor em uma operação de update.
                                    //*MODEL_FIELD_VIRTUAL L Indica se o campo é virtual
                                                                                            //*GETSX8NUM( <cAlias>, <cCampo>, <cAliasSXE>, <nOrdem> )

    oModel:AddFields('ZZ1MASTER', /*OWNER –> PAI*/, oStruZZ1) 

    oModel:SetDescription('Modelo de Categorias de CNH')

    oModel:GetModel('ZZ1MASTER'):SetDescription('Formulário - Categorias de CNH')

    oModel:SetPrimaryKey({'ZZ1_COD'})

Return oModel

Static Function ViewDef()

    Local oModel    := FWLoadModel('MVC_ATV1')   // Passar o nome do Fonte ou User Function
    Local oStruZZ1  := FWFormStruct(2, 'ZZ1')    // 2 –> View
    Local oView     := FWFormView():New()        // Instanciando o objeto da View

    oView:SetModel(oModel)

    oStruZZ1:GetProperty('ZZ1_CODVL', MVC_VIEW_LOOKUP)
    //TODO: Busca Padrão em MVC –> oObjeto:SetProperty('Campo ou Field', MVC_VIEW_LOOKUP, "Alias da Consulta Padrão")  
    oStruZZ1:SetProperty('ZZ1_CODVL', MVC_VIEW_LOOKUP, "ZZ2") //! É necessário ter a Consulta Padrão criada pelo SIGACFG do Protheus
                                                              //! Contudo não há o preenchimento em Opções –> Consulta Padrão no campo 
                                                              //! pretendido para estar sendo consumida!
    oView:AddField('VIEW_ZZ1', oStruZZ1, 'ZZ1MASTER')

    oView:CreateHorizontalBox('Categorias de CNH', 100)

    oView:SetOwnerView('VIEW_ZZ1', 'Categorias de CNH') //* Demonstra a quem essa view pertence

    oView:EnableTitleView('VIEW_ZZ1', 'Categorias de CNH')

Return oView
