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
Click 392, 334
Sleep 500
Send ^v
Sleep 500
Click 535, 331
Sleep 500
Click 418, 736
Sleep 1000
Click 526, 169
Sleep 3000
Click 623, 169
Sleep 2000
Send !{Tab}
Sleep 500
Send ^r
Sleep 500
Send {Down}
Sleep 500
Send {Right}
Sleep 500
}