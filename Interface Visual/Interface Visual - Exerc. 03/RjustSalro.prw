#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function RjustSalro
    Lista 04 - Interfaces Visuais | Exercício 03
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function RjustSalro()

    Local cSal   := SPACE(10) 
    Local cReaj  := SPACE(5)
    Local cTitle := ' Reajuste Salarial ' 
    Local nSal   := 0
    Local nReaj  := 0 
    Local nOpcao := 0
    Local oDlg   := NIL 

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 200, 355 FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL 

    @ 012, 010 SAY ' Insira informações para o rejuste do salário. ' SIZE 150, 10 OF oDlg PIXEL     
    @ 030, 010 SAY ' Digite o valor do salário: '                    SIZE 150, 10 OF oDlg PIXEL 
    @ 050, 010 SAY ' Digite o valor do reajuste (porcentagem): '     SIZE 150, 10 OF oDlg PIXEL
    @ 030, 135 MSGET cSal                                            SIZE 36, 11  OF oDlg PIXEL 
    @ 050, 135 MSGET cReaj                                           SIZE 36, 11  OF oDlg PIXEL PICTURE '@# 99999%'  

    @ 073, 041 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 073, 091 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED   

    if nOpcao == 1
        nSal  := val(cSal)
        nReaj := val(cReaj)

        CalcReaj(nSal , nReaj)
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif 

Return 

Static Function CalcReaj(nSal , nReaj)

    Local nTotal := 0
    Local nPrct  := 0

    nPrct  := nSal * (nReaj/100)
    nTotal := nSal + nPrct

    FwAlertInfo(' O valor do <i>salário</i> com reajuste é: R$ ' + StrTran(Alltrim(Str(nTotal, 20, 2)),".",",") + '.', ' Novo Salário ')

Return
