-- Simple example of  DosQueryCurrentDisk,DosQueryCurrentDir
--                    DosSetDefaultDisk,  DosSetCurrentDir  API OS/2
-- change directory
-- in the end of current directory on path
with os2;use os2;
with os2.fm;use os2.fm;
with os2.err;use os2.err;
with text_io; use text_io;
with builtin; use builtin;
procedure dirch is
zero:constant character:=character'val(0);
ind :integer;
rc:apiret;
lit:character;
l:natural;
path         :string(1..60):=(others=>zero);
ppath        :constant PSZ :=path(4)'address;   --  c:\xxxxx
                                       --  123|
 drive       :aliased ULONG ;     -- driver number  (A=1,B=2   )
pdrive       :PULONG:=drive'unchecked_access;
 map         :aliased ULONG  ;     -- driver map (not used)
pmap         :PULONG:=map'unchecked_access;
 bufflen     :aliased ULONG:=60;  -- buffer size
pbufflen     :PULONG:=bufflen'unchecked_access;
pathbuff     :array(1..60) of aliased byte;
pathbufa     :constant system.address := pathbuff(1)'address ;
ppathbuff    :PBYTE :=pathbuff(1)'unchecked_access;
pathstr      :string(1..60);
for pathstr'address use pathbufa;
------------------------------------------------------------------------
begin
new_line; put("Enter new path (c:\os2)  => ");   get_line(path,l);
upper_low(path); -- upper string

rc:=DosQueryCurrentDisk(pdrive,pmap);  -- curent disk

if rc>0 then put_edit("DosQCurDisk error=",integer(rc),4);
put(' '); put(Err_list(integer(rc)));
   goto fin;
end if;

rc:=DosQueryCurrentDir(drive,ppathbuff,pbufflen );
if rc>0 then put_edit("DosQCurDir error=",integer(rc),4);
put(' '); put(Err_list(integer(rc))); goto fin;
end if;

put("Old directory="); ind:=index(pathstr,zero)-1;
put(left(pathstr,ind));
lit:=path(1);
new_line;
case lit is
when 'A' =>drive:= 1 ; when 'B' =>drive:= 2 ;  when 'C' =>drive:= 3 ; when 'D' =>drive:= 4 ;
when 'E' =>drive:= 5 ; when 'F' =>drive:= 6 ;  when 'G' =>drive:= 7 ; when 'H' =>drive:= 8 ;
when 'I' =>drive:= 9 ; when 'J' =>drive:= 10;  when 'K' =>drive:= 11; when 'L' =>drive:= 12;
when others =>drive:= 3;
end case;
put_edit("New drive number =>",integer(drive),2);
rc:=DosSetDefaultDisk( drive );  -- change drive
if rc=15 then new_line; put("Invalid drive"); goto fin; end if;
if rc>0  then new_line; put_edit("DosSelectDisk error=",integer(rc),4);
put(' '); put(Err_list(integer(rc))); goto fin;
end if;
                      -- directory change
put(" New Drive Ok!");
rc:=DosSetCurrentDir (ppath);
if rc=3 then new_line; put("Invalid directory path"); goto fin; end if;
if rc>0 then new_line; put_edit("DosChDir error=",integer(rc),4);
put(' '); put(Err_list(integer(rc))); goto fin;
end if;
        -- new directory
new_line;
rc:=DosQueryCurrentDir ( drive,ppathbuff,pbufflen );
if rc>0 then  put_edit("DosQCurDir error=",integer(rc),4);
put(' '); put(Err_list(integer(rc))); goto fin;
end if;
put("New directory =>"); ind:=index(pathstr,zero)-1; put(left(pathstr,ind));
<<fin>> null;
end dirch;
