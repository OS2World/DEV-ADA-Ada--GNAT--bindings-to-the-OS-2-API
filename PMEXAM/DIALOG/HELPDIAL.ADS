with Os2; use Os2;
with Os2.Pmsc;
Package helpdial is
--  resurse constant dialog.h
ID_MAINWND     : constant ulong :=  256 ;
ID_MYDIALOG    : constant ulong :=  257 ;
ID_ENTRYFIELD  : constant ulong :=  258 ;
ID_COMMANDS    : constant ulong :=  259 ;
ID_WHERE       : constant ulong :=  260 ;
ID_EXITPROGRAM : constant ulong :=  261 ;
ID_RESPONSE    : constant ulong :=  262 ;
ID_MESSAGEBOX  : constant ulong :=  263 ;
ID_BITMAP      : constant ulong :=  264 ;
ID_PRODINFO    : constant ulong :=  265 ;
ID_NULL        : constant ulong :=  9999;
-- program constants and variables
length_string : constant integer := 33 ;
 ha                           :aliased HAB         ; -- Anchor block handle
 mq                           :aliased HMQ         ; -- Message queue handle
 msg                          :aliased QMSG        ; -- Message from message queue
 hwndClient                   :aliased HWND        ; -- Client window handle
 hwndFrame                    :aliased HWND        ; -- Frame window handle


--  hwnd_desktop                 :aliased HWND        ; -- Place in desktop
 szLocation:astring(1..length_string):=(others=>' '); -- To hold text entered by user
 szResponse:astring(1..length_string):=(others=>' '); -- To hold "You live in"
 bComplete                     :BOOL := 0           ; -- Switch for first time through
 rcb                           :BOOL                ;
 rcl                           :LONG                ;
 rcul                          :ULONG               ;
 rcb32                         :BOOL32              ;
 rcmr                          :Mresult             ;
 nul_char                      :constant character :=character'val(0) ;
 zero                          :LONG               := 0;

--  procedures and functions
--
--  ***************************************************************
--    Name:   MyWndProc
--
--    Description : Window procedure for the main clent window.
--
--    Concepts : Processes the messages sent to the main client
--               window.
--
--    API's : WinLoadString
--            WinDlgBox
--            WinInvalidateRegion
--            WinPostMsg
--            WinDefDlgProc
--            WinBeginPaint
--            WinFillRect
--            GpiCharStringAt
--            GpiSetColor
--            WinEndPaint
--
--   Parameters   : hwn - Window handle to which message is addressed
--                  msg - Message type
--                  mp1 - First message parameter
--                  mp2 - Second message parameter
--
--    Returns:  Return values are determined by each message
--
--  **************************************************************
function  MyWindowProc (hwn:HWND ; msg:ULONG;mp1,mp2:MPARAM)  return ulong;

--  ********************************************************************
--    Name : MyDlgProc
--
--    Description : Processes all messages sent to the dialog.
--
--    Concepts : Called for each message sent to the dialog box.
--               A switch statement branches to the routines to be
--               performed for each message processed.  Any messages
--               not specifically process are passed to the default
--               window procedure WinDefDlgProc().
--
--    API's : WinQueryWindowText
--            WinDismissDlg
--
--   Parameters   : hwn - Window handle to which message is addressed
--                  msg - Message type
--                  mp1 - First message parameter
--                  mp2 - Second message parameter
--
--    Returns : Dependent upon message sent
--
--  **************************************************************
function  MyDlgProc (hwndDlg:HWND ; msg:ULONG;mp1,mp2:MPARAM)  return ulong;

--  ********************************************************************
--    Name : ProdInfoDlgProc
--
--    Description : Processes all messages sent to the Product
--                  Information dialog box.
--
--    Concepts : Called for each message sent to the Product
--               Information dialog box.  The Product
--               Information box only has a button control so
--               this routine only processes WM_COMMAND
--               messages.  Any WM_COMMAND posted must have come
--               from the Ok button so we dismiss the dialog
--               upon receiving it.
--
--    API's : WinDismissDlg
--            WinDefDlgProc
--
--   Parameters   : hwn - Window handle to which message is addressed
--                  msg - Message type
--                  mp1 - First message parameter
--                  mp2 - Second message parameter
--
--    Returns : Dependent upon message sent
--
--  **************************************************************
function  ProdInfoDlgProc(hwn:HWND ; msg:ULONG;mp1,mp2:MPARAM)  return ulong;
--  ***************************************************************
--    Name:   DisplayMessage
--
--    Description : Displays error messages.
--
--    Concepts : Displays a message box containing an error
--               message each time called.
--
--    API's : WinMessageBoxNon
--
--   Parameters   : str - error message to display
--
--    Returns:  Void
--
--  **************************************************************
procedure DisplayMessage(str:astring);

--  **********************************************************
--   Name         : SetSysMenu
--
--   Description  : Procedure to remove unselectable items from
--                  the window system menu.
--
--   Concepts     : This routine determines the number of items
--                  in the system menu, loops through those
--                  items removing disabled menu items and menu
--                  seperators.
--
--   API's        : WinMessageBox
--
--   Parameters   : None
--
--   Return       : None
--
--  ************************************************************
procedure SetSysMenu(hwndDlg:HWND ) ;
end helpdial ;
