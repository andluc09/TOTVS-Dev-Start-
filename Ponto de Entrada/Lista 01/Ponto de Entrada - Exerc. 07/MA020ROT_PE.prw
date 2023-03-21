#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MA020ROT
    Lista 01: Pontos de Entrada - Exercício 07
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

User Function MA020ROT()

    Local aRotUser := {}
    //Define Array contendo as Rotinas a executar do programa     
    // ----------- Elementos contidos por dimensao ------------    
    // 1. Nome a aparecer no cabecalho                             
    // 2. Nome da Rotina associada                                 
    // 3. Usado pela rotina                                        
    // 4. Tipo de Transacao a ser efetuada                         
    //    1 - Pesquisa e Posiciona em um Banco de Dados            
    //    2 - Simplesmente Mostra os Campos                        
    //    3 - Inclui registros no Bancos de Dados                  
    //    4 - Altera o registro corrente                           
    //    5 - Remove o registro corrente do Banco de Dados         
    //    6 - Altera determinados campos sem incluir novos Regs     
    
    AAdd( aRotUser, { "Cad. Produtos", "MsDocument('SA2', SA2->(RecNo()), 4)", 0, 3} )
    
Return (aRotUser)
