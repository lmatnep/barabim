#SingleInstance, Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

F9::Reload
F8::

Começo:
Loop {
Send ^c
Sleep 1000
Click 888, 358, 2
Sleep 1000
Send ^v
Sleep 1000
Click 1048, 378
Sleep 1000
Send !{Tab}
Sleep 1000
Send {Right}
Send ^c
Sleep 1000
Send !{Tab}
Sleep 1000
PixelSearch, Px, Py, 956, 316, 992, 328, 0xE5FAFF, 0, Fast
If (ErrorLevel = 0) {
Goto, Mensagem
}
Click 786, 334, 3
Send ^v
Sleep 1000
Click 1059, 450
Click 1059, 450
SendInput, 2,00
Sleep 1000
Send !{Tab}
Sleep 1000
Send {Right}
Send ^c
Sleep 1000
Send !{Tab}
Sleep 1000
Click 676, 560
Send ^v
Sleep 1000
Click 757, 486
SendInput, MENSALIDADE
Sleep 2000
Click 1048, 632
Sleep 2000
Click 915, 162
Sleep 2000
Click 1049, 548
Sleep 2000
Click 906, 159
Sleep 2000
Click 881, 126
Sleep 2000
Send !{Tab}
Sleep 1000
Send ^r
Sleep 1000
Send {Down}
Sleep 1000
}

Mensagem:
Click 807, 358, 3
Send ^v
Sleep 1000
Click 1055, 470, 2
SendInput, 2,00
Sleep 1000
Send !{Tab}
Sleep 1000
Send {Right}
Send ^c
Sleep 1000
Send !{Tab}
Sleep 1000
Click 664, 584
Send ^v
Sleep 1000
Click 789, 519, 2
SendInput, MENSALIDADE
Sleep 2000
Click 1054, 652
Sleep 2000
Click 906, 162
Sleep 2000
Click 1048, 548
Sleep 2000
Click 912, 160
Sleep 2000
Click 883, 129
Sleep 2000
Send !{Tab}
Sleep 1000
Send ^r
Sleep 1000
Send {Down}
Sleep 1000
Goto, Começo
