-- Simple example of DosBeep API OS/2
with builtin; use builtin;
with os2; use os2;
with os2.bse; use os2.bse;
procedure beep is
frequency:ulong:=500;
durat    :ulong:=1000;
rc       :apiret;  --
begin
rc:=DosBeep(frequency, durat );
put_edit("return cod is ",integer(rc),3);
end beep;
