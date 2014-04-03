
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.SES                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Session   support    of os/2 api functions            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Ses  is
pragma Preelaborate (Ses);

--** Session manager support --

type  STARTDATA is record     -- stdata --
 Length            :USHORT  ;
 Related           :USHORT  ;
 FgBg              :USHORT  ;
 TraceOpt          :USHORT  ;
 PgmTitle          :PSZ     ;
 PgmName           :PSZ     ;
 PgmInputs         :PBYTE   ;
 TermQ             :PBYTE   ;
 Environment       :PBYTE   ;
 InheritOpt        :USHORT  ;
 SessionType       :USHORT  ;
 IconFile          :PSZ     ;
 PgmHandle         :ULONG   ;
 PgmControl        :USHORT  ;
 InitXPos          :USHORT  ;
 InitYPos          :USHORT  ;
 InitXSize         :USHORT  ;
 InitYSize         :USHORT  ;
 Reserved          :USHORT  ;
 ObjectBuffer      :PSZ     ;
 ObjectBuffLen     :ULONG   ;
end record;  -- STARTDATA;
type PSTARTDATA is access all STARTDATA;

  SSF_RELATED_INDEPENDENT:constant Long:=  0 ;
  SSF_RELATED_CHILD      :constant Long:=  1 ;

  SSF_FGBG_FORE          :constant Long:=  0 ;
  SSF_FGBG_BACK          :constant Long:=  1 ;

  SSF_TRACEOPT_NONE      :constant Long:=  0 ;
  SSF_TRACEOPT_TRACE     :constant Long:=  1 ;
  SSF_TRACEOPT_TRACEALL  :constant Long:=  2 ;

  SSF_INHERTOPT_SHELL    :constant Long:=  0 ;
  SSF_INHERTOPT_PARENT   :constant Long:=  1 ;

 -- note that these types are identical to those
 -- in pmshl.h for PROG_*
  SSF_TYPE_DEFAULT       :constant Long:=  0 ;
  SSF_TYPE_FULLSCREEN    :constant Long:=  1 ;
  SSF_TYPE_WINDOWABLEVIO :constant Long:=  2 ;
  SSF_TYPE_PM            :constant Long:=  3 ;
  SSF_TYPE_VDM           :constant Long:=  4 ;
  SSF_TYPE_GROUP         :constant Long:=  5 ;
  SSF_TYPE_DLL           :constant Long:=  6 ;
  SSF_TYPE_WINDOWEDVDM   :constant Long:=  7 ;
  SSF_TYPE_PDD           :constant Long:=  8 ;
  SSF_TYPE_VDD           :constant Long:=  9 ;

 -- note that these flags are identical to those in pmshl.h for SHE_*
  SSF_CONTROL_VISIBLE    :constant Long:=  16#0000#;
  SSF_CONTROL_INVISIBLE  :constant Long:=  16#0001#;
  SSF_CONTROL_MAXIMIZE   :constant Long:=  16#0002#;
  SSF_CONTROL_MINIMIZE   :constant Long:=  16#0004#;
  SSF_CONTROL_NOAUTOCLOSE:constant Long:=  16#0008#;
  SSF_CONTROL_SETPOS     :constant Long:=  16#8000#;

type  STATUSDATA   is record   -- stsdata --
   Length          :USHORT ;
   SelectInd       :USHORT ;
   BondInd         :USHORT ;
end record;  -- STATUSDATA;
type PSTATUSDATA is access all STATUSDATA;

--   ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
--   บ -- SelectInd and BondInd paramater values for DosSetSession --   บ
--   บ  SET_SESSION_UNCHANGED      0                             บ
--   บ  SET_SESSION_SELECTABLE     1                             บ
--   บ  SET_SESSION_NON_SELECTABLE 2                             บ
--   บ  SET_SESSION_BOND           1                             บ
--   บ  SET_SESSION_NO_BOND        2                             บ
--   บ                                                                  บ
--   บ -- TargetOption (scope) parameter values for DosStopSession --   บ
--   บ  STOP_SESSION_SPECIFIED     0                             บ
--   บ  STOP_SESSION_ALL           1                             บ
--   ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
--
--      DosQAppType--   DosQueryAppType
--
function   DosStartSession(psd       :PSTARTDATA ;
                           pidSession:PULONG    ;
                           ppd       :PPID      )return apiret;
pragma Import(c,DosStartSession, Link_name=>"_DosStartSession");

function   DosSetSession(idSession:ULONG       ;
                         psd      :PSTATUSDATA )return apiret;
pragma Import(c,DosSetSession, Link_name=>"_DosSetSession");

function   DosSelectSession(idSession:ULONG )return apiret;
pragma Import(c,DosSelectSession, Link_name=>"_DosSelectSession");

function   DosStopSession(scope    :ULONG ;
                          idSession:ULONG )return apiret;
pragma Import(c,DosStopSession, Link_name=>"_DosStopSession");

function  DosQueryAppType(pszName:PSZ    ;
                          pFlags :PULONG )return apiret;
pragma Import(c,DosQueryAppType, Link_name=>"_DosQueryAppType");

end Os2.Ses;
