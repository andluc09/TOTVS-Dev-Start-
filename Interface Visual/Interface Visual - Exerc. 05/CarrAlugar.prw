#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CarrAlugar
    Lista 04 - Interfaces Visuais | Exercício 05
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function CarrAlugar()

    Local cKM    := SPACE(10) 
    Local cDias  := SPACE(10)
    Local cTitle := 'Aluguel Veículo' 
    Local nKM    := 0
    Local nDias  := 0 
    Local nOpcao := 0
    Local oDlg   := NIL 

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 150, 390 FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL 

    @ 005, 012 SAY ' Despesas Viagem: ALUGUEL DE CARRO ' SIZE 135, 11 OF oDlg PIXEL  
    @ 021, 014 SAY ' KM Percorridos: '                   SIZE 55, 11  OF oDlg PIXEL 
    @ 041, 014 SAY ' Dias Alugado: '                     SIZE 55, 11  OF oDlg PIXEL 
    @ 021, 079 MSGET cKM                                 SIZE 30, 11  OF oDlg PIXEL 
    @ 041, 079 MSGET cDias                               SIZE 30, 11  OF oDlg PIXEL 

    @ 020, 122 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 040, 122 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED   

    if nOpcao == 1
        nKM := val(cKM)
        nDias := val(cDias)

        Aluguel(nKM , nDias)
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO', 'CANCELADO')
    endif 

Return 

Static Function Aluguel(nKM , nDias)

    Local nTotKM     := 0
    Local nTotDiasCr := 0
    Local nTotal     := 0

    nTotKM := nKM * 0.15
    nTotDiasCr := nDias * 60
    nTotal  := nTotKM + nTotDiasCr

    FwAlertInfo( +CRLF + CRLF + ' Valor de aluguel do carro é <b>R$</b> ' + StrTran(Alltrim(str(nTotDiasCr, 20 , 2)),".",",") + ';' + CRLF + CRLF +;
                                ' Valor de combustível é <b>R$</b> ' + StrTran(Alltrim(str(nTotKM, 20 , 2)),".",",") + ';' + CRLF + CRLF +;
                                ' Valor Total: <b>R$</b> ' + StrTran(Alltrim(str(nTotal, 20 , 2)),".",",") + '.', ' Despesas de aluguel: Veículo + Combutível ' )

Return
