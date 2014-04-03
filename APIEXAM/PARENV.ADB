-- process with arg and env list DosKillProcess API OS/2
with Ada.text_io; use Ada.text_io;
with builtin; use builtin;
with Os2; use Os2;
with Os2.Bse; use Os2.Bse;
procedure parenv is

LENGTH: ulong := 40;
FLAGS : ulong := 2 ;
buf   : aliased string(1..integer(LENGTH));
pbuf  :Pch:=buf(1)'address;
name  :aliased constant string:="CHARGENV.EXE"  & ' ' & character'val(0);
ppgmname:pch   :=name(1)'address;
childID:aliased RESULTCODES ;
pchildid:PRESULTCODES :=childId'unchecked_access;
KillAll :ulong :=0 ;
rc      : apiret ;
lit     : character;
ArgStr  : string := "PARGENV.EXE" & character'val(0) & "arg1 arg2 arg3"
                                  & character'val(0) ;
EnvStr  : string :="Temp=d:\tmp" & character'val(0) &
                   "LIB=d:\gcc\lib" & character'val(0) ;
pARGS  : psz  :=argStr(1)'address;
pENVS  : psz  :=envStr(1)'address;

begin
 rc := dosexecpgm(pbuf,length,flags,pargs,penvs,pchildid,ppgmname);
 if rc>0 then put_edit("DosExecPgm error =",integer(rc),4); goto fin; end if;
get(lit);
                          -- kill
rc := DosKillProcess(KillAll,childID.codeTerminate);
new_line; put_edit("DosKillProcess error =",integer(rc),4);

<<fin>> null;
end parenv;
