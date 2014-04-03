--  driver information  DosQueryFSInfo API OS/2
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with os2; use os2;
with os2.fm; use os2.fm;
procedure flsys is
Level:ULONG:= 1 ;                 --  1=file  2=vol
drive:ULONG;         --  driver's number
                                 -- 0=work     1=€  2=‚ ...
buffer: aliased FSALLOCATE ;    --  Os2-fm
-- pbuffer:PFSALLOCATE:=buffer'access;
pbuffer:PVOID :=buffer'address;
size  : ULONG:=buffer'size/8;                --  buffer's size
rc    : APIRET;
i     : integer;
package io is new integer_io(integer);
begin
put("Input drive number "); io.get(i); drive:=ulong(i);

rc:=DosQueryFSInfo(drive, Level,pbuffer, size);

put_edit("DosQFSInfo error=",integer(rc),4);
if rc>0 then goto fin; end if;
new_line; put_edit("File system ID =    ",integer( buffer.idFileSystem));
new_line; put_edit("Number of sectors = ",integer( buffer.cSectorUnit));
new_line; put_edit("Allocation units =  ",integer( buffer.cUnit));
new_line; put_edit("Availavle units =   ",integer( buffer.cUnitAvail));
new_line; put_edit("Bytes per sector =  ",integer( buffer.cbSector));
<<fin>> null;
end flsys;
