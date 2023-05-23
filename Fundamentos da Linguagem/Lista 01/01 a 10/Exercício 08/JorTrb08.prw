#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function JorTrb08
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 08
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function JorTrb08()

    Local cHoraReg    := ''
    Local cSemana     := ''
    Local nBancoHoras := 0
    Local nHoraExtra  := 0
    Local nSalario    := 0
    Local nI          := 0

//*Colocar valida��o num�rica, depois

    cHoraReg := FwInputBox('Digite o sal�rio por hora: ', cHoraReg)

    for nI := 1 to 4
        cSemana := FwInputBox('Informe as horas trabalhadas na ' + cValToChar(nI) + '� semana:', cSemana)
        nBancoHoras+= VAL(cSemana)
    next

    if nBancoHoras > 160
        nHoraExtra := ((nBancoHoras - 160)*(VAL(StrTran(cHoraReg,",","."))*1.5))
        nSalario := (160*VAL(StrTran(cHoraReg,",","."))) + nHoraExtra

        FwAlertInfo('O sal�rio do funcion�rio �: R$' + StrTran(cValToChar(NoRound(nSalario,2)),".",",") + CRLF + 'Onde ele recebeu de hora extra: R$' + cValToChar(NoRound(nHoraExtra,2)))
    else
        nSalario := (nBancoHoras*(VAL(StrTran(cHoraReg,",","."))))
        FwAlertInfo('O sal�rio do funcion�rio �: R$ ' + StrTran(cValToChar(NoRound(nSalario,2)),".",","))
    endif

Return
