-- Simple example of DosKillProcess API OS/2
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with Os2; use Os2;
with Os2.Bse; use Os2.Bse;
procedure parent is

LENGTH: ulong := 40;
FLAGS : ulong := 1 ;
args  : aliased uchar := 0 ;   -- empty arg list
envs  : aliased uchar := 0 ;   -- empty env list
pARGS  : psz  :=args'address;
pENVS  : psz  :=envs'address;
buf   : aliased string(1..integer(LENGTH));
pbuf  :Pch:=buf(1)'address;
name  :aliased constant string:="CHILD.EXE" & ' ' & character'val(0);
ppgmname:pch   :=name(1)'address;
childID:aliased RESULTCODES ;    -- Os2-bse
pchildid:PRESULTCODES :=childId'unchecked_access;
KillAll :ulong :=0 ;   -- kill process
rc      : apiret ;
lit     : character;

begin
 rc := dosexecpgm(pbuf,length,flags,pargs,penvs,pchildid,ppgmname);
 if rc>0 then put_edit("DosExecPgm error =",integer(rc),4); goto fin; end if;
get(lit);
                          -- kill
rc := DosKillProcess(KillAll,childID.codeTerminate);
new_line; put_edit("DosKillProcess error =",integer(rc),4);

<<fin>> null;
end parent;
