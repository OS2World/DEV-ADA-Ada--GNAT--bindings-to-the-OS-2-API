-- set time zone DosGetDateTime,DosSetDateTime API OS/2
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with Interfaces.C;         use Interfaces.C;
-- with Interfaces.C.Strings; use Interfaces.C.Strings;
with os2; use os2;
with os2.time; use os2.time;

procedure tmzone is
rc : apiret;
dt : aliased DATETIME ;   --  Os2-time
pdt:PDATETIME:=dt'access;
i  :integer;
package io is new integer_io(integer);
begin
rc:=DosGetDateTime(pdt);
put("Enter new means of timezone"); io.get(i);
dt.timezone := short(i);
rc:=DosSetDateTime( pdt );
if rc>0 then
 new_line; put_edit("DosSetDateTime error=",integer(rc));
end if;
end tmzone;
