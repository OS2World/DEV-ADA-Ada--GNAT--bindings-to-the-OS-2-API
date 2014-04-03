
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PMwd                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             PM Window dialog                                      บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

with Os2.pmsc ;            use Os2.pmsc;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMwd is
pragma Preelaborate (PMwd);
--
--             Keyboard and mouse
--       Keyboard and mouse input COMMON subsection

function WinSetFocus(hwndDesktop :HWND ;
                     hwndSetFocus:HWND )return BOOL32 ;
pragma Import(c,WinSetFocus, Link_name=>"_WinSetFocus");

function WinFocusChange(hwndDesktop  :HWND  ;
                        hwndSetFocus :HWND  ;
                        flFocusChange:ULONG )return BOOL32 ;
pragma Import(c,WinFocusChange, Link_name=>"_WinFocusChange");

function WinLockupSystem(ha:HAB )return BOOL32;
pragma Import(c,WinLockupSystem, Link_name=>"_WinLockupSystem");

function WinUnlockSystem(ha :HAB ; pszPassword:PSZ)return BOOL32;
pragma Import(c,WinUnlockSystem, Link_name=>"_WinUnlockSystem");

 FC_NOSETFOCUS              :constant Ulong:=16#0001#;
 FC_NOBRINGTOTOP            :constant Ulong:=16#0001#;
 FC_NOLOSEFOCUS             :constant Ulong:=16#0002#;
 FC_NOBRINGTOPFIRSTWINDOW   :constant Ulong:=16#0002#;
 FC_NOSETACTIVE             :constant Ulong:=16#0004#;
 FC_NOLOSEACTIVE            :constant Ulong:=16#0008#;
 FC_NOSETSELECTION          :constant Ulong:=16#0010#;
 FC_NOLOSESELECTION         :constant Ulong:=16#0020#;
 QFC_NEXTINCHAIN            :constant Ulong:=16#0001#;
 QFC_ACTIVE                 :constant Ulong:=16#0002#;
 QFC_FRAME                  :constant Ulong:=16#0003#;
 QFC_SELECTACTIVE           :constant Ulong:=16#0004#;
 QFC_PARTOFCHAIN            :constant Ulong:=16#0005#;

--       Keyboard and mouse input COMMON subsection

function WinSetCapture(hwndDesktop:HWND ;
                       hwn        :HWND )return BOOL32 ;
pragma Import(c,WinSetCapture, Link_name=>"_WinSetCapture");

function WinQueryCapture(hwndDesktop:HWND )return HWND ;
pragma Import(c,WinQueryCapture, Link_name=>"_WinQueryCapture");

function WinCheckInput(ha :HAB )return BOOL32 ;
pragma Import(c,WinCheckInput, Link_name=>"_WinCheckInput");

--          Mouse input messages
 WM_MOUSEFIRST           :constant Ulong:=16#0070#;
 WM_MOUSELAST            :constant Ulong:=16#0079#;
 WM_BUTTONCLICKFIRST     :constant Ulong:=16#0071#;
 WM_BUTTONCLICKLAST      :constant Ulong:=16#0079#;
 WM_MOUSEMOVE            :constant Ulong:=16#0070#;
 WM_BUTTON1DOWN          :constant Ulong:=16#0071#;
 WM_BUTTON1UP            :constant Ulong:=16#0072#;
 WM_BUTTON1DBLCLK        :constant Ulong:=16#0073#;
 WM_BUTTON2DOWN          :constant Ulong:=16#0074#;
 WM_BUTTON2UP            :constant Ulong:=16#0075#;
 WM_BUTTON2DBLCLK        :constant Ulong:=16#0076#;
 WM_BUTTON3DOWN          :constant Ulong:=16#0077#;
 WM_BUTTON3UP            :constant Ulong:=16#0078#;
 WM_BUTTON3DBLCLK        :constant Ulong:=16#0079#;
 WM_MOUSEMAP             :constant Ulong:=16#007D#;
 WM_EXTMOUSEFIRST        :constant Ulong:=16#0410#;
 WM_EXTMOUSELAST         :constant Ulong:=16#0419#;
 WM_CHORD                :constant Ulong:=16#0410#;
 WM_BUTTON1MOTIONSTART   :constant Ulong:=16#0411#;
 WM_BUTTON1MOTIONEND     :constant Ulong:=16#0412#;
 WM_BUTTON1CLICK         :constant Ulong:=16#0413#;
 WM_BUTTON2MOTIONSTART   :constant Ulong:=16#0414#;
 WM_BUTTON2MOTIONEND     :constant Ulong:=16#0415#;
 WM_BUTTON2CLICK         :constant Ulong:=16#0416#;
 WM_BUTTON3MOTIONSTART   :constant Ulong:=16#0417#;
 WM_BUTTON3MOTIONEND     :constant Ulong:=16#0418#;
 WM_BUTTON3CLICK         :constant Ulong:=16#0419#;
--
--           Messages 16#041A#  16#041F# are reserved
--
 WM_MOUSETRANSLATEFIRST  :constant Ulong:=16#0420#;
 WM_MOUSETRANSLATELAST   :constant Ulong:=16#0428#;
 WM_BEGINDRAG            :constant Ulong:=16#0420#;
 WM_ENDDRAG              :constant Ulong:=16#0421#;
 WM_SINGLESELECT         :constant Ulong:=16#0422#;
 WM_OPEN                 :constant Ulong:=16#0423#;
 WM_CONTEXTMENU          :constant Ulong:=16#0424#;
 WM_CONTEXTHELP          :constant Ulong:=16#0425#;
 WM_TEXTEDIT             :constant Ulong:=16#0426#;
 WM_BEGINSELECT          :constant Ulong:=16#0427#;
 WM_ENDSELECT            :constant Ulong:=16#0428#;
 WM_PENFIRST             :constant Ulong:=16#04C0#;
 WM_PENLAST              :constant Ulong:=16#04FF#;
 WM_MMPMFIRST            :constant Ulong:=16#0500#;
 WM_MMPMLAST             :constant Ulong:=16#05FF#;

function WinQueryFocus(hwndDesktop:HWND )return HWND ;
pragma Import(c,WinQueryFocus, Link_name=>"_WinQueryFocus");

--          Key/Character input messages
 WM_CHAR                    :constant Ulong:=16#007a#;
 WM_VIOCHAR                 :constant Ulong:=16#007b#;
--
--        WM_CHAR fs field bits
 KC_NONE                    :constant Ulong:=16#0000#;   -- Reserved
 KC_CHAR                    :constant Ulong:=16#0001#;
 KC_VIRTUALKEY              :constant Ulong:=16#0002#;
 KC_SCANCODE                :constant Ulong:=16#0004#;
 KC_SHIFT                   :constant Ulong:=16#0008#;
 KC_CTRL                    :constant Ulong:=16#0010#;
 KC_ALT                     :constant Ulong:=16#0020#;
 KC_KEYUP                   :constant Ulong:=16#0040#;
 KC_PREVDOWN                :constant Ulong:=16#0080#;
 KC_LONEKEY                 :constant Ulong:=16#0100#;
 KC_DEADKEY                 :constant Ulong:=16#0200#;
 KC_COMPOSITE               :constant Ulong:=16#0400#;
 KC_INVALIDCOMP             :constant Ulong:=16#0800#;
 KC_TOGGLE                  :constant Ulong:=16#1000#;
 KC_INVALIDCHAR             :constant Ulong:=16#2000#;
 KC_DBCSRSRVD1              :constant Ulong:=16#4000#;
 KC_DBCSRSRVD2              :constant Ulong:=16#8000#;

--
--       The following structure and macro are used to access the
--       WM_MOUSEMOVE; and WM_BUTTON message parameters
--
type MSEMSG   is record   -- mousemsg
  x               :SHORT   ;  -- mp1
  y               :SHORT   ;
  codeHitTest     :USHORT  ;   -- mp2
  fsInp           :USHORT  ;   -- input flags
end record; -- MSEMSG;
type PMSEMSG  is access all MSEMSG;

type CHRMSG   is record   -- charmsg
    fs         :USHORT  ;       -- mp1
    cRepeat    :UCHAR   ;
    scancode   :UCHAR   ;
    chr        :USHORT  ;        -- mp2
    vkey       :USHORT  ;
end record; -- CHRMSG;
type PCHRMSG  is access all CHRMSG;

 INP_NONE                   :constant Ulong:=16#0000#;
 INP_KBD                    :constant Ulong:=16#0001#;
 INP_MULT                   :constant Ulong:=16#0002#;
 INP_RES2                   :constant Ulong:=16#0004#;
 INP_SHIFT                  :constant Ulong:=16#0008#;
 INP_CTRL                   :constant Ulong:=16#0010#;
 INP_ALT                    :constant Ulong:=16#0020#;
 INP_RES3                   :constant Ulong:=16#0040#;
 INP_RES4                   :constant Ulong:=16#0080#;
 INP_IGNORE                 :constant Ulong:=16#FFFF#;
--
--          Virtual key values
 VK_BUTTON1                 :constant Ulong:=16#01#;
 VK_BUTTON2                 :constant Ulong:=16#02#;
 VK_BUTTON3                 :constant Ulong:=16#03#;
 VK_BREAK                   :constant Ulong:=16#04#;
 VK_BACKSPACE               :constant Ulong:=16#05#;
 VK_TAB                     :constant Ulong:=16#06#;
 VK_BACKTAB                 :constant Ulong:=16#07#;
 VK_NEWLINE                 :constant Ulong:=16#08#;
 VK_SHIFT                   :constant Ulong:=16#09#;
 VK_CTRL                    :constant Ulong:=16#0A#;
 VK_ALT                     :constant Ulong:=16#0B#;
 VK_ALTGRAF                 :constant Ulong:=16#0C#;
 VK_PAUSE                   :constant Ulong:=16#0D#;
 VK_CAPSLOCK                :constant Ulong:=16#0E#;
 VK_ESC                     :constant Ulong:=16#0F#;
 VK_SPACE                   :constant Ulong:=16#10#;
 VK_PAGEUP                  :constant Ulong:=16#11#;
 VK_PAGEDOWN                :constant Ulong:=16#12#;
 VK_END                     :constant Ulong:=16#13#;
 VK_HOME                    :constant Ulong:=16#14#;
 VK_LEFT                    :constant Ulong:=16#15#;
 VK_UP                      :constant Ulong:=16#16#;
 VK_RIGHT                   :constant Ulong:=16#17#;
 VK_DOWN                    :constant Ulong:=16#18#;
 VK_PRINTSCRN               :constant Ulong:=16#19#;
 VK_INSERT                  :constant Ulong:=16#1A#;
 VK_DELETE                  :constant Ulong:=16#1B#;
 VK_SCRLLOCK                :constant Ulong:=16#1C#;
 VK_NUMLOCK                 :constant Ulong:=16#1D#;
 VK_ENTER                   :constant Ulong:=16#1E#;
 VK_SYSRQ                   :constant Ulong:=16#1F#;
 VK_F1                      :constant Ulong:=16#20#;
 VK_F2                      :constant Ulong:=16#21#;
 VK_F3                      :constant Ulong:=16#22#;
 VK_F4                      :constant Ulong:=16#23#;
 VK_F5                      :constant Ulong:=16#24#;
 VK_F6                      :constant Ulong:=16#25#;
 VK_F7                      :constant Ulong:=16#26#;
 VK_F8                      :constant Ulong:=16#27#;
 VK_F9                      :constant Ulong:=16#28#;
 VK_F10                     :constant Ulong:=16#29#;
 VK_F11                     :constant Ulong:=16#2A#;
 VK_F12                     :constant Ulong:=16#2B#;
 VK_F13                     :constant Ulong:=16#2C#;
 VK_F14                     :constant Ulong:=16#2D#;
 VK_F15                     :constant Ulong:=16#2E#;
 VK_F16                     :constant Ulong:=16#2F#;
 VK_F17                     :constant Ulong:=16#30#;
 VK_F18                     :constant Ulong:=16#31#;
 VK_F19                     :constant Ulong:=16#32#;
 VK_F20                     :constant Ulong:=16#33#;
 VK_F21                     :constant Ulong:=16#34#;
 VK_F22                     :constant Ulong:=16#35#;
 VK_F23                     :constant Ulong:=16#36#;
 VK_F24                     :constant Ulong:=16#37#;
 VK_ENDDRAG                 :constant Ulong:=16#38#;
 VK_MENU                    :constant Ulong:=16#29#;
 VK_DBCSFIRST               :constant Ulong:=16#0080#;
 VK_DBCSLAST                :constant Ulong:=16#00ff#;
 VK_USERFIRST               :constant Ulong:=16#0100#;
 VK_USERLAST                :constant Ulong:=16#01ff#;
--
function WinGetKeyState(hwndDesktop:HWND ;
                        vkey       :LONG )return LONG;
pragma Import(c,WinGetKeyState, Link_name=>"_WinGetKeyState");

function WinGetPhysKeyState(hwndDesktop:HWND ;
                            sc         :LONG )return LONG;
pragma Import(c,WinGetPhysKeyState, Link_name=>"_WinGetPhysKeyState");

function WinEnablePhysInput(hwndDesktop:HWND   ;
                            fEnable    :BOOL32 )return BOOL32 ;
pragma Import(c,WinEnablePhysInput, Link_name=>"_WinEnablePhysInput");

function WinIsPhysInputEnabled(hwndDesktop:HWND )return BOOL32 ;
pragma Import(c,WinIsPhysInputEnabled, Link_name=>"_WinIsPhysInputEnabled");

function WinSetKeyboardStateTable(hwndDesktop   :HWND   ;
                                  pKeyStateTable:PBYTE  ;
                                  fSet          :BOOL32 )return BOOL32 ;
pragma Import(c,WinSetKeyboardStateTable, Link_name=>"_WinSetKeyboardStateTable");

--        -- Journal Notification messages
 WM_JOURNALNOTIFY           :constant Ulong:=16#007c#;
--
--        Define the valid commands ( lParm1) for journal notify message
 JRN_QUEUESTATUS            :constant Ulong:=16#00000001#;
 JRN_PHYSKEYSTATE           :constant Ulong:=16#00000002#;
--

--        Dialog Manager
--
--           Dialog Manager COMMON subsection
--
function WinGetDlgMsg(hwndDlg:HWND  ;
                      pqms   :PQMSG )return BOOL32   ;
pragma Import(c,WinGetDlgMsg, Link_name=>"_WinGetDlgMsg");

function WinLoadDlg(hwndParent   :HWND    ;
                    hwndOwner    :HWND    ;
                    pfnDlgProc   :PFNWP   ;
                    hmod         :HMODULE ;
                    idDlg        :ULONG   ;
                    pCreateParams:PVOID   )return HWND   ;
pragma Import(c,WinLoadDlg, Link_name=>"_WinLoadDlg");

function WinDlgBox(hwndParent   :HWND    ;
                   hwndOwner    :HWND    ;
                   pfnDlgProc   :PFNWP   ;
                   hmod         :HMODULE ;
                   idDlg        :ULONG   ;
                   pCreateParams:PVOID   )return ULONG ;
pragma Import(c,WinDlgBox, Link_name=>"_WinDlgBox");

function WinDismissDlg(hwndDlg :HWND  ;
                       usResult:ULONG )return BOOL32   ;
pragma Import(c,WinDismissDlg, Link_name=>"_WinDismissDlg");

function WinQueryDlgItemShort(hwndDlg:HWND   ;
                              idItem :ULONG  ;
                              pResult:PSHORT ;
                              fSigned:BOOL32 )return BOOL32   ;
pragma Import(c,WinQueryDlgItemShort, Link_name=>"_WinQueryDlgItemShort");

function WinSetDlgItemShort(hwndDlg:HWND   ;
                            idItem :ULONG  ;
                            usValue:USHORT ;
                            fSigned:BOOL32 )return BOOL32   ;
pragma Import(c,WinSetDlgItemShort, Link_name=>"_WinSetDlgItemShort");

function WinSetDlgItemText(hwndDlg:HWND  ;
                           idItem :ULONG ;
                           pszText:PSZ   )return BOOL32   ;
pragma Import(c,WinSetDlgItemText, Link_name=>"_WinSetDlgItemText");

function WinQueryDlgItemText(hwndDlg     :HWND  ;
                             idItem      :ULONG ;
                             cchBufferMax:LONG  ;
                             pchBuffer   :PSZ   )return ULONG ;
pragma Import(c,WinQueryDlgItemText, Link_name=>"_WinQueryDlgItemText");

function WinQueryDlgItemTextLength(hwndDlg:HWND  ;
                                   idItem :ULONG )return LONG  ;
pragma Import(c,WinQueryDlgItemTextLength, Link_name=>"_WinQueryDlgItemTextLength");

function  WinDefDlgProc(hwndDlg:HWND   ;
                        msg    :ULONG  ;
                        mp1    :Mparam ;
                        mp2    :Mparam ) return Long;
pragma Import(c,WinDefDlgProc, Link_name=>"_WinDefDlgProc");

--      Special item IDs
 DID_OK      : constant Ulong:= 1 ;
 DID_CANCEL  : constant Ulong:= 2 ;
 DID_ERROR   : constant Ulong:= 16#ffff#;
--
function WinAlarm(hwndDesktop:HWND  ;
                  rgfType    :ULONG )return  BOOL32;
pragma Import(c,WinAlarm, Link_name=>"_WinAlarm");

--      WinAlarm Codes

 WA_WARNING    :constant Ulong:= 0;
 WA_NOTE       :constant Ulong:= 1;
 WA_ERROR      :constant Ulong:= 2;
 WA_CWINALARMS :constant Ulong:=10; -- count of valid alarms     53304

function WinMessageBox(hwndParent:HWND  ;
                       hwndOwner :HWND  ;
                       pszText   :PSZ   ;
                       pszCaption:PSZ   ;
                       idWindow  :ULONG ;
                       flStyle   :ULONG )return ULONG;
pragma Import(c,WinMessageBox, Link_name=>"_WinMessageBox");

--     -- Message box types

 MB_OK                   :constant Ulong:=16#0000#;
 MB_OKCANCEL             :constant Ulong:=16#0001#;
 MB_RETRYCANCEL          :constant Ulong:=16#0002#;
 MB_ABORTRETRYIGNORE     :constant Ulong:=16#0003#;
 MB_YESNO                :constant Ulong:=16#0004#;
 MB_YESNOCANCEL          :constant Ulong:=16#0005#;
 MB_CANCEL               :constant Ulong:=16#0006#;
 MB_ENTER                :constant Ulong:=16#0007#;
 MB_ENTERCANCEL          :constant Ulong:=16#0008#;
 MB_NOICON               :constant Ulong:=16#0000#;
 MB_CUANOTIFICATION      :constant Ulong:=16#0000#;
 MB_ICONQUESTION         :constant Ulong:=16#0010#;
 MB_ICONEXCLAMATION      :constant Ulong:=16#0020#;
 MB_CUAWARNING           :constant Ulong:=16#0020#;
 MB_ICONASTERISK         :constant Ulong:=16#0030#;
 MB_ICONHAND             :constant Ulong:=16#0040#;
 MB_CUACRITICAL          :constant Ulong:=16#0040#;
 MB_QUERY                :constant Ulong:=16#0010#;
 MB_WARNING              :constant Ulong:=16#0020#;
 MB_INFORMATION          :constant Ulong:=16#0030#;
 MB_CRITICAL             :constant Ulong:=16#0040#;
 MB_ERROR                :constant Ulong:=16#0040#;
 MB_DEFBUTTON1           :constant Ulong:=16#0000#;
 MB_DEFBUTTON2           :constant Ulong:=16#0100#;
 MB_DEFBUTTON3           :constant Ulong:=16#0200#;
 MB_APPLMODAL            :constant Ulong:=16#0000#;
 MB_SYSTEMMODAL          :constant Ulong:=16#1000#;
 MB_HELP                 :constant Ulong:=16#2000#;
 MB_MOVEABLE             :constant Ulong:=16#4000#;

--      Message box return codes

 MBID_OK                 :constant Ulong:=      1;
 MBID_CANCEL             :constant Ulong:=      2;
 MBID_ABORT              :constant Ulong:=      3;
 MBID_RETRY              :constant Ulong:=      4;
 MBID_IGNORE             :constant Ulong:=      5;
 MBID_YES                :constant Ulong:=      6;
 MBID_NO                 :constant Ulong:=      7;
 MBID_HELP               :constant Ulong:=      8;
 MBID_ENTER              :constant Ulong:=      9;
 MBID_ERROR              :constant Ulong:=16#ffff#;

--     -- Useful macros

--       ULONG/USHORT WinCheckButton(:HWND hwn Dlg;:USHORT id;:USHORT checkState)
--          sets the check state of button #id.
--          returns the previous check state.
--
--     #define WinCheckButton( hwn Dlg; id; usCheckState) \
--     ( (:ULONG)WinSendDlgItemMsg( hwn Dlg; id; BM_SETCHECK; \
--     MPFROMSHORT( usCheckState)return ( MPARAM)NULL))
--
--     --*************************************************************************--
--       ULONG/USHORT WinQueryButtonCheckstate(:HWND hwn Dlg;:USHORT id)
--          returns the check state of buttin #id.
--
--     *************************************************************************--
--     #define WinQueryButtonCheckstate( hwn Dlg; id) \
--     ( (:ULONG)WinSendDlgItemMsg( hwn Dlg; id; BM_QUERYCHECK; \
--     ( MPARAM)NULL; ( MPARAM)NULL))
--
--     --*************************************************************************--
--     --BOOL32 WinEnableControl(:HWND hwn Dlg;:USHORT id; BOOL32 fEnable)
--     --   sets the enable state of button #id.
--     --   returns fSuccess.
--     *************************************************************************--
--     #define WinEnableControl( hwn Dlg; id; fEnable) \
--     WinEnableWindow( WinWindowFromID( hwn Dlg; id)return fEnable)
--
--     --*************************************************************************--
--     --BOOL32 WinIsControlEnabled(:HWND hwn Dlg;:ULONG id)
--     --   returns the enable state of control #id.
--     --
--     *************************************************************************--
--     #define WinIsControlEnabled( hwn Dlg; id) \
--     ( ( BOOL)WinIsWindowEnabled( WinWindowFromID( hwn Dlg; id)))
--

--
--        Dialog codes: returned by WM_QUERYDLGCODE msg
--
 DLGC_ENTRYFIELD :constant Ulong:=16#0001#;  -- Entry field item understands EM_SETSEL)
 DLGC_BUTTON     :constant Ulong:=16#0002#;  -- Button item
 DLGC_RADIOBUTTON:constant Ulong:=16#0004#;  -- Radio button
 DLGC_STATIC     :constant Ulong:=16#0008#;  -- Static item
 DLGC_DEFAULT    :constant Ulong:=16#0010#;  -- Default push button
 DLGC_PUSHBUTTON :constant Ulong:=16#0020#;  -- Normal ( Non-default) push button
 DLGC_CHECKBOX   :constant Ulong:=16#0040#;  -- Check box button control
 DLGC_SCROLLBAR  :constant Ulong:=16#0080#;  -- Scroll bar
 DLGC_MENU       :constant Ulong:=16#0100#;  -- Menu
 DLGC_TABONCLICK :constant Ulong:=16#0200#;
 DLGC_MLE        :constant Ulong:=16#0400#;  -- Multiple Line Entry

function WinProcessDlg(hwndDlg:HWND )return ULONG ;
pragma Import(c,WinProcessDlg, Link_name=>"_WinProcessDlg");

procedure  WinSendDlgItemMsg(hwndDlg:HWND   ;
                             idItem :ULONG  ;
                             msg    :ULONG  ;
                             mp1    :MPARAM ;
                             mp2    :Pmenuitem);
pragma Import(c,WinSendDlgItemMsg, Link_name=>"_WinSendDlgItemMsg");

function WinMapDlgPoints(hwndDlg          :HWND    ;
                         prgwptl          :PPOINTL ;
                         cwpt             :ULONG   ;
                         fCalcWindowCoords:BOOL32  )return BOOL32   ;
pragma Import(c,WinMapDlgPoints, Link_name=>"_WinMapDlgPoints");

function WinEnumDlgItem(hwndDlg:HWND  ;
                        hwn    :HWND  ;
                        code   :ULONG )return HWND   ;
pragma Import(c,WinEnumDlgItem, Link_name=>"_WinEnumDlgItem");

function WinSubstituteStrings(hwn      :HWND ;
                              pszSrc   :PSZ  ;
                              cchDstMax:LONG ;
                              pszDst   :PSZ  )return LONG  ;
pragma Import(c,WinSubstituteStrings, Link_name=>"_WinSubstituteStrings");

--      WinEnumDlgItem( ) constants

 EDI_FIRSTTABITEM       :constant Ulong:= 0 ;
 EDI_LASTTABITEM        :constant Ulong:= 1 ;
 EDI_NEXTTABITEM        :constant Ulong:= 2 ;
 EDI_PREVTABITEM        :constant Ulong:= 3 ;
 EDI_FIRSTGROUPITEM     :constant Ulong:= 4 ;
 EDI_LASTGROUPITEM      :constant Ulong:= 5 ;
 EDI_NEXTGROUPITEM      :constant Ulong:= 6 ;
 EDI_PREVGROUPITEM      :constant Ulong:= 7 ;


--          Variable-sized dialog template items:

--  ***********************************************************************--

--   We pack the structures _DLGTITEM and _DLGTEMPLATE so that the
--   structures are identical in the 32-bit and 16-bit worlds. We have
--   to do this because is has been documented that one can pass a
--   pointer to 'the binary resource format' when calling WinCreateDlg.
--
--
--   Binary resources may be bound into application executables or
--   passed as a parameter when creating a window or dialog
--   Currently they must be the same for both 16-bit and 32-bit
--   so we pack the structures.
--  ***********************************************************************--

type DLGTITEM   is record   -- dlgti
    fsItemStatus      :USHORT  ;
    cChildren         :USHORT  ;
    cchClassName      :USHORT  ;
    offClassName      :USHORT  ;
    cchText           :USHORT  ;
    offText           :USHORT  ;
    flStyle           :ULONG   ;
    x                 :SHORT   ;
    y                 :SHORT   ;
    cx                :SHORT   ;
    cy                :SHORT   ;
    id                :USHORT  ;
    offPresParams     :USHORT  ;
    offCtlData        :USHORT  ;
end record; -- DLGTITEM;
type PDLGTITEM  is access all DLGTITEM;

--       Dialog Template structure
--
--   Binary resources may be bound into application executables or
--   passed as a parameter when creating a window or dialog
--   Currently they must be the same for both 16-bit and 32-bit
--   so we pack the structures.

type DLGTEMPLATE  is record    -- dlgt
    cbTemplate         :USHORT   ;
    typ                :USHORT   ;
    codepage           :USHORT   ;
    offadlgti          :USHORT   ;
    fsTemplateStatus   :USHORT   ;
    iItemFocus         :USHORT   ;
    coffPresParams     :USHORT   ;
    adlgti             :DLGTITEM ;                  --  [1];
end record; -- DLGTEMPLATE;
type PDLGTEMPLATE  is access all DLGTEMPLATE;

function WinCreateDlg(hwndParent   :HWND         ;
                      hwndOwner    :HWND         ;
                      pfnDlgProc   :PFNWP        ;
                      pdlgt        :PDLGTEMPLATE ;
                      pCreateParams:PVOID        )return HWND  ;
pragma Import(c,WinCreateDlg, Link_name=>"_WinCreateDlg");

end os2.PMwd;
