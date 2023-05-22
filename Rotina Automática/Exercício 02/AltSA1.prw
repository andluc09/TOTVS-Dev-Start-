#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function AltSA1
    Rotina Autom�tica | Exerc�cio 02
    @type   Function
    @author Andr� Lucas M. Santos
    @since 19/05/2023
    @version 0.1
    @see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=566489232
    @see https://terminaldeinformacao.com/2021/07/14/voce-sabe-o-que-significam-as-letras-na-chamada-de-um-msexecauto/
    @see https://terminaldeinformacao.com/2015/12/01/vd-advpl-011/
/*/

User Function AltSA1()

    Local aVetor := {}
    Local nOper  := 4
    Private lMsErroAuto := .F.

    //? Abre Ambiente (n�o deve ser utilizado caso utilize interface ou seja chamado de uma outra rotina que j� inicializou o ambiente)
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'

//* VERIFICAR OS CAMPOS OBRIGAT�RIOS //

//*     Filial
//*     C�digo
//*     Loja
//*     Nome
//*     Fisica/Juridica
//*     Endere�o
//*     Nome Fantasia
//*     Tipo
//*     Estado
//*     Munic�pio

    //? Adicionando dados ao Array
    AADD(aVetor, {'A1_FILIAL', xFilial('SA1')          , NIL})
    AADD(aVetor, {'A1_COD'   , '00199'                 , NIL})
    AADD(aVetor, {'A1_END'   , 'Washington, 5003 - EUA', NIL})

    //? Executa a rotina autom�tica
    MSExecAuto({|x, y| MATA030(x, y)}, aVetor, nOper) //? nOper = 4 - Opera��o de Altera��o

    //? Se houver algum erro
    if lMsErroAuto
        //? Apresenta o erro
        MostraErro()
    else
        FWAlertInfo("Alterado com sucesso!", "RESULTADO")
    endif

    RESET ENVIRONMENT

Return
