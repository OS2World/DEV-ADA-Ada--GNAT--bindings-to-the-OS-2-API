
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PMpn                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               PM     Pointer manager                              บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMpn is
pragma Preelaborate (PMpn);

--     Pointer manager
subtype HPOINTER is LHANDLE  ;   -- hptr
--
function WinSetPointer(hwndDesktop:HWND     ;
                       hptrNew    :HPOINTER )return BOOL32;
pragma Import(c,WinSetPointer, Link_name=>"_WinSetPointer");

function WinSetPointerOwner(hptr    :HPOINTER ;
                            p_id    :PID      ;
                            fDestroy:BOOL32   )return BOOL32;
pragma Import(c,WinSetPointerOwner, Link_name=>"_WinSetPointerOwner");

function WinShowPointer(hwndDesktop:HWND   ;
                        fShow      :BOOL32 )return BOOL32;
pragma Import(c,WinShowPointer, Link_name=>"_WinShowPointer");

function WinLockPointerUpdate(hwndDesktop   :HWND     ;
                              hptrNew       :HPOINTER ;
                              ulTimeInterval:ULONG    )return BOOL32;
pragma Import(c,WinLockPointerUpdate, Link_name=>"_WinLockPointerUpdate");

function WinQuerySysPointer(hwndDesktop:HWND   ;
                            iptr       :LONG   ;
                            fLoad      :BOOL32 )return HPOINTER;
pragma Import(c,WinQuerySysPointer, Link_name=>"_WinQuerySysPointer");

function WinQuerySysPointerData(hwndDesktop:HWND      ;
                                iptr       :ULONG     ;
                                pIcon      :PICONINFO )return BOOL32;
pragma Import(c,WinQuerySysPointerData, Link_name=>"_WinQuerySysPointerData");

function WinSetSysPointerData(hwndDesktop:HWND      ;
                              iptr       :ULONG     ;
                              pIcon      :PICONINFO )return BOOL32;
pragma Import(c,WinSetSysPointerData, Link_name=>"_WinSetSysPointerData");

--     -- System pointers ( NOTE: these are 1-based)

 SPTR_ARROW           :constant Long:=      1 ;
 SPTR_TEXT            :constant Long:=      2 ;
 SPTR_WAIT            :constant Long:=      3 ;
 SPTR_SIZE            :constant Long:=      4 ;
 SPTR_MOVE            :constant Long:=      5 ;
 SPTR_SIZENWSE        :constant Long:=      6 ;
 SPTR_SIZENESW        :constant Long:=      7 ;
 SPTR_SIZEWE          :constant Long:=      8 ;
 SPTR_SIZENS          :constant Long:=      9  ;
 SPTR_APPICON         :constant Long:=      10 ;
 SPTR_ICONINFORMATION :constant Long:=      11 ;
 SPTR_ICONQUESTION    :constant Long:=      12 ;
 SPTR_ICONERROR       :constant Long:=      13 ;
 SPTR_ICONWARNING     :constant Long:=      14 ;
 SPTR_ILLEGAL         :constant Long:=      18 ;
 SPTR_FILE            :constant Long:=      19 ;
 SPTR_FOLDER          :constant Long:=      20 ;
 SPTR_MULTFILE        :constant Long:=      21 ;
 SPTR_PROGRAM         :constant Long:=      22 ;
 SPTR_DISPLAY_PTRS    :constant Long:=      22 ;
 SPTR_PENFIRST        :constant Long:=      23 ;
 SPTR_PENLAST         :constant Long:=      39 ;
 SPTR_CPTR            :constant Long:=      39 ;-- total # of system pointers
--
--     -- backward compatibility
 SPTR_HANDICON    :constant Long:=     SPTR_ICONERROR     ;
 SPTR_QUESICON    :constant Long:=     SPTR_ICONQUESTION  ;
 SPTR_BANGICON    :constant Long:=     SPTR_ICONWARNING   ;
 SPTR_NOTEICON    :constant Long:=     SPTR_ICONINFORMATION ;

function WinLoadPointer(hwndDesktop:HWND    ;
                        hmod       :HMODULE ;
                        idres      :ULONG   )return HPOINTER;
pragma Import(c,WinLoadPointer, Link_name=>"_WinLoadPointer");

function WinCreatePointer(hwndDesktop:HWND    ;
                          hbmPointer :HBITMAP ;
                          fPointer   :BOOL32  ;
                          xHotspot   :LONG    ;
                          yHotspot   :LONG    )return HPOINTER;
pragma Import(c,WinCreatePointer, Link_name=>"_WinCreatePointer");

function WinSetPointerPos(hwndDesktop:HWND ;
                          x          :LONG ;
                          y          :LONG )return BOOL32;
pragma Import(c,WinSetPointerPos, Link_name=>"_WinSetPointerPos");

function WinDestroyPointer( hptr:HPOINTER)return BOOL32;
pragma Import(c,WinDestroyPointer, Link_name=>"_WinDestroyPointer");

function WinQueryPointer( hwndDesktop:HWND)return HPOINTER;
pragma Import(c,WinQueryPointer, Link_name=>"_WinQueryPointer");

function WinQueryPointerPos(hwndDesktop:HWND    ;
                            pptl       :PPOINTL )return BOOL32;
pragma Import(c,WinQueryPointerPos, Link_name=>"_WinQueryPointerPos");

type POINTERINFO  is record    -- ptri
   fPointer          :ULONG   ;
   xHotspot          :LONG    ;
   yHotspot          :LONG    ;
   hbmPointer        :HBITMAP ;
   hbmColor          :HBITMAP ;
   hbmMiniPointer    :HBITMAP ;
   hbmMiniColor      :HBITMAP ;
end record; -- POINTERINFO;
type PPOINTERINFO  is access all POINTERINFO;

function WinCreatePointerIndirect(hwndDesktop:HWND         ;
                                  pptri      :PPOINTERINFO )return HPOINTER;
pragma Import(c,WinCreatePointerIndirect, Link_name=>"_WinCreatePointerIndirect");

function WinQueryPointerInfo(hptr        :HPOINTER     ;
                             pPointerInf :PPOINTERINFO )return BOOL32;
pragma Import(c,WinQueryPointerInfo, Link_name=>"_WinQueryPointerInfo");

function WinDrawPointer(hp  :HPS      ;
                        x   :LONG     ;
                        y   :LONG     ;
                        hptr:HPOINTER ;
                        fs  :ULONG    )return BOOL32;
pragma Import(c,WinDrawPointer, Link_name=>"_WinDrawPointer");

--     -- WinDrawPointer( ) constants
--
 DP_NORMAL        :constant Long:=          16#0000#;
 DP_HALFTONED     :constant Long:=          16#0001#;
 DP_INVERTED      :constant Long:=          16#0002#;

function WinGetSysBitmap(hwndDesktop:HWND  ;
                         ibm        :ULONG )return HBITMAP;
pragma Import(c,WinGetSysBitmap, Link_name=>"_WinGetSysBitmap");

--     System bitmaps ( NOTE: these are 1-based)
--
 SBMP_OLD_SYSMENU       :constant Long:=    1 ;
 SBMP_OLD_SBUPARROW     :constant Long:=    2 ;
 SBMP_OLD_SBDNARROW     :constant Long:=    3 ;
 SBMP_OLD_SBRGARROW     :constant Long:=    4 ;
 SBMP_OLD_SBLFARROW     :constant Long:=    5 ;
 SBMP_MENUCHECK         :constant Long:=    6 ;
 SBMP_OLD_CHECKBOXES    :constant Long:=    7 ;
 SBMP_BTNCORNERS        :constant Long:=    8 ;
 SBMP_OLD_MINBUTTON     :constant Long:=    9 ;
 SBMP_OLD_MAXBUTTON     :constant Long:=    10;
 SBMP_OLD_RESTOREBUTTON :constant Long:=    11;
 SBMP_OLD_CHILDSYSMENU  :constant Long:=    12;
 SBMP_DRIVE             :constant Long:=    15;
 SBMP_FILE              :constant Long:=    16;
 SBMP_FOLDER            :constant Long:=    17;
 SBMP_TREEPLUS          :constant Long:=    18;
 SBMP_TREEMINUS         :constant Long:=    19;
 SBMP_PROGRAM           :constant Long:=    22;
 SBMP_MENUATTACHED      :constant Long:=    23;
 SBMP_SIZEBOX           :constant Long:=    24;
 SBMP_SYSMENU           :constant Long:=    25;
 SBMP_MINBUTTON         :constant Long:=    26;
 SBMP_MAXBUTTON         :constant Long:=    27;
 SBMP_RESTOREBUTTON     :constant Long:=    28;
 SBMP_CHILDSYSMENU      :constant Long:=    29;
 SBMP_SYSMENUDEP        :constant Long:=    30;
 SBMP_MINBUTTONDEP      :constant Long:=    31;
 SBMP_MAXBUTTONDEP      :constant Long:=    32;
 SBMP_RESTOREBUTTONDEP  :constant Long:=    33;
 SBMP_CHILDSYSMENUDEP   :constant Long:=    34;
 SBMP_SBUPARROW         :constant Long:=    35;
 SBMP_SBDNARROW         :constant Long:=    36;
 SBMP_SBLFARROW         :constant Long:=    37;
 SBMP_SBRGARROW         :constant Long:=    38;
 SBMP_SBUPARROWDEP      :constant Long:=    39;
 SBMP_SBDNARROWDEP      :constant Long:=    40 ;
 SBMP_SBLFARROWDEP      :constant Long:=    41 ;
 SBMP_SBRGARROWDEP      :constant Long:=    42 ;
 SBMP_SBUPARROWDIS      :constant Long:=    43 ;
 SBMP_SBDNARROWDIS      :constant Long:=    44 ;
 SBMP_SBLFARROWDIS      :constant Long:=    45 ;
 SBMP_SBRGARROWDIS      :constant Long:=    46 ;
 SBMP_COMBODOWN         :constant Long:=    47 ;
 SBMP_CHECKBOXES        :constant Long:=    48 ;
end os2.pmpn;
