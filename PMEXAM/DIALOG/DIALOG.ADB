with System;
with os2; use os2;
with os2.bse ; use os2.bse ;
with os2.pmwb; use os2.pmwb;
with os2.pmsc; use os2.pmsc;
with os2.pmwd; use os2.pmwd;
with os2.pmcp; use os2.pmcp;
with os2.pmer; use os2.pmer;
with helpdial;use helpdial;
with text_io; use text_io;
with builtin; use builtin;
--  API's       :
--  -------------
--  GpiCharStringAt       WinDestroyWindow    WinInvalidateRegion
--  GpiSetColor           WinDismissDlg       WinLoadString
--  WinBeginPaint         WinDispatchMsg      WinPostMsg
--  WinCreateMsgQueue     WinDlgBox           WinQueryWindowText
--  WinCreateStdWindow    WinEndPaint         WinRegisterClass
--  WinDefDlgProc         WinFillRect         WinSendMsg
--  WinDefWindowProc      WinGetMsg           WinTerminate
--  WinDestroyMsgQueue    WinInitialize       WinWindowFromID
--  WinGetMsg             WinRegisterClass    WinDispatchMsg
--  DosBeep               WinCreateStdWindow  WinDestroyWindow
--  WinCreateMsgQueue     WinSetWindowText
--  WinTerminate
procedure dialog is
success        :   BOOL ;
rca            :apiret;
title :constant astring(1..31) := "Dialog - Sample Ada-95 Program" & nul_char;
myw   :constant astring(1..16) := "MyWindow ADA-95" & nul_char;    -- Window class name
pwin                 :psz :=myw'address;
zero  :constant ulong := 0;
flCreate     :aliased ULONG  := Os2.pmsc.Fcf_Standard;

   print:file_type;
   package int is new modular_io(Ulong);

begin

   create(file=>print,name=>"dialog.prn",mode=>out_file);
   set_output(print);

ha  := WinInitialize( 0 );
if ha  = 0 then    put(" Can't initialize window");
rca:=  DosBeep(60, 100 ); goto fin;  end if;
mq := WinCreateMsgQueue( ha , 0 );
if  mq = 0  then   put(" Can't create Msg window");
 rca:=  DosBeep(60 , 100); rcb:=  WinTerminate(ha ); goto fin;
end if;

  success := WinDlgBox( hwnd_desktop,            -- Place anywhere on desktop
                        hwnd_desktop,            -- Owned by desk top
                        ProdInfoDlgProc'address, -- Addr. of procedure
                        0          ,             -- Module handle
                        id_prodinfo,             --  Dialog identifier in resource
                        System.Null_Address);    -- Initialization data

  if success = 0 then
    put("Could Not Register Class"); goto fin;
  end if;

success := WinRegisterClass(           -- Register window class
           ha ,                        -- Anchor block handle
           MyW'address,             -- Window class name
           MyWindowProc'address,       -- Address of window procedure
           cs_sizeredraw,              -- Class style
           0                           -- No extra window words
           );
if success=0 then
  put ("Could Not Register Class");
  goto fin;
end if;

hwndFrame := WinCreateStdWindow(
            hwnd_desktop,                   -- Desktop window is parent
            ws_visible,                     -- Frame style
            flCreate'unchecked_access,      -- Frame control flag
            pwin      ,                     -- Window class name
            pwin      ,                     -- Window title
            0 ,                             -- Client style of VISIBLE
            0 ,                             -- Resource is in .EXE file
            id_mainwnd,                     -- Frame window identifier
            hwndClient'unchecked_access);   -- Client window handle

if hwndFrame=0 then
  DisplayMessage("Could Not Create Main Window");
  goto fin;
end if;

rcb32:=  WinSetWindowText(hwndFrame, title'address);
   new_line; put_edit(" SetWindowText=",integer(rcb32),5);

--   * until WinGetMsg returns 0, indicating a WM_QUIT message.
--   * Get and dispatch messages from the application message queue
loop
  rcb32:=WinGetMsg( ha, msg'unchecked_access , 0, 0, 0 );
--  put_edit(" WinGetMsg rc=",integer(rcb32));  put(" msg");
--  int.put(item=>msg.msg,base=>16);

  exit when rcb32=0;

  rcmr :=WinDispatchMsg( ha , msg'unchecked_access  );
--  new_line;put("windispatch "); int.put(item=>msg.msg,base=>16);

end loop;
<<fin>>
   put_edit("End dialog", integer(rcb32));
   close(file=>print);
rcb32:=  WinDestroyWindow( hwndFrame );  -- Tidy up...
rcb32:=  WinDestroyMsgQueue( mq );       -- and
rcb32:=  WinTerminate( ha );    -- terminate the application
end dialog;
