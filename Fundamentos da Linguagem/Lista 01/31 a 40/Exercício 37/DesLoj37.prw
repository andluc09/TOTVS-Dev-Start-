#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function DesLoj37
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 37
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function DesLoj37()

    Local nValor  := 0
    Local nDesc   := 0
    Local nDesc1  := 0
    Local nCompra := 0
    Local nCp     := 500
    Local nCont   := 0
    Local nNum    := 0
    Local nFim    := 0
    Local nAux    := 0
    Local aValor  := {}
    Local aDesc   := {}
    Local cExibe  := ''

    nCompra := VAL(FWInputBox('Insira o valor da compra: ', 'R$ '))

    nAux := nCompra

    while nCp <> (nCompra + 100)
        for nCont := 1 to 29
            if nCompra >= 500 .AND. nCompra <= 2900
                if(nCompra%100 != 0)
                    do case 
                        case nCompra > 500 .AND. nCompra < 600
                            nCompra := 500
                        case nCompra > 600 .AND. nCompra < 700
                            nCompra := 600
                        case nCompra > 700 .AND. nCompra < 800
                            nCompra := 700      
                        case nCompra > 800 .AND. nCompra < 900
                            nCompra := 800    
                        case nCompra > 900 .AND. nCompra < 1000
                            nCompra := 900
                        case nCompra > 1000 .AND. nCompra < 1100
                            nCompra := 1000
                        case nCompra > 1100 .AND. nCompra < 1200
                            nCompra := 1100
                        case nCompra > 1200 .AND. nCompra < 1300
                            nCompra := 1200 
                        case nCompra > 1300 .AND. nCompra < 1400
                            nCompra := 1300
                        case nCompra > 1400 .AND. nCompra < 1500
                            nCompra := 1400                                                                                                                                                                                                                                
                        case nCompra > 1500 .AND. nCompra < 1600
                            nCompra := 1500
                        case nCompra > 1600 .AND. nCompra < 1700
                            nCompra := 1600
                        case nCompra > 1700 .AND. nCompra < 1800
                            nCompra := 1700
                        case nCompra > 1800 .AND. nCompra < 1900
                            nCompra := 1800
                        case nCompra > 1900 .AND. nCompra < 2000
                            nCompra := 1900
                        case nCompra > 2000 .AND. nCompra < 2100
                            nCompra := 2000
                        case nCompra > 2100 .AND. nCompra < 2200
                            nCompra := 2100
                        case nCompra > 2200 .AND. nCompra < 2300
                            nCompra := 2200
                        case nCompra > 2300 .AND. nCompra < 2400
                            nCompra := 2300
                        case nCompra > 2400 .AND. nCompra < 2500
                            nCompra := 2400
                        case nCompra > 2500 .AND. nCompra < 2600
                            nCompra := 2500
                        case nCompra > 2600 .AND. nCompra < 2700
                            nCompra := 2600
                        case nCompra > 2700 .AND. nCompra < 2800
                            nCompra := 2700
                        case nCompra > 2800 .AND. nCompra < 2900
                            nCompra := 2800                                                                                                                                                                                                                                                                                                                                                                                                        
                    endcase
                endif
                if  nCompra/100 == nCont
                    nDesc += 1
                endif
            elseif nCompra > 2900
                nDesc := 25
            endif
        next
        if(nCompra%100 == 0)
            nCp += 100
        else
            nCp++
        endif
    enddo

    if(nAux%100 != 0)
        nValor := nAux - ((nDesc/100)*nAux)

        FWAlertInfo('Valor pago: R$ ' + cValToChar(nAux) + ' desconto adquirido: ' + cValToChar(nDesc) + '%' + CRLF + CRLF + 'Valor com desconto: R$ ' + cValToChar(nValor), 'DESCONTO APLICADO')
    else
        nValor := nCompra - ((nDesc/100)*nCompra)

        FWAlertInfo('Valor pago: R$ ' + cValToChar(nCompra) + ' desconto adquirido: ' + cValToChar(nDesc) + '%' + CRLF + CRLF + 'Valor com desconto: R$ ' + cValToChar(nValor), 'DESCONTO APLICADO')
    endif

    while nNum <> 3200
        for nCont := 1 to 29
            if nNum >= 500 .AND. nNum <= 2900
                if  Round(nNum/100, 0) == nCont
                    aADD(aValor, nNum)
                    nDesc1 += 1
                    aADD(aDesc, nDesc1)
                endif
            elseif nNum > 2900
                aADD(aValor, nNum)
                nDesc1 := 25
                aADD(aDesc, nDesc1)
                nCont := 29
            endif
        next
        nNum += 100
    enddo

    cExibe := 'Valor da compra  –  Porcentagem de desconto  –  Valor final' + CRLF + CRLF

    for nNum := 1 to LEN(aValor)
        nFim := (aValor[nNum] - ((aDesc[nNum]/100)*aValor[nNum] ))
        cExibe += 'Valor de compra: R$ ' + cValToChar(aValor[nNum]) + '; Porcentagem de desconto: ' + cValToChar(aDesc[nNum]) + '% ; Valor Final: R$ ' + cValToChar(nFim) + CRLF + CRLF
    next

    TScrollArea(cExibe)

Return

Static Function TScrollArea(cExibe)

    DEFINE DIALOG oDlg TITLE " DESCONTO APLICADO " FROM 180,180 TO 700,950 PIXEL;
    FONT oFont :=  TFont():New('Arial',,-14,.T.)

    // Cria objeto Scroll
    oScroll := TScrollArea():New(oDlg,01,01,100,100)
    oScroll:Align := CONTROL_ALIGN_ALLCLIENT

    // Cria painel
    @ 000,000 MSPANEL oPanel OF oScroll SIZE 1000,1000 COLOR CLR_HRED

    // Define objeto painel como filho do scroll
    oScroll:SetFrame( oPanel )

    // Define as características de texto incluindo a sujeição como filho do painel 
    TSay():New(15,12,{||cExibe},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlg CENTERED

Return
