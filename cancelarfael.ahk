#SingleInstance, Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

F9::Reload
F8::


Loop {
Send ^c
Sleep 1000
Send !{Tab}
Sleep 1000
Click 669, 424, 2
Sleep 1000
Send ^v
Sleep 1000
Click 747, 422
Sleep 2000
Click 80, 596
Sleep 2000
Click 273, 511
Sleep 2000
Click 228, 532
Sleep 3000
Click 405, 603
SendInput, SERVICO N PRESTADO
Sleep 2000
Click 189, 665
Sleep 1000
Send !{Tab}
Sleep 1000
Send ^r
Sleep 1000
Send {Down}
Sleep 1000
}