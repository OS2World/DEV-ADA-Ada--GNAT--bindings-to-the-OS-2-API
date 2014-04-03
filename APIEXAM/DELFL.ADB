-- Simple example DosDelete  API OS/2
-- delete file
-- in the end of current directory on path
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with os2;use os2;
with os2.fm;use os2.fm;
with os2.err;use os2.err;
procedure delfl is
zero:constant character:=character'val(0);
rc:apiret;
l:natural;
path         :string(1..60):=(others=>zero); -- buffer for path-name
ppath        :PSZ :=path(1)'address;
------------------------------------------------------------------------
begin
put("enter file name(if will be deleted) => ");  get_line(path,l);
upper_low(path); -- upper string

rc:=DosDelete(ppath);
case rc is
when 0 => put("File is deleted");
when 2 => put("File not found ");
when 32=> put("Sharing violation ");put(Err_list(32));
when others => put_edit("DosDelete error=",integer(rc),4);
               put(' ');  put(Err_list(integer(rc)));
end case;
end delfl;
