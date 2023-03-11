#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 1 - Lista: Pontos de Entrada
/*/

User Function MsgImpede()

    Local cMemoria    := AllTrim(M->CC2_FILIAL+M->CC2_EST+M->CC2_MUN)

    DbSelectArea('CC2')
    CC2->(dbSetOrder(4)) //CC2_FILIAL+CC2_EST+CC2_MUN
    
    while !('CC2')->(Eof())
        if (AllTrim(CC2->CC2_FILIAL+CC2->CC2_EST+CC2->CC2_MUN) == cMemoria)
            xRet := .F.
        endif
        ('CC2')->(DBSkip())
    enddo

    if(xRet == .F.)
        ALERT('Este munic�pio j� existe para a UF informada!')
    endif

Return 
