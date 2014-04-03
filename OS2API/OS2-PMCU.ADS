
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PM                                         บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               PM    Cursor manager                                บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMcu is
pragma Preelaborate (PMcu);

--     Cursor manager common subsection
--
function WinDestroyCursor(hwn :HWND )return BOOL32;
pragma Import(c,WinDestroyCursor, Link_name=>"_WinDestroyCursor");

function WinShowCursor(hwn  :HWND   ;
                       fShow:BOOL32 )return BOOL32;
pragma Import(c,WinShowCursor, Link_name=>"_WinShowCursor");

function WinCreateCursor(hwn     :HWND   ;
                         x       :LONG   ;
                         y       :LONG   ;
                         cx      :LONG   ;
                         cy      :LONG   ;
                         fs      :ULONG  ;
                         prclClip:PRECTL )return BOOL32;
pragma Import(c,WinCreateCursor, Link_name=>"_WinCreateCursor");

--     WinCreateCursor( ) flags

 CURSOR_SOLID             :constant Long:=16#0000#;
 CURSOR_HALFTONE          :constant Long:=16#0001#;
 CURSOR_FRAME             :constant Long:=16#0002#;
 CURSOR_FLASH             :constant Long:=16#0004#;
 CURSOR_SETPOS            :constant Long:=16#8000#;

type CURSORINFO  is record    -- csri
   hwn       :HWND    ;
   x         :LONG    ;
   y         :LONG    ;
   cx        :LONG    ;
   cy        :LONG    ;
   fs        :ULONG   ;
   rclClip   :RECTL   ;
end record; -- CURSORINFO;
type PCURSORINFO  is access all CURSORINFO;

function WinQueryCursorInfo(hwndDesktop:HWND        ;
                            pCursorInf :PCURSORINFO )return BOOL32;
pragma Import(c,WinQueryCursorInfo, Link_name=>"_WinQueryCursorInfo");
end os2.pmcu;
