#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 1 - Lista: Pontos de Entrada
/*/

#Define CLR_RGB_VERMELHO        RGB(255,000,000)    //Cor Vermelha em RGB
#Define CLR_RGB_PRETO        RGB(000,000,000)    //Cor Preta em RGB

User Function MBlkColor()

    Local aCores := {}    //Se deixar assim tem o retorno padr�o

    //Adicionando as cores
    aAdd(aCores, (CLR_RGB_VERMELHO)   ) //Cor do texto
    aAdd(aCores, (CLR_RGB_PRETO)) //Cor de fundo
    
Return aCores
