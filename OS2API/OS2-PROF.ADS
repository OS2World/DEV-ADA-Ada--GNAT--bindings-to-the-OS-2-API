
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package  SYSTEM.PROF                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Profile   support    of os/2 api functions            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Prof is
pragma Preelaborate (Prof);

--** DosProfile API support --

   --** Perfview API support --

function DosTmrQueryFreq(pulTmrFreq:PULONG )return apiret;
pragma Import(c,DosTmrQueryFreq, Link_name=>"_DosTmrQueryFreq");

function DosTmrQueryTime(pqwTmrTime:PQWORD )return apiret;
pragma Import(c,DosTmrQueryTime, Link_name=>"_DosTmrQueryTime");

function DosRegisterPerfCtrs(pbDataBlk:PBYTE ;
                             pbTextBlk:PBYTE ;
                             flFlags  :ULONG )return apiret;
pragma Import(c,DosRegisterPerfCtrs, Link_name=>"_DosRegisterPerfCtrs");--

 -- DosProfile ordinal number

  PROF_ORDINAL :constant Long:=       133 ;

 -- DosProfile usType --

  PROF_SYSTEM  :constant Long:=          0 ;
  PROF_USER    :constant Long:=          1 ;
  PROF_USEDD   :constant Long:=          2 ;
  PROF_KERNEL  :constant Long:=          4 ;
  PROF_VERBOSE :constant Long:=          8 ;
  PROF_ENABLE  :constant Long:=         16 ;

 -- DosProfile usFunc --

  PROF_ALLOC   :constant Long:=          0 ;
  PROF_CLEAR   :constant Long:=          1 ;
  PROF_ON      :constant Long:=          2 ;
  PROF_OFF     :constant Long:=          3 ;
  PROF_DUMP    :constant Long:=          4 ;
  PROF_FREE    :constant Long:=          5 ;

 -- DosProfile tic count granularity (DWORD)

  PROF_SHIFT   :constant Long:=          2 ;

 -- DosProfile module name string length

  PROF_MOD_NAME_SIZE :constant Long:=   10 ;

 -- DosProfile error code for end of data

  PROF_END_OF_DATA  :constant Long:=    13 ;

end Os2.Prof;
