; Array of URLs you want to open
urlA        :=  ["https://outlook.office.com/mail/"
                ,"http://teams.microsoft.com/"
                ,"http://folha.sereduc.com/FrameHTML/web/app/RH/PortalMeuRH/#/login"]

; Build list of urls on one line
urlList     := ""
for index, value in urlA
    urlList .= ((A_Index = 1) ? "" : " ") . value


Run, % "msedge.exe --new-window " urlList
Return