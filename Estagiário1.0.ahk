; ================================================
; 🔹 CONFIG BASE AHK (para reutilizar em projetos)
; ================================================

; --- Diretivas Gerais ---
#SingleInstance Force       ; Evita múltiplas instâncias
#Persistent                 ; Mantém o script ativo mesmo sem hotkeys
#MaxThreadsPerHotkey 1      ; Impede hotkeys duplicadas em paralelo
#HotkeyInterval 2000        ; Intervalo para contagem de hotkeys (ms)
#MaxHotkeysPerInterval 200  ; Permite muitas hotkeys em loops
#WinActivateForce

; --- Ajustes de Velocidade ---
SetBatchLines, -1           ; Executa na velocidade máxima
SendMode Input              ; Modo de envio mais rápido e confiável
SetTitleMatchMode, 2        ; Permite identificar janelas por parte do título

; --- Ajustes de Delay (ajuste conforme o sistema alvo) ---
SetKeyDelay, 50, 50         ; Tempo entre teclas
SetControlDelay, 50         ; Delay em controles
SetMouseDelay, 30           ; Delay entre cliques
SetWinDelay, 100            ; Delay em comandos de janela
SetDefaultMouseSpeed, 0     ; Delay no movimento da seta do mouse


; ======================
; 🔹 HOTKEYS DE CONTROLE
; ======================
!Esc::                      ; Alt + Esc = Pausar script
    Pause
    SoundBeep, 750
    return

^Esc::ExitApp                ; Ctrl + Esc = Encerrar script

^r::Reload   ; Ctrl + R recarrega o script

; ===========================
; Lista de frases rápidas
; ===========================
^+1::
SendInput Prezados,`nBoleto(s) gerado(s) conforme solicitação.
return

^+2::
SendInput Prezados,`nPlano de pagamento gerado.
return

^+3::
SendInput Prezados,`nValores requisitados disponíveis na tabela. Esses valores são válidos para o período, matriz e turno requerido no chamado. Obs: Disciplinas optativas não incorrem em custos ao aluno na primeira vez sendo cursadas. 
return

^+4::
SendInput Prezados,`nInformamos que o plano de pagamento foi integralmente gerado, não havendo parcelas pendentes a serem emitidas. Ressaltamos que, caso o(a) discente venha a realizar a reposição de alguma disciplina, será lançada uma parcela adicional correspondente ao valor da disciplina solicitada.
return

^+5::
SendInput Prezados,`nInformamos que o(a) aluno(a) é cobrado(a) com base na quantidade de créditos da(s) disciplina(s) em que está matriculado(a). No momento, não há créditos suficientes para gerar novas parcelas, pois o valor cobrado na(s) mensalidade(s) anterior já cobriu integralmente o valor da(s) disciplina(s) cadastrada(s) no período letivo atual.`n`nSalientamos que, caso haja inclusão de novas disciplinas, serão geradas mensalidades adicionais correspondentes ao valor dos créditos dessas disciplinas.
return

^+6::
SendInput Prezado(a) aluno(a),`nPara que possamos atender à sua solicitação de forma eficaz, solicitamos, por gentileza, que entre em contato com a Central de Relacionamento com o Aluno.
return

; ==============================
; AUTOMAÇÕES - TOTVS e COMPÊNDIO
; ==============================

^F1:: ; Ctrl + F1 (CANCELAR REMESSA DO BOLETO E LANÇAMENTO)
{
    InputBox, repeticoes, Fala Analista!, Quantas parcelas desejas cancelar?, , 200, 150
    if (ErrorLevel || repeticoes = "" || repeticoes+0 != repeticoes || repeticoes <= 0 || Mod(repeticoes, 1) != 0) {
        MsgBox, 16, Erro, Informe um número inteiro maior que zero.
        Return
    }

    Loop, %repeticoes%
    {
        if (Abort) {
            MsgBox, 48, Cancelado, Execução interrompida pelo usuário.
            Abort := false
            Break
        }

        ; Passo 1: Ctrl + Enter
        SendInput,  ^{Enter}

        ; Loop até a janela "Parcela" ficar ativa
        Loop {
            IfWinExist, Parcela
            {
                WinActivate, Parcela
                WinWaitActive, Parcela, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }

        ; Passo 2: Clique 1x na posição 391, 79
        Click, 371, 79  ; Coordenadas fixas — dependente de resolução
        Sleep, 1000

        ; Passo 3: Clique 2x na posição 332, 254
        
        Click, 358, 248, 2  ; Coordenadas fixas — dependente de resolução
        Sleep, 2000
        
        Click, 260, 355, 3  ; Coordenadas fixas — dependente de resolução
        Sleep, 1000

        ; Loop até a janela "Lançamento" ficar ativa
        Loop {
            IfWinExist, Lançamento:
            {
                WinActivate, Lançamento:
                WinWaitActive, Lançamento:, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }

        ; Passo 4: Ctrl + Alt + A
        Click, 295, 45
        Sleep, 500

        ; Passo 5: 11x seta para baixo
        Loop, 11 {
            SendInput, {Down}
            Sleep, 50
        }

        ; Passo 6: Enter
        SendInput, {Enter}
        Sleep, 2000

        Click, 260, 355, 2  ; Coordenadas fixas — dependente de resolução
        Sleep, 10

        Loop {
            IfWinExist, Lançamento
            {
                WinActivate, Lançamento
                WinWaitActive, Lançamento, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }
        ; Passo 7: Ctrl + P
        SendInput, ^p
        Sleep, 500

        ; Passo 8: 3x seta para baixo
        Loop, 3 {
            SendInput, {Down}
            Sleep, 50
        }

        ; Passo 9: Enter
        SendInput, {Enter}
        Sleep, 500
        SendInput, !y
        Sleep, 100

        Loop {
            IfWinExist, Cancelamento Remessa de Boleto
            {
                WinActivate, Cancelamento Remessa de Boleto
                WinWaitActive, Cancelamento Remessa de Boleto, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }
        
        ; Passo 11: 4x tab
        Loop, 4 {
            SendInput, {Tab}
            Sleep, 50
        }

        ; Passo 12: Enter
        SendInput, {Enter}
        Sleep, 300

        ; Passo 13: 1x seta para baixo
        SendInput, {Down}
        Sleep, 300

        ; Passo 14: Enter
        SendInput, {Enter}
        Sleep, 300

        ; Passo 15: Alt + R
        SendInput, !r
        Sleep, 1000

        ; Loop até a janela "Lançamento" ficar ativa
        Loop {
            IfWinExist, Lançamento
            {
                WinActivate, Lançamento
                WinWaitActive, Lançamento, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }
        ; Passo 16: Ctrl + X
        SendInput, ^x

        ; Passo 17: 5x tab
        Loop, 5 {
            SendInput, {Tab}
            Sleep, 50
        }

        ; Passo 18: Enter
        SendInput, {Enter}
        Sleep, 200

        ; Passo 19: 1x seta para baixo
        SendInput, {Down}
        Sleep, 200

        ; Passo 20: Enter
        SendInput, {Enter}
        Sleep, 200

        ; Passo 21: Alt + R
        SendInput, !r

        Loop
        {
            ; Tenta ativar a janela
            IfWinExist, Lançamento
            {
                WinActivate, Lançamento
                ; Aguarda a janela ficar ativa
                WinWaitActive, Lançamento:, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
                ; Se a janela não existir, espera um pouco e tenta de novo
                Sleep, 1000 ; Espera 1 segundo
            }
        }

        ; Passo 23: Alt + O (duas vezes)
        Send !o

        Loop
        {
            ; Tenta ativar a janela
            IfWinExist, Parcela
            {
                WinActivate, Parcela
                ; Aguarda a janela ficar ativa
                WinWaitActive, Parcela, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
                ; Se a janela não existir, espera um pouco e tenta de novo
                Sleep, 1000 ; Espera 1 segundo
            }
        }

        Send !o
        Sleep, 1000

        ; Passo 24: seta para baixo
        SendInput, {Down}
        Sleep, 500

        ; Feedback opcional visual/auditivo por iteração
        ToolTip, Cancelamento %A_Index% concluído!
        SoundBeep, 750, 100
        Sleep, 800
        ToolTip
    }
    ;condicional e input Sim/Não
    ; Mostra uma mensagem perguntando se deseja cancelar o contrato, com botões Yes e No
    MsgBox, 4,, Deseja cancelar o contrato?
    IfMsgBox, Yes
    {
        Sleep, 500
        Click, 465, 44
        Sleep, 1000

        Loop, 4
        {
            SendInput, {Down}
            Sleep, 50
        }

        SendInput, {Enter}
        Sleep, 500

        Loop, 3
        {
            SendInput, {Tab}
            Sleep, 50
        }

        SendInput, {Enter}
        Sleep, 500

        SendInput, {Down}
        Sleep, 100

        SendInput, {Enter}
        Sleep, 500

        Loop, 3
        {
            SendInput, !r
            Sleep, 500
        }
    }
    ; Se o usuário escolheu "No", nada é feito — chegamos aqui.
    return
}
return

^F2:: ; Atalho Ctrl + F2 (ASSISTENTES)
{
    Gui, 1:Destroy
    Depor := ""
    Dispensa := ""
    SerSolidario := ""
    PlanosDiversos := ""

    Gui, 1:New, +AlwaysOnTop, Assistentes
    Gui, 1:Add, Text,, Escolha o plano de pagamento:
    Gui, 1:Add, Button, w250 gDepor, DE:POR
    Gui, 1:Add, Button, w250 gDispensa, DISPENSA DE DISCIPLINA
    Gui, 1:Add, Button, w250 gSerSolidario, SER SOLIDÁRIO
    Gui, 1:Add, Button, w250 gPlanosDiversos, PLANOS DIVERSOS
    Gui, 1:Add, Button, w250 gedicao, EDIÇÃO DE MATRÍCULA
    Gui, 1:Add, Button, w250 greposicao, REPOSIÇÃO DE DISCIPLINA - PÓS
    Gui, 1:Add, Button, w250 gCancelar, Cancelar  ; <<< Botão Cancelar
    Gui, 1:Show,, Fala Analista!
    return

    Cancelar:
        Gui, Destroy
        Depor := ""
        Dispensa := ""
        SerSolidario := ""
        PlanosDiversos := ""
        edicao := ""
        reposicao := ""
    Return

    Depor:
        Gui, 1:Destroy  ; fecha o menu
        
        SetTitleMatchMode, 2

        Loop {
            IfWinExist, Compêndio mágico do faturamento
            {
                WinActivate, Compêndio mágico do faturamento
                WinWaitActive, Compêndio mágico do faturamento, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }

        ; === Etapa 2: Excel ===
        try {
            xl := ComObjActive("Excel.Application")
            sheet := xl.ActiveSheet
            Valor1 := sheet.Range("B17").Text
            QtdeParcelas := sheet.Range("B16").Text
        } catch e {
            MsgBox, 16, Erro, % "Não conectou ao Excel:`n" e.Message
            return
        }

        ; === (Opcional) Ativar janela do TOTVs ===
        attempts := 0
        Loop {
            IfWinExist, TOTVS Linha RM - Educacional
            {
                WinActivate, TOTVS Linha RM - Educacional 
                WinWaitActive, TOTVS Linha RM - Educacional,, 10
                if !ErrorLevel
                    break
            }
            attempts++
            if (attempts > 30) {
                MsgBox, 48, Aviso, Janela do TOTVs não encontrada.
                break
            }
            Sleep, 100
        }

        ; === Etapa 3: Formulário (GUI 2) ===
        Gui, 2:New, +AlwaysOnTop, Fala Analista!
        Gui, 2:Font, s9, Segoe UI
        Gui, 2:Add, Text, x10 y15 w100, Período Letivo:
        Gui, 2:Add, Edit, vPeriodoLetivo x120 y10 w120
        Gui, 2:Add, Text, x10 y45 w100, RA:
        Gui, 2:Add, Edit, vRA x120 y40 w120
        Gui, 2:Add, Text, x10 y75 w100, CodContrato:
        Gui, 2:Add, Edit, vCodContrato x120 y70 w120
        Gui, 2:Add, Text, x10 y105 w100, Data Vencimento:
        Gui, 2:Add, DateTime, vDataVencimento x120 y100 w120, dd/MM/yyyy
        Gui, 2:Add, Button, x30 y140 w90 default gConfirmar_depor, OK
        Gui, 2:Add, Button, x140 y140 w90 gCancelar2, Cancelar
        Gui, 2:Show, w255 h180
    Return

    Confirmar_depor:
        Gui, 2:Submit, NoHide
        if (!RA || !PeriodoLetivo) {
            MsgBox, 48, Atenção, Preencha RA e Período Letivo.
            return
        }
        ; Validação da Data
        FormatTime, hoje, , yyyyMMdd
        FormatTime, dataSelecionada, %DataVencimento%, yyyyMMdd

        FormatTime, DataVencimentoFormatada, %DataVencimento%, dd/MM/yyyy
        FormatTime, Competencia, %DataVencimento%, MM/yyyy

        Gui, 2:Destroy

        SetTitleMatchMode, 2

        ; === Etapa 2: Ativar a janela do TOTVS ===
        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, ahk_exe mstsc.exe
                {
                    WinActivate, ahk_exe mstsc.exe
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, ahk_exe mstsc.exe, , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        ; === Etapa 3: Execução dos comandos com pausas ===

        SendInput {F10}
        Sleep, 200

        SendInput f
        Sleep, 100

        SendInput a
        Sleep, 100

        SendInput i
        Sleep, 100

        SendInput c
        Sleep, 100

        SendInput r
        Sleep, 100

        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Gerar Parcela(s) para Contrato(s)
                {
                    WinActivate, Gerar Parcela(s) para Contrato(s)
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Enter}
        Sleep, 200

        Click, 140, 545
        Sleep, 100

        SendInput, !r
        Sleep, 500

        Loop, 8 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput %PeriodoLetivo%
        Sleep, 1000

        Loop, 8 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput {Space}
        Sleep, 200

        SendInput {Tab}
        Sleep, 500

        SendInput %RA%
        Sleep, 1000

        SendInput {Tab}
        Sleep, 500

        SendInput !a
        Sleep, 500

        ; === Etapa 4: Loop de busca do contrato ===
 
        Click, 157, 155
        Sleep, 2000
        SendInput, {Tab}
        Sleep, 100

        ; === 1. Copiar linha inicial ===
        SendInput, ^c
        Sleep, 100  ; aguardar a cópia
        ClipWait, 2
        linha := Clipboard

        ; === 2. Tabular sem quebrar nomes ou cursos ===
        resultado := RegExReplace(linha, "\s+", "`t")

        ; === 3. Procurar CodContrato ===
        contador := 0

        While (true)  ; loop até achar 5 vezes consecutivas
        {
            ; === Copiar linha atual ===
            SendInput, ^c
            Sleep, 100
            ClipWait, 2
            linha := Clipboard
            resultado := RegExReplace(linha, "\s+", "`t")

            ; === Quebrar linha em colunas e procurar CodContrato exato ===
            colunas := StrSplit(resultado, "`t")
            encontrado := false
            for index, valor in colunas
            {
                if (Trim(valor) = CodContrato)  ; comparação exata
                {
                    encontrado := true
                    break
                }
            }

            if (encontrado)  ; achou contrato exatamente
            {
                contador++  ; soma no contador

                if (contador = 5)  ; 5 consecutivas → ALT+R
                {
                    SendInput, !r
                    Sleep, 100
                    break
                }

                ; Descer para próxima linha
                SendInput, {Down}
                Sleep, 100

                continue
            }
            else
            {
                ; Se não achou, zera contador
                contador := 0

                ; === Ação alternativa ===
                SendInput, {Space}
                Sleep, 100
                Click, 576, 181
                Sleep, 200
                Click, 157, 155
                Sleep, 1500
                SendInput, {Tab}
                Sleep, 100
                Click, 212, 215
                Sleep, 100

                continue
            }
        }

        ; === Esperar janela aparecer ===
        Loop
        {
            IfWinExist, Gerar Parcela(s) para Contrato(s)
            {
                WinActivate, Gerar Parcela(s) para Contrato(s)
                WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                if !ErrorLevel
                    break
            }
            Sleep, 1000
        }

        SendInput {Tab}
        Sleep, 500

        SendInput {Tab}
        Sleep, 500

        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Gerar Parcela(s) para Contrato(s)
                {
                    WinActivate, Gerar Parcela(s) para Contrato(s)
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        SendRaw, % "%MENSALIDADE%(COM PONTUALIDADE"
        Sleep, 3000

        SendInput {Tab}
        Sleep, 200

        SendInput {Tab}
        Sleep, 100
        
        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Right}
        Sleep, 100

        SendInput {Right}
        Sleep, 100

        SendInput {F2}
        Sleep, 500

        SendInput %Valor1%
        Sleep, 2500

        SendInput !r
        Sleep, 500

        SendInput {Tab}
        Sleep, 500

        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Gerar Parcela(s) para Contrato(s)
                {
                    WinActivate, Gerar Parcela(s) para Contrato(s)
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }
        
        SendInput %QtdeParcelas%
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, 01
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 200

        SendInput 01
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, 01
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, Parcela do plano
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput %Competencia%
        Sleep, 200

        Loop, 4 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput {Up}
        Sleep, 100

        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 200

        SendInput %DataVencimentoFormatada%
        Sleep, 200

        SendInput !r
        Sleep, 100

        SendInput !r
        Sleep, 100

        SendInput !r
        Sleep, 100
    return


    Cancelar2:
        Gui, 2:Destroy
        RA := ""
        PeriodoLetivo := ""
        DataVencimento := ""
    return

    ; ============================================
    ; Rotina Dispensa
    ; ============================================
    Dispensa:
        Gui, 1:Destroy  ; fecha o menu

        SetTitleMatchMode, 2

        ; === Ativar Compêndio ===
        Loop {
            IfWinExist, Compêndio mágico do faturamento
            {
                WinActivate, Compêndio mágico do faturamento
                WinWaitActive, Compêndio mágico do faturamento, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }

        ; === Conectar ao Excel ===
        try {
            xl := ComObjActive("Excel.Application")
            sheet := xl.ActiveSheet
            Valor1 := sheet.Range("B43").Text
            QtdeParcelas := sheet.Range("B42").Text
            Ocorrencia := sheet.Range("B44").Text
            Coligada := sheet.Range("B22").Text
        } catch e {
            MsgBox, 16, Erro, % "Não conectou ao Excel:`n" e.Message
            return
        }

        ; === Ativar TOTVS Linha RM - Educacional (opcional) ===
        attempts := 0
        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, ahk_exe mstsc.exe
                {
                    WinActivate, ahk_exe mstsc.exe
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, ahk_exe mstsc.exe, , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        ; === Tabela de Serviços: texto legível -> chave curta -> código ===
        Servicos := {}
        Servicos["UNINASSAU - Com pontualidade"] := {Chave:"UNINASSAU_EAD", Codigo:1041}
        Servicos["UNINASSAU - Mensalidade Digital-EAD"]          := {Chave:"UNINASSAU_DIGITAL", Codigo:769}
        Servicos["UNAMA - Com pontualidade"]     := {Chave:"UNAMA_EAD", Codigo:708}
        Servicos["UNAMA - Mensalidade Digital-EAD"]           := {Chave:"UNAMA_DIGITAL", Codigo:523}
        Servicos["UNG - Com pontualidade"]       := {Chave:"UNG_EAD", Codigo:684}
        Servicos["UNG - Mensalidade Digital-EAD"]             := {Chave:"UNG_DIGITAL", Codigo:567}
        Servicos["FAEL - Com pontualidade"]      := {Chave:"FAEL_EAD", Codigo:212}
        Servicos["FAEL - Mensalidade Digital-EAD"]            := {Chave:"FAEL_DIGITAL", Codigo:1}
        Servicos["UNINORTE - Com pontualidade"]  := {Chave:"UNINORTE_EAD", Codigo:1142}
        Servicos["UNINORTE - Mensalidade Digital-EAD"]       := {Chave:"UNINORTE_DIGITAL", Codigo:620}

        ; === Monta a lista de serviços para a DropDownList ===
        ListaServicos := ""
        for ServicoNome, Info in Servicos
            ListaServicos .= ServicoNome "|"
        StringTrimRight, ListaServicos, ListaServicos, 1  ; remove o último "|"

        ; === Configuração da GUI ===
        GuiWidth := 400
        GuiHeight := 180
        Gui, 2:Destroy
        Gui, 2:New, +AlwaysOnTop, Fala Analista!
        Gui, 2:Font, s9, Segoe UI

        ; Campos
        Gui, 2:Add, Text, x10 y10 w100, Período Letivo:
        Gui, 2:Add, Edit, vPeriodoLetivo x120 y10 w215
        Gui, 2:Add, Text, x10 y40 w100, RA:
        Gui, 2:Add, Edit, vRA x120 y40 w215
        Gui, 2:Add, Text, x10 y70 w100, CodContrato:
        Gui, 2:Add, Edit, vCodContrato x120 y70 w215
        Gui, 2:Add, Text, x10 y100 w100, Parcela Inicial:
        Gui, 2:Add, Edit, vParcelaInicial x120 y100 w215
        Gui, 2:Add, Text, x10 y130 w100, Serviço:
        Gui, 2:Add, DropDownList, vServicoSelecionado x120 y130 w215, %ListaServicos%
        Gui, 2:Add, Text, x10 y165 w100, Data Vencimento:
        Gui, 2:Add, DateTime, vDataVencimento x120 y160 w215, dd/MM/yyyy
        Gui, 2:Add, Button, x55 y200 w110 default gConfirmar_dispensa, OK
        Gui, 2:Add, Button, x195 y200 w110 gCancelar3, Cancelar
        Gui, 2:Show, w350 h240
    Return

    ; === Botão OK ===
    Confirmar_dispensa:
        Gui, 2:Submit, NoHide

        if (!RA || !ServicoSelecionado || !PeriodoLetivo || !CodContrato) {
            MsgBox, 48, Atenção, preencha todas as informações corretamente.
            return
        }

        CodigoSelecionado := Servicos[ServicoSelecionado].Codigo
        Chave := Servicos[ServicoSelecionado].Chave

        ; Validação da Data
        FormatTime, hoje, , yyyyMMdd
        FormatTime, dataSelecionada, %DataVencimento%, yyyyMMdd

        FormatTime, DataVencimentoFormatada, %DataVencimento%, dd/MM/yyyy
        FormatTime, Competencia, %DataVencimento%, MM/yyyy

        Gui, 2:Destroy

        ; === Etapa 2: Ativar a janela do TOTVS ===
        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, TOTVS Linha RM - Educacional
                {
                    WinActivate, TOTVS Linha RM - Educacional
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, TOTVS Linha RM - Educacional, , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        ; === Etapa 3: Execução dos comandos com pausas ===

        SendInput {F10}
        Sleep, 200

        SendInput f
        Sleep, 100

        SendInput a
        Sleep, 100

        SendInput i
        Sleep, 100

        SendInput c
        Sleep, 100

        SendInput r
        Sleep, 100

        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Gerar Parcela(s) para Contrato(s)
                {
                    WinActivate, Gerar Parcela(s) para Contrato(s)
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Enter}
        Sleep, 200

        Click, 140, 545
        Sleep, 100

        SendInput, !r
        Sleep, 500

        Loop, 8 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput, %PeriodoLetivo%
        Sleep, 1000

        Loop, 8 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput {Space}
        Sleep, 200

        SendInput {Tab}
        Sleep, 500

        SendInput %RA%
        Sleep, 1000

        SendInput {Tab}
        Sleep, 500

        SendInput !a
        Sleep, 500

                ; === Etapa 4: Loop de busca do contrato ===
 
        Click, 157, 155
        Sleep, 2000
        SendInput, {Tab}
        Sleep, 100

        ; === 1. Copiar linha inicial ===
        SendInput, ^c
        Sleep, 100  ; aguardar a cópia
        ClipWait, 2
        linha := Clipboard

        ; === 2. Tabular sem quebrar nomes ou cursos ===
        resultado := RegExReplace(linha, "\s+", "`t")

        ; === 3. Procurar CodContrato ===
        contador := 0

        While (true)  ; loop até achar 5 vezes consecutivas
        {
            ; === Copiar linha atual ===
            SendInput, ^c
            Sleep, 100
            ClipWait, 2
            linha := Clipboard
            resultado := RegExReplace(linha, "\s+", "`t")

            ; === Quebrar linha em colunas e procurar CodContrato exato ===
            colunas := StrSplit(resultado, "`t")
            encontrado := false
            for index, valor in colunas
            {
                if (Trim(valor) = CodContrato)  ; comparação exata
                {
                    encontrado := true
                    break
                }
            }

            if (encontrado)  ; achou contrato exatamente
            {
                contador++  ; soma no contador

                if (contador = 5)  ; 5 consecutivas → ALT+R
                {
                    SendInput, !r
                    Sleep, 100
                    break
                }

                ; Descer para próxima linha
                SendInput, {Down}
                Sleep, 100

                continue
            }
            else
            {
                ; Se não achou, zera contador
                contador := 0

                ; === Ação alternativa ===
                SendInput, {Space}
                Sleep, 100
                Click, 576, 181
                Sleep, 200
                Click, 157, 155
                Sleep, 1500
                SendInput, {Tab}
                Sleep, 100
                Click, 212, 215
                Sleep, 100

                continue
            }
        }

        ; === Esperar janela aparecer ===
        Loop
        {
            IfWinExist, Gerar Parcela(s) para Contrato(s)
            {
                WinActivate, Gerar Parcela(s) para Contrato(s)
                WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                if !ErrorLevel
                    break
            }
            Sleep, 1000
        }
        
        SendInput {Tab}
        Sleep, 500

        SendInput, %CodigoSelecionado%
        Sleep, 2500

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100
        
        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Right}
        Sleep, 100

        SendInput {Right}
        Sleep, 100

        SendInput {F2}
        Sleep, 500

        SendInput %Valor1%
        Sleep, 2500

        SendInput !r
        Sleep, 500

        SendInput {Tab}
        Sleep, 500

        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Gerar Parcela(s) para Contrato(s)
                {
                    WinActivate, Gerar Parcela(s) para Contrato(s)
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }
            
        
        SendInput %QtdeParcelas%
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, 01
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 200

        SendInput %ParcelaInicial%
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, 01
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, Parcela do plano
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput %Competencia%
        Sleep, 200

        Loop, 4 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput {Up}
        Sleep, 100

        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 200

        SendInput %DataVencimentoFormatada%
        Sleep, 200

        SendInput !r
        Sleep, 100

        SendInput !r
        Sleep, 100

        SendInput !r
        Sleep, 2000

        SendInput ^a
        Sleep 100

        Loop, 3 {
        SendInput, {Up}
        Sleep, 50
        }
        Send {Enter}
        Sleep 500

        Send {Down}
        Sleep 1000

        Send {Enter}
        Sleep 2000

        Loop
        {
             ; Tenta ativar a janela
            IfWinExist, Ocorrência
            {
                WinActivate, Ocorrência
                ; Aguarda a janela ficar ativa
                WinWaitActive, Ocorrência, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
            ; Se a janela não existir, espera um pouco e tenta de novo
            Sleep, 1000 ; Espera 1 segundo
            }
        }  

        Loop, 14 {
            SendInput, {Tab}
            Sleep, 50
        }

        SendRaw, % "%Fat"
        Sleep 1000

        Loop, 3 {
            SendInput, {Tab}
            Sleep, 50
        }

        If (Coligada = "UNG"){
            SendRaw, % "%DIFERENÇA"
            Sleep 1000
        }
        Else{
            SendRaw, % "%Disp"
            Sleep 1000
        }       
        SendInput, {Tab}
        Sleep, 50

        SendInput, {Tab}
        Sleep, 50

        FormatTime, DataVencimentoFormatada, %A_Now%, dd/MM/yyyy

        SendInput, %DataVencimentoFormatada%
        Sleep 1000

        SendInput, {Tab}
        Sleep, 50

        SendInput, {Tab}
        Sleep, 500

        SendInput, %Ocorrencia%
        Sleep, 500
        SendInput, {Enter}
        SendInput, {Enter}
        Sleep, 200
        Loop
        {
             ; Tenta ativar a janela
            IfWinExist, *Sem título - Bloco de Notas
            {
                WinActivate, *Sem título - Bloco de Notas
                ; Aguarda a janela ficar ativa
                WinWaitActive, *Sem título - Bloco de Notas, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
            ; Se a janela não existir, espera um pouco e tenta de novo
            Sleep, 1000 ; Espera 1 segundo
            }
        }
        SendInput, ^a
        Sleep, 200
        SendInput, ^c
        Sleep, 200
        Loop
        {
             ; Tenta ativar a janela
            IfWinExist, Ocorrência
            {
                WinActivate, Ocorrência
                ; Aguarda a janela ficar ativa
                WinWaitActive, Ocorrência, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
            ; Se a janela não existir, espera um pouco e tenta de novo
            Sleep, 1000 ; Espera 1 segundo
            }
        }           
        SendInput, ^v
        Sleep, 200
        SendInput, ^a
        Sleep, 200
        SendInput, ^c
        SendInput, !o
    return

    Cancelar3:
        Gui, 2:Destroy
        RA := ""
        ServicoSelecionado := ""
        DataVencimento := ""
    return

    SerSolidario:
        Gui, 1:Destroy  ; fecha o menu

        SetTitleMatchMode, 2

        Loop {
            IfWinExist, Compêndio mágico do faturamento
            {
                WinActivate, Compêndio mágico do faturamento
                WinWaitActive, Compêndio mágico do faturamento, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }

        ; === Etapa 2: Excel ===
        try {
            xl := ComObjActive("Excel.Application")
            sheet := xl.ActiveSheet
            Valor1 := sheet.Range("E13").Text
            QtdeParcelas := sheet.Range("E12").Text
        } catch e {
            MsgBox, 16, Erro, % "Não conectou ao Excel:`n" e.Message
            return
        }

        ; === (Opcional) Ativar janela do TOTVs ===
        attempts := 0
        Loop {
            IfWinExist, TOTVS Linha RM - Educacional
            {
                WinActivate, TOTVS Linha RM - Educacional 
                WinWaitActive, TOTVS Linha RM - Educacional,, 15
                if !ErrorLevel
                    break
            }
            attempts++
            if (attempts > 30) {
                MsgBox, 48, Aviso, Janela do TOTVs não encontrada.
                break
            }
            Sleep, 1000
        }

        ; === Etapa 3: Formulário (GUI 2) ===
        Gui, 2:Destroy
        Gui, 2:New, +AlwaysOnTop, Fala Analista!
        Gui, 2:Font, s9, Segoe UI
        Gui, 2:Add, Text, x10 y15 w100, Período Letivo:
        Gui, 2:Add, Edit, vPeriodoLetivo x120 y10 w120
        Gui, 2:Add, Text, x10 y45 w100, RA:
        Gui, 2:Add, Edit, vRA x120 y40 w120
        Gui, 2:Add, Text, x10 y75 w100, CodContrato:
        Gui, 2:Add, Edit, vCodContrato x120 y70 w120
        Gui, 2:Add, Text, x10 y105 w100, Data Vencimento:
        Gui, 2:Add, DateTime, vDataVencimento x120 y100 w120, dd/MM/yyyy
        Gui, 2:Add, Button, x30 y140 w90 default gConfirmar_SerSolidario, OK
        Gui, 2:Add, Button, x140 y140 w90 gCancelar, Cancelar
        Gui, 2:Show, w255 h180
    Return

    Confirmar_SerSolidario:
        Gui, 2:Submit, NoHide
        if (!RA || !CodContrato) {
            MsgBox, 48, Atenção, Preencha o RA, o Período Letivo e o Código do Contrato.
            return
        }

        ; Validação da Data
        FormatTime, hoje, , yyyyMMdd
        FormatTime, dataSelecionada, %DataVencimento%, yyyyMMdd

        FormatTime, DataVencimentoFormatada, %DataVencimento%, dd/MM/yyyy
        FormatTime, Competencia, %DataVencimento%, MM/yyyy

        Gui, 2:Destroy

        ; === Etapa 2: Ativar a janela do TOTVS ===
        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, ahk_exe mstsc.exe
                {
                    WinActivate, ahk_exe mstsc.exe
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, ahk_exe mstsc.exe, , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        ; === Etapa 3: Execução dos comandos com pausas ===

        SendInput {F10}
        Sleep, 200

        SendInput f
        Sleep, 100

        SendInput a
        Sleep, 100

        SendInput i
        Sleep, 100

        SendInput c
        Sleep, 100

        SendInput r
        Sleep, 100

        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Gerar Parcela(s) para Contrato(s)
                {
                    WinActivate, Gerar Parcela(s) para Contrato(s)
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Gerar Parcela(s) para Contrato(s), , 15
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Enter}
        Sleep, 200

        Click, 140, 545
        Sleep, 100

        SendInput, !r
        Sleep, 500

        Loop, 8 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput, %PeriodoLetivo%
        Sleep, 1000

        Loop, 8 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput {Space}
        Sleep, 200

        SendInput {Tab}
        Sleep, 500

        SendInput %RA%
        Sleep, 1000

        SendInput {Tab}
        Sleep, 500

        SendInput !a
        Sleep, 500

        ; === Etapa 4: Loop de busca do contrato ===
 
        Click, 157, 155
        Sleep, 2000
        SendInput, {Tab}
        Sleep, 100

        ; === 1. Copiar linha inicial ===
        SendInput, ^c
        Sleep, 100  ; aguardar a cópia
        ClipWait, 2
        linha := Clipboard

        ; === 2. Tabular sem quebrar nomes ou cursos ===
        resultado := RegExReplace(linha, "\s+", "`t")

        ; === 3. Procurar CodContrato ===
        contador := 0

        While (true)  ; loop até achar 5 vezes consecutivas
        {
            ; === Copiar linha atual ===
            SendInput, ^c
            Sleep, 100
            ClipWait, 2
            linha := Clipboard
            resultado := RegExReplace(linha, "\s+", "`t")

            ; === Quebrar linha em colunas e procurar CodContrato exato ===
            colunas := StrSplit(resultado, "`t")
            encontrado := false
            for index, valor in colunas
            {
                if (Trim(valor) = CodContrato)  ; comparação exata
                {
                    encontrado := true
                    break
                }
            }

            if (encontrado)  ; achou contrato exatamente
            {
                contador++  ; soma no contador

                if (contador = 5)  ; 5 consecutivas → ALT+R
                {
                    SendInput, !r
                    Sleep, 100
                    break
                }

                ; Descer para próxima linha
                SendInput, {Down}
                Sleep, 100

                continue
            }
            else
            {
                ; Se não achou, zera contador
                contador := 0

                ; === Ação alternativa ===
                SendInput, {Space}
                Sleep, 100
                Click, 576, 181
                Sleep, 200
                Click, 157, 155
                Sleep, 1500
                SendInput, {Tab}
                Sleep, 100
                Click, 212, 215
                Sleep, 100

                continue
            }
        }

        ; === Esperar janela aparecer ===
        Loop
        {
            IfWinExist, Gerar Parcela(s) para Contrato(s)
            {
                WinActivate
                WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                if !ErrorLevel
                    break
            }
            Sleep, 1000
        }


        ; === Após abrir janela ===
        SendInput {Tab}
        Sleep, 1000
        SendInput {Tab}
        Sleep, 1000


        SendInput, PARCELAMENTO
        Sleep, 2500

        SendInput {Tab}
        Sleep, 200

        SendInput {Tab}
        Sleep, 100
        
        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Tab}
        Sleep, 100

        SendInput {Right}
        Sleep, 100

        SendInput {Right}
        Sleep, 100

        SendInput {F2}
        Sleep, 500

        SendInput %Valor1%
        Sleep, 2500

        SendInput !r
        Sleep, 500

        SendInput {Tab}
        Sleep, 500

        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Gerar Parcela(s) para Contrato(s)
                {
                    WinActivate, Gerar Parcela(s) para Contrato(s)
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 10 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }
        
        SendInput %QtdeParcelas%
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, 01
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 200

        SendInput 01
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, 01
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput, Parcela do plano
        Sleep, 200

        SendInput {Tab}
        Sleep, 100

        SendInput %Competencia%
        Sleep, 200

        Loop, 4 {
            SendInput {Tab}
            Sleep, 50
        }

        SendInput {Up}
        Sleep, 100

        SendInput {Space}
        Sleep, 100

        SendInput {Tab}
        Sleep, 200

        SendInput %DataVencimentoFormatada%
        Sleep, 200

        SendInput !r
        Sleep, 100

        SendInput !r
        Sleep, 100

        SendInput !r
        Sleep, 100
    return


    Cancelar4:
        Gui, 2:Destroy
        RA := ""
        CodContrato := ""
        DataVencimento := ""
    return

    PlanosDiversos:
        
        Gui, 1:Destroy
        EnsinoSuperior := ""
        PosGraduacao:= ""

        Gui, 1:New, +AlwaysOnTop, Assistentes
        Gui, 1:Add, Text,, Escolha o nível de ensino:
        Gui, 1:Add, Button, w250 gEnsinoSuperior, ENSINO SUPERIOR EAD
        Gui, 1:Add, Button, w250 gPosGraduacao, PÓS GRADUAÇÃO EAD
        Gui, 1:Add, Button, w250 gCancelar9, Cancelar  ; <<< Botão Cancelar
        Gui, 1:Show,, Fala Analista!
        return

        Cancelar9:
            Gui, 1:Destroy
            EnsinoSuperior := ""
            PosGraduacao:= ""
        Return

        EnsinoSuperior:
        ; === Tabela de Serviços: texto legível -> chave curta -> código ===
        Servicos := {}
        Servicos["UNINASSAU - Com pontualidade"] := {Chave:"UNINASSAU_EAD", Codigo:1041}
        Servicos["UNINASSAU - Mensalidade Digital-EAD"]          := {Chave:"UNINASSAU_DIGITAL", Codigo:769}
        Servicos["UNAMA - Com pontualidade"]     := {Chave:"UNAMA_EAD", Codigo:708}
        Servicos["UNAMA - Mensalidade Digital-EAD"]           := {Chave:"UNAMA_DIGITAL", Codigo:523}
        Servicos["UNG - Com pontualidade"]       := {Chave:"UNG_EAD", Codigo:684}
        Servicos["UNG - Mensalidade Digital-EAD"]             := {Chave:"UNG_DIGITAL", Codigo:567}
        Servicos["FAEL - Com pontualidade"]      := {Chave:"FAEL_EAD", Codigo:212}
        Servicos["FAEL - Mensalidade Digital-EAD"]            := {Chave:"FAEL_DIGITAL", Codigo:1}
        Servicos["UNINORTE - Com pontualidade"]  := {Chave:"UNINORTE_EAD", Codigo:1142}
        Servicos["UNINORTE - Mensalidade Digital-EAD"]       := {Chave:"UNINORTE_DIGITAL", Codigo:620}

        ; === Monta a lista de serviços para a DropDownList ===
        ListaServicos := ""
        for ServicoNome, Info in Servicos
            ListaServicos .= ServicoNome "|"
        StringTrimRight, ListaServicos, ListaServicos, 1  ; remove o último "|"

        Gui, 1:Destroy
        Gui, 2:New, +AlwaysOnTop, Fala Analista!
        Gui, 2:Font, s9, Segoe UI

        ; --- Campos ---
        Gui, 2:Add, Text, x10  y15  w100, Período Letivo:
        Gui, 2:Add, Edit, vPeriodoLetivo x120 y10 w210
        Gui, 2:Add, Text, x10  y45  w100, RA:
        Gui, 2:Add, Edit, vRA x120 y40 w210
        Gui, 2:Add, Text, x10 y75 w100, CodContrato:
        Gui, 2:Add, Edit, vCodContrato x120 y70 w210
        Gui, 2:Add, Text, x10  y105  w100, Qtde Parcelas:
        Gui, 2:Add, Edit, vQtdeParcelas x120 y100 w210
        Gui, 2:Add, Text, x10  y135 w100, Parcela Inicial:
        Gui, 2:Add, Edit, vParcelaInicial x120 y130 w210
        Gui, 2:Add, Text, x10  y165 w100, Serviço:
        Gui, 2:Add, DropDownList, vServicoSelecionado x120 y160 w210, %ListaServicos%
        Gui, 2:Add, Text, x10  y195 w100, Valor:
        Gui, 2:Add, Edit, vValor1 x120 y190 w210
        Gui, 2:Add, Text, x10  y225 w100, Vencimento:
        Gui, 2:Add, DateTime, vDataVencimento x120 y220 w210, dd/MM/yyyy

        ; --- Botões ---
        Gui, 2:Add, Button, x40  y260 w120 default gConfirmar_PlanosDiversosESUP, OK
        Gui, 2:Add, Button, x190 y260 w120 gCancelar6, Cancelar

        ; --- Exibir janela ---
        Gui, 2:Show, w350 h300, Fala Analista!
        return

        Confirmar_PlanosDiversosESUP:
            Gui, 2:Submit, NoHide
            
            FormatTime, hoje, , yyyyMMdd
            FormatTime, dataSelecionada, %DataVencimento%, yyyyMMdd

            FormatTime, DataVencimentoFormatada, %DataVencimento%, dd/MM/yyyy
            FormatTime, Competencia, %DataVencimento%, MM/yyyy

            CodigoSelecionado := Servicos[ServicoSelecionado].Codigo
            Chave := Servicos[ServicoSelecionado].Chave

            Gui, 2:Destroy
            SetTitleMatchMode, 2

            ; === Etapa 2: Ativar a janela do TOTVS ===
            Loop
                {
                    ; Tenta ativar a janela
                    IfWinExist, ahk_exe mstsc.exe
                    {
                        WinActivate, ahk_exe mstsc.exe
                        ; Aguarda a janela ficar ativa
                        WinWaitActive, ahk_exe mstsc.exe, , 10
                        if ErrorLevel
                        {
                            ; Se não ficou ativa em 10 segundos, continua tentando
                            Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                            continue
                        }
                        else
                        {
                            ; Se a janela ficou ativa, sai do loop
                            break
                        }
                    }
                    else
                    {
                        ; Se a janela não existir, espera um pouco e tenta de novo
                        Sleep, 1000 ; Espera 1 segundo
                    }
                }

            ; === Etapa 3: Execução dos comandos com pausas ===
                SendInput {F10}
            Sleep, 200

            SendInput f
            Sleep, 100

            SendInput a
            Sleep, 100

            SendInput i
            Sleep, 100

            SendInput c
            Sleep, 100

            SendInput r
            Sleep, 100

        Loop
                {
                    ; Tenta ativar a janela
                    IfWinExist, Gerar Parcela(s) para Contrato(s)
                    {
                        WinActivate, Gerar Parcela(s) para Contrato(s)
                        ; Aguarda a janela ficar ativa
                        WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                        if ErrorLevel
                        {
                            ; Se não ficou ativa em 10 segundos, continua tentando
                            Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                            continue
                        }
                        else
                        {
                            ; Se a janela ficou ativa, sai do loop
                            break
                        }
                    }
                    else
                    {
                        ; Se a janela não existir, espera um pouco e tenta de novo
                        Sleep, 1000 ; Espera 1 segundo
                    }
                }

            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendInput {Enter}
            Sleep, 200

            Click, 140, 545
            Sleep, 100

            SendInput, !r
            Sleep, 500

            Loop, 8 {
                SendInput {Tab}
                Sleep, 50
            }

            SendInput %PeriodoLetivo%
            Sleep, 1000

            Loop, 8 {
                SendInput {Tab}
                Sleep, 50
            }

            SendInput {Space}
            Sleep, 200

            SendInput {Tab}
            Sleep, 200

            SendInput %RA%
            Sleep, 1000

            SendInput {Tab}
            Sleep, 100

            SendInput !a
            Sleep, 500
            
                    ; === Etapa 4: Loop de busca do contrato ===
 
            Click, 157, 155
            Sleep, 2000
            SendInput, {Tab}
            Sleep, 100

            ; === 1. Copiar linha inicial ===
            SendInput, ^c
            Sleep, 100  ; aguardar a cópia
            ClipWait, 2
            linha := Clipboard

            ; === 2. Tabular sem quebrar nomes ou cursos ===
            resultado := RegExReplace(linha, "\s+", "`t")

            ; === 3. Procurar CodContrato ===
            contador := 0

            While (true)  ; loop até achar 5 vezes consecutivas
            {
                ; === Copiar linha atual ===
                SendInput, ^c
                Sleep, 100
                ClipWait, 2
                linha := Clipboard
                resultado := RegExReplace(linha, "\s+", "`t")

                ; === Quebrar linha em colunas e procurar CodContrato exato ===
                colunas := StrSplit(resultado, "`t")
                encontrado := false
                for index, valor in colunas
                {
                    if (Trim(valor) = CodContrato)  ; comparação exata
                    {
                        encontrado := true
                        break
                    }
                }

                if (encontrado)  ; achou contrato exatamente
                {
                    contador++  ; soma no contador

                    if (contador = 5)  ; 5 consecutivas → ALT+R
                    {
                        SendInput, !r
                        Sleep, 100
                        break
                    }

                    ; Descer para próxima linha
                    SendInput, {Down}
                    Sleep, 100

                    continue
                }
                else
                {
                    ; Se não achou, zera contador
                    contador := 0

                    ; === Ação alternativa ===
                    SendInput, {Space}
                    Sleep, 100
                    Click, 576, 181
                    Sleep, 200
                    Click, 157, 155
                    Sleep, 1500
                    SendInput, {Tab}
                    Sleep, 100
                    Click, 212, 215
                    Sleep, 100

                    continue
                }
            }

            ; === Esperar janela aparecer ===
            Loop
            {
                IfWinExist, Gerar Parcela(s) para Contrato(s)
                {
                    WinActivate
                    WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                    if !ErrorLevel
                        break
                }
                Sleep, 1000
            }

            SendInput {Tab}
            Sleep, 500

            SendInput %CodigoSelecionado%
            Sleep, 2500

            SendInput {Tab}
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100
            
            SendInput {Space}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendInput {Right}
            Sleep, 100

            SendInput {Right}
            Sleep, 100

            SendInput {F2}
            Sleep, 500

            SendInput %Valor1%
            Sleep, 2500

            SendInput !r
            Sleep, 500

            SendInput {Tab}
            Sleep, 500

            Loop
                {
                    ; Tenta ativar a janela
                    IfWinExist, Gerar Parcela(s) para Contrato(s)
                    {
                        WinActivate, Gerar Parcela(s) para Contrato(s)
                        ; Aguarda a janela ficar ativa
                        WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                        if ErrorLevel
                        {
                            ; Se não ficou ativa em 10 segundos, continua tentando
                            Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                            continue
                        }
                        else
                        {
                            ; Se a janela ficou ativa, sai do loop
                            break
                        }
                    }
                    else
                    {
                        ; Se a janela não existir, espera um pouco e tenta de novo
                        Sleep, 1000 ; Espera 1 segundo
                    }
                }
            
            SendInput %QtdeParcelas%
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput, 01
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput {Space}
            Sleep, 100

            SendInput {Tab}
            Sleep, 200

            SendInput %ParcelaInicial%
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput, 01
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput, Parcela do plano
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput %Competencia%
            Sleep, 200

            Loop, 4 {
                SendInput {Tab}
                Sleep, 50
            }

            SendInput {Up}
            Sleep, 100

            SendInput {Space}
            Sleep, 100

            SendInput {Tab}
            Sleep, 200

            SendInput %DataVencimentoFormatada%
            Sleep, 200

            SendInput !r
            Sleep, 100

            SendInput !r
            Sleep, 100

            SendInput !r
            Sleep, 100
        return

        Cancelar6:
            Gui, 2: Destroy
            RA := ""
            PeriodoLetivo := ""
            QtdeParcelas := ""
            ParcelaInicial := ""
            CodServico := ""
            Valor := ""
            DataVencimento := ""
        return

        PosGraduacao:
        Gui, 1:Destroy

        Gui, 2:New, +AlwaysOnTop, Fala Analista!
        Gui, 2:Font, s9, Segoe UI

        ; --- Campos ---
        Gui, 2:Add, Text, x20  y15  w100, RA:
        Gui, 2:Add, Edit, vRA x120 y10 w210

        Gui, 2:Add, Text, x20 y45 w100, CodContrato:
        Gui, 2:Add, Edit, vCodContrato x120 y40 w210

        Gui, 2:Add, Text, x20  y75  w100, Qtde Parcelas:
        Gui, 2:Add, Edit, vQtdeParcelas x120 y70 w210

        Gui, 2:Add, Text, x20  y105  w100, Parcela Inicial:
        Gui, 2:Add, Edit, vParcelaInicial x120 y100 w210

        Gui, 2:Add, Text, x20  y135 w100, Valor:
        Gui, 2:Add, Edit, vValor1 x120 y130 w210

        Gui, 2:Add, Text, x20  y165 w100, Vencimento:
        Gui, 2:Add, DateTime, vDataVencimento x120 y160 w210, dd/MM/yyyy

        ; --- Botões ---
        Gui, 2:Add, Button, x40  y195 w120 default gConfirmar_PlanosDiversosPOS, OK
        Gui, 2:Add, Button, x190 y195 w120 gCancelar10, Cancelar

        ; --- Exibir janela ---
        Gui, 2:Show, w350 h230, Fala Analista!
        return

        Confirmar_PlanosDiversosPOS:
            Gui, 2:Submit, NoHide
            
            FormatTime, hoje, , yyyyMMdd
            FormatTime, dataSelecionada, %DataVencimento%, yyyyMMdd

            FormatTime, DataVencimentoFormatada, %DataVencimento%, dd/MM/yyyy
            FormatTime, Competencia, %DataVencimento%, MM/yyyy

            Gui, 2:Destroy
            SetTitleMatchMode, 2

            ; === Etapa 2: Ativar a janela do TOTVS ===
            Loop
                {
                    ; Tenta ativar a janela
                    IfWinExist, ahk_exe mstsc.exe
                    {
                        WinActivate, ahk_exe mstsc.exe
                        ; Aguarda a janela ficar ativa
                        WinWaitActive, ahk_exe mstsc.exe, , 10
                        if ErrorLevel
                        {
                            ; Se não ficou ativa em 10 segundos, continua tentando
                            Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                            continue
                        }
                        else
                        {
                            ; Se a janela ficou ativa, sai do loop
                            break
                        }
                    }
                    else
                    {
                        ; Se a janela não existir, espera um pouco e tenta de novo
                        Sleep, 1000 ; Espera 1 segundo
                    }
                }

            ; === Etapa 3: Execução dos comandos com pausas ===
            SendInput {F10}
            Sleep, 200

            SendInput f
            Sleep, 100

            SendInput a
            Sleep, 100

            SendInput i
            Sleep, 100

            SendInput c
            Sleep, 100

            SendInput r
            Sleep, 100

        Loop
                {
                    ; Tenta ativar a janela
                    IfWinExist, Gerar Parcela(s) para Contrato(s)
                    {
                        WinActivate, Gerar Parcela(s) para Contrato(s)
                        ; Aguarda a janela ficar ativa
                        WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                        if ErrorLevel
                        {
                            ; Se não ficou ativa em 10 segundos, continua tentando
                            Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                            continue
                        }
                        else
                        {
                            ; Se a janela ficou ativa, sai do loop
                            break
                        }
                    }
                    else
                    {
                        ; Se a janela não existir, espera um pouco e tenta de novo
                        Sleep, 1000 ; Espera 1 segundo
                    }
                }

            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendInput {Enter}
            Sleep, 200

            Click, 140, 545
            Sleep, 100

            SendInput, !r
            Sleep, 500

            Loop, 8 {
                SendInput {Tab}
                Sleep, 50
            }

            SendInput POS
            Sleep, 1000

            Loop, 8 {
                SendInput {Tab}
                Sleep, 50
            }

            SendInput {Space}
            Sleep, 200

            SendInput {Tab}
            Sleep, 200

            SendInput %RA%
            Sleep, 1000

            SendInput {Tab}
            Sleep, 100

            SendInput !a
            Sleep, 500

                    ; === Etapa 4: Loop de busca do contrato ===
 
            Click, 157, 155
            Sleep, 2000
            SendInput, {Tab}
            Sleep, 100

            ; === 1. Copiar linha inicial ===
            SendInput, ^c
            Sleep, 100  ; aguardar a cópia
            ClipWait, 2
            linha := Clipboard

            ; === 2. Tabular sem quebrar nomes ou cursos ===
            resultado := RegExReplace(linha, "\s+", "`t")

            ; === 3. Procurar CodContrato ===
            contador := 0

            While (true)  ; loop até achar 5 vezes consecutivas
            {
                ; === Copiar linha atual ===
                SendInput, ^c
                Sleep, 100
                ClipWait, 2
                linha := Clipboard
                resultado := RegExReplace(linha, "\s+", "`t")

                ; === Quebrar linha em colunas e procurar CodContrato exato ===
                colunas := StrSplit(resultado, "`t")
                encontrado := false
                for index, valor in colunas
                {
                    if (Trim(valor) = CodContrato)  ; comparação exata
                    {
                        encontrado := true
                        break
                    }
                }

                if (encontrado)  ; achou contrato exatamente
                {
                    contador++  ; soma no contador

                    if (contador = 5)  ; 5 consecutivas → ALT+R
                    {
                        SendInput, !r
                        Sleep, 100
                        break
                    }

                    ; Descer para próxima linha
                    SendInput, {Down}
                    Sleep, 100

                    continue
                }
                else
                {
                    ; Se não achou, zera contador
                    contador := 0

                    ; === Ação alternativa ===
                    SendInput, {Space}
                    Sleep, 100
                    Click, 576, 181
                    Sleep, 200
                    Click, 157, 155
                    Sleep, 1500
                    SendInput, {Tab}
                    Sleep, 100
                    Click, 212, 215
                    Sleep, 100

                    continue
                }
            }
            
            SendInput {Tab}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendRaw, % "%MENSALIDADE%(COM PONTUALIDADE"
            Sleep, 3000

            SendInput {Tab}
            Sleep, 200

            SendInput {Tab}
            Sleep, 100
            
            SendInput {Space}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendInput {Tab}
            Sleep, 100

            SendInput {Right}
            Sleep, 100

            SendInput {Right}
            Sleep, 100

            SendInput {F2}
            Sleep, 500

            SendInput %Valor1%
            Sleep, 2500

            SendInput !r
            Sleep, 500

            SendInput {Tab}
            Sleep, 500

            Loop
                {
                    ; Tenta ativar a janela
                    IfWinExist, Gerar Parcela(s) para Contrato(s)
                    {
                        WinActivate, Gerar Parcela(s) para Contrato(s)
                        ; Aguarda a janela ficar ativa
                        WinWaitActive, Gerar Parcela(s) para Contrato(s), , 10
                        if ErrorLevel
                        {
                            ; Se não ficou ativa em 10 segundos, continua tentando
                            Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                            continue
                        }
                        else
                        {
                            ; Se a janela ficou ativa, sai do loop
                            break
                        }
                    }
                    else
                    {
                        ; Se a janela não existir, espera um pouco e tenta de novo
                        Sleep, 1000 ; Espera 1 segundo
                    }
                }
            
            SendInput %QtdeParcelas%
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput, 01
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput {Space}
            Sleep, 100

            SendInput {Tab}
            Sleep, 200

            SendInput %ParcelaInicial%
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput, 01
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput, Parcela do plano
            Sleep, 200

            SendInput {Tab}
            Sleep, 100

            SendInput %Competencia%
            Sleep, 200

            Loop, 4 {
                SendInput {Tab}
                Sleep, 50
            }

            SendInput {Up}
            Sleep, 100

            SendInput {Space}
            Sleep, 100

            SendInput {Tab}
            Sleep, 200

            SendInput %DataVencimentoFormatada%
            Sleep, 200

            SendInput !r
            Sleep, 100

            SendInput !r
            Sleep, 100

            SendInput !r
            Sleep, 100
        return

        Cancelar10:
            Gui, 2:Destroy
            RA := ""
            QtdeParcelas := ""
            ParcelaInicial := ""
            Valor := ""
            DataVencimento := ""
        return

    edicao:
        Gui, 1:Destroy
        ; === Etapa 1: Ativar janela do Compêndio ===
        Loop {
            IfWinExist, Compêndio mágico do faturamento
            {
                WinActivate, Compêndio mágico do faturamento
                WinWaitActive, Compêndio mágico do faturamento, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }

        ; === Etapa 2: Coleta de dados do Excel ===
        try {
            xl := ComObjActive("Excel.Application")
        } catch {
            MsgBox, 16, Erro, O Excel não está aberto ou não foi possível conectar.
            return
        }
        
        sheet := xl.ActiveSheet
        Valor := xl.ActiveSheet.Range("B8").Value

        ; === Etapa 3: Ativar janela Contrato ===
        Loop {
            IfWinExist, Contrato
            {
                WinActivate, Contrato
                WinWaitActive, Contrato, , 15
                if ErrorLevel {
                    Sleep, 1000
                    continue
                } else {
                    break
                }
            } else {
                Sleep, 1000
            }
        }

        ; === Etapa 4: Criar GUI ===
        Gui, Destroy
        Repeticoes := ""
        ParcelaInicial := ""
        DataVencimento := ""

        Gui, Font, s9, Segoe UI  ; Fonte

        ; --- Quantidade de Parcelas ---
        Gui, Add, Text, x10 y15 w100, Qtde de Parcelas:
        Gui, Add, Edit, vRepeticoes x120 y10 w100

        ; --- Parcela Inicial ---
        Gui, Add, Text, x10 y45 w100, Parcela Inicial:
        Gui, Add, Edit, vParcelaInicial x120 y40 w100

        ; --- Data de Vencimento ---
        Gui, Add, Text, x10 y75 w100, Data Vencimento:
        Gui, Add, DateTime, vDataVencimento x120 y70 w100, dd/MM/yyyy

        ; --- Botões ---
        Gui, Add, Button, x30 y110 w80 default gConfirmar_F3, OK
        Gui, Add, Button, x140 y110 w80 gCancelar7, Cancelar

        ; --- Exibe a GUI ---
        Gui, Show, w250 h150, Fala Analista!
        Return
        

        ; --- Botão OK ---
        Confirmar_F3:
            Gui, Submit

            ; Validação de Repeticoes
            if (Repeticoes = "" || Repeticoes+0 != Repeticoes || Repeticoes <= 0 || Repeticoes >= 10  ||Mod(Repeticoes, 1) != 0) {
                MsgBox, 16, Erro, Informe um número de 1 até 10 para as repetições.
                Return
            }

            ; Validação de ParcelaInicial
            if (ParcelaInicial = "" || ParcelaInicial+0 != ParcelaInicial || ParcelaInicial <= 0 || Mod(ParcelaInicial, 1) != 0) {
                MsgBox, 16, Erro, Informe um número inteiro válido para a parcela inicial.
                Return
            }

            ; Validação da Data
            FormatTime, hoje, , yyyyMMdd
            FormatTime, dataSelecionada, %DataVencimento%, yyyyMMdd
            if (dataSelecionada < hoje) {
                MsgBox, 16, Erro, A data de vencimento não pode ser anterior a hoje.
                Return
            }

            FormatTime, DataVencimentoFormatada, %DataVencimento%, dd/MM/yyyy
            DataVencimento := DataVencimentoFormatada

            ; Fecha GUI
            Gui, Destroy

            ; === Etapa 5: Execução dos comandos ===
            Loop, %Repeticoes%
            {
                if (Abort) {
                    MsgBox, 48, Cancelado, Execução interrompida pelo usuário.
                    Abort := false
                    Break
                }
                Loop {
                    IfWinExist, Contrato
                    {
                        WinActivate, Contrato
                        WinWaitActive, Contrato, , 15
                        if ErrorLevel {
                            Sleep, 1000
                            continue
                        } else {
                            break
                        }
                    } else {
                        Sleep, 1000
                    }
                }
                Sleep, 500
                Click 26, 107
                Sleep, 1000

                ; --- Ativar janela Parcela ---
                Loop {
                    IfWinExist, Parcela
                    {
                        WinActivate, Parcela
                        WinWaitActive, Parcela, , 15
                        if ErrorLevel {
                            Sleep, 1000
                            continue
                        } else {
                            break
                        }
                    } else {
                        Sleep, 1000
                    }
                }

                ; === Preenchimento ===
                Loop, 5 {
                    SendInput, {Tab}
                    Sleep, 40
                }

                SendInput %ParcelaInicial%
                Sleep, 300

                SendInput, {Tab}
                Sleep, 100
                SendInput, 01
                Sleep, 100
                SendInput, {Tab}
                Sleep, 100
                SendInput, {Tab}
                Sleep, 100
                SendInput, MENSALIDADE REPO
                Sleep, 800
                SendInput, {Tab}
                Sleep, 100
                SendInput, {Tab}
                Sleep, 100
                SendInput, {Down}
                Sleep, 100
                SendInput, {Tab}
                Sleep, 100
                SendInput %DataVencimentoFormatada%
                Sleep, 200
                
                Loop, 4 {
                    Send {Tab}
                    Sleep, 40
                }

                SendInput, ^a
                Sleep, 200
                SendInput %Valor%
                Sleep, 200
                SendInput, !o
                Sleep, 1000

                ; --- Atualiza valores ---
                ParcelaInicial += 1  ; soma 1 na parcela

                ; Ajusta DataVencimento para o dia 15 do mês seguinte
                StringSplit, DataParts, DataVencimento, /
                Dia := 15
                Mes := DataParts2
                Ano := DataParts3

                Mes++
                if (Mes > 12) {
                    Mes := 1
                    Ano++
                }

                if (Mes < 10)
                    Mes := "0" Mes

                DataVencimento := Dia "/" Mes "/" Ano
                DataVencimentoFormatada := DataVencimento   
            }
        Return
        ; --- Botão Cancelar ---
        Cancelar7:
            Gui, Destroy
            Repeticoes := ""
            ParcelaInicial := ""
            DataVencimento := ""
        Return

    reposicao:
        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Compêndio mágico do faturamento
                {
                    WinActivate, Compêndio mágico do faturamento
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Compêndio mágico do faturamento, , 15
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 15 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        ; === Etapa 1: Coleta de dados do Excel ===
        try {
            xl := ComObjActive("Excel.Application")
        } catch {
            MsgBox, 16, Erro, O Excel não está aberto ou não foi possível conectar.
            return
        }
        
        sheet := xl.ActiveSheet
        valor := xl.ActiveSheet.Range("B104").Value

        ; === Etapa 2: Ativar a janela do TOTVS ===
        Loop
            {
                ; Tenta ativar a janela
                IfWinExist, Contrato
                {
                    WinActivate, Contrato
                    ; Aguarda a janela ficar ativa
                    WinWaitActive, Contrato, , 15
                    if ErrorLevel
                    {
                        ; Se não ficou ativa em 15 segundos, continua tentando
                        Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                        continue
                    }
                    else
                    {
                        ; Se a janela ficou ativa, sai do loop
                        break
                    }
                }
                else
                {
                    ; Se a janela não existir, espera um pouco e tenta de novo
                    Sleep, 1000 ; Espera 1 segundo
                }
            }

        ; === Etapa 3: Criar GUI para receber duas entradas ===
        
        ; Fecha a GUI anterior, se existir
        Gui, Destroy

        ; Zera manualmente as variáveis
        Repeticoes := ""
        ParcelaInicial := ""

        Gui, Font, s9, Segoe UI  ; Fonte
        Gui, Add, Text, x20 y15 w200, Qtde de Parcelas:
        Gui, Add, Edit, vRepeticoes x120 y10 w100
        Gui, Add, Text, x20 y45 w150, Parcela Inicial:
        Gui, Add, Edit, vParcelaInicial x120 y40 w100
        Gui, Add, Button, x30 y80 w80 default gConfirmar_F4, OK
        Gui, Add, Button, x130 y80 w80 gCancelar8, Cancelar
        Gui, Show, w240 h120, Fala Analista!
        Return

    Confirmar_F4:
        Gui, Submit
        ; Validação das repetições
        if (Repeticoes = "" || Repeticoes+0 != Repeticoes || Repeticoes <= 0 || Repeticoes >= 10 ||Mod(Repeticoes, 1) != 0) {
            MsgBox, 16, Erro, Informe um número de 1 a 10 para as repetições.
            Return
        }
        ; Validação da parcela inicial
        if (ParcelaInicial = "" || ParcelaInicial+0 != ParcelaInicial || ParcelaInicial <= 0 || Mod(ParcelaInicial, 1) != 0) {
            MsgBox, 16, Erro, Informe um número inteiro válido para a parcela inicial.
            Return
        }

        Gui, Destroy
    
        ; --- Calcula +2 dias úteis ---
        dias := 0
        dataCalc := A_Now
        while (dias < 2) {
            dataCalc += 1, Days
            FormatTime, diaSemana, %dataCalc%, WDay  ; 1 = Domingo, 7 = Sábado
            if (diaSemana != 1 && diaSemana != 7) {
                dias++
            }
        }
        FormatTime, DataVencimento, %dataCalc%, dd/MM/yyyy

        Loop, %Repeticoes%
        {
            if (Abort) {
                MsgBox, 48, Cancelado, Execução interrompida pelo usuário.
                Abort := false
                Break
            }

            Loop {
                IfWinExist, Contrato
                {
                    WinActivate, Contrato
                    WinWaitActive, Contrato, , 15
                    if ErrorLevel {
                        Sleep, 1000
                        continue
                    } else {
                        break
                    }
                } else {
                    Sleep, 1000
                }
            }
            Sleep, 1000 ; Espera antes de iniciar os comandos

            ; === Etapa 4: Execução dos comandos com pausas ===
            Click 26, 109
            Sleep 2000

            ; Loop até a janela ficar ativa
            Loop {
                IfWinExist, Parcela
                {
                    WinActivate, Parcela
                    WinWaitActive, Parcela, , 15
                    if ErrorLevel {
                        Sleep, 1000
                        continue
                    } else {
                        break
                    }
                } else {
                    Sleep, 1000
                }
            }

            Loop, 5 {
                SendInput, {Tab}
                Sleep, 50
            }

            SendInput %ParcelaInicial%
            Sleep, 200

            SendInput, {Tab}
            Sleep, 100

            SendInput, 01
            Sleep, 100

            SendInput, {Tab}
            Sleep, 100

            SendInput, {Tab}
            Sleep, 300
            
            SendInput, REPO
            Sleep, 1000

            SendInput, {Tab}
            Sleep, 100

            SendInput, {Tab}
            Sleep, 100

            SendInput, {Down}
            Sleep, 100

            SendInput, {Tab}
            Sleep, 200

            SendInput %DataVencimento%
            Sleep, 100

            Loop, 4 {
                SendInput, {Tab}
                Sleep, 100
            }

            SendInput, ^a
            Sleep, 200

            SendInput %Valor%
            Sleep, 100

            SendInput, !o
            Sleep, 2000
                        
            ; --- Atualiza valores para o próximo loop ---
            ParcelaInicial += 1  ; soma 1 na parcela

            ; === Soma 30 dias na DataVencimentoFormatada ===
            ; Divide a data atual (dd/MM/yyyy)
            StringSplit, Partes, DataVencimento, /

            Dia := Partes1
            Mes := Partes2
            Ano := Partes3

            ; Converte para AAAAMMDD
            DataVencimento := Ano . Mes . Dia

            ; Soma 30 dias
            DataCalc := DataVencimento
            DataCalc += 30, Days

            ; Converte de volta para dd/MM/yyyy
            FormatTime, DataVencimento, %DataCalc%, dd/MM/yyyy

        }
    return
    ; --- Botão Cancelar ---
    Cancelar8:
        Gui, Destroy
        Repeticoes := ""
        ParcelaInicial := ""
    Return
}

^1:: ; Ctrl + 1 - EDUCACIONAL
    SendInput, {F10}         ; Pressiona F10
    Sleep, 100         
    SendInput, a             ; Digita "A"
    Sleep, 100
    SendInput, p             ; Digita "P"
    Sleep, 100
    SendInput, e             ; Digita "E"
    Sleep, 100
    SendInput, e             ; Digita "E" novamente
return

^2:: ; Ctrl + 2 - FINANCEIRO
    SendInput, {F10}
    Sleep, 100
    SendInput, a
    Sleep, 100
    SendInput, p
    Sleep, 100
    SendInput, b
    Sleep, 100
    SendInput, g
    Sleep, 100
    SendInput, s
return

^3:: ; Ctrl + 3 - ESTOQUES
    SendInput, {F10}
    Sleep, 100
    SendInput, a
    Sleep, 100
    SendInput, p
    Sleep, 100
    SendInput, b
    Sleep, 100
    SendInput, g
    Sleep, 100
    SendInput, e
return

!c:: ; Alt + C - ALTERAR CONTEXTO
{
    SendInput, {F10}
    Sleep, 100
    SendInput, c
    Sleep, 100
    SendInput, n
    Sleep, 100
    SendInput, !y

}
return

!b:: ; BAIXAS DO LANÇAMENTO
{
    SendInput, ^{Enter}
    Sleep, 2000
        Loop
        {
            ; Tenta ativar a janela
            IfWinExist, Parcela
            {
                WinActivate, Parcela
                ; Aguarda a janela ficar ativa
                WinWaitActive, Parcela, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
                ; Se a janela não existir, espera um pouco e tenta de novo
                Sleep, 1000 ; Espera 1 segundo
            }
        }

    Click, 371, 79
    Sleep, 1000

    ; !! PONTO CRÍTICO !!
    Click, 358, 248, 2
    Sleep, 3000

    Loop
        {
            ; Tenta ativar a janela
            IfWinExist, Lançamento:
            {
                WinActivate, Lançamento:
                ; Aguarda a janela ficar ativa
                WinWaitActive, Lançamento:, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
                ; Se a janela não existir, espera um pouco e tenta de novo
                Sleep, 1000 ; Espera 1 segundo
            }
    }

    ; !! PONTO CRÍTICO !!
    Click, 295, 45
    Sleep, 300

    Loop, 9 {
        SendInput, {Down}
        Sleep, 50
    }

    SendInput, {Enter}
}
Return