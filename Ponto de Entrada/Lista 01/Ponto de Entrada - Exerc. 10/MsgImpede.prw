#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MsgImpede
    Lista 01: Pontos de Entrada - Exercício 10
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
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
        ALERT('Este município já existe para a UF informada!')
    endif

Return 
