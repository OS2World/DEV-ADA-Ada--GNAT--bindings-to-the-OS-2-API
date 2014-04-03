-- Create new subdirectory DosCreateDir API OS/2
-- in the end of current directory on path
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with os2;use os2;
with os2.fm;use os2.fm;
with os2.err;use os2.err;
procedure newdir is
zero:constant character:=character'val(0);
rc:apiret;
l:natural;
path         :string(1..60):=(others=>zero);
ppath        :PSZ :=path(1)'address;

------------------------------------------------------------------------
begin
put("Enter path or *.* => ");  get_line(path,l);
rc:=DosCreateDir(pszDirName => ppath,op2  => Null );

if    rc=3 then put("path not found");
elsif rc=5 then put("Can't make directory");
elsif rc>0 then  put_edit("DosMkdir error=",integer(rc),4);
    put("System Error=>"); put(Err_list(integer(rc)));
            else put("All right");
end if;
end newdir;
