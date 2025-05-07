#NoEnv
#Warn
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%
#Persistent  ; Keeps the script running

I_Icon = C:\Users\010129987\Desktop\ccc.ico
IfExist, %I_Icon%
    Menu, Tray, Icon, %I_Icon%

; Start AntiSleep and AntiIdle immediately when the script runs
SetTimer, AntiIdle, 2000
SetTimer, AntiSleep, 120000

Return

AntiSleep:
    DllCall("SetThreadExecutionState", UInt, 0x80000003)
Return

AntiIdle:
    MouseMove, 0, 1, 0, R
    Sleep 1000
    MouseMove, 0, -1, 0, R
Return
