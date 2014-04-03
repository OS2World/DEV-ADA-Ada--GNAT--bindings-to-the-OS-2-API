--  search   file path DosSearchPath API OS/2
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with os2;use os2;
with os2.misc;use os2.misc;
with os2.err;use os2.err;
procedure seefl is
zero:constant character:=character'val(0);
rc:apiret;
l:natural;
FileName     :string(1..60):=(others=>zero);
pname        :PSZ :=FileName(1)'address;
Path         :string(1..60):=(others=>zero);
ppath        :PSZ :=Path(1)'address;
rezult       :string(1..256);
buffer       :array(1..256) of aliased byte;     -- buffer to rezult
for buffer'address use rezult'address;
pbuffer      :pbyte:=buffer(1)'access;
len          :ulong:=256;                        -- buffer length
control      :ulong:=0 ;                         -- search curent dir
flag_end     :boolean:=false;
------------------------------------------------------------------------
begin
put("Enter file name xxx.xxx => ");  get_line(FileName,l);
-- upper_low(FileName); -- upper string
put("Enter full path \xxx[\xxx]... => ");  get_line(Path,l);
upper_low(Path); -- upper string
new_line;

rc:=DosSearchPath(flag          => control,
                  pszPathOrName => ppath,
                  pszFilename   => pname,
                  pBuf          => pbuffer,
                  cbBuf         => len     );

if rc>0 then put_edit("DosSearchPath=error",integer(rc),4);
             put(' '); put(Err_list(integer(rc))); goto fin;
end if;

new_line; put("List of files"); new_line;
for i in 1..integer(len) loop  exit when rezult(i)=zero and flag_end;
 if rezult(i)=zero then new_line;  flag_end:=true;
                   else
  put(rezult(i)); flag_end:=false;
 end if;
end loop;
<<fin>> null;
end seefl;
