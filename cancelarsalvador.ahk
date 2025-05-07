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
Click 487, 359
Sleep 1000
Send ^v
Sleep 1000
Click 495, 440
Sleep 1000
Click 505, 683
Sleep 3000
Send ^{End}
Sleep 3000
Click 233, 379
Click 233, 379
Sleep 2000
SendInput, 0,01
Sleep 1000
Click 546, 845
Sleep 2000
Click 510, 559
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