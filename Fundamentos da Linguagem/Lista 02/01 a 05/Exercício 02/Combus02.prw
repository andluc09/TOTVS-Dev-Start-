#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Combus02
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 02
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Combus02()

    nLitros     := 0
    nTempo      := 0
    nVelMed     := 0
    nDistan     := 0

//*Colocar validação numérica, depois

    nTempo := FwInputBox('Digite o tempo gasto na viagem (h): ')
        nTempo := VAL(nTempo)

    nVelMed := FwInputBox('Digite a velocidade media durante a viagem (km/h): ')
        nVelMed := VAL(nVelMed)

    nDistan := nTempo * nVelMed

    nLitros := nDistan / 12 //? Automóvel que faz 12 Km por litro

    FwAlertSuccess('Velocidade Média:  ' + StrTran(allTrim(Str(nVelMed)), ".", ",") +  ' km/h ' + CRLF + 'Tempo Gasto na Viagem: ' + StrTran(allTrim(Str(nTempo)), ".", ",") + ' h ' + CRLF + 'Distância Percorrida: '  + StrTran(allTrim(Str(nDistan)), ".", ",") + 'km ' + CRLF + 'Quantidade de Litros Gastos na Viagem:  ' + StrTran(allTrim(Str(nLitros, 18, 2)), ".", ",") + 'L ' , 'Viagem de Carro')

Return
