-- move file DosMove API OS/2
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with os2;use os2;
with os2.fm;use os2.fm;
with os2.err;use os2.err;
procedure movfl is
zero:constant character:=character'val(0);
ind :integer;
rc:apiret;
l:natural;
OldName      :string(1..60):=(others=>zero); -- from
pold         :PSZ :=OldName(1)'address;
NewName      :string(1..60):=(others=>zero); -- to
pnew         :PSZ :=NewName(1)'address;
------------------------------------------------------------------------
begin
put("Enter old full file name (c:\xxxxx) => ");  get_line(OldName,l);
upper_low(Oldname); -- upper string
new_line;
put("Enter new full file name (c:\xxxxx) => ");  get_line(NewName,l);
upper_low(NewName); -- upper string
new_line; put("Moving from =>");
ind:=index(OldName,zero)-1; put(left(OldName,ind));
put(" to =>");
ind:=index(NewName,zero)-1; put(left(NewName,ind));
new_line;
rc:= DosMove(pold,pnew);
case rc is
when 0 => put("File moved");
when others => put_edit("DosMove error=",integer(rc),4);
put(" "); put(Err_list(integer(rc)));
end case;
<<fin>>  null; end movfl;
