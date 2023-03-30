#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function Dia_ZZGRP
    Lista BD - Exerc�cio 21 | DESAFIO!
    @type  Function
    @author Andr� Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
    @see https://tdn.totvs.com/display/public/framework/Posicione+-+Posiciona+tabela+em+registro
/*/

User Function Dia_ZZGRP()

    Local cTipoCampo := " "
    Local cCampo     := M->B1_ZZGRP
    Local cNum       := " "
    Local aSemana    := {'Domingo', 'Segunda', 'Ter�a', 'Quarta', 'Quinta', 'Sexta', 'S�bado'}
    Local nNum       := 0

    cTipoCampo := Posicione("SB1", 1, xFilial("SB1") + B1_COD, "M->B1_TIPO") //? Posicione: B1_FILIAL + B1_COD (chave ou �ndice da tabela do Protheus) | M->B1_ZZGRP (gatilho do campo)
    //* Posicione (Alias, �ndice, Chave, Campo)

    if (!Empty(cTipoCampo) .AND. cTipoCampo <> " " .AND. (ALTERA))
        cNum := FWInputBox("Insira um n�mero: ", cNum)

        nNum := VAL(cNum)

        if(nNum >= 1 .AND. nNum <=7)
            FWAlertInfo(aSemana[nNum], 'Dia da semana: ')
            cCampo := UPPER(aSemana[nNum])
        else
            FWAlertWarning('Valor inv�lido!', 'ATEN��O')
        endif
    endif

Return cCampo
