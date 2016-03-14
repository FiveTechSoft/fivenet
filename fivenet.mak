#FiveNet make, (c) FiveTech Software 2011

HBDIR=c:\harbour
BCDIR=c:\bcc582

#change these paths as needed
.path.OBJ = .\obj
.path.PRG = .\source\prg
.path.C   = .\source\c
.path.CS  = .\source\cs
.path.CH  = $(FWDIR)\include;$(HBDIR)\include
.path.rc  = .\
.path.LIB = .\lib
.path.DLL = .\samples

#important: Use Uppercase for filenames extensions, in the next two rules!

PROJECT    : fivenet.lib fivenet.dll ftsnet.dll

fivenet.lib : fivenet.obj

fivenet.dll : fivetech.cs
   c:\Windows\Microsoft.NET\Framework\v3.5\csc /out:samples\fivenet.dll /target:library source\cs\fivetech.cs
   c:\Windows\Microsoft.NET\Framework\v2.0.50727\regasm samples\fivenet.dll /tlb

ftsnet.dll : ftsnet.c
   $(BCDIR)\bin\bcc32 -c source\c\ftsnet.c
   $(BCDIR)\bin\ilink32 /Tpd $(BCDIR)\lib\c0d32.obj ftsnet.obj, samples\ftsnet.dll,,$(BCDIR)\lib\cw32.lib $(BCDIR)\import32.lib
   @del samples\ftsnet.i*
   @del samples\ftsnet.map
   @del samples\ftsnet.obj
   @del samples\ftsnet.tds
   @del samples\ftsnet.tlb

fivenet.obj : fivenet.prg
   $(HBDIR)\bin\harbour .\source\prg\fivenet.prg /N /W /Oobj\ /I$(FWDIR)\include;$(HBDIR)\include
   $(BCDIR)\bin\bcc32 -c -tWM -I$(HBDIR)\include -oobj\$& obj\$&.c
   $(BCDIR)\bin\tlib lib\fivenet.lib -+ obj\fivenet.obj

.PRG.OBJ:
   $(HBDIR)\bin\harbour $< /N /W /Oobj\ /I$(FWDIR)\include;$(HBDIR)\include
   $(BCDIR)\bin\bcc32 -c -tWM -I$(HBDIR)\include -oobj\$& obj\$&.c
   $(BCDIR)\bin\tlib lib\fivenet.lib -+ obj\fivenet.obj

.C.OBJ:
   echo -c -tWM -D__HARBOUR__ -DHB_API_MACROS > tmp
   echo -I$(HBDIR)\include;$(FWDIR)\include >> tmp
   $(BCDIR)\bin\bcc32 -oobj\$& @tmp $&.c
   del tmp
