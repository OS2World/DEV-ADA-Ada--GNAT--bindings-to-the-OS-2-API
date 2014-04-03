with os2; use os2;

package helphell is

 MSGBOXID     : CONSTANT ULONG:= 1001 ;
 ID_WINDOW    : CONSTANT ULONG:=  256 ;
 ID_OPTIONS   : CONSTANT ULONG:=  257 ;
 ID_OPTION1   : CONSTANT ULONG:=  258 ;
 ID_OPTION2   : CONSTANT ULONG:=  259 ;
 ID_OPTION3   : CONSTANT ULONG:=  260 ;
 ID_EXITPROG  : CONSTANT ULONG:=  261 ;

 IDS_HELLO    : CONSTANT ULONG:=  262 ;
 IDS_1        : CONSTANT ULONG:=  263 ;
 IDS_2        : CONSTANT ULONG:=  264 ;
 IDS_3        : CONSTANT ULONG:=  265 ;

 mq        :     HMQ              ;        -- Message queue handle
hwndClient : aliased     HWND:= 0 ;        -- Client area window handle
hwndFrame  : aliased     HWND:= 0 ;        -- Frame window handle  ULONG
 msg       : aliased     QMSG     ;        -- Message from message queue
flCreate   : aliased     ULONG    ;        -- Window creation control flags
-- return codes
rcb   :BOOL;
rcb32 :BOOL32;
rcl   :LONG;
rcul  :ULONG;
rcmr  :Mresult;
zero  :constant Ulong :=0;
one   :constant Ulong :=1;
nul_char:character:=character'val(0);
hello_txt  : string(1..13):= "HELLO ADA-95 " ;

win  :astring(1..9):="MyWindow" & nul_char;  -- Window class name
pwin :PSZ:=win'address;
str  :string(1..80):=(others => nul_char);
STRINGLENGTH :constant long:=20;        -- Length of string
subtype str20  is string(1..integer(STRINGLENGTH));
ha :HAB ;                               -- PM anchor block handle
szHello:str20 ;       -- String parameters, set in
sz1:str20     ;       -- the processing of WM_CREATE,
sz2:str20     ;       -- and used in the processing
sz3:str20     ;       -- of WM_COMMAND, in window
szString:str20;       -- procedure.
pszErrMsg:PSZ;
--  --*************************************************************************
--   *
--   *  Name       : GoOut
--   *
--   *  Description: Report an error returned from an API service
--   *
--   *  Concepts   :  use of message box to display information
--   *
--   *  API's      :  DosBeep                 OS2.Bse
--   *                WinGetErrorInfo         OS2.PMcp
--   *                WinMessageBox           OS2.PMwd
--   *                WinFreeErrorInfo        OS2.PMcp
--   *                WinPostMsg              OS2.PMwb
--   *
--   *  Parameters :      Frame:= frame window handle
--   *                    Client:= client window handle
--   *
--   ************************************************************************
function  GoOut(Frame ,Client:HWND) return BOOL32;

--  --*************************************************************************
--   *
--   *  Name       : MyWindowProc
--   *
--   *  Description: The window procedure associated with the client area in
--   *               the standard frame window. It processes all messages
--   *               either sent or posted to the client area, depending on
--   *               the message command and parameters.
--   *
--   *  Concepts   :
--   *
--   *  API's      :   WinLoadString          OS2.PMwb
--   *                 WinInvalidateRegion    OS2.PMwb
--   *                 WinPostMsg             OS2.PMwb
--   *                 WinDefWindowProc       OS2.PMwb
--   *                 WinBeginPaint          OS2.PMwb
--   *                 GpiSetColor            OS2.Gpi
--   *                 GpiSetBackColor        OS2.Gpi
--   *                 GpiSetBackMix          OS2.Gpi
--   *                 GpiCharStringAt        OS2.Gpi
--   *                 WinEndPaint            OS2.PMwb
--   *
--   *  Parameters :  hwnd:= window handle
--   *                msg:= message code
--   *                mp1:= first message parameter
--   *                mp2:= second message parameter
--   *
--   *  Return     :  depends on message sent
--   *
--   ************************************************************************

function MyWindowProc(hwn:HWND   ;
                      msg:ULONG  ;
                      mp1:Mparam ;
                      mp2:Mparam )return Ulong ;
pproc:PFNWP   ;   -- Address of window procedure
end helphell;
