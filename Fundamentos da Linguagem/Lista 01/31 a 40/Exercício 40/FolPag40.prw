#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function FolPag40
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 40
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function FolPag40()

    Local nHora      := 0
    Local nQtdHoras  := 0
    Local nIR        := 0
    Local nINSS      := 0
    Local nFGTS      := 0
    Local nTotalDesc := 0
    Local nSalBruto  := 0
    Local nSalLiq    := 0
    Local cIR        := ''

//*Colocar validação isDigit e NEGATIVO, depois

    nHora := VAL(FWInputBox('Informe o valor da hora: ', 'R$'))

    nQtdHoras := VAL(FWInputBox('Informe a quantidade de horas: ', 'horas'))

    nSalBruto := nHora * nQtdHoras

    if nSalBruto > 1200 .and. nSalBruto <= 1800  
        nIR := 0.05 * nSalBruto         
        cIR := '5%'
    elseif nSalBruto > 1800 .and. nSalBruto <= 2500 
        nIR := 0.10 * nSalBruto 
        cIR := '10%'
    elseif nSalBruto > 2500 
        nIR := 0.20 * nSalBruto 
        cIR := '20%'
    else
        FwAlertSuccess('O salário informado é <b>isento</b>, não tem <i>desconto</i> de IR!')
        nIR := 0 * nSalBruto
    endif

    nINSS := 0.10 * nSalBruto     

    nFGTS := 0.11 * nSalBruto 

    nTotalDesc := nIR + nINSS 

    nSalLiq := nSalBruto - nTotalDesc

    FwAlertInfo(CRLF + CRLF + 'Salário bruto R$: ' + StrTran(ALLTRIM(Str(nSalBruto,15,2)),".",",") + CRLF + CRLF + ;
                'IR ('+ALLTRIM(cIR)+'): R$ '+ StrTran(ALLTRIM(Str(nIR,15,2)),".",",")+ CRLF + CRLF + ;
                'INSS (10%): R$ '+ StrTran(ALLTRIM(Str(nINSS,15,2)),".",",")+ CRLF + CRLF + ;
                'FGTS (11%): R$ '+ StrTran(ALLTRIM(Str(nFGTS,15,2)),".",",")+ CRLF + CRLF + ;
                'Total de descontos: R$ '+ StrTran(ALLTRIM(Str(nTotalDesc,15,2)),".",",")+ CRLF + CRLF + ;
                'Salário Líquido: R$ '+ StrTran(ALLTRIM(Str(nSalLiq,15,2)),".",","), 'Folha de Pagamento')

Return
