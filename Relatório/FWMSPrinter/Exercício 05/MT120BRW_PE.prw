#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MT120BRW 
    Lista 11 - FWMSPrinter | Exercício 05
    @type  Function
    @author André Lucas M. Santos
    @since 25/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=6085467
/*/

User Function MT120BRW()

//? Define Array contendo as Rotinas a executar do programa     
//? ----------- Elementos contidos por dimensao ------------    
//? 1. Nome a aparecer no cabecalho                             
//? 2. Nome da Rotina associada                                 
//? 3. Usado pela rotina                                        
//? 4. Tipo de Transa‡„o a ser efetuada                         
//?    1 - Pesquisa e Posiciona em um Banco de Dados            
//?    2 - Simplesmente Mostra os Campos                        
//?    3 - Inclui registros no Bancos de Dados                  
//?    4 - Altera o registro corrente                           
//?    5 - Remove o registro corrente do Banco de Dados         
//?    6 - Altera determinados campos sem incluir novos Regs     

    AAdd( aRotina, { 'Relatório de Todos os Pedidos de Compra com Totalizador', 'u_TdsPdCmp', 0, 2})

Return 
