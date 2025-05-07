#SingleInstance, Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

F9::Reload
F8::


Loop {
MouseClickDrag, Left, 1106, 121, 508, 328
Sleep 500
Click 333, 379
Sleep 2000
Click 412, 451
Click 412, 451
Sleep 2000
Send ^c
Sleep 1000
Send !{Tab}
Sleep 1000
Send {F2}
Sleep 1000
Send ^v
Sleep 500
Send {Enter}
Sleep 2000
Send {F5}
Sleep 1000
Send {Home}
Sleep 2000
}