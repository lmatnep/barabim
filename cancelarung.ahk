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
Click 569, 450
Sleep 500
Send ^v
Sleep 500
Click 514, 481
Sleep 500
SendInput, SERVIÇO NÃO PRESTADO.
Sleep 1000
Click 539, 573
Sleep 1000
Click 402, 529
Sleep 1000
Click 449, 538
Sleep 1000
Click 128, 415
Sleep 1000
Send !{Tab}
Sleep 500
Send ^r
Sleep 500
Send {Down}
Sleep 500
Send {Right}
Sleep 500
}