#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function LadTri11
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 11
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function LadTri11()

    Local nLadoA := 0
    Local nLadoB := 0
    Local nLadoC := 0
    Local cLadoA := ""
    Local cLadoB := ""
    Local cLadoC := ""
    Local lVerdade := .F.

//*Colocar valida��o isDigit sem NEGATIVO, depois

    FWAlertInfo(' Insira tr�s valores para cada lado de um tri�ngulo. ','')

    while (lVerdade != .T.)
        cLadoA := FwInputBox("Insira a medida do lado: ", cLadoA)
        cLadoB := FwInputBox("Insira a medida do lado: ", cLadoB)
        cLadoC := FwInputBox("Insira a medida do lado: ", cLadoC)

        nLadoA := VAL(cLadoA)
        nLadoB := VAL(cLadoB)
        nLadoC := VAL(cLadoC)

        if(((nLadoA < (nLadoB + nLadoC)) .OR. (nLadoB < (nLadoA + nLadoC)) .OR. (nLadoC < (nLadoA + nLadoB))).AND. (nLadoA != 0 .AND. nLadoB != 0 .AND. nLadoC != 0))
            FWAlertInfo('Os valores informados formam um tri�ngulo! ','Tri�ngulo')
            lVerdade := .T.
        else
            FWAlertInfo('Os valores informados n�o formam um tri�ngulo! ','Tri�ngulo')
        endif        
    end do

    if ((nLadoA <> nLadoB) .AND. (nLadoB <> nLadoC) .AND. (nLadoC <> nLadoA))
        FWAlertInfo(' Escaleno','Tri�ngulo')
    elseif ((nLadoA = nLadoB) .AND. (nLadoB = nLadoC) .AND. (nLadoC = nLadoA))
        FWAlertInfo(' Equil�tero','Tri�ngulo')
    elseif ((nLadoA < (nLadoB + nLadoC)) .AND. (nLadoB < (nLadoA + nLadoC)) .AND. (nLadoC < (nLadoA + nLadoB)))
        FWAlertInfo(' Is�sceles','Tri�ngulo')
    endif

Return
