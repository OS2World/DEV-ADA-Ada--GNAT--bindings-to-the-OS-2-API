
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     OS2.TIME                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Date/time  part of os/2 api functions                 บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Time is
pragma Preelaborate (Time);


   --** Time support --
subtype HSEM is PVOID; -- typedef void *hsem
type  DATETIME is record       -- date --
  hours         :UCHAR   ;
  minutes       :UCHAR   ;
  seconds       :UCHAR   ;
  hundredths    :UCHAR   ;
  day           :UCHAR   ;
  month         :UCHAR   ;
  year          :USHORT  ;
  timezone      :SHORT   ;
  weekday       :UCHAR   ;
end record;  -- DATETIME;
type PDATETIME is access all DATETIME;

function    DosGetDateTime(pdt:PDATETIME ) return apiret;
pragma Import(c,DosGetDateTime, Link_name=>"_DosGetDateTime");

function    DosSetDateTime(pdt:PDATETIME ) return apiret;
pragma Import(c,DosSetDateTime, Link_name=>"_DosSetDateTime");

--   ษอออออออออออออออออออออออออออออออออออออออออป
--   บ #define DosTimerAsync   DosAsyncTimer   บ
--   บ #define DosTimerStart   DosStartTimer   บ
--   บ #define DosTimerStop    DosStopTimer    บ
--   ศอออออออออออออออออออออออออออออออออออออออออผ
subtype HTIMER  is LHANDLE;
type PHTIMER  is access all HTIMER;

function  DosAsyncTimer(msec   :ULONG   ;
                        hsm    :HSEM    ;
                        phtim  :PHTIMER ) return apiret;
pragma Import(c,DosAsyncTimer, Link_name=>"_DosAsyncTimer");

function  DosStartTimer(msec   :ULONG   ;
                        hsm    :HSEM    ;
                        phtim  :PHTIMER ) return apiret;
pragma Import(c,DosStartTimer, Link_name=>"_DosStartTimer");

function  DosStopTimer(htim:HTIMER ) return apiret;
pragma Import(c,DosStopTimer, Link_name=>"_DosStopTimer");

end Os2.Time;
