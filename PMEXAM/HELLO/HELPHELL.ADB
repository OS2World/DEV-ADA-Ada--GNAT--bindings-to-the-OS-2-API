with text_io;
with builtin; use builtin;
with os2; use os2;
with os2.bse ; use os2.bse ;
with os2.pmwb; use os2.pmwb;
with os2.pmcp; use os2.pmcp;
with os2.pmwd; use os2.pmwd;
with os2.pmsc; use os2.pmsc;
with os2.Gpi; use os2.Gpi;
package body helphell is

err_info     :aliased ERRINFO;
pErrInfoBlk  :PERRINFO:=err_info'access  ;
pszOffSet    :PSZ       ;
rc : apiret;
mp :mparam := 0       ;
ermsg:constant astring:=  "Error Msg" & nul_char;

function GoOut(Frame,Client:HWND) return BOOL32 is

begin
rc:=      DosBeep(100,10);
pErrInfoBlk:= WinGetErrorInfo(ha);
if  err_info.idError /= 0  then
 pszOffSet:= err_info.offaoffszMsg'address;
 pszErrMsg:= err_info.offaoffszMsg'address;
--        pszErrMsg:= ((PSZ)pErrInfoBlk) + *((PSHORT)pszOffSet);
end if;

if Frame/=0 and Client/=0   then


rcul:=  WinMessageBox(1           , -- Parent window is desk top  HWND_DESKTOP HWND
                      hwndFrame,    -- Owner window is our frame      HWND
                      pszErrMsg,    -- PMWIN Error message            PSZ
                      ermsg(1)'address,   -- Title bar message        PSZ
                      1001    ,           -- Message identifier MSGBOXID ULONG
                      16#4046#            -- 4000 40 6
                 --   MB_MOVEABLE | MB_CUACRITICAL | MB_CANCEL -- Flags  ULONG
                      ); -- Ulong
end if;
rcb32:=   WinFreeErrorInfo(pErrInfoBlk);

rcb32:= WinPostMsg(Client,  -- HWND
                   WM_QUIT   ,  -- ULONG
                   mp        ,  -- MPARAM
                   mp           -- MPARAM
                   );           -- BOOL32
return rcb32;
End GoOut;

function MyWindowProc(hwn:HWND   ;
                      msg:ULONG  ;
                      mp1:Mparam ;
                      mp2:Mparam )return Ulong is

hp  :HPS    ;                        -- Presentation Space handle
Paint  :aliased RECTL  ;             -- Rectangle coordinates
pt     :aliased POINTL ;             -- String screen coordinates
begin

Text_io.New_line; put_edit("Start MyWindowProc msg=>",integer(msg),4);
case  msg is
 when  WM_CREATE   =>
        text_io.put(" Wm_Create");
--         * Window initialization is performed here in WM_CREATE processing
--         * WinLoadString loads strings from the resource file.
  rcl  := WinLoadString( ha                     , --   HAB
                         0                      , --   HMODULE
                         IDS_HELLO              , --   ULONG
                         STRINGLENGTH           , --   LONG
                         szHello(1)'address     --   PSZ
  );                                   --   LONG
put_edit(" LoadStr 0=>",integer(rcl),4);
  rcl  := WinLoadString(ha ,0   ,IDS_1  , STRINGLENGTH, sz1(1)'address );
put_edit(" LoadStr 1=>",integer(rcl),4);
  rcl  := WinLoadString(ha ,0   ,IDS_2  , STRINGLENGTH, sz2(1)'address );
put_edit(" LoadStr 2=>",integer(rcl),4);
  rcl  := WinLoadString(ha ,0   ,IDS_3  , STRINGLENGTH, sz3(1)'address );
put_edit(" LoadStr 3=>",integer(rcl),4);
  szString:=szHello ;                      -- Copy text Hello into szString

 when  WM_COMMAND =>
        text_io.put(" Wm_Command");

  --  * When the user chooses option 1, 2, or 3 from the Options pull-
  --  * down, the text string is set to 1, 2, or 3, and
  --  * WinInvalidateRegion sends a WM_PAINT message.
  --  * When Exit is chosen, the application posts itself a WM_CLOSE
  --  * message.

     case mp1  is
      when  ID_OPTION1  =>  szString:= sz1 ;
       rcb:=     WinInvalidateRegion( hwn ,   -- HWND
                                      0   ,   -- HRGN
                                      0       -- BOOL32
       );                                     -- BOOL

      when ID_OPTION2  =>  szString:=sz2 ;
       rcb:=     WinInvalidateRegion( hwn , 0 , 0     );

      when  ID_OPTION3  => szString:=sz3 ;
       rcb:=     WinInvalidateRegion( hwn , 0, 0 );

       when ID_EXITPROG   =>
        rcb32:=     WinPostMsg( hwn     ,  -- HWND
                              WM_CLOSE  ,  -- ULONG
                                mp      ,  -- MPARAM
                                mp         -- MPARAM
                               );

      when others =>
       rcb32 := WinDefWindowProc( hwn,   -- HWND
                                  msg,   -- ULONG
                                  mp1,   -- Mparam
                                  mp2    -- Mparam
                                  );
       return  ulong(rcb32);
      end case;

    when WM_ERASEBACKGROUND  =>

        text_io.put(" Wm_Erasebackground");
     --  * Return TRUE to request PM to paint the window background
     --  * in SYSCLR_WINDOW.

    return one;

    when WM_PAINT  =>
        text_io.put(" Wm_Paint");

     --  * Window contents are drawn here in WM_PAINT processing.

                         -- Create a presentation space

      hp := WinBeginPaint( hwn        ,           -- HWND
                           0          ,           -- HPS
                           Paint'unchecked_access -- PRECL
                          );                      -- HPS

      pt.x:= 50; pt.y:= 50;             -- Set the text coordinates,

      -- colour of the text,
      rcb  :=  GpiSetColor( hp ,         -- HPS
                            CLR_NEUTRAL  -- LONG
               );                        -- BOOL

      rcb  :=  GpiSetBackColor( hp ,0 );  -- its background and CLR_BACKGROUND

      rcb  :=  GpiSetBackMix( hp ,2);      -- BM_OVERPAINT how it mixes,

      rcl:= GpiCharStringAt(hp                 ,  -- HPS
                            pt'unchecked_access,  -- PPOINL
                            STRINGLENGTH       ,  -- LONG
                            szString(1)'address   -- PCH
                     );                           -- LONG


      rcb32:=  WinEndPaint( hp  );   -- Drawing is complete

    when 16#29# =>   -- WM_CLOSE
        text_io.put(" Wm_Close");

   --  * This is the place to put your termination routines

      rcb32:=   WinPostMsg( hwn    ,    -- HWND
                           WM_QUIT ,    -- ULONG
                            mp     ,    -- MPARAM
                            mp          -- MPARAM
                 );-- Cause termination  -- BOOL32

    when others =>
        text_io.put(" Null");

  --   * Everything else comes here.  This call MUST exist
  --   * in your window procedure.
  --
  --
     rcb32 := WinDefWindowProc( hwn ,    -- HWND
                                msg,     -- ULONG
                                mp1,     -- Mparam
                                mp2      -- Mparam
                               );
     return Ulong(rcb32);
 end case;
 put_edit(" End myWindowProc msg=>",integer(msg),4);
 return zero ;

End MyWindowProc;

end helphell;
