!x:: ;Black Screens on/off
IF hwnd
	Reload
hwnd := WinExist("A") ;active window
SysGet, Mo, 80 ;number of monitors
Loop,% Mo
{
	SysGet, Mo, MonitorWorkArea, %A_Index%
	Width := MoRight - MoLeft
	Height := MoBottom - MoTop
	Gui, New, +AlwaysOnTop -Caption
	Gui, Color, Black
	Gui, Show, W%Width% H%Height% X%MoLeft% Y%MoTop%
}
WinActivate, ahk_id %hwnd% ;reactivate previously active window
Return