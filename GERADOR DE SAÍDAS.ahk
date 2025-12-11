#SingleInstance Force
SetBatchLines, -1
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetDefaultMouseSpeed, 0

; ================================================
; =============== VARIÁVEIS GLOBAIS ===============
; ================================================
global Combinacoes := []
global StopNow := false
global SelectedCodes := []

; Lista de códigos
Codigos := []
Codigos.Push(Object("codigo","298", "desc","FATURAMENTO DE MATRÍCULA - GRADUAÇÃO"))
Codigos.Push(Object("codigo","298", "desc","FATURAMENTO DE MATRÍCULA - GRADUAÇÃO P7"))
Codigos.Push(Object("codigo","267", "desc","FATURAMENTO DE MENSALIDADES - GRADUAÇÃO"))
Codigos.Push(Object("codigo","108", "desc","FATURAMENTO DE OUTRAS RECEITAS - GRADUAÇÃO"))

Codigos.Push(Object("codigo","301", "desc","FATURAMENTO DE MATRÍCULA - EAD GRADUAÇÃO"))
Codigos.Push(Object("codigo","301", "desc","FATURAMENTO DE MATRÍCULA - EAD GRADUAÇÃO P7"))
Codigos.Push(Object("codigo","289", "desc","FATURAMENTO DE MENSALIDADES - EAD GRADUAÇÃO"))
Codigos.Push(Object("codigo","122", "desc","FATURAMENTO DE OUTRAS RECEITAS - EAD GRADUAÇÃO"))

Codigos.Push(Object("codigo","306", "desc","FATURAMENTO DE MATRÍCULA - SEMIPRESENCIAL"))
Codigos.Push(Object("codigo","306", "desc","FATURAMENTO DE MATRÍCULA - SEMIPRESENCIAL P7"))
Codigos.Push(Object("codigo","295", "desc","FATURAMENTO DE MENSALIDADES - SEMIPRESENCIAL"))
Codigos.Push(Object("codigo","170", "desc","FATURAMENTO DE OUTRAS RECEITAS - SEMIPRESENCIAL"))

Codigos.Push(Object("codigo","302", "desc","FATURAMENTO DE MATRÍCULA - EAD PÓS-GRADUAÇÃO"))
Codigos.Push(Object("codigo","290", "desc","FATURAMENTO DE MENSALIDADES - EAD PÓS-GRADUAÇÃO"))
Codigos.Push(Object("codigo","118", "desc","FATURAMENTO DE OUTRAS RECEITAS - EAD PÓS-GRADUAÇÃO"))

Codigos.Push(Object("codigo","391", "desc","FATURAMENTO DE MATRÍCULA - PÓS-GRADUAÇÃO REMOTA"))
Codigos.Push(Object("codigo","394", "desc","FATURAMENTO DE MENSALIDADES - PÓS-GRADUAÇÃO REMOTA"))
Codigos.Push(Object("codigo","392", "desc","FATURAMENTO DE OUTRAS RECEITAS - PÓS-GRADUAÇÃO REMOTA"))

Codigos.Push(Object("codigo","307", "desc","FATURAMENTO DE MATRÍCULA - TÉCNICO"))
Codigos.Push(Object("codigo","296", "desc","FATURAMENTO DE MENSALIDADES - TÉCNICO"))
Codigos.Push(Object("codigo","121", "desc","FATURAMENTO DE OUTRAS RECEITAS - TÉCNICO"))

Codigos.Push(Object("codigo","308", "desc","FATURAMENTO DE MATRÍCULA - TÉCNICO EAD"))
Codigos.Push(Object("codigo","297", "desc","FATURAMENTO DE MENSALIDADES - TÉCNICO EAD"))
Codigos.Push(Object("codigo","174", "desc","FATURAMENTO DE OUTRAS RECEITAS - TÉCNICO EAD"))

Codigos.Push(Object("codigo","305", "desc","FATURAMENTO DE MATRÍCULA - PÓS-GRADUAÇÃO"))
Codigos.Push(Object("codigo","293", "desc","FATURAMENTO DE MENSALIDADES - PÓS-GRADUAÇÃO"))
Codigos.Push(Object("codigo","135", "desc","FATURAMENTO DE OUTRAS RECEITAS - PÓS-GRADUAÇÃO"))
Codigos.Push(Object("codigo","334", "desc","FATURAMENTO DE OUTRAS RECEITAS - PÓS-CONVÊNIO"))

Codigos.Push(Object("codigo","304", "desc","FATURAMENTO DE MATRÍCULA - MESTRADO"))
Codigos.Push(Object("codigo","292", "desc","FATURAMENTO DE MENSALIDADES - MESTRADO"))
Codigos.Push(Object("codigo","125", "desc","FATURAMENTO DE OUTRAS RECEITAS - MESTRADO"))

Codigos.Push(Object("codigo","300", "desc","FATURAMENTO DE MATRÍCULA - DOUTORADO"))
Codigos.Push(Object("codigo","288", "desc","FATURAMENTO DE MENSALIDADES - DOUTORADO"))
Codigos.Push(Object("codigo","128", "desc","FATURAMENTO DE OUTRAS RECEITAS - DOUTORADO"))

Codigos.Push(Object("codigo","291", "desc","FATURAMENTO DE MENSALIDADES - FORMAÇÃO PROFISSIONAL"))
Codigos.Push(Object("codigo","139", "desc","FATURAMENTO DE OUTRAS RECEITAS - FORMAÇÃO PROFISSIONAL"))

Codigos.Push(Object("codigo","310", "desc","FATURAMENTO DE MATRÍCULA - PÓS-GRADUAÇÃO SEMIPRESENCIAL"))
Codigos.Push(Object("codigo","311", "desc","FATURAMENTO DE MENSALIDADES - PÓS-GRADUAÇÃO SEMIPRESENCIAL"))

Codigos.Push(Object("codigo","388", "desc","FATURAMENTO DE MATRÍCULA - SEMIPRESENCIAL FLEX"))
Codigos.Push(Object("codigo","388", "desc","FATURAMENTO DE MATRÍCULA - SEMIPRESENCIAL FLEX P7"))
Codigos.Push(Object("codigo","389", "desc","FATURAMENTO DE MENSALIDADES - SEMIPRESENCIAL FLEX"))
Codigos.Push(Object("codigo","390", "desc","FATURAMENTO DE OUTRAS RECEITAS - SEMIPRESENCIAL FLEX"))

; ================================================
; =============== GUI PRINCIPAL ==================
; ================================================
Gui, Exportar:New, ;+AlwaysOnTop
Gui, Exportar:Font, s10, Expressway

; -------------------------------------------
; GROUPBOX – CAMPOS PRINCIPAIS (ESQUERDA)
; -------------------------------------------
Gui, Exportar:Add, GroupBox, x10 y10 w270 h150, Geral

Gui, Exportar:Add, Text, x25 y40, Data Inicial:
Gui, Exportar:Add, Edit, x120 y38 w120 vDataIni

Gui, Exportar:Add, Text, x25 y75, Data Final:
Gui, Exportar:Add, Edit, x120 y73 w120 vDataFim

Gui, Exportar:Add, Text, x25 y110, Horário:
Gui, Exportar:Add, Edit, x120 y108 w120 vHora


; -------------------------------------------
; GROUPBOX – NOVA COMBINAÇÃO (DIREITA)
; -------------------------------------------
Gui, Exportar:Add, GroupBox, x290 y10 w420 h150, Definições

Gui, Exportar:Add, Text, x305 y40, Primeira pasta:
Gui, Exportar:Add, Edit, x405 y38 w120 vTempPasta1

Gui, Exportar:Add, Text, x305 y75, Segunda pasta:
Gui, Exportar:Add, Edit, x405 y73 w120 vTempPasta2

Gui, Exportar:Add, Text, x305 y110, Coligada:
Gui, Exportar:Add, Edit, x365 y108 w60 vTempColigada

Gui, Exportar:Add, Text, x431 y110, Filial:
Gui, Exportar:Add, Edit, x465 y108 w60 vTempFilial

Gui, Exportar:Add, Button, x550 y37 w150 h50 gOpenCodesGui, Selecionar Relatórios
Gui, Exportar:Add, Button, x550 y95 w150 h50 gAddCombo, + Adicionar

; -------------------------------------------
; LISTA DE COMBINAÇÕES
; -------------------------------------------
Gui, Exportar:Add, Text, x10 y170, Agendamentos:

Gui, Exportar:Add, ListView, x10 y190 w700 h250 vLVCombos Grid, Primeira pasta|Segunda pasta|Coligada|Filial|Código

Gui, Exportar:Add, Button, x10 y445 w700 h30 gClearCombos, Limpar lista

Gui, Exportar:Show, w730 h480, Gerador de Saídas

; Ajuste das colunas.
LV_ModifyCol(1, 120)
LV_ModifyCol(2, 120)
LV_ModifyCol(3, 80)
LV_ModifyCol(4, 80)

return

; ================================================
; =============== ATUALIZAR LISTVIEW ==============
; ================================================
UpdateComboList() {
    global Combinacoes, Codigos
    LV_Delete()

    for i, obj in Combinacoes
    {
        descricao := obj.CodRel " - " obj.CodDesc
        LV_Add("", obj.Pasta1, obj.Pasta2, obj.Coligada, obj.Filial, descricao)
    }
}

; ================================================
; =============== LIMPAR LISTA ====================
; ================================================
ClearCombos:
    Combinacoes := []
    UpdateComboList()
return

; ================================================
; ===== GUI DE SELEÇÃO DE CÓDIGOS =================
; ================================================
OpenCodesGui:
    Gosub, BuildAndShowCodesGui
return

BuildAndShowCodesGui:
    Gui, Codigos:Destroy
    Gui, Codigos:New, +AlwaysOnTop -SysMenu
    Gui, Codigos:Font, s10, Expressway

    Gui, Codigos:Add, Button, x10 y10 w120 gSelectAllCodes, Marcar tudo
    Gui, Codigos:Add, Button, x140 y10 w120 gClearAllCodes, Desmarcar tudo

    Gui, Codigos:Add, ListView, x10 y45 w600 h760 vCodesLV Checked Grid, Código|Descrição

    for index, item in Codigos {
        idx := LV_Add("", item.codigo, item.desc)
        if (IsCodeSelected(item.codigo))
            LV_Modify(idx, "Check")
    }

    Gui, Codigos:Add, Button, x110 y815 w120 gConfirmCodes, Confirmar
    Gui, Codigos:Add, Button, x250 y815 w120 gCancelCodes, Cancelar

    Gui, Codigos:Show, w630 h855, Selecionar Relatórios
return

IsCodeSelected(code) {
    global SelectedCodes
    for i, v in SelectedCodes
        if (v.codigo = code)
            return true
    return false
}

; ================================================
; =========== MARCAR / DESMARCAR TUDO ============
; ================================================
SelectAllCodes:
    count := LV_GetCount()
    Loop, %count%
        LV_Modify(A_Index, "Check")

    SelectedCodes := []
    for index, item in Codigos
        SelectedCodes.Push(Object("codigo", item.codigo, "desc", item.desc))
return

ClearAllCodes:
    count := LV_GetCount()
    Loop, %count%
        LV_Modify(A_Index, "-Check")

    SelectedCodes := []
return

; ================================================
; ======= CONFIRMAR / CANCELAR CÓDIGOS ===========
; ================================================
ConfirmCodes:
    global SelectedCodes
    SelectedCodes := []

    idx := LV_GetNext(0, "Checked")
    while (idx) {
        LV_GetText(code, idx, 1)
        LV_GetText(desc, idx, 2)
        comboObj := Object("codigo", Trim(code), "desc", desc)
        SelectedCodes.Push(comboObj)
        idx := LV_GetNext(idx, "Checked")
    }

    Gui, Codigos:Destroy
return

CancelCodes:
    Gui, Codigos:Destroy
return

; ================================================
; =============== ADICIONAR COMBO =================
; ================================================
AddCombo:
    Gui, Exportar:Submit, NoHide

    if (TempPasta1="" || TempPasta2="" || TempColigada="" || TempFilial="") {
        MsgBox, 48, Erro, Preencha todos os campos antes de adicionar.
        return
    }

    if (SelectedCodes.Length() = 0) {
        MsgBox, 48, Erro, Nenhum código selecionado!
        return
    }

    for i, codeObj in SelectedCodes {
        combo := {}
        combo.Pasta1 := TempPasta1
        combo.Pasta2 := TempPasta2
        combo.Coligada := TempColigada
        combo.Filial := TempFilial
        combo.CodRel := codeObj.codigo
        combo.CodDesc := codeObj.desc ; salva a descrição completa

        Combinacoes.Push(combo)
    }

    UpdateComboList()
return

; ==================================================
; =============== EXECUTAR (F8) =====================
; ==================================================
F8::
    global StopNow
    StopNow := false
    Gui, Exportar:Submit, NoHide

    if (StrLen(Hora) < 2)
    Hora := "0" . Hora

    if (Combinacoes.Length() = 0) {
        MsgBox, 48, Erro, Adicione ao menos uma combinação!
        return
    }

    for index, combo in Combinacoes
    {
        if (StopNow)
            break

        Sleep, 100
        SendInput, ^p
        Sleep, 100
        SendInput, {Down}
        Sleep, 100
        SendInput, {Enter}
        Sleep, 100

        WinWaitActive, Geração de Saídas,, 5

        Loop {
            SendInput, {Tab}
            Sleep, 100
            SendInput, % combo.CodRel
            Sleep, 100
            SendInput, {Tab}
            Sleep, 2000
            PixelSearch, Px, Py, 2130, 442, 2428, 465, 0xE57800, 0, Fast
            If (ErrorLevel = 0)
                break
            if (StopNow)
                break
        }

        SendInput, {Tab 3}
        Sleep, 100
        SendInput, {Enter}
        Sleep, 100

        WinWaitActive, Browse For Folder,, 5
        Sleep, 100
        SendInput, {Tab 2}
        Sleep, 100

        ImagePath := A_ScriptDir . "\This PC.png"

        Process, Priority,, High
        SysGet, MonitorCount, MonitorCount

        Left := 99999, Top := 99999, Right := -99999, Bottom := -99999

        Loop, %MonitorCount% {
            SysGet, Mon, Monitor, %A_Index%
            if (MonLeft < Left)
                Left := MonLeft
            if (MonTop < Top)
                Top := MonTop
            if (MonRight > Right)
                Right := MonRight
            if (MonBottom > Bottom)
                Bottom := MonBottom
        }

        Loop {
            if (StopNow)
                break
            ImageSearch, x, y, Left, Top, Right, Bottom, *30 %ImagePath%
            if (!ErrorLevel) {
                MouseClick, left, x+38, y+11
                break
            }
            Sleep, 10
        }

        if (StopNow)
            break

        ImagePath2 := A_ScriptDir . "\Troca de Arquivos.png"

        Loop {
            if (StopNow)
                break
            ImageSearch, x, y, Left, Top, Right, Bottom, *30 %ImagePath2%
            if (!ErrorLevel) {
                MouseClick, left, x+38, y+11
                break
            }
            Sleep, 10
        }

        if (StopNow)
            break

        SendInput, {Right}
        Sleep, 100
        SendRaw, % combo.Pasta1
        Sleep, 100
        SendInput, {Right}
        Sleep, 100
        SendRaw, % combo.Pasta2
        Sleep, 100
        SendInput, {Enter}
        Sleep, 100

        WinWaitActive, Geração de Saídas,, 5
        SendInput, !r
        Sleep, 100

        SendInput, {Tab}
        Sleep, 100
        SendInput, ^a
        Sleep, 100
        SendInput, % combo.Coligada
        Sleep, 100

        SendInput, {Tab}
        Sleep, 100
        SendInput, ^a
        Sleep, 100
        SendInput, % combo.Filial
        Sleep, 100

        SendInput, {Tab}
        Sleep, 100
        SendInput, ^a
        Sleep, 100
        SendInput, %DataIni%
        Sleep, 100

        SendInput, {Tab}
        Sleep, 100
        SendInput, ^a
        Sleep, 100
        SendInput, %DataFim%
        Sleep, 100

        ; ============================================
        ; Determinar Parcela automaticamente
        ; ============================================
        if (InStr(combo.CodDesc, "P7"))
            Parcela := "7"
        else
            Parcela := "1"

        ; Enviar Parcela
        SendInput, {Tab}
        Sleep, 100
        SendInput, ^a
        Sleep, 100
        SendInput, %Parcela%
        Sleep, 100

        SendInput, !r
        Sleep, 100
        SendInput, {Down 2}
        Sleep, 100
        SendInput, {Tab 2}
        Sleep, 100
        Loop, % StrLen(Hora)
        {
        SendInput, % SubStr(Hora, A_Index, 1)
        Sleep, 100
        }

        Sleep, 100
        SendInput, !r
        Sleep, 100
        SendInput, !r
        Sleep, 100

    }
return

; ================================================
; =============== CTRL+R (PARAR) ==================
; ================================================
^r::
    StopNow := true
return

F9::Reload
Return

; ================================================
; =============== FECHAR GUI ======================
; ================================================
ExportarGuiClose:
ExportarGuiEscape:
    Gui, Exportar:Destroy
    ExitApp
return
