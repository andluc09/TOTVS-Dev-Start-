#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MBlkColor
    Lista 01: Pontos de Entrada - Exercício 08
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/public/PROT/Pontos+de+Entrada
/*/

#Define CLR_RGB_VERMELHO        RGB(255,000,000)    //Cor Vermelha em RGB
#Define CLR_RGB_PRETO        RGB(000,000,000)    //Cor Preta em RGB

User Function MBlkColor()

    Local aCores := {}    //Se deixar assim tem o retorno padrão

    //Adicionando as cores
    aAdd(aCores, (CLR_RGB_VERMELHO)   ) //Cor do texto
    aAdd(aCores, (CLR_RGB_PRETO)) //Cor de fundo
    
Return aCores
