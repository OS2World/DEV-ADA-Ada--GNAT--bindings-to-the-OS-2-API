
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.Pmwb                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Base PM window function                               บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

with Os2.pmsc ;            use Os2.pmsc  ;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMwb is
pragma Preelaborate (PMwb);

--+ INCL_WINWINDOWMGR       General window management
--+ INCL_WINMESSAGEMGR      Message management
--+ INCL_WININPUT           Mouse and keyboard input
--+ INCL_WINDIALOGS         Dialog boxes
--+ INCL_WINSTATICS         Static controls
--+ INCL_WINBUTTONS         Button controls
--+ INCL_WINENTRYFIELDS     Entry Fields
--  INCL_WINMLE             Multiple Line Entry Fields
--+ INCL_WINLISTBOXES       List box controls
--+ INCL_WINMENUS           Menu controls
--+ INCL_WINSCROLLBARS      Scroll bar controls
--+ INCL_WINFRAMEMGR        Frame manager
--  INCL_WINFRAMECTLS       Frame controls (title bars & size border)
--  INCL_WINRECTANGLES      Rectangle routines
--  INCL_WINSYS             System values (and colors)
--  INCL_WINTIMER           Timer routines
--+ INCL_WINACCELERATORS    Keyboard accelerators
--  INCL_WINTRACKRECT       WinTrackRect() function
--  INCL_WINCLIPBOARD       Clipboard manager
--+ INCL_WINCURSORS         Text cursors
--+ INCL_WINPOINTERS        Mouse pointers
--  INCL_WINHOOKS           Hook manager
--+ INCL_WINSWITCHLIST      Shell Switch List API
--  INCL_WINPROGRAMLIST     Shell Program List API
--  INCL_WINSHELLDATA       Shell Data (?)
--  INCL_WINCOUNTRY         Country support
--  INCL_WINHEAP            Heap Manager
--  INCL_WINATOM            Atom Manager
--  INCL_WINERRORS          Error code definitions
--  INCL_NLS                DBCS window manager definition
--+ INCL_WINHELP            Help Manager definitions
--  INCL_WINSEI             Set Error Info API
--  INCL_WINLOAD            Load/Delete Library/Procedure
--  INCL_WINTYPES           Definitions for Datatypes
--  INCL_WINTHUNKAPI        Thunk Procedure API
--  INCL_WINDESKTOP         Desktop API
--

-- typedef VOID *MPARAM;    -- mp
-- typedef MPARAM *PMPARAM;   -- pmp
-- typedef VOID *MRESULT;   -- mres
-- typedef MRESULT *PMRESULT;  -- pmres

--   Macros to make an MPARAM from standard types.

-- #define MPVOID                     ((MPARAM)0L)
-- #define MPFROMP(p)                 ((MPARAM)((ULONG)(p)))
-- #define MPFROMHWND(hwnd)           ((MPARAM)(HWND)(hwnd))
-- #define MPFROMCHAR(ch)             ((MPARAM)(USHORT)(ch))
-- #define MPFROMSHORT(s)             ((MPARAM)(USHORT)(s))
-- #define MPFROM2SHORT(s1, s2)       ((MPARAM)MAKELONG(s1, s2))
-- #define MPFROMSH2CH(s, uch1, uch2) ((MPARAM)MAKELONG(s, MAKESHORT(uch1, uch2)))
-- #define MPFROMLONG(l)              ((MPARAM)(ULONG)(l))

--       Macros to extract standard types from an MPARAM
--
--  #define PVOIDFROMMP(mp)            ((VOID *)(mp))
--  #define HWNDFROMMP(mp)             ((HWND)(mp))
--  #define CHAR1FROMMP(mp)            ((UCHAR)(mp))
--  #define CHAR2FROMMP(mp)            ((UCHAR)((ULONG)mp >> 8))
--  #define CHAR3FROMMP(mp)            ((UCHAR)((ULONG)mp >> 16))
--  #define CHAR4FROMMP(mp)            ((UCHAR)((ULONG)mp >> 24))
--  #define SHORT1FROMMP(mp)           ((USHORT)(ULONG)(mp))
--  #define SHORT2FROMMP(mp)           ((USHORT)((ULONG)mp >> 16))
--  #define LONGFROMMP(mp)             ((ULONG)(mp))
--
--       Macros to make an MRESULT from standard types.
--
--  #define MRFROMP(p)                 ((MRESULT)(VOID *)(p))
--  #define MRFROMSHORT(s)             ((MRESULT)(USHORT)(s))
--  #define MRFROM2SHORT(s1, s2)       ((MRESULT)MAKELONG(s1, s2))
--  #define MRFROMLONG(l)              ((MRESULT)(ULONG)(l))
--
--       Macros to extract standard types from an MRESULT
--
--  #define PVOIDFROMMR( mr)            ( ( VOID *)( mr))
--  #define SHORT1FROMMR( mr)           ( ( USHORT)( (ULONG)mr))
--  #define SHORT2FROMMR( mr)           ( ( USHORT)( (ULONG)mr >> 16))
--  #define LONGFROMMR( mr)             ( ( ULONG)( mr))
--
--
--  This is the standard function definition for window procedures.
--  Typically they are names like "XxxxxxxxWndProc", where the prefix
--  "Xxxxxxxxx" is replaced by some name descriptive of the window procedure
--  being declared.  Window procedures must be EXPORTED in the definitions
--  file used by the linker.

 HWND_DESKTOP       :constant HWND:=1;
 HWND_OBJECT        :constant HWND:=2;
 HWND_TOP           :constant HWND:=3;
 HWND_BOTTOM        :constant HWND:=4;
 HWND_THREADCAPTURE :constant HWND:=5;

function  MyclassWndProc(hwn:HWND   ;   --window handle        --
                         msg:ULONG  ;   --message number       --
                         mp1:MPARAM ;  --1st ( packed) parms   --
                         mp2:MPARAM ) return Mresult;
pragma Import(c,MyclassWndProc, Link_name=>"MyclassWndProc");

--       Pointer to a window procedure function
--  typedef MRESULT ( Efunction FNWP)(:HWND;:ULONG;:MPARAM;:MPARAM)return

--       Standard Window Classes

--  #define WC_FRAME             ( ( PSZ)0xffff0001L)
--  #define WC_COMBOBOX          ( ( PSZ)0xffff0002L)
--  #define WC_BUTTON            ( ( PSZ)0xffff0003L)
--  #define WC_MENU              ( ( PSZ)0xffff0004L)
--  #define WC_STATIC            ( ( PSZ)0xffff0005L)
--  #define WC_ENTRYFIELD        ( ( PSZ)0xffff0006L)
--  #define WC_LISTBOX           ( ( PSZ)0xffff0007L)
--  #define WC_SCROLLBAR         ( ( PSZ)0xffff0008L)
--  #define WC_TITLEBAR          ( ( PSZ)0xffff0009L)
--  #define WC_MLE               ( ( PSZ)0xffff000AL)
--  -- 000B to 000F reserved
--  #define WC_APPSTAT           ( ( PSZ)0xffff0010L)
--  #define WC_KBDSTAT           ( ( PSZ)0xffff0011L)
--  #define WC_PECIC             ( ( PSZ)0xffff0012L)
--  #define WC_DBE_KKPOPUP       ( ( PSZ)0xffff0013L)
--  -- 0014 to 001F reserved
--  #define WC_SPINBUTTON        ( ( PSZ)0xffff0020L)
--  -- 0021 to 0024 reserved
--  #define WC_CONTAINER         ( ( PSZ)0xffff0025L)
--  #define WC_SLIDER            ( ( PSZ)0xffff0026L)
--  #define WC_VALUESET          ( ( PSZ)0xffff0027L)
--  #define WC_NOTEBOOK          ( ( PSZ)0xffff0028L)
--  -- 0029 to 002C used by PEN
--  #define WC_PENFIRST          ( ( PSZ)0xffff0029L)
--  #define WC_PENLAST           ( ( PSZ)0xffff002CL)
--  -- 002D to 0030 reserved
--  -- 0030 to 003F reserved
--  #define WC_MMPMFIRST         ( ( PSZ)0xffff0040L)
--  #define WC_MMPMLAST          ( ( PSZ):constant Ulong:=16#ffff004fL)

--       Standard Window Styles

 WS_VISIBLE                 :constant Ulong:=16#80000000#;
 WS_DISABLED                :constant Ulong:=16#40000000#;
 WS_CLIPCHILDREN            :constant Ulong:=16#20000000#;
 WS_CLIPSIBLINGS            :constant Ulong:=16#10000000#;
 WS_PARENTCLIP              :constant Ulong:=16#08000000#;
 WS_SAVEBITS                :constant Ulong:=16#04000000#;
 WS_SYNCPAINT               :constant Ulong:=16#02000000#;
 WS_MINIMIZED               :constant Ulong:=16#01000000#;
 WS_MAXIMIZED               :constant Ulong:=16#00800000#;
 WS_ANIMATE                 :constant Ulong:=16#00400000#;

--       Dialog manager styles

 WS_GROUP                   :constant Ulong:=16#00010000#;
 WS_TABSTOP                 :constant Ulong:=16#00020000#;
 WS_MULTISELECT             :constant Ulong:=16#00040000#;

--       Class styles

 CS_MOVENOTIFY              :constant Ulong:=16#00000001#;
 CS_SIZEREDRAW              :constant Ulong:=16#00000004#;
 CS_HITTEST                 :constant Ulong:=16#00000008#;
 CS_PUBLIC                  :constant Ulong:=16#00000010#;
 CS_FRAME                   :constant Ulong:=16#00000020#;
 CS_CLIPCHILDREN            :constant Ulong:=16#20000000#;
 CS_CLIPSIBLINGS            :constant Ulong:=16#10000000#;
 CS_PARENTCLIP              :constant Ulong:=16#08000000#;
 CS_SAVEBITS                :constant Ulong:=16#04000000#;
 CS_SYNCPAINT               :constant Ulong:=16#02000000#;

--       Window Manager Subsection part 1

function WinRegisterClass(ha          :HAB   ;
                          pszClassName:PSZ   ;
                          pfnWndProc  :PFNWP ;
                          flStyle     :ULONG ;
                          cbWindowData:ULONG )return  BOOL32;
pragma Import(c,WinRegisterClass, Link_name=>"_WinRegisterClass");

function WinDefWindowProc(hwn :HWND   ;
                          msg :ULONG  ;
                          mp1 :Mparam ;
                          mp2 :Mparam ) return Ulong;
pragma Import(c,WinDefWindowProc, Link_name=>"_WinDefWindowProc");

function WinDestroyWindow(hwn:HWND )return BOOL32 ;
pragma Import(c,WinDestroyWindow, Link_name=>"_WinDestroyWindow");

function WinShowWindow(hwn:HWND ; fShow:BOOL32 )return BOOL32;
pragma Import(c,WinShowWindow, Link_name=>"_WinShowWindow");

function WinQueryWindowRect(hwn     :HWND   ;
                            prclDest:PRECTL )return BOOL32;
pragma Import(c,WinQueryWindowRect, Link_name=>"_WinQueryWindowRect");

function WinGetPS(hwn:HWND )return HPS;
pragma Import(c,WinGetPS, Link_name=>"_WinGetPS");

function WinReleasePS(hp :HPS)return BOOL32 ;
pragma Import(c,WinReleasePS, Link_name=>"_WinReleasePS");

function WinEndPaint( hp :HPS)return BOOL32;
pragma Import(c,WinEndPaint, Link_name=>"_WinEndPaint");

function WinGetClipPS(hwn     :HWND  ;
                      hwndClip:HWND  ;
                      fl      :ULONG )return HPS ;
pragma Import(c,WinGetClipPS, Link_name=>"_WinGetClipPS");

function WinIsWindowShowing(hwn :HWND )return BOOL32;
pragma Import(c,WinIsWindowShowing, Link_name=>"_WinIsWindowShowing");

function WinBeginPaint(hwn      :HWND   ;
                       hp       :HPS    ;
                       prclPaint:PRECTL )return HPS;
pragma Import(c,WinBeginPaint, Link_name=>"_WinBeginPaint");

function WinOpenWindowDC(hwn :HWND )return HDC;
pragma Import(c,WinOpenWindowDC, Link_name=>"_WinOpenWindowDC");

function WinScrollWindow(hwn       :HWND   ;
                         dx        :LONG   ;
                         dy        :LONG   ;
                         prclScroll:PRECTL ;
                         prclClip  :PRECTL ;
                         hrgnUpdate:HRGN   ;
                         prclUpdate:PRECTL ;
                         rgfsw     :ULONG  )return LONG ;
pragma Import(c,WinScrollWindow, Link_name=>"_WinScrollWindow");

--          WinGetClipPS( ) flags
--
 PSF_LOCKWINDOWUPDATE       :constant Ulong:=16#0001#;
 PSF_CLIPUPWARDS            :constant Ulong:=16#0002#;
 PSF_CLIPDOWNWARDS          :constant Ulong:=16#0004#;
 PSF_CLIPSIBLINGS           :constant Ulong:=16#0008#;
 PSF_CLIPCHILDREN           :constant Ulong:=16#0010#;
 PSF_PARENTCLIP             :constant Ulong:=16#0020#;
--
--          WinScrollWindow( ) flags

 SW_SCROLLCHILDREN          :constant Ulong:=16#0001#;
 SW_INVALIDATERGN           :constant Ulong:=16#0002#;

function WinFillRect(hp    :HPS    ;
                     prcl  :PRECTL ;
                     lColor:LONG   )return BOOL32 ;
pragma Import(c,WinFillRect, Link_name=>"_WinFillRect");

--          WinInitialize/WinTerminate Interface declarations

type QVERSDATA  is record    -- qver
  environment    :USHORT   ;
  version        :USHORT   ;
end record; -- QVERSDATA;
type PQVERSDATA  is access all QVERSDATA;

 QV_OS2                     :constant Ulong:=16#0000#;
 QV_CMS                     :constant Ulong:=16#0001#;
 QV_TSO                     :constant Ulong:=16#0002#;
 QV_TSOBATCH                :constant Ulong:=16#0003#;
 QV_OS400                   :constant Ulong:=16#0004#;

function WinQueryVersion(ha:HAB )return ULONG;
pragma Import(c,WinQueryVersion, Link_name=>"_WinQueryVersion");

function WinInitialize( flOptions:ULONG)return HAB;
pragma Import(c,WinInitialize, Link_name=>"_WinInitialize");

function WinTerminate(ha :HAB )return BOOL32;
pragma Import(c,WinTerminate, Link_name=>"_WinTerminate");

function WinQueryAnchorBlock(hwn :HWND )return HAB;
pragma Import(c,WinQueryAnchorBlock, Link_name=>"_WinQueryAnchorBlock");

--        End of Window Manager COMMON section

function WinCreateWindow(hwndParent      :HWND  ;
                         pszClass        :PSZ   ;
                         pszName         :PSZ   ;
                         flStyle         :ULONG ;
                         x               :LONG  ;
                         y               :LONG  ;
                         cx              :LONG  ;
                         cy              :LONG  ;
                         hwndOwner       :HWND  ;
                         hwndInsertBehind:HWND  ;
                         id              :ULONG ;
                         pCtlData        :PVOID ;
                         pPresParams     :PVOID )return HWND;
pragma Import(c,WinCreateWindow, Link_name=>"_WinCreateWindow");

function WinEnableWindow(hwn    :HWND   ;
                         fEnable:BOOL32 )return BOOL;
pragma Import(c,WinEnableWindow, Link_name=>"_WinEnableWindow");

function WinIsWindowEnabled(hwn :HWND )return BOOL ;
pragma Import(c,WinIsWindowEnabled, Link_name=>"_WinIsWindowEnabled");

function WinEnableWindowUpdate(hwn    :HWND   ;
                               fEnable:BOOL32 )return BOOL ;
pragma Import(c,WinEnableWindowUpdate, Link_name=>"_WinEnableWindowUpdate");

function WinIsWindowVisible(hwn :HWND )return BOOL ;
pragma Import(c,WinIsWindowVisible, Link_name=>"_WinIsWindowVisible");

function WinQueryWindowText(hwn         :HWND ;
                            cchBufferMax:LONG ;
                            pchBuffer   :PCH  )return LONG;
pragma Import(c,WinQueryWindowText, Link_name=>"_WinQueryWindowText");

function WinSetWindowText(hwn    :HWND ;
                          pszText:PSZ  )return BOOL;
pragma Import(c,WinSetWindowText, Link_name=>"_WinSetWindowText");

function WinQueryWindowTextLength(hwn :HWND )return LONG ;
pragma Import(c,WinQueryWindowTextLength, Link_name=>"_WinQueryWindowTextLength");

function WinWindowFromID(hwndParent:HWND  ;
                         id        :ULONG )return HWND;
pragma Import(c,WinWindowFromID, Link_name=>"_WinWindowFromID");

function WinIsWindow(ha :HAB  ;
                     hwn:HWND  )return BOOL;
pragma Import(c,WinIsWindow, Link_name=>"_WinIsWindow");

function WinQueryWindow(hwn:HWND ;
                        cmd:LONG )return HWND;
pragma Import(c,WinQueryWindow, Link_name=>"_WinQueryWindow");

function WinMultWindowFromIDs(hwndParent:HWND  ;
                              prghwnd   :PHWND ;
                              idFirst   :ULONG ;
                              idLast    :ULONG )return LONG;
pragma Import(c,WinMultWindowFromIDs, Link_name=>"_WinMultWindowFromIDs");

--       WinQueryWindow( ) codes

 QW_NEXT        :constant ushort:= 0 ;
 QW_PREV        :constant ushort:= 1 ;
 QW_TOP         :constant ushort:= 2 ;
 QW_BOTTOM      :constant ushort:= 3 ;
 QW_OWNER       :constant ushort:= 4 ;
 QW_PARENT      :constant ushort:= 5 ;
 QW_NEXTTOP     :constant ushort:= 6 ;
 QW_PREVTOP     :constant ushort:= 7 ;
 QW_FRAMEOWNER  :constant ushort:= 8 ;

function WinSetParent(hwn          :HWND   ;
                      hwndNewParent:HWND   ;
                      fRedraw      :BOOL32 )return BOOL;
pragma Import(c,WinSetParent, Link_name=>"_WinSetParent");

function WinIsChild(hwn       :HWND ;
                    hwndParent:HWND )return BOOL;
pragma Import(c,WinIsChild, Link_name=>"_WinIsChild");

function WinSetOwner(hwn         :HWND ;
                     hwndNewOwner:HWND )return BOOL;
pragma Import(c,WinSetOwner, Link_name=>"_WinSetOwner");

function WinQueryWindowProcess(hwn :HWND ;
                               ppi :PPID ;
                               pti :PTID )return BOOL32 ;
pragma Import(c,WinQueryWindowProcess, Link_name=>"_WinQueryWindowProcess");

function WinQueryObjectWindow(hwndDesktop:HWND )return HWND ;
pragma Import(c,WinQueryObjectWindow, Link_name=>"_WinQueryObjectWindow");

function WinQueryDesktopWindow(ha:HAB  ;
                               hd:HDC  )return HWND;
pragma Import(c,WinQueryDesktopWindow, Link_name=>"_WinQueryDesktopWindow");

--    Window positioning functions

function WinSetWindowPos(hwn             :HWND ;
                         hwndInsertBehind:HWND ;
                         x               :LONG ;
                         y               :LONG ;
                         cx              :LONG ;
                         cy              :LONG ;
                          fl             :ULONG)return BOOL;
pragma Import(c,WinSetWindowPos, Link_name=>"_WinSetWindowPos");

function WinSetMultWindowPos(ha  :HAB   ;
                             psw :PSWP  ;
                             cswp:ULONG )return BOOL;
pragma Import(c,WinSetMultWindowPos, Link_name=>"_WinSetMultWindowPos");

function WinQueryWindowPos(hwn:HWND  ;
                           psw:PSWP  )return BOOL ;
pragma Import(c,WinQueryWindowPos, Link_name=>"_WinQueryWindowPos");

--   Values returned from WM_ADJUSTWINDOWPOS and passed to WM_WINDOWPOSCHANGED
--
 AWP_MINIMIZED              :constant Ulong:=16#00010000#;
 AWP_MAXIMIZED              :constant Ulong:=16#00020000#;
 AWP_RESTORED               :constant Ulong:=16#00040000#;
 AWP_ACTIVATE               :constant Ulong:=16#00080000#;
 AWP_DEACTIVATE             :constant Ulong:=16#00100000#;
--
--     WinSetWindowPos( ) flags
--
 SWP_SIZE                   :constant Ulong:=16#0001#;
 SWP_MOVE                   :constant Ulong:=16#0002#;
 SWP_ZORDER                 :constant Ulong:=16#0004#;
 SWP_SHOW                   :constant Ulong:=16#0008#;
 SWP_HIDE                   :constant Ulong:=16#0010#;
 SWP_NOREDRAW               :constant Ulong:=16#0020#;
 SWP_NOADJUST               :constant Ulong:=16#0040#;
 SWP_ACTIVATE               :constant Ulong:=16#0080#;
 SWP_DEACTIVATE             :constant Ulong:=16#0100#;
 SWP_EXTSTATECHANGE         :constant Ulong:=16#0200#;
 SWP_MINIMIZE               :constant Ulong:=16#0400#;
 SWP_MAXIMIZE               :constant Ulong:=16#0800#;
 SWP_RESTORE                :constant Ulong:=16#1000#;
 SWP_FOCUSACTIVATE          :constant Ulong:=16#2000#;
 SWP_FOCUSDEACTIVATE        :constant Ulong:=16#4000#;
 SWP_NOAUTOCLOSE            :constant Ulong:=16#8000#;  -- Valid in PROGDETAILS struct only
--
--     Window painting
--
function WinUpdateWindow(hwn :HWND )return BOOL;
pragma Import(c,WinUpdateWindow, Link_name=>"_WinUpdateWindow");

function WinInvalidateRect(hwn             :HWND   ;
                           pwrc            :PRECTL ;
                           fIncludeChildren:BOOL32 )return BOOL;
pragma Import(c,WinInvalidateRect, Link_name=>"_WinInvalidateRect");

function WinInvalidateRegion(hwn             :HWND   ;
                             hrg             :HRGN   ;
                             fIncludeChildren:BOOL32 )return BOOL;
pragma Import(c,WinInvalidateRegion, Link_name=>"_WinInvalidateRegion");

--  -- Drawing helpers

function WinInvertRect(hp  :HPS    ;
                       prcl:PRECTL )return BOOL;
pragma Import(c,WinInvertRect, Link_name=>"_WinInvertRect");

function WinDrawBitmap(hpsDst :HPS     ;
                       hbm    :HBITMAP ;
                       pwrcSrc:PRECTL  ;
                       pptlDst:PPOINTL ;
                       clrFore:LONG    ;
                       clrBack:LONG    ;
                       fl     :ULONG   )return BOOL;
pragma Import(c,WinDrawBitmap, Link_name=>"_WinDrawBitmap");

--  -- WinDrawBitmap( ) flags

 DBM_NORMAL                 :constant Ulong:=16#0000#;
 DBM_INVERT                 :constant Ulong:=16#0001#;
 DBM_HALFTONE               :constant Ulong:=16#0002#;
 DBM_STRETCH                :constant Ulong:=16#0004#;
 DBM_IMAGEATTRS             :constant Ulong:=16#0008#;

function WinDrawText(hp      :HPS    ;
                     cchText :LONG   ;
                     lpchText:PCH    ;
                     prcl    :PRECTL ;
                     clrFore :LONG   ;
                     clrBack :LONG   ;
                     flCmd   :ULONG  )return LONG;
pragma Import(c,WinDrawText, Link_name=>"_WinDrawText");

--  WinDrawText( ) codes:
--  From DT_LEFT to DT_EXTERNALLEADING; the codes are designed to be OR'ed with
--  SS_TEXT to create variations of the basic text static item.
--
 DT_LEFT                    :constant Ulong:=16#0000#;
 DT_QUERYEXTENT             :constant Ulong:=16#0002#;
 DT_UNDERSCORE              :constant Ulong:=16#0010#;
 DT_STRIKEOUT               :constant Ulong:=16#0020#;
 DT_TEXTATTRS               :constant Ulong:=16#0040#;
 DT_EXTERNALLEADING         :constant Ulong:=16#0080#;
 DT_CENTER                  :constant Ulong:=16#0100#;
 DT_RIGHT                   :constant Ulong:=16#0200#;
 DT_TOP                     :constant Ulong:=16#0000#;
 DT_VCENTER                 :constant Ulong:=16#0400#;
 DT_BOTTOM                  :constant Ulong:=16#0800#;
 DT_HALFTONE                :constant Ulong:=16#1000#;
 DT_MNEMONIC                :constant Ulong:=16#2000#;
 DT_WORDBREAK               :constant Ulong:=16#4000#;
 DT_ERASERECT               :constant Ulong:=16#8000#;

function WinDrawBorder(hp     :HPS    ;
                       prcl   :PRECTL ;
                       cx     :LONG   ;
                       cy     :LONG   ;
                       clrFore:LONG   ;
                       clrBack:LONG   ;
                       flCmd  :ULONG  )return BOOL;
pragma Import(c,WinDrawBorder, Link_name=>"_WinDrawBorder");

--     WinDrawBorder( ) flags
--
 DB_PATCOPY                 :constant Ulong:=16#0000#;
 DB_PATINVERT               :constant Ulong:=16#0001#;
 DB_DESTINVERT              :constant Ulong:=16#0002#;
 DB_AREAMIXMODE             :constant Ulong:=16#0003#;
 DB_ROP                     :constant Ulong:=16#0007#;
 DB_INTERIOR                :constant Ulong:=16#0008#;
 DB_AREAATTRS               :constant Ulong:=16#0010#;
 DB_STANDARD                :constant Ulong:=16#0100#;
 DB_DLGBORDER               :constant Ulong:=16#0200#;

--         Resource loading functions

function WinLoadString(ha       :HAB     ;
                       hmod     :HMODULE ;
                       id       :ULONG   ;
                       cchMax   :LONG    ;
                       pchBuffer:PSZ     )return LONG;
pragma Import(c,WinLoadString, Link_name=>"_WinLoadString");

function WinLoadMessage(ha       :HAB     ;
                        hmod     :HMODULE ;
                        id       :ULONG   ;
                        cchMax   :LONG    ;
                        pchBuffer:PSZ     )return LONG;
pragma Import(c,WinLoadMessage, Link_name=>"_WinLoadMessage");

--                        Window Manager Subsection part 2                  **--

function WinSetActiveWindow(hwndDesktop:HWND ;
                            hwn        :HWND )return BOOL32;
pragma Import(c,WinSetActiveWindow, Link_name=>"_WinSetActiveWindow");

--        WM_CREATE structure

type CREATESTRUCT is record     -- crst
   pPresParams         :PVOID   ;
   pCtlData            :PVOID   ;
   id                  :ULONG   ;
   hwndInsertBehind    :HWND    ;
   hwndOwner           :HWND    ;
   cy                  :LONG    ;
   cx                  :LONG    ;
   y                   :LONG    ;
   x                   :LONG    ;
   flStyle             :ULONG   ;
   pszText             :PSZ     ;
   pszClass            :PSZ     ;
   hwndParent          :HWND    ;
end record; -- CREATESTRUCT;
type PCREATESTRUCT  is access all CREATESTRUCT;

--        WinQueryClassInfo( ) structure

type CLASSINFO  is record  -- clsi
   flClassStyle     :ULONG   ;
   pfnWindowProc    :PFNWP   ;
   cbWindowData     :ULONG   ;
end record; -- CLASSINFO;
type PCLASSINFO  is access all CLASSINFO;

function WinSubclassWindow(hwn  :HWND  ;
                           pfnw :PFNWP )return PFNWP;
pragma Import(c,WinSubclassWindow, Link_name=>"_WinSubclassWindow");

function WinQueryClassName(hwn   :HWND ;
                           cchMax:LONG ;
                           pc    :PCH  )return LONG;
pragma Import(c,WinQueryClassName, Link_name=>"_WinQueryClassName");

function WinQueryClassInfo(ha          :HAB        ;
                           pszClassName:PSZ        ;
                           pClassInf   :PCLASSINFO )return BOOL32;
pragma Import(c,WinQueryClassInfo, Link_name=>"_WinQueryClassInfo");

function WinQueryActiveWindow(hwndDesktop:HWND )return HWND;
pragma Import(c,WinQueryActiveWindow, Link_name=>"_WinQueryActiveWindow");

function WinIsThreadActive(ha :HAB )return BOOL32;
pragma Import(c,WinIsTHreadActive, Link_name=>"_WinIsTHreadActive");

function WinQuerySysModalWindow(hwndDesktop:HWND )return HWND;
pragma Import(c,WinQuerySysModalWindow, Link_name=>"_WinQuerySysModalWindow");

function WinSetSysModalWindow(hwndDesktop:HWND ;
                              hwn        :HWND )return BOOL32  ;
pragma Import(c,WinSetSysModalWindow, Link_name=>"_WinSetSysModalWindow");

function WinQueryWindowUShort(hwn  :HWND ;
                              index:LONG )return USHORT;
pragma Import(c,WinQueryWindowUShort, Link_name=>"_WinQueryWindowUShort");

function WinSetWindowUShort(hwn  :HWND   ;
                            index:LONG   ;
                            us   :USHORT )return BOOL32  ;
pragma Import(c,WinSetWindowUShort, Link_name=>"_WinSetWindowUShort");

function WinQueryWindowULong(hwn  :HWND ;
                             index:LONG )return ULONG ;
pragma Import(c,WinQueryWindowULong, Link_name=>"_WinQueryWindowULong");

function WinSetWindowULong(hwn  :HWND  ;
                           index:LONG  ;
                           ul   :ULONG )return BOOL32  ;
pragma Import(c,WinSetWindowULong, Link_name=>"_WinSetWindowULong");

function WinQueryWindowPtr(hwn  :HWND ;
                           index:LONG )return PVOID ;
pragma Import(c,WinQueryWindowPtr, Link_name=>"_WinQueryWindowPtr");

function WinSetWindowPtr(hwn  :HWND ;
                         index:LONG ;
                          p   :PVOID)return BOOL32  ;
pragma Import(c,WinSetWindowPtr, Link_name=>"_WinSetWindowPtr");

function WinSetWindowBits(hwn   :HWND  ;
                          index :LONG  ;
                          flData:ULONG ;
                          flMask:ULONG )return BOOL32  ;
pragma Import(c,WinSetWindowBits, Link_name=>"_WinSetWindowBits");

--             Standard WinQueryWindowUShort/ULong( ) indices

 QWS_USER    :constant Long:= 0   ;
 QWS_ID      :constant Long:=   -1;
 QWS_MIN     :constant Long:=   -1;
 QWL_USER    :constant Long:= 0   ;
 QWL_STYLE   :constant Long:=   -2;
 QWP_PFNWP   :constant Long:=   -3;
 QWL_HMQ     :constant Long:=   -4;
 QWL_RESERVED:constant Long:=   -5;
 QWL_PENDATA :constant Long:=   -7;
 QWL_MIN     :constant Long:=   -7;
--
--             WC_FRAME WinQueryWindowUShort/ULong( ) indices
 QWL_HHEAP                  :constant Ulong:=16#0004#;
 QWL_HWNDFOCUSSAVE          :constant Ulong:=16#0018#;
 QWL_DEFBUTTON              :constant Ulong:=16#0040#;
 QWL_PSSCBLK                :constant Ulong:=16#0048#;
 QWL_PFEPBLK                :constant Ulong:=16#004c#;
 QWL_PSTATBLK               :constant Ulong:=16#0050#;
 QWS_FLAGS                  :constant Ulong:=16#0008#;
 QWS_RESULT                 :constant Ulong:=16#000a#;
 QWS_XRESTORE               :constant Ulong:=16#000c#;
 QWS_YRESTORE               :constant Ulong:=16#000e#;
 QWS_CXRESTORE              :constant Ulong:=16#0010#;
 QWS_CYRESTORE              :constant Ulong:=16#0012#;
 QWS_XMINIMIZE              :constant Ulong:=16#0014#;
 QWS_YMINIMIZE              :constant Ulong:=16#0016#;
--
--                  Window enumeration
subtype HENUM is LHANDLE   ;  -- henum

function WinBeginEnumWindows(hwn :HWND )return HENUM;
pragma Import(c,WinBeginEnumWindows, Link_name=>"_WinBeginEnumWindows");

function WinGetNextWindow( hen :HENUM )return HWND ;
pragma Import(c,WinGetNextWindow, Link_name=>"_WinGetNextWindow");

function WinEndEnumWindows(hen :HENUM  )return BOOL32 ;
pragma Import(c,WinEndEnumWindows, Link_name=>"_WinEndEnumWindows");

function WinWindowFromPoint(hwn      :HWND    ;
                            pptl     :PPOINTL ;
                            fChildren:BOOL32  )return HWND ;
pragma Import(c,WinWindowFromPoint, Link_name=>"_WinWindowFromPoint");

function WinMapWindowPoints(hwndFrom:HWND    ;
                            hwndTo  :HWND    ;
                            prgptl  :PPOINTL ;
                            cwpt    :LONG    )return BOOL32 ;
pragma Import(c,WinMapWindowPoints, Link_name=>"_WinMapWindowPoints");

--                 More window painting  functions

function WinValidateRect(hwn             :HWND   ;
                         prcl            :PRECTL ;
                         fIncludeChildren:BOOL32 )return BOOL32 ;
pragma Import(c,WinValidateRect, Link_name=>"_WinValidateRect");

function WinValidateRegion(hwn             :HWND   ;
                           hrg             :HRGN   ;
                           fIncludeChildren:BOOL32 )return BOOL32 ;
pragma Import(c,WinValidateRegion, Link_name=>"_WinValidateRegion");

function WinWindowFromDC(hd :HDC )return HWND ;
pragma Import(c,WinWindowFromDC, Link_name=>"_WinWindowFromDC");

function WinQueryWindowDC(hwn :HWND )return HDC  ;
pragma Import(c,WinQueryWindowDC, Link_name=>"_WinQueryWindowDC");

function WinGetScreenPS(hwndDesktop:HWND )return HPS  ;
pragma Import(c,WinGetScreenPS, Link_name=>"_WinGetScreenPS");

function WinLockWindowUpdate(hwndDesktop   :HWND ;
                             hwndLockUpdate:HWND )return BOOL32 ;
pragma Import(c,WinLockWindowUpdate, Link_name=>"_WinLockWindowUpdate");

function WinLockVisRegions(hwndDesktop:HWND   ;
                           fLock      :BOOL32 )return BOOL32 ;
pragma Import(c,WinLockVisRegions, Link_name=>"_WinLockVisRegions");

function WinQueryUpdateRect(hwn :HWND   ;
                            prcl:PRECTL )return BOOL32 ;
pragma Import(c,WinQueryUpdateRect, Link_name=>"_WinQueryUpdateRect");

function WinQueryUpdateRegion(hwn:HWND ;
                              hrg:HRGN )return LONG;
pragma Import(c,WinQueryUpdateRegion, Link_name=>"_WinQueryUpdateRegion");

function WinExcludeUpdateRegion(hp :HPS  ;
                                hwn:HWND )return LONG;
pragma Import(c,WinExcludeUpdateRegion, Link_name=>"_WinExcludeUpdateRegion");

--          Standard Window Messages
 WM_NULL                    : constant Ulong := 16#0000# ;
 WM_CREATE                  : constant Ulong := 16#0001# ;
 WM_DESTROY                 : constant Ulong := 16#0002# ;
 WM_ENABLE                  : constant Ulong := 16#0004# ;
 WM_SHOW                    : constant Ulong := 16#0005# ;
 WM_MOVE                    : constant Ulong := 16#0006# ;
 WM_SIZE                    : constant Ulong := 16#0007# ;
 WM_ADJUSTWINDOWPOS         : constant Ulong := 16#0008# ;
 WM_CALCVALIDRECTS          : constant Ulong := 16#0009# ;
 WM_SETWINDOWPARAMS         : constant Ulong := 16#000a# ;
 WM_QUERYWINDOWPARAMS       : constant Ulong := 16#000b# ;
 WM_HITTEST                 : constant Ulong := 16#000c# ;
 WM_ACTIVATE                : constant Ulong := 16#000d# ;
 WM_SETFOCUS                : constant Ulong := 16#000f# ;
 WM_SETSELECTION            : constant Ulong := 16#0010# ;
--
--        language support Winproc
 WM_PPAINT               : constant Ulong := 16#0011# ;
 WM_PSETFOCUS            : constant Ulong := 16#0012# ;
 WM_PSYSCOLORCHANGE      : constant Ulong := 16#0013# ;
 WM_PSIZE                : constant Ulong := 16#0014# ;
 WM_PACTIVATE            : constant Ulong := 16#0015# ;
 WM_PCONTROL             : constant Ulong := 16#0016# ;
 WM_COMMAND              : constant Ulong := 16#0020# ;
 WM_SYSCOMMAND           : constant Ulong := 16#0021# ;
 WM_HELP                 : constant Ulong := 16#0022# ;
 WM_PAINT                : constant Ulong := 16#0023# ;
 WM_TIMER                : constant Ulong := 16#0024# ;
 WM_SEM1                 : constant Ulong := 16#0025# ;
 WM_SEM2                 : constant Ulong := 16#0026# ;
 WM_SEM3                 : constant Ulong := 16#0027# ;
 WM_SEM4                 : constant Ulong := 16#0028# ;
 WM_CLOSE                : constant Ulong := 16#0029# ;
 WM_QUIT                 : constant Ulong := 16#002a# ;
 WM_SYSCOLORCHANGE       : constant Ulong := 16#002b# ;
 WM_SYSVALUECHANGED      : constant Ulong := 16#002d# ;
 WM_APPTERMINATENOTIFY   : constant Ulong := 16#002e# ;
 WM_PRESPARAMCHANGED     : constant Ulong := 16#002f# ;
--
--     -- Control notification messages
 WM_CONTROL              : constant Ulong := 16#0030# ;
 WM_VSCROLL              : constant Ulong := 16#0031# ;
 WM_HSCROLL              : constant Ulong := 16#0032# ;
 WM_INITMENU             : constant Ulong := 16#0033# ;
 WM_MENUSELECT           : constant Ulong := 16#0034# ;
 WM_MENUEND              : constant Ulong := 16#0035# ;
 WM_DRAWITEM             : constant Ulong := 16#0036# ;
 WM_MEASUREITEM          : constant Ulong := 16#0037# ;
 WM_CONTROLPOINTER       : constant Ulong := 16#0038# ;
 WM_QUERYDLGCODE         : constant Ulong := 16#003a# ;
 WM_INITDLG              : constant Ulong := 16#003b# ;
 WM_SUBSTITUTESTRING     : constant Ulong := 16#003c# ;
 WM_MATCHMNEMONIC        : constant Ulong := 16#003d# ;
 WM_SAVEAPPLICATION      : constant Ulong := 16#003e# ;
--
--     --***********************************************************************--
--     --Reserve a range of messages for help manager.  This range includes
--     --public messages; defined below; and private ones; which need to be
--     --reserved here to prevent clashing with application messages
--
 WM_HELPBASE    : constant Ulong := 16#0F00#; -- Start of msgs for help manager
 WM_HELPTOP     : constant Ulong := 16#0FFF#; -- End of msgs for help manager
 WM_USER        : constant Ulong := 16#1000#;

--          WM_COMMAND msg source codes
 CMDSRC_PUSHBUTTON  :constant ulong:=    1 ;
 CMDSRC_MENU        :constant ulong:=    2 ;
 CMDSRC_ACCELERATOR :constant ulong:=    3 ;
 CMDSRC_FONTDLG     :constant ulong:=    4 ;
 CMDSRC_FILEDLG     :constant ulong:=    5 ;
 CMDSRC_PRINTDLG    :constant ulong:=    6 ;
 CMDSRC_COLORDLG    :constant ulong:=    7 ;
 CMDSRC_OTHER       :constant ulong:=    0 ;

--       The following structure and macro are used to access the
--       WM_COMMAND; WM_HELP; and WM_SYSCOMMAND message parameters:
--
type CMDMSG  is record    -- commandmsg
  cmd       :USHORT  ;           -- mp1
  unused    :USHORT  ;
  source    :USHORT  ;           -- mp2
  fMouse    :USHORT  ;
end record; -- CMDMSG;
type PCMDMSG  is access all CMDMSG;

--     The following structure is used by the WinQueryQueueInfo( ) routine

type MQINFO  is record    -- mqi
   cb           :ULONG   ;
   pi           :PID     ;
   ti           :TID     ;
   cmsgs        :ULONG   ;
   pReserved    :PVOID   ;
end record; -- MQINFO;
type PMQINFO  is access all MQINFO;

function   WinSendMsg(hwn:HWND   ;
                      msg:ULONG  ;
                      mp1:MPARAM ;
                      mp2:Menuitem) return Long   ;
pragma Import(c,WinSendMsg, Link_name=>"_WinSendMsg");

function   WinSendMsg(hwn:HWND   ;
                      msg:ULONG  ;
                      mp1:MPARAM ;
                      mp2:MPARAM ) return Long   ;
pragma Import(c,WinSendMsg, Link_name=>"_WinSendMsg");

function WinCreateMsgQueue(ha  :HAB  ;
                           cmsg:LONG )return HMQ    ;
pragma Import(c,WinCreateMsgQueue, Link_name=>"_WinCreateMsgQueue");

function WinDestroyMsgQueue(hm:HMQ)return BOOL32   ;
pragma Import(c,WinDestroyMsgQueue, Link_name=>"_WinDestroyMsgQueue");

function WinQueryQueueInfo(hm    :HMQ     ;
                           pmqi  :PMQINFO ;
                           cbCopy:ULONG   )return BOOL32   ;
pragma Import(c,WinQueryQueueInfo, Link_name=>"_WinQueryQueueInfo");

function WinCancelShutdown(hm           :HMQ    ;
                           fCancelAlways:BOOL32 )return BOOL32   ;
pragma Import(c,WinCancelShutdown, Link_name=>"_WinCancelShutdown");

function WinGetMsg(ha            :HAB   ;
                   pqms          :PQMSG ;
                   hwndFilter    :HWND  ;
                   msgFilterFirst:ULONG ;
                   msgFilterLast :ULONG )return BOOL32   ;
pragma Import(c,WinGetMsg, Link_name=>"_WinGetMsg");

function WinPeekMsg(ha            :HAB   ;
                    pqms          :PQMSG ;
                    hwndFilter    :HWND  ;
                    msgFilterFirst:ULONG ;
                    msgFilterLast :ULONG ;
                    fl            :ULONG )return BOOL32   ;
pragma Import(c,WinPeekMsg, Link_name=>"_WinPeekMsg");

function  WinDispatchMsg(ha  :HAB   ;
                         pqms:PQMSG ) return Mresult;
pragma Import(c,WinDispatchMsg, Link_name=>"_WinDispatchMsg");

function WinPostMsg(hwn:HWND   ;
                    msg:ULONG  ;
                    mp1:MPARAM ;
                    mp2:MPARAM )return BOOL32   ;
pragma Import(c,WinPostMsg, Link_name=>"_WinPostMsg");

function WinRegisterUserMsg(ha       :HAB   ;
                            msgid    :ULONG ;
                            datatype1:LONG  ;
                            dir1     :LONG  ;
                            datatype2:LONG  ;
                            dir2     :LONG  ;
                            datatyper:LONG  )return BOOL32   ;
pragma Import(c,WinRegisterUserMsg, Link_name=>"_WinRegisterUserMsg");

function WinRegisterUserDatatype(ha      :HAB   ;
                                 datatype:LONG  ;
                                 count   :LONG  ;
                                 types   :PLONG )return BOOL32   ;
pragma Import(c,WinRegisterUserDatatype, Link_name=>"_WinRegisterUserDatatype");

function WinSetMsgMode(ha       :HAB  ;
                       classname:PSZ  ;
                       control  :LONG )return BOOL32   ;
pragma Import(c,WinSetMsgMode, Link_name=>"_WinSetMsgMode");

function WinSetSynchroMode(ha  :HAB  ;
                           mode:LONG )return BOOL32   ;
pragma Import(c,WinSetSynchroMode, Link_name=>"_WinSetSynchroMode");

--          WinPeekMsg( ) constants
 PM_REMOVE                  : constant Long := 16#0001#;
 PM_NOREMOVE                : constant Long := 16#0000#;

--          WinRegisterUserDatatype datatypes defined in separate file
--        #include <pmtypes.h>  constants

--          WinRegisterUserMsg direction codes
 RUM_IN    : constant Long := 1;
 RUM_OUT   : constant Long := 2;
 RUM_INOUT : constant Long := 3;
--
--          WinSetMsgMode constants
 SMD_DELAYED                : constant Long := 16#0001#;
 SMD_IMMEDIATE              : constant Long := 16#0002#;
--
--          WinSetSynchroMode constants
 SSM_SYNCHRONOUS            : constant Long := 16#0001#;
 SSM_ASYNCHRONOUS           : constant Long := 16#0002#;
 SSM_MIXED                  : constant Long := 16#0003#;
--
--          WM_CALCVALIDRECTS return flags
 CVR_ALIGNLEFT               : constant Long := 16#0001#;
 CVR_ALIGNBOTTOM             : constant Long := 16#0002#;
 CVR_ALIGNRIGHT              : constant Long := 16#0004#;
 CVR_ALIGNTOP                : constant Long := 16#0008#;
 CVR_REDRAW                  : constant Long := 16#0010#;
--
--          WM_HITTEST return codes
 HT_NORMAL           : constant Long :=        0 ;
 HT_TRANSPARENT      : constant Long :=         -1;
 HT_DISCARD          : constant Long :=         -2;
 HT_ERROR            : constant Long :=         -3;
--
--          WM_SET/QUERYWINDOWPARAMS structures and flags

type WNDPARAMS   is record   -- wprm
   fsStatus        :ULONG   ;
   cchText         :ULONG   ;
   pszText         :PSZ     ;
   cbPresParams    :ULONG   ;
   pPresParams     :PVOID   ;
   cbCtlData       :ULONG   ;
   pCtlData        :PVOID   ;
end record; -- WNDPARAMS;
type PWNDPARAMS  is access all WNDPARAMS;

 WPM_TEXT                   : constant Long := 16#0001#;
 WPM_CTLDATA                : constant Long := 16#0002#;
 WPM_PRESPARAMS             : constant Long := 16#0004#;
 WPM_CCHTEXT                : constant Long := 16#0008#;
 WPM_CBCTLDATA              : constant Long := 16#0010#;
 WPM_CBPRESPARAMS           : constant Long := 16#0020#;

function WinInSendMsg(ha:HAB  )return BOOL32   ;
pragma Import(c,WinInSendMsg, Link_name=>"_WinInSendMsg");

function WinBroadcastMsg(hwn:HWND   ;
                         msg:ULONG  ;
                         mp1:MPARAM ;
                         mp2:MPARAM ;
                         rgf:ULONG  )return BOOL32   ;
pragma Import(c,WinBroadcastMsg, Link_name=>"_WinBroadcastMsg");

--          WinBroadcastMsg codes
 BMSG_POST                  : constant Long := 16#0000#;
 BMSG_SEND                  : constant Long := 16#0001#;
 BMSG_POSTQUEUE             : constant Long := 16#0002#;
 BMSG_DESCENDANTS           : constant Long := 16#0004#;
 BMSG_FRAMEONLY             : constant Long := 16#0008#;

function WinWaitMsg(ha      :HAB   ;
                    msgFirst:ULONG ;
                    msgLast :ULONG )return BOOL32 ;
pragma Import(c,WinWaitMsg, Link_name=>"_WinWaitMsg");

function WinQueryQueueStatus(hwndDesktop:HWND )return ULONG;
pragma Import(c,WinQueryQueueStatus, Link_name=>"_WinQueryQueueStatus");

--             WinQueryQueueStatus( ) constants
 QS_KEY                     : constant Long := 16#0001#;
 QS_MOUSEBUTTON             : constant Long := 16#0002#;
 QS_MOUSEMOVE               : constant Long := 16#0004#;
 QS_MOUSE                   : constant Long := 16#0006#; -- QS_MOUSEMOVE|QS_MOUSEBUTTON
 QS_TIMER                   : constant Long := 16#0008#;
 QS_PAINT                   : constant Long := 16#0010#;
 QS_POSTMSG                 : constant Long := 16#0020#;
 QS_SEM1                    : constant Long := 16#0040#;
 QS_SEM2                    : constant Long := 16#0080#;
 QS_SEM3                    : constant Long := 16#0100#;
 QS_SEM4                    : constant Long := 16#0200#;
 QS_SENDMSG                 : constant Long := 16#0400#;
 QS_MSGINPUT                : constant Long := 16#0800#;

function WinQueryMsgPos(ha  :HAB     ;
                        pptl:PPOINTL )return BOOL32 ;
pragma Import(c,WinQueryMsgPos, Link_name=>"_WinQueryMsgPos");

function WinQueryMsgTime(ha :HAB )return ULONG;
pragma Import(c,WinQueryMsgTime, Link_name=>"_WinQueryMsgTime");

subtype  HEV   is ULONG ;    -- hev
subtype  HMTX  is ULONG ;   -- hmtx
subtype  HMUX  is ULONG ;   -- hmux

function WinWaitEventSem(hv       :HEV   ;
                         ulTimeout:ULONG )return APIRET;
pragma Import(c,WinWaitEventSem, Link_name=>"_WinWaitEventSem");

function WinRequestMutexSem(hmt      :HMTX  ;
                            ulTimeout:ULONG )return APIRET;
pragma Import(c,WinRequestMutexSem, Link_name=>"_WinRequestMutexSem");

function WinWaitMuxWaitSem(hmx      :HMUX   ;
                           ulTimeout:ULONG  ;
                           pulUser  :PULONG )return APIRET;
pragma Import(c,WinWaitMuxWaitSem, Link_name=>"_WinWaitMuxWaitSem");

function WinPostQueueMsg(hm :HMQ    ;
                         msg:ULONG  ;
                         mp1:MPARAM ;
                         mp2:MPARAM )return BOOL32 ;
pragma Import(c,WinPostQueueMsg, Link_name=>"_WinPostQueueMsg");

--          WinSetMsgInterest( )/WinSetClassMsgInterest( ) constants
 SMIM_ALL                   : constant Long := 16#0EFF#;
 SMI_NOINTEREST             : constant Long := 16#0001#;
 SMI_INTEREST               : constant Long := 16#0002#;
 SMI_RESET                  : constant Long := 16#0004#;
 SMI_AUTODISPATCH           : constant Long := 16#0008#;

function WinSetMsgInterest(hwn      :HWND  ;
                           msg_class:ULONG ;
                           control  :LONG  )return BOOL32 ;
pragma Import(c,WinSetMsgInterest, Link_name=>"_WinSetMsgInterest");

function WinSetClassMsgInterest(ha          :HAB   ;
                                pszClassName:PSZ   ;
                                msg_class   :ULONG ;
                                control     :LONG  )return BOOL32 ;
pragma Import(c,WinSetClassMsgInterest, Link_name=>"_WinSetClassMsgInterest");

end os2.PMwb;
