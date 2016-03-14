set path=c:\bcc582\bin
c:\harbour\bin\hbmk2 -gtgui -i..\include -l..\lib\fivenet.lib -lhbwin.lib %1
if errorlevel==0 %1.exe