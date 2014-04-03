
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.Misc                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             definitions for DosSearchPath control word            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Misc is
pragma Preelaborate (Misc);

-- initions for DosSearchPath control word

 DSP_IMPLIEDCUR  :constant ushort:=  1;-- current dir will be searched first
 DSP_PATHREF     :constant ushort:=  2;-- from env.variable
 DSP_IGNORENETERR:constant ushort:=  4;-- ignore net errs & continue search

--  for DosQuerySysInfo --

 QSV_MAX_PATH_LENGTH :constant ushort:=     1 ;
 Q_MAX_PATH_LENGTH   :constant ushort:=     QSV_MAX_PATH_LENGTH ;
 QSV_MAX_TEXT_SESSIONS:constant ushort:=    2 ;
 QSV_MAX_PM_SESSIONS  :constant ushort:=    3 ;
 QSV_MAX_VDM_SESSIONS :constant ushort:=    4 ;
 QSV_BOOT_DRIVE       :constant ushort:=    5 ;     -- 1=A; 2=B; etc.
 QSV_DYN_PRI_VARIATION:constant ushort:=    6 ;     -- 0=Absolute; 1=Dynamic
 QSV_MAX_WAIT         :constant ushort:=    7 ;     -- seconds
 QSV_MIN_SLICE        :constant ushort:=    8 ;     -- milli seconds
 QSV_MAX_SLICE        :constant ushort:=    9 ;     -- milli seconds
 QSV_PAGE_SIZE        :constant ushort:=    10;
 QSV_VERSION_MAJOR    :constant ushort:=    11;
 QSV_VERSION_MINOR    :constant ushort:=    12;
 QSV_VERSION_REVISION :constant ushort:=    13;     -- Revision letter
 QSV_MS_COUNT         :constant ushort:=    14;     -- Free running millisecond counter
 QSV_TIME_LOW         :constant ushort:=    15;     -- Low dword of time in seconds
 QSV_TIME_HIGH        :constant ushort:=    16;     -- High dword of time in seconds
 QSV_TOTPHYSMEM       :constant ushort:=    17;     -- Physical memory on system
 QSV_TOTRESMEM        :constant ushort:=    18;     -- Resident memory on system
 QSV_TOTAVAILMEM      :constant ushort:=    19;     -- Available memory for all processes
 QSV_MAXPRMEM         :constant ushort:=    20;     -- Avail private mem for calling proc
 QSV_MAXSHMEM         :constant ushort:=    21;     -- Avail shared mem for calling proc
 QSV_TIMER_INTERVAL   :constant ushort:=    22;     -- Timer interval in tenths of ms
 QSV_MAX_COMP_LENGTH  :constant ushort:=    23;     -- max len of one component in a name
 QSV_MAX              :constant ushort:=    QSV_MAX_COMP_LENGTH ;


      -- definitions for DosError - combine with
 FERR_DISABLEHARDERR   :constant ushort:=   16#00000000#;    -- disable hard error popups
 FERR_ENABLEHARDERR    :constant ushort:=   16#00000001#;    -- enable hard error popups
 FERR_ENABLEEXCEPTION  :constant ushort:=   16#00000000#;    -- enable exception popups
 FERR_DISABLEEXCEPTION :constant ushort:=   16#00000002#;    -- disable exception popups

-- definitions for DosQueryRASInfo Index --
 SIS_MMIOADDR  :constant ushort:=           0;
 SIS_MEC_TABLE :constant ushort:=           1;
 SIS_SYS_LOG   :constant ushort:=           2;

--   #define DosInsMessage   DosInsertMessage
--   #define DosQSysInfo     DosQuerySysInfo

function  DosError(error:ULONG )return apiret;
pragma Import(c,DosError, Link_name=>"_DosError");

function  DosGetMessage(pTable   :PCHAR  ;
                        cTable   :ULONG  ;
                        pBuf     :PCHAR  ;
                        cbBuf    :ULONG  ;
                        msgnumber:ULONG  ;
                        pszFile  :PSZ    ;
                        pcbMsg   :PULONG )return apiret;
pragma Import(c,DosGetMessage, Link_name=>"_DosGetMessage");

function  DosErrClass(code   :ULONG  ;
                      pClass :PULONG ;
                      pAction:PULONG ;
                      pLocus :PULONG )return apiret;
pragma Import(c,DosErrClass, Link_name=>"_DosErrClass");

function DosInsertMessage(pTable:PCHAR  ;
                          cTable:ULONG  ;
                          pszMsg:PSZ    ;
                          cbMsg :ULONG  ;
                          pBuf  :PCHAR  ;
                          cbBuf :ULONG  ;
                          pcbMsg:PULONG ) return apiret;
pragma Import(c,DosInsertMessage, Link_name=>"_DosInsertMessage");

function  DosPutMessage(hfl  :HFILE ;
                        cbMsg:ULONG ;
                        pBuf :PCHAR ) return apiret;
pragma Import(c,DosPutMessage, Link_name=>"_DosPutMessage");

function DosQuerySysInfo(iStart:ULONG ;
                         iLast :ULONG ;
                         pBuf  :PVOID ;
                         cbBuf :ULONG )return apiret;
pragma Import(c,DosQuerySysInfo, Link_name=>"_DosQuerySysInfo");

type PPSZ is access all PSZ;
function  DosScanEnv(pszName  :PSZ  ;
                     ppszValue:PPSZ )return apiret;
pragma Import(c,DosScanEnv, Link_name=>"_DosScanEnv");

function DosSearchPath(flag         :ULONG ;
                       pszPathOrName:PSZ   ;
                       pszFilename  :PSZ   ;
                       pBuf         :PBYTE ;
                       cbBuf        :ULONG )return apiret;
pragma Import(c,DosSearchPath, Link_name=>"_DosSearchPath");

function DosQueryMessageCP(pb         :PCHAR  ;
                           cb         :ULONG  ;
                           pszFilename:PSZ    ;
                           cbBuf      :PULONG )return apiret;
pragma Import(c,DosQueryMessageCp, Link_name=>"_DosQueryMessageCp");

function  DosQueryRASInfo(Index:ULONG ;
                          Addr :PVOID )return apiret;
pragma Import(c,DosQueryRASInfo, Link_name=>"_DosQueryRASInfo");
end Os2.Misc;
