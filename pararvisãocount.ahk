CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

; Function to show a countdown timer during Sleep
SleepWithCountdown(sleepDuration) {
    Loop, % sleepDuration // 1000 {  ; Loop for the number of seconds in the sleep duration
        remainingTime := (sleepDuration // 1000) - A_Index
        ToolTip, Sleeping... %remainingTime% seconds remaining
        Sleep, 1000
    }
    ToolTip  ; Clear the tooltip
}

F8::
Loop {
    Loop {
        Click 380, 353
	Sleep 1000
	Click 380, 353
        SleepWithCountdown(10000)  ; Sleep with countdown for 30 seconds
        PixelSearch, Px, Py, 373, 350, 384, 362, 0x616161, 0, Fast
        If (ErrorLevel = 0)
            break
    }
    {
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 477, 325
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 689, 445
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 667, 546     --parar
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 916, 442
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 926, 498
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 1057, 711
        SleepWithCountdown(10000) ; Sleep with countdown for 50 seconds
        Click 1001, 553
        SleepWithCountdown(10000) ; Sleep with countdown for 80 seconds
    }
}
F9::Reload
