#SingleInstance Force
SetBatchLines, -1
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetDefaultMouseSpeed, 0
;SetTitleMatchMode, 2


Gui, 1:New
Gui, 1:Font, s10, Expressway

Gui, 1:Add, GroupBox, x10 y10 w270 h320, Geral

Gui, 1:Add, Text, x25 y40, Período Letivo:
Gui, 1:Add, Edit, x128 y38 w120 vPeríodo

Gui, 1:Add, Text, x25 y75, R.A:
Gui, 1:Add, Edit, x128 y73 w120 vRA

Gui, 1:Add, Text, x25 y110, Código Contrato:
Gui, 1:Add, Edit, x128 y108 w120 vCódContrato

Gui, 1:Add, Text, x25 y145, Código Serviço:
Gui, 1:Add, Edit, x128 y143 w120 vCódServiço

Gui, 1:Add, Text, x25 y180, Valor Parcelas:
Gui, 1:Add, Edit, x128 y178 w120 vValorParcelas

Gui, 1:Add, Text, x25 y215, Quant. Parcelas:
Gui, 1:Add, Edit, x128 y213 w120 vQuantidadeParcelas

Gui, 1:Add, Text, x25 y250, Parcela Inicial:
Gui, 1:Add, Edit, x128 y248 w120 vParcelaInicial

Gui, 1:Add, Text, x25 y285, Vencto. Inicial:
Gui, 1:Add, Edit, x128 y283 w120 vVencimentoInicial


Gui, 1:Add, GroupBox, x300 y10 w140 h140, Ações


Gui, 1:Add, Button, x310 y38 w120 gExecutar, Executar

Gui, 1:Add, Button, x310 y73 w120 gLimparCampos, Limpar

Gui, 1:Add, Button, x310 y108 w120 gReload, Reload

Gui, 1:Show, w450 h340, Criar Parcelas

LimparCampos:
    GuiControl, 1:, RA,
    GuiControl, 1:, CódContrato,
    GuiControl, 1:, CódServiço,
    GuiControl, 1:, ValorParcelas,
    GuiControl, 1:, QuantidadeParcelas,
    GuiControl, 1:Focus, Período
Return



Executar:
Gui, 1:Submit, NoHide
WinActivate, ahk_class RAIL_WINDOW
Sleep, 100
SendInput, {F10}
Sleep, 100
SendInput, f
Sleep, 100
SendInput, ai
Sleep, 100
SendInput, cr
Sleep, 100
WinWaitActive, Gerar,, 5
SendInput, !r
Sleep, 100
SendInput, {Tab 8}
Sleep, 100
SendInput, %Período%
Sleep, 1000
SendInput, {Tab 8}
Sleep, 100
SendInput, {Space}
Sleep, 100
SendInput, {Tab}
Sleep, 100
SendInput, %RA%
Sleep, 1000
SendInput, !a
Sleep, 100
SendInput, {Tab 15}
Sleep, 100
SendInput, {Right}
Sleep, 500
SendInput, {Tab}
Sleep, 500


ChecarContrato:
Send, ^c
ClipWait
RegExMatch(Clipboard, "\b\d{7}\b", m)
Clipboard := m
Sleep, 1000

m := Trim(m)
CodContrato := Trim(CódContrato)

If (m = CódContrato)
{
    Gosub, Segue
}
Else
{
    GoSub, RemoverContrato
}
Return

RemoverContrato:
Sleep, 300
SendInput, {Space}
Sleep, 300
SendInput, {Tab}
Sleep, 300
SendInput, {Enter}
Sleep, 300
SendInput, {Tab 9}
Sleep, 300
GoSub, ChecarContrato

Return

Segue:
SendInput, !r
Sleep, 100
SendInput, {Tab}
Sleep, 100
SendInput, %CódServiço%
Sleep, 1000
SendInput, {Tab 3}
Sleep, 100
SendInput, {Enter}
Sleep, 100
SendInput, {Tab 2}
Sleep, 100
SendInput, {Right 2}
Sleep, 100
SendInput, %ValorParcelas%
Sleep, 300
SendInput, !r
Sleep, 100
SendInput, {Tab}
Sleep, 100
SendInput, %QuantidadeParcelas%
Sleep, 100
SendInput, {Tab}
Sleep, 100
SendInput, 1
Sleep, 100
SendInput, {Tab}
Sleep, 100
SendInput, {Space}
Sleep, 100
SendInput, {Tab}
Sleep, 100
SendInput, %ParcelaInicial%
Sleep, 100
SendInput, {Tab}
Sleep, 100
SendInput, 1
Sleep, 100
SendInput, {Tab 2}
Sleep, 100

Competência := SubStr(VencimentoInicial, 3, 8)
SendInput, %Competência%
Sleep, 100
SendInput, {Tab 4}
Sleep, 100
SendInput, {Up}
Sleep, 100
SendInput, {Space}
Sleep, 100
SendInput, {Tab}
Sleep, 100
SendInput, %VencimentoInicial%
Sleep, 100
SendInput, !r
Sleep, 100
SendInput, !r
Sleep, 100
SendInput, !r







Return



^F1::
Gui, 1:Show, w450 h340, Criar Parcelas
Return



Reload:
Reload
Return