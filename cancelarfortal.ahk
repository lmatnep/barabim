#SingleInstance, Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

F9::Reload
F8::


Loop {
Send ^c
Sleep 600
Send !{Tab}
Sleep 600
Click 113, 425
Sleep 600
SendRaw %clipboard%
Sleep 1000
Click 93, 458
Sleep 1000
Click 115, 444
Sleep 1000
Click 117, 490
Sleep 1000
Click 160, 505
Sleep 1000
SendInput, SERVIÇO NÃO PRESTADO.
Sleep 1000
Click 96, 787
Sleep 600
Send !{Tab}
Sleep 600
Send ^r
Sleep 600
Send {Down}
Sleep 600
}