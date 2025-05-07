#SingleInstance, Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

F9::Reload
F8::


Loop {
Send ^c
Sleep 500
Send !{Tab}
Sleep 500
Click 162, 216
Click 162, 216
Sleep 500
Send ^v
Sleep 2000
Click 103, 241
Sleep 2000
Click 97, 298
Sleep 2000
Click 125, 388
Sleep 2000
Click 243, 493
Sleep 3000
SendInput, SERVIÇO NÃO PRESTADO.
Sleep 500
Click 416, 564
Sleep 500
Send !{Tab}
Sleep 500
Send ^r
Sleep 500
Send {Down}
Sleep 500
}