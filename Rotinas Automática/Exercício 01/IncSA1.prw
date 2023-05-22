#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function IncSA1
    Rotina Automática | Exercício 01
    @type   Function
    @author André Lucas M. Santos
    @since 19/05/2023
    @version 0.1
    @see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=566489232
    @see https://terminaldeinformacao.com/2021/07/14/voce-sabe-o-que-significam-as-letras-na-chamada-de-um-msexecauto/
    @see https://terminaldeinformacao.com/2015/12/01/vd-advpl-011/
/*/

User Function IncSA1()

    Local aDados := {}
    Local nOper  := 3 //? Inclusão
    Private lMsErroAuto := .F.

//! Preenchimento automático de dados para os campos de determinada tabela

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'

//* VERIFICAR OS CAMPOS OBRIGATÓRIOS //

//*     Filial
//*     Código
//*     Loja
//*     Nome
//*     Fisica/Juridica
//*     Endereço
//*     Nome Fantasia
//*     Tipo
//*     Estado
//*     Município

    AADD(aDados, {'A1_FILIAL' , xFilial('SA1')         , NIL}) //? FwFilial() mais recente!!
    AADD(aDados, {'A1_COD'   , '00199'                 , NIL}) 
    AADD(aDados, {'A1_LOJA'   , '50'                   , NIL}) 
    AADD(aDados, {'A1_NOME'   , 'WIZARDS OF THE COAST' , NIL}) 
    AADD(aDados, {'A1_PESSOA' , 'J'                    , NIL})
    AADD(aDados, {'A1_END'    , 'Washington, EUA'      , NIL}) 
    AADD(aDados, {'A1_NREDUZ' , 'WZC'                  , NIL})
    AADD(aDados, {'A1_TIPO'   , 'R'                    , NIL})
    AADD(aDados, {'A1_EST'    , 'SP'                   , NIL})
    AADD(aDados, {'A1_MUN'    , 'SÃO PAULO'            , NIL})

    //?                                      x   ,   y
    //? MsExecAuto({|x, y| MATA030(x, y)}, aDados, nOper)
    //?                                      a   ,   b
    //? MsExecAuto({|a, b| MATA030(a, b)}, aDados, nOper)
    MsExecAuto({|aDados, nOper| MATA030(aDados, nOper)}, aDados, nOper)

    if lMsErroAuto
        MostraErro()
    else
        FWAlertInfo("Incluído com sucesso!", "RESULTADO")
    endif

    RESET ENVIRONMENT

Return 
