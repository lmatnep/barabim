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
        Click 409, 354
        SleepWithCountdown(5000)  ; Sleep with countdown for 30 seconds
        PixelSearch, Px, Py, 402, 349, 416, 365, 0x616161, 0, Fast
        If (ErrorLevel = 0)
            break
    }
    {
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 477, 328
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 678, 446
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 663, 495     --enviar
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 886, 445
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 887, 497
        SleepWithCountdown(1000)  ; Sleep with countdown for 1 second
        Click 1055, 711
        SleepWithCountdown(5000) ; Sleep with countdown for 50 seconds
        Click 985, 554
        SleepWithCountdown(30000) ; Sleep with countdown for 80 seconds
    }
}
F9::Reload
