#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MT120BRW
    Lista 10 - TReport | Exercício 03
    @type  Function
    @author André Lucas M. Santos
    @since 18/04/2024
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function MT120BRW()

//* Define Array contendo as Rotinas a executar do programa     
//* ----------- Elementos contidos por dimensao ------------    
//* 1. Nome a aparecer no cabecalho                             
//* 2. Nome da Rotina associada                                 
//* 3. Usado pela rotina                                        
//* 4. Tipo de Transação a ser efetuada                         
//*    1 - Pesquisa e Posiciona em um Banco de Dados            
//*    2 - Simplesmente Mostra os Campos                        
//*    3 - Inclui registros no Bancos de Dados                  
//*    4 - Altera o registro corrente                           
//*    5 - Remove o registro corrente do Banco de Dados         
//*    6 - Altera determinados campos sem incluir novos Regs     

AAdd( aRotina, { 'Relatório do Pedido de Compra Selecionado', 'U_RelPdCmp', 0, 1 } )

Return
