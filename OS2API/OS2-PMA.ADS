
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PMa                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               PM       Accelerator   functions                    บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMa is
pragma Preelaborate (PMa);
--     Accelerator ; functions

subtype HACCEL is  LHANDLE ; -- haccel
--
--   ACCEL fs bits
--
--  NOTE: the first six AF_ code bits have the same value
--  as their KC_ counterparts

  AF_CHAR       :constant Long:=              16#0001#;
  AF_VIRTUALKEY :constant Long:=              16#0002#;
  AF_SCANCODE   :constant Long:=              16#0004#;
  AF_SHIFT      :constant Long:=              16#0008#;
  AF_CONTROL    :constant Long:=              16#0010#;
  AF_ALT        :constant Long:=              16#0020#;
  AF_LONEKEY    :constant Long:=              16#0040#;
  AF_SYSCOMMAND :constant Long:=              16#0100#;
  AF_HELP       :constant Long:=              16#0200#;

--   Binary resources may be bound into application executables or
--   passed as a parameter when creating a window or dialog
--   Currently they must be the same for both 16-bit and 32-bit
--   so we pack the structures.

type ACCEL  is record    -- acc
  fs    :USHORT  ;
  key   :USHORT  ;
  cmd   :USHORT  ;
end record; -- ACCEL;
type PACCEL  is access all ACCEL;

--   Binary resources may be bound into application executables or
--   passed as a parameter when creating a window or dialog
--   Currently they must be the same for both 16-bit and 32-bit
--   so we pack the structures.

type ACCELTABLE  is record    -- acct
   cAccel   :USHORT  ;
   codepage :USHORT  ;
   aaccel   :ACCEL   ;      -- [1];
end record; -- ACCELTABLE;
type PACCELTABLE  is access all ACCELTABLE;

function WinLoadAccelTable(ha           :HAB     ;
                           hmod         :HMODULE ;
                           idAccelTable :ULONG   )return HACCEL;
pragma Import(c,WinLoadAccelTable, Link_name=>"_WinLoadAccelTable");

function WinCopyAccelTable(haccl      :HACCEL      ;
                           pAccelTab  :PACCELTABLE ;
                           cbCopyMax  :ULONG       )return ULONG;
pragma Import(c,WinCopyAccelTable, Link_name=>"_WinCopyAccelTable");

function WinCreateAccelTable(ha         :HAB         ;
                             pAccelTab  :PACCELTABLE )return HACCEL;
pragma Import(c,WinCreateAccelTable, Link_name=>"_WinCreateAccelTable");

function WinDestroyAccelTable(haccl:HACCEL )return BOOL32  ;
pragma Import(c,WinDestroyAccelTable, Link_name=>"_WinDestroyAccelTable");

function WinTranslateAccel(ha   :HAB    ;
                           hwn  :HWND   ;
                           haccl:HACCEL ;
                           pqm  :PQMSG  )return BOOL32  ;
pragma Import(c,WinTranslateAccel, Link_name=>"_WinTranslateAccel");

function WinSetAccelTable(ha       :HAB    ;
                          haccl    :HACCEL ;
                          hwndFrame:HWND   )return BOOL32  ;
pragma Import(c,WinSetAccelTable, Link_name=>"_WinSetAccelTable");

function WinQueryAccelTable(ha       :HAB  ;
                            hwndFrame:HWND )return HACCEL;
pragma Import(c,WinQueryAccelTable, Link_name=>"_WinQueryAccelTable");
end os2.PMa;
