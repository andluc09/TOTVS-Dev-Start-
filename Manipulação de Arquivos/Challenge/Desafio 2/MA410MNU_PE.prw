#INCLUDE 'TOTVS.CH'

User Function MA410MNU()    

//* ONDE:Parametros do array a Rotina:
//* 1. Nome a aparecer no cabecalho
//* 2. Nome da Rotina associada    
//* 3. Reservado                        
//* 4. Tipo de Transação a ser efetuada:     
//*  1 - Pesquisa e Posiciona em um Banco de Dados      
//*  2 - Simplesmente Mostra os Campos                  
//*  3 - Inclui registros no Bancos de Dados            
//*  4 - Altera o registro corrente                     
//*  5 - Remove o registro corrente do Banco de Dados 5. Nivel de acesso                                   
//*  6 - Habilita Menu Funcional

    AADD(aRotina, {'Salvar arquivos PDF dos Pedidos de Venda', 'u_CopiPDF', 0,6})

Return 
