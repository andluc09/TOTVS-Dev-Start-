#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function ExclSA2
    Rotina Autom�tica | Exerc�cio 02
    @type   Function
    @author Andr� Lucas M. Santos
    @since 19/05/2023
    @version 0.1
    @see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=566489232
    @see https://terminaldeinformacao.com/2021/07/14/voce-sabe-o-que-significam-as-letras-na-chamada-de-um-msexecauto/
    @see https://terminaldeinformacao.com/2015/12/01/vd-advpl-011/
/*/

User Function ExclSA2()

    Local aVetor := {}
    Local nOper  := 5
    Private lMsErroAuto := .F.

    //? Abre Ambiente (n�o deve ser utilizado caso utilize interface ou seja chamado de uma outra rotina que j� inicializou o ambiente)
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'

//* VERIFICAR OS CAMPOS OBRIGAT�RIOS //

//*     Filial
//*     C�digo
//*     Loja
//*     Raz�o Social
//*     Nome Fantasia
//*     Endere�o
//*     Estado
//*     C�digo Munic�pio
//*     Munic�pio
//*     Tipo

    //? Adicionando dados ao Array
    AADD(aVetor, {'A2_FILIAL', xFilial('SA2')                   , NIL})
    AADD(aVetor, {'A2_COD'   , '797956'                         , NIL})
    AADD(aVetor, {'A2_NOME'  , 'EXCLUIDO - BIC', NIL})

    //? Executa a rotina autom�tica
    MSExecAuto({|x, y| MATA020(x, y)}, aVetor, nOper) //? nOper = 5 - Opera��o de Exclus�o

    //? Se houver algum erro
    if lMsErroAuto
        //? Apresenta o erro
        MostraErro()
    else
        FWAlertInfo("Exclu�do com sucesso!", "RESULTADO")
    endif

    RESET ENVIRONMENT

Return
