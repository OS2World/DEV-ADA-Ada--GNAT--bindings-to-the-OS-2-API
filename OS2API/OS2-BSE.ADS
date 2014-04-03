
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package  OS2.BSE                                           บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             root part of os/2 api functions                       บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Bse is
pragma Preelaborate (BSE);

   --*** General services --

function DosBeep (Freq : ULONG; Dur : ULONG) return APIRET;
pragma Import (C, DosBeep, Link_Name => "_DosBeep");

       --** Process and Thread support --
procedure DosExit(action:ULONG ; result:ULONG );
pragma Import(c,DosExit, Link_name=>"_DosExit");

       -- DosExit codes --

 EXIT_THREAD  : constant ushort :=  0 ;
 EXIT_PROCESS : constant ushort :=  1 ;

--  ษออออออออออออออออออออออออออออออออออออออออออออป
--  บ  #define DosCwait           DosWaitChild   บ
--  บ  #define DosSetPrty         DosSetPriority บ
--  ศออออออออออออออออออออออออออออออออออออออออออออผ
--     #include <bsetib.h>

    --   type  VOID APIENTRY FNTHREAD(:ULONG);

type PFNTHREAD is access procedure (prm:ULONG);

function DosCreateThread(ptd    :PTID      ;
                         pfn    :PFNTHREAD ;
                         param  :ULONG     ;
                         flag   :ULONG     ;
                         cbStack:ULONG     ) return apiret;
pragma Import(c,DosCreateThread, Link_name=>"_DosCreateThread");

function DosResumeThread(td:TID )return apiret;
pragma Import(c,DosResumeThread, Link_name=>"_DosResumeThread");

function DosSuspendThread(td:TID )return apiret;
pragma Import(c,DosSuspendThread, Link_name=>"_DosSuspendThread");


--
--      Thread Information Block (TIB)
--

type TIB2 is record
 tib2_ultid             :ULONG   ;      -- Thread I.D. --
 tib2_ulpri             :ULONG   ;      -- Thread priority --
 tib2_version           :ULONG   ;      -- Version number for this structure --
 tib2_usMCCount         :USHORT  ;      -- Must Complete count --
 tib2_fMCForceFlag      :USHORT  ;      -- Must Complete force flag --
end record;
type PTIB2 is access all TIB2;

type TIB is record                     -- TIB Thread Information Block --
  tib_pexchain         :PVOID   ;      -- Head of exception handler chain --
  tib_pstack           :PVOID   ;      -- Pointer to base of stack --
  tib_pstacklimit      :PVOID   ;      -- Pointer to end of stack --
  tib_ptib2            :PTIB2   ;      -- Pointer to system specific TIB --
  tib_version          :ULONG   ;      -- Version number for this TIB structure --
  tib_ordinal          :ULONG   ;      -- Thread ordinal number        --
end record;
type PTIB is access all TIB;

--
--      Process Information Block (PIB)
--

type PIB is record                     -- PIB Process Information Block --
   pib_ulpid       :ULONG   ;          -- Process I.D. --
   pib_ulppid      :ULONG   ;          -- Parent process I.D. --
   pib_hmte        :ULONG   ;          -- Program (.EXE) module handle --
   pib_pchcmd      :PCHAR   ;          -- Command line pointer --
   pib_pchenv      :PCHAR   ;          -- Environment pointer --
   pib_flstatus    :ULONG   ;          -- Process' status bits --
   pib_ultype      :ULONG   ;          -- Process' type code --
end record;
type PPIB is access all PIB;
function DosGetInfoBlocks(pptib:access PTIB;
                          pppib:access PPIB) return apiret;
pragma Import(c,DosGetInfoBlocks, Link_name=>"_DosGetInfoBlocks");

function DosKillThread(td:TID ) return apiret;
pragma Import(c,DosKillThread, Link_name=>"_DosKillThread");

       -- Action code values --
 DCWA_PROCESS       : constant ushort := 0 ;
 DCWA_PROCESSTREE   : constant ushort := 1 ;

       -- Wait option values --
 DCWW_WAIT          : constant ushort := 0 ;
 DCWW_NOWAIT        : constant ushort := 1 ;

type RESULTCODES  is record      -- resc --
   codeTerminate       :ULONG ;
   codeResult          :ULONG ;
end record;  -- RESULTCODES;
type PRESULTCODES is access all RESULTCODES;

function DosWaitChild(action:ULONG        ;
                      option:ULONG        ;
                      pres  :PRESULTCODES ;
                      ppi   :PPID         ;
                           p:PID          ) return apiret;
pragma Import(c,DosWaitChild, Link_name=>"_DosWaitChild");

function DosWaitThread(pti :PTID ;option:ULONG )  return apiret;
pragma Import(c,DosWaitThread, Link_name=>"_DosWaitThread");

function DosSleep(msec:ULONG ) return apiret;
pragma Import (C, DosSleep, Link_name => "_DosSleep");

function DosDebug(pdbgbuf:PVOID ) return apiret;
pragma Import(c,DosDebug, Link_name=>"_DosDebug");


       -- codeTerminate values (also passed to ExitList routines) --

 TC_EXIT            : constant ushort := 0 ;
 TC_HARDERROR       : constant ushort := 1 ;
 TC_TRAP            : constant ushort := 2 ;
 TC_KILLPROCESS     : constant ushort := 3 ;
 TC_EXCEPTION       : constant ushort := 4 ;

type PFNEXITLIST is access procedure(pfn:ULONG);

function DosEnterCritSec return apiret;
pragma Import(c,DosEnterCritSec, Link_name=>"_DosEnterCritSec");

function DosExitCritSec return apiret;
pragma Import(c,DosExitCritSec, Link_name=>"_DosExitCritSec");

function DosExitList(ordercode:ULONG       ;
                     pfn      :PFNEXITLIST ) return apiret;
pragma Import(c,DosExitList, Link_name=>"_DosExitList");

       -- DosExitList functions --

 EXLST_ADD          : constant ushort := 1 ;
 EXLST_REMOVE       : constant ushort := 2 ;
 EXLST_EXIT         : constant ushort := 3 ;

function DosExecPgm(pObjname :PCH          ;
                    cbObjname:ULONG        ;
                    execFlag :ULONG        ;
                    pArg     :PSZ          ;
                    pEnv     :PSZ          ;
                    pRes     :PRESULTCODES ;
                    pName    :PCH          ) return apiret;
pragma Import(c,DosExecPgm, Link_name=>"_DosExecPgm");

       -- DosExecPgm functions --

 EXEC_SYNC          : constant ushort := 0 ;
 EXEC_ASYNC         : constant ushort := 1 ;
 EXEC_ASYNCRESULT   : constant ushort := 2 ;
 EXEC_TRACE         : constant ushort := 3 ;
 EXEC_BACKGROUND    : constant ushort := 4 ;
 EXEC_LOAD          : constant ushort := 5 ;
 EXEC_ASYNCRESULTDB : constant ushort := 6 ;

function DosSetPriority(scope :ULONG ;
                        class :ULONG ;
                        delt  :LONG  ;
                        PorTid:ULONG ) return apiret;
pragma Import(c,DosSetPriority, Link_name=>"_DosSetPriority");

       -- Priority scopes --

 PRTYS_PROCESS      : constant ushort := 0 ;
 PRTYS_PROCESSTREE  : constant ushort := 1 ;
 PRTYS_THREAD       : constant ushort := 2 ;
       -- Priority classes --

 PRTYC_NOCHANGE         : constant ushort := 0 ;
 PRTYC_IDLETIME         : constant ushort := 1 ;
 PRTYC_REGULAR          : constant ushort := 2 ;
 PRTYC_TIMECRITICAL     : constant ushort := 3 ;
 PRTYC_FOREGROUNDSERVER : constant ushort := 4 ;

       -- Priority deltas --

 PRTYD_MINIMUM          : constant  short := -31;
 PRTYD_MAXIMUM          : constant  short :=  31;

function DosKillProcess(action:ULONG ;p:PID)  return apiret;
pragma Import(c,DosKillProcess, Link_name=>"_DosKillProcess");

end Os2.BSE;
