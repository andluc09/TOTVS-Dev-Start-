#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CadAlnLeg
    Lista 04 - Interfaces Visuais | Exercício 20
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com.br/pages/releaseview.action?pageId=23889136
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346981
/*/

User Function CadAlnLeg()

    Local cAlias      := 'ZAL'
    Local cFiltro     := ''
    Local aCores      := {}
    Private aRotina   := {}
    Private cCadastro := 'Cadastro de Alunos'

    ZAL->(DBSelectArea(cAlias))
    ZAL->(DBSetOrder(1))

    AADD(aCores,{ 'ZAL->ZAL_IDADE > 18'  , 'ENABLE'  }) // Ativo
    AADD(aCores,{ 'ZAL->ZAL_IDADE < 18'  , 'DISABLE' }) // Inativo

    AADD(aRotina, { "Pesquisar" , "AxPesqui"    , 0, 1 })
    AADD(aRotina, { "Visualizar", "AxVisual"    , 0, 2 })
    AADD(aRotina, { "Incluir"   , "AxInclui"    , 0, 3 })
    AADD(aRotina, { "Alterar"   , "AxAltera"    , 0, 4 })
    AADD(aRotina, { "Excluir"   , "AxDeleta"    , 0, 5 })
    AADD(aRotina, { "Legenda"   , "u_Legenda()" , 0, 6 })

    //? mBrowse( <nLinha1>, <nColuna1>, <nLinha2>, <nColuna2>, <cAlias>, <aFixe>, <cCpo>, <nPar>, <cCorFun>, <nClickDef>, <aColors>, <cTopFun>, <cBotFun>, <nPar14>, <bInitBloc>, <lNoMnuFilter>, <lSeeAll>, <lChgAll>, <cExprFilTop>, <nInterval>, <uPar22>, <uPar23> )
    //? mBrowse( , , , , cAlias, , , , , , aColors, , , , , , , , cExprFilTop, , , )

    mBrowse( , , , , cAlias, , , , , , aCores, , , , , , , , cFiltro, , , )

    ZAL->(DBCloseArea())

Return 

User Function Legenda()

    Local aLegenda := {} 

    AADD(aLegenda,{"BR_VERDE"   , 'Verde:    Alunos maiores de 18 anos'}) 
    AADD(aLegenda,{"BR_VERMELHO", 'Vermelho: Alunos menores de 18 anos'}) 

    BrwLegenda(cCadastro, "Legenda", aLegenda) 

Return
