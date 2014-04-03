-- read file list from FAT
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with os2;use os2;
with os2.fm;use os2.fm;
procedure dirlst is
zero:constant character:=character'val(0);
ind :integer;
path_len     :constant integer:=80;   -- buffer length
--                    |01234567890123456789012345678901
--                    |          1         2         3
--                    |   x  xx      xxxxxxxxxxxxxxxxxx - rezerv
-- attr         :ulong:=2#11101100111111000000000000000000#; -- all attr
attr         :ulong:=16#0037#;                 -- normal files
NO_MORE_FILES:apiret:=18 ;            -- end of files list

buff         :aliased FILEFINDBUF3;   --  Os2-fm
pbuff        :Pvoid       :=buff'address;
path         :string(1..integer(PATH_LEN)):=(others=>zero);
-- handle       :aliased HDIR := 16#FFFFFFFF#; -- or 1  -- start mean
handle       :aliased HDIR := 16#1#;
phandle      :PHDIR:=handle'unchecked_access;
SearchCount  : aliased ulong:=1;
pSearchCount :pulong:=SearchCount'unchecked_access;
rc:apiret;
l:natural;
flag:boolean:=false;
pp     :constant PCH  :=buff.achName'address;
pdt    :constant PCH  :=buff.fdateLastWrite'address;
file_Name:constant astring(1..CCHMAXPATHCOMP) :=( others => ' ');
for file_Name'address use  pp;
dt:os2.fm.fdate;
for  dt'address use  pdt;
-----------------------------------------------------------------------
procedure pinfo(rc:apiret) is  --  print file or directory information
rcc:apiret;
begin
if rc=NO_MORE_FILES then
 new_line; put_edit("All file list. RC_close=",integer(rcc),4);
 return;
end if;
if rc>0 then
  new_line; put_edit("DosFindxxx error=",integer(rc),4); return;
end if;
ind:=integer(buff.cchName);
set_col(20);
for j in 1..ind loop put(File_name(j)); end loop;  -- file name
set_col(40);
put_edit(" ",integer(buff.attrFile),4);
set_col(50);
if buff.cbFile=0 then put (" <DIR>");
                           else  put_edit(" ",integer(buff.cbFile),5);
end if;
-- put_edit(" write_day=",integer(dt.day),4);
end pinfo;
------------------------------------------------------------------------
begin
put("Enter path or *.* => ");  get_line(path,l);

rc:=DosFindFirst(path,phandle,FILE_DIRECTORY,pbuff,buff'size,
                 pSearchCount,FIL_STANDARD);
if rc>0 then
    new_line; put_edit("DosFindFirst error=",integer(rc),4); put(" xx ");
    goto fin;
end if;
new_line; put("File #  1");
pinfo(rc);                  -- print file/directory inform
for j in 2..integer'last loop  exit when flag;
 rc:=DosFindNext(handle,pbuff,buff'size,pSearchCount);
 if rc>0 then flag:=true; else new_line; put_edit("File #",j,3); end if;
 pinfo(rc);                  -- print file/directory inform
end loop;
<<fin>> new_line; put("End");
  if  DosFindClose(handle) = 0 then null; end if; put('!');
end dirlst;
