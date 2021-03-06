
-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �       D E S I G N   E N G I N E R I N G              �D�S�        �
-- �            S O F T W A R E                           藩瞥�        �
-- �                                                                   �
-- �        Package     OS2.TIME                                       �
-- �                                                                   �
-- �        Author :  Leonid Dulman     1995 , 1996                    �
-- �                                                                   �
-- �             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            �
-- �                                                                   �
-- �             Date/time  part of os/2 api functions                 �
-- �                                                                   �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�


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

--   浜様様様様様様様様様様様様様様様様様様様様�
--   � #define DosTimerAsync   DosAsyncTimer   �
--   � #define DosTimerStart   DosStartTimer   �
--   � #define DosTimerStop    DosStopTimer    �
--   藩様様様様様様様様様様様様様様様様様様様様�
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