with text_io; use text_io;
with builtin; use builtin;
with os2; use os2;
with os2.pmwb; use os2.pmwb;
with os2.pmsc; use os2.pmsc;
with os2.pmcp; use os2.pmcp;
with os2.pmer; use os2.pmer;
with helphell;use helphell;

--  /*************** Hello Sample Program Source Code File (.adb) ************
--   *
--   * PROGRAM NAME: HELLO
--   * -------------
--   *  Presentation Manager Standard Window Ada-95 Sample Program
--   *
--   * REVISION LEVEL: 1.0
--   * ---------------
--   *
--   * WHAT THIS PROGRAM DOES:
--   * -----------------------
--   *  This program displays a standard window containing the text "Hello".
--   *  The action bar contains a single choice, Options.
--   *  The Options pull-down contains three choices that each
--   *  paint a different string in the window.
--   *
--   * WHAT THIS PROGRAM DEMONSTRATES:
--   * -------------------------------
--   *  This program demonstrates how to create and display a standard window,
--   *  and how to use resources defined in a resource script file.
--   *
--   * WHAT YOU NEED TO COMPILE THIS PROGRAM:
--   * --------------------------------------
--   *
--   *  REQUIRED FILES:
--   *  ---------------
--   *
--   *    HELLO.adb     - Source code  helphell.ads helphell.adb
--   *    HELLO.ICO     - Icon file
--   *    HELLO.RC      - Resource file
--   *
--   *  REQUIRED LIBRARIES:
--   *  -------------------
--   *
--   *    OS2.A     - Presentation Manager/OS2 library
--   *
--   *  REQUIRED PROGRAMS:
--   *  ------------------
--   *    GNAT Ada-95 Compiler  3.05
--   *    Resource Compiler
--   *
--   *      DISCLAIMER OF WARRANTIES.  The following [enclosed] code is
--   *      sample code created by IBM Corporation. This sample code is not
--   *      part of any standard or IBM product and is provided to you solely
--   *      for  the purpose of assisting you in the development of your
--   *      applications.  The code is provided "AS IS", without
--   *      warranty of any kind.  IBM shall not be liable for any damages
--   *      arising out of your use of the sample code, even if they have been
--   *      advised of the possibility of such damages.                                                    *
--   ******************************************************************************/

procedure hello is

--  --*************************************************************************
--   *
--   *
--   *  Description: Initializes the process for OS/2 PM services and
--   *               process the application message queue until a
--   *               WM_QUIT message is received.  It then destroys all
--   *               OS/2 PM resources and terminates.
--   *
--   *  Concepts   : - obtains anchor block handle and creates message
--   *                   queue
--   *               - creates the main frame window which creates the
--   *                   main client window
--   *               - polls the message queue via Get/Dispatch Msg loop
--   *               - upon exiting the loop, exits
--   *                                        Package
--   *                                        -------
--   *  API's      :   WinInitialize          OS2.PMwb
--   *                 WinCreateMsgQueue      OS2.PMwb
--   *                 WinTerminate           OS2.PMwb
--   *                 WinSetWindowPos        OS2.PMwb
--   *                 WinSetWindowText       OS2.PMwb
--   *                 WinRegisterClass       OS2.PMwb
--   *                 WinCreateStdWindow     OS2.PMsc
--   *                 WinGetMsg              OS2.PMwb
--   *                 WinGetLastError        OS2.PMcp
--   *                 WinDispatchMsg         OS2.PMwb
--   *                 WinDestroyWindow       OS2.PMwb
--   *                 WinDestroyMsgQueue     OS2.PMwb
--   *
--   ************************************************************************

str_hel:astring(1..12):="Open window" & nul_char;
point: PSZ  :=str_hel'address;
print:file_type;

rcId    : ErrorId;
pfl     : pulong;
pClient : PHWND;
 package int is new modular_io(ErrorId);
begin
create(file=>print,name=>"hello.prn",mode=>out_file);
set_output(print);
hello_txt(13):=nul_char;
ha := WinInitialize(0);        -- Initialize PM
if ha = 0 then
  rcb32:=GoOut(hwndFrame, hwndClient); -- Terminate the application
  goto fin;
end if;
put_edit(" Ha=",integer(ha),4);
mq:= WinCreateMsgQueue( ha, 0 ); -- Create a msg queue
if mq=0 then
    rcb32:=GoOut(hwndFrame, hwndClient); -- Terminate the application
    goto fin;
end if;
put_edit(" Mq=",integer(mq),4);

 pproc      :=MyWindowProc'address;   -- Address of window procedure
 new_line;
 rcb32:= WinRegisterClass(   -- Register window class
           ha   ,         -- Anchor block handle            HAB
           pwin ,         -- Window class name              PSZ
           pproc,         -- Address of window procedure    PFNWP
  CS_SIZEREDRAW ,         -- Class style  CS_SIZEREDRAW     ULONG
           0              -- No extra window words          ULONG
           ) ;
 new_line; put_edit(" RegisterClass=",integer(rcb32),5);

  if  rcb32= 0 then                                    -- BOOL32
        rcb32:=GoOut(hwndFrame, hwndClient); -- Terminate the application
   put("Error 3");goto fin;
  end if;

flCreate := 1 + 2 + 16#30# + 8 + 16#800# + 4 + 16#8000# ;

 put(" flCreate =>"); int.put(item=>ErrorId(flCreate),base=>16);
 pfl:=flCreate'access;
 pClient:=hwndClient'access;
 hwndFrame:= WinCreateStdWindow(      -- return          HWND
             HWND_DESKTOP,   -- Desktop window is parent HWND
             0,              -- STD. window styles       ULONG
             pfl ,           -- Frame control flag       PULONG
             pwin,           -- Client window class name  PSZ
             point,          -- No window text           PSZ
             0   ,           -- No special class style   ULONG
             0   ,           -- Resource is in .EXE file HMODULE
             ID_WINDOW  ,    -- Frame window identifier  ULONG
             pClient         -- Client window handle     PHWND
 );
 new_line;
 put_edit(" hwndFrame=",integer(hwndFrame),4);
if hwndFrame=0 then
 rcId:=WinGetLastError(ha);
 put("Error number =>");
 case rcId is
 when  PMERR_INVALID_HWND           => put(" PMERR_INVALID_HWND ");
 when  PMERR_INVALID_FLAG           => put(" PMERR_INVALID_FLAG ");
 when  PMERR_INVALID_INTEGER_ATOM   => put(" PMERR_INVALID_INTEGER_ATOM");
 when  PMERR_ATOM_NAME_NOT_FOUND    => put(" PMERR_ATOM_NAME_NOT_FOUND");
 when  PMERR_INVALID_ATOM_NAME      => put(" PMERR_INVALID_ATOM_NAME ");
 when  others => put("Nonstandard"); int.put(item=>rcId,base=>16);
 end case;
  rcb32:=GoOut(hwndFrame, hwndClient); -- Terminate the application
  put("Error 4") ;   goto fin;
 end if;
     rcb:=   WinSetWindowText(hwndFrame,              --  HWND
                              hello_txt(1)'address    --  PSZ
                               );                     --  BOOL
new_line; put_edit(" SetWindText=",integer(rcb),4);
--
    rcb:= WinSetWindowPos( hwndFrame,   -- Shows and activates frame    HWND
                          HWND_TOP,     -- window at position 100, 100, HWND
                          100,          -- x Long
                          100,          -- y Long
                          200,          -- cx Long
                          200,          -- cy Ulong
                       16#8B#           -- SWP_SIZE | SWP_MOVE | SWP_ACTIVATE | SWP_SHOW
                       );               --        1          2             80   8
new_line; put_edit(" SetWindPos=",integer(rcb),4);
if rcb  = 0 then
     rcb32:=GoOut(hwndFrame, hwndClient); -- Terminate the application
      goto fin;
end if;
--
--  --   * Get and dispatch messages from the application message queue
--  --   * until WinGetMsg returns FALSE, indicating a WM_QUIT message.

loop
rcb32:=WinGetMsg( ha, msg'access, 0, 0, 0 ) ;
exit when rcb32 = 0 ;
rcmr := WinDispatchMsg( ha,              -- HAB
                       msg'access       -- PQMSG
                       );
end loop;
<<fin>> null; new_line; Put("End");
rcb32:=WinDestroyWindow(hwndFrame);    -- Tidy up...  HWND
rcb32:=WinDestroyMsgQueue( mq  );      -- Tidy up...  HMQ
rcb32:=WinTerminate( ha );             -- Terminate the application HAD
end hello;
