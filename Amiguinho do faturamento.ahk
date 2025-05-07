#SingleInstance, force
#Persistent
SetFormat, Float, 0.0
SetBatchLines, -1
SetKeyDelay, 0

I_Icon = C:\Users\010129987\Desktop\panda.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%



Pause::Pause
F11::
xl := ComObjActive("excel.application")



while (tmp := Format("{:08}", xl.activecell.offset(a_index -1,0).value))	
	{
	send, %tmp%!a
	send, {up 2}^a
	sleep, 600 
	}
	send, !s
	FormatTime, time, A_now, dd.MM.yyyy HH:mm
	send, %time%
	send, !o

Return

F12::Reload
