#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MediaAluno
    Lista Array - Exercício 16
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function MediaAluno()

    Local aArrayAluno[4][5] //! [4] Coluna x [5] Linha
    Local nColuna   := 0
    Local nLinha    := 0
    Local cTexto1    := ""
    Local cTexto2_1    := ""
    Local cTexto2_2    := ""
    Local cTexto2_3    := ""
    Local cTexto3    := ""
    Local cTextoA   := ""
    Local nNum1      := 1
    Local nNum2      := 1
    Local nNum3      := 1
    Local nNum4      := 1

    //? 0    Coluna:    1   2   3   4
    //? 1     Nomes:    A   B   C   D
    //? 2     Notas1:   N1  N1  N1  N1
    //? 3     Notas2:   N2  N2  N2  N2
    //? 4     Notas3:   N3  N3  N3  N3
    //? 5     Médias:   M.A M.B M.C M.D

    for nColuna := 1 to 4
            aArrayAluno[nColuna][1] := FWInputBox("Insira o " + CValToChar(nColuna) + "º nome de um aluno: ")
            aArrayAluno[nColuna][5] := 0
            cTextoA += "Nome: " + CValToChar(aArrayAluno[nColuna][1]) + Space(1) + CRLF + CRLF
            if(nColuna <= 3)
                cTexto1 += aArrayAluno[nColuna][1] + Space(1) + "• "
            else
                cTexto1 += aArrayAluno[nColuna][1] + Space(1)
            endif
        for nLinha  := 2 to 4
                aArrayAluno[nColuna][nLinha] := VAL(FWInputBox("Digite a " + CValToChar(nNum1++) + "ª nota do " + CValToChar(nColuna) + "º aluno: "))
                aArrayAluno[nColuna][5] += aArrayAluno[nColuna][nLinha]/3  
                cTextoA += "Nota " + CValToChar(nNum3++) + ": " + CValToChar(aArrayAluno[nColuna][nLinha]) + Space(1) + CRLF + CRLF
                if(nNum2 == 1)
                    if(nColuna <= 3)
                        cTexto2_1 += CValToChar(aArrayAluno[nColuna][nLinha]) + Space(1) + "• "
                    else
                        cTexto2_1 += CValToChar(aArrayAluno[nColuna][nLinha]) + Space(1)
                    endif
                    nNum2++
                elseif(nNum2 == 2)
                    if(nColuna <= 3)
                        cTexto2_2 += CValToChar(aArrayAluno[nColuna][nLinha]) + Space(1) + "• "
                    else
                        cTexto2_2 += CValToChar(aArrayAluno[nColuna][nLinha]) + Space(1)
                    endif
                    nNum2++
                else
                    if(nColuna <= 3)
                        cTexto2_3 += CValToChar(aArrayAluno[nColuna][nLinha]) + Space(1) + "• "
                    else
                        cTexto2_3 += CValToChar(aArrayAluno[nColuna][nLinha]) + Space(1)
                    endif                        
                endif
        next nLinha 
        nNum1 := 1
        nNum2 := 1
        nNum3 := 1
        nNum4 := 1
        cTextoA += "Média Aluno " + CValToChar(nNum4++) + ": " + CValToChar(aArrayAluno[nColuna][5]) + Space(1) + CRLF +CRLF
        if(nColuna <= 3)
            cTexto3 += CValToChar(aArrayAluno[nColuna][5]) + Space(1) + "• "
        else
            cTexto3 += CValToChar(aArrayAluno[nColuna][5]) + Space(1)
        endif            
    next nColuna

    FWAlertInfo("Nomes: " + cTexto1 + CRLF + CRLF + "Notas1: " + cTexto2_1 + CRLF + CRLF + "Notas2: " + cTexto2_2 + CRLF + CRLF + "Notas3: " + cTexto2_3 + CRLF + CRLF + "Médias: " + cTexto3, 'Matriz: Alunos, Notas e Médias')

    FWAlertInfo(cTextoA + CRLF + CRLF, 'Matriz: Alunos, Notas e Médias')

Return 
