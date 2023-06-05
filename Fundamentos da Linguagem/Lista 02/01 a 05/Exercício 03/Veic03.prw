#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Veic03
    Lista 02 - Fundamentos da Linguagem ADVPL | Exerc�cio 03
    @type  Function
    @author Andr� Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Veic03()

    nLitros     := 0
    nTempo      := 0
    nVelMed     := 0
    nDistan     := 0
    nKmLt       := 0

//*Colocar valida��o num�rica, depois

    nKmLt := FwInputBox('Digite quantos km por litro o seu carro faz: ')
        nKmLt := val(nKmLt)

    nTempo := FwInputBox('Digite o tempo gasto na viagem (h): ')
        nTempo := VAL(nTempo)

    nVelMed := FwInputBox('Digite a velocidade media durante a viagem (km/h): ')
        nVelMed := VAL(nVelMed)

    nDistan := nTempo * nVelMed

    nLitros := nDistan / nKmLt //? Consumo do autom�vel informado pelo usu�rio

    FwAlertSuccess('Velocidade M�dia:  ' + StrTran(allTrim(Str(nVelMed)), ".", ",") +  ' km/h ' + CRLF + 'Tempo Gasto na Viagem: ' + StrTran(allTrim(Str(nTempo)), ".", ",") + ' h ' + CRLF + 'Dist�ncia Percorrida: '  + StrTran(allTrim(Str(nDistan)), ".", ",") + 'km ' + CRLF + 'Quantidade de Litros Gastos na Viagem:  ' + StrTran(allTrim(Str(nLitros, 18, 2)), ".", ",") + 'L ' , 'Viagem de Carro')

Return
