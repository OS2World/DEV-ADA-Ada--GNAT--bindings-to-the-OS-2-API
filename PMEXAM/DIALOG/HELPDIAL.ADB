with System;
with os2; use os2;
with os2.bse ; use os2.bse ;
with os2.pmwb; use os2.pmwb;
with os2.pmsc; use os2.pmsc;
with os2.pmwd; use os2.pmwd;
with os2.pmcp; use os2.pmcp;
with os2.pmcl; use os2.pmcl;
with os2.pmer; use os2.pmer;
with os2.Gpi ; use os2.Gpi ;
with text_io; use text_io;
with builtin; use builtin;
package body helpdial is

function MyWindowProc(hwn:HWND ; msg:ULONG;mp1,mp2:MPARAM) return ulong is
hp     :HPS    ;                      -- Presentation space handle
pt     :aliased POINTL ;    -- String screen coordinates
rc     :aliased RECTL  ;    -- Window rectangle
begin

 case  msg is
when       WM_CREATE  =>
--  Window initialization - load "You live in" string from resource

 rcl  := WinLoadString( ha,
                0,        -- Resource is in .EXE file
                ID_RESPONSE,          -- String identifier
                long(length_string),                 -- Size of buffer
                szResponse'address);     -- Buffer
when       WM_COMMAND  =>

-- When the user chooses "Where..." from the Options pull-down,
-- the application displays a dialog box. WinDlgBox calls the
-- dialog procedure below. WinDlgBox does not return until the
-- dialog procedure returns.
-- WinInvalidateRegion sends a WM_PAINT message.
--
    case  mp1  is
      when ID_WHERE  =>

rcul:=  WinDlgBox( HWND_DESKTOP,         -- Place anywhere on desktop
                   hwndFrame,            -- Owned by frame
                   MyDlgProc'address,    -- Address of dialog procedure
                   0         ,           -- Module handle
                   ID_MYDIALOG        ,  -- Dialog identifier in resource
                   System.Null_Address); -- Initialization data

rcb32:=  WinInvalidateRegion( hwn, 0, 0 ); -- Force a repaint
-- put_edit(" WinInvalidateRegion ",integer(rcb32));

    when      ID_EXITPROGRAM  =>
--
rcb32:=   WinPostMsg( hwn, WM_CLOSE, 0 , 0);

   when others =>
          return WinDefWindowProc( hwn, msg, mp1, mp2 );
  end case;

    when  WM_PAINT  =>
--  Window contents are drawn here. First time through, bComplete
--  is 0, so window is simply filled with SYSCLR_WINDOW.
--  On subsequent passes, if bComplete has been set to TRUE in the
--  dialog procedure, GpiCharStringAt draws the text.

            hp := WinBeginPaint( hwn, 0   , rc'unchecked_access );
            rcb32:=WinFillRect( hp, rc'unchecked_access, SYSCLR_WINDOW );
-- put_edit(" WinFillRect ",integer(rcb32));
-- new_line; put_edit(" bComplete ",integer(bComplete));
  if  bComplete > 0 then
        rcb:= GpiSetColor( hp, CLR_NEUTRAL ); -- Text color same as PM
-- put_edit(" GpiSetColor ",integer(rcb  ));
              pt.x := 50 ; pt.y := 50 ;    -- Coordinates of "You live in"
        rcl:= GpiCharStringAt( hp, pt'unchecked_access, LONG(szResponse'length),
                              szResponse'address);
-- put_edit(" GpiCharStringAt 1 ",integer(rcl  ));
              pt.x := 50 ; pt.y := 30 ;         -- Coordinates of location
        rcl:= GpiCharStringAt( hp, pt'unchecked_access, LONG(szLocation'length), szLocation(1)'address );
-- put_edit(" GpiCharStringAt 2 ",integer(rcl  ));
  end if;
  rcb:=     WinEndPaint( hp );               -- Drawing is complete
-- put_edit(" WinEndPaint ",integer(rcb  ));
        when Ulong(WM_CLOSE) =>
  rcb32:= WinPostMsg( hwn, WM_QUIT ,0, 0 );     -- Cause termination
--   put_edit(" WinPostMsg ",integer(rcb32));

        when others =>

-- Must have WinDefWindowProc in your window procedure

  return WinDefWindowProc( hwn, msg, mp1, mp2 );
end case ;
return  0;
end MyWindowProc;

function  MyDlgProc (hwndDlg:HWND ; msg:ULONG;mp1,mp2:MPARAM)  return ulong is

begin

 case   msg is
 when       WM_INITDLG  =>
 SetSysMenu(hwndDlg);             -- remove unused sys. menu items

 when WM_COMMAND =>                    -- Posted by pushbutton or key

-- PM sends a WM_COMMAND message when the user presses either
-- the Enter or Escape pushbuttons.
    case mp1  is      -- Extract the command value
    when      DID_OK  =>    -- The Enter pushbutton or key.
                      -- WinQueryWindowText copies the
                     -- contents of the entry field
                     -- into szLocation.
      rcl  := WinQueryWindowText( WinWindowFromID( hwndDlg, ID_ENTRYFIELD ),
                               long(length_string),
                               szLocation'address );
      bComplete := 1   ;         -- Set case so strings are
                                         -- drawn in WM_PAINT processing.

      rcul:= ulong(WinDefDlgProc( hwndDlg, msg, mp1, mp2 ));
      return rcul;

    when      DID_CANCEL  =>       -- The Cancel pushbutton or Escape key
       rcb32:=    WinDismissDlg( hwndDlg, 1 );  -- Removes the dialog box
                  return  0;
       when others => null ;
    end case;
    when others =>

--  Any event messages that the dialog procedure has not processed
--  come here and are processed by WinDefDlgProc.
--  This call MUST exist in your dialog procedure.

      rcul:= ulong(WinDefDlgProc( hwndDlg, msg, mp1, mp2 ));
      return rcul;

 end case;
 return 0;
end MyDlgProc;

function ProdInfoDlgProc(hwn:HWND ; msg:ULONG;mp1,mp2:MPARAM )  return ulong is
begin

 case msg is

 when       WM_INITDLG  =>
  SetSysMenu(hwn);              -- remove unused sys. menu items

when       WM_COMMAND  =>

--  No matter what the command, close the dialog

rcb:=        WinDismissDlg(hwn, 1);

when others =>
  rcl:=       WinDefDlgProc(hwn, msg, mp1, mp2) ;
  return Ulong(rcl);
end case;
return 0;
end ProdInfoDlgProc;

procedure DisplayMessage(str:astring) is
errstr:astring(1..37):= "Error Messages For The Dialog Sample" & nul_char;
begin

--  This routine calls WinMessageBox to display error messages to the
--  user.
--
rcb32:= WinMessageBox(HWND_DESKTOP, HWND_DESKTOP, str'address,
        errstr'address , ID_MESSAGEBOX,
        MB_OK or MB_APPLMODAL or MB_MOVEABLE or MB_ERROR);

end DisplayMessage;

procedure SetSysMenu(hwndDlg:HWND ) is

sMenuItems    :Long     ;
usItemid      :Long             ;
menu_Item     :aliased MENUITEM:=(0,0,0,0,0,0)  ;
menu_null     :MENUITEM :=(0,0,0,0,0,0) ;
hwndSubMenu   :HWND             ;
begin
   new_line; put("SetSysMenu"); 
-- Determine the definition of the system menu

   WinSendDlgItemMsg(hwndDlg,FID_SYSMENU , MM_QUERYITEM,
                        SC_SYSMENU,
                       menu_Item'unchecked_access );
   hwndSubMenu := menu_Item.hwndSubMenu;

--  Find the number of items in the in the submenu
   sMenuItems :=  Long (WinSendMsg(hwndSubMenu,
                mm_queryitemcount,0 ,menu_null ));

--     * Loop through the submenu items and remove disabled
--     * menu items and menu separators.

loop
   put_edit(" WinSendMsg ",integer(sMenuItems));
    sMenuItems := sMenuItems -1 ;
    exit when sMenuItems = 0;

--  Find the item ID for the current position.
     usItemid := Long  (WinSendMsg(hwndSubMenu,MM_ITEMIDFROMPOSITION,
                    Mparam(sMenuItems), menu_null));
 return;

-- Query the definition of the current item
     rcl  := WinSendMsg(hwndSubMenu, MM_QUERYITEM,
                   Mparam(usItemid) , menu_Item );

--  If the menu item is disabled or the item has a style
--  of MIS_SEPARATOR - delete it.

    menu_null.iposition := short(mia_disabled) ;
    if WinSendMsg(hwndSubMenu, MM_QUERYITEMATTR,
           Mparam(usItemid) , menu_null    ) > 0 or
         (Ulong(menu_Item.afStyle) =  MIS_SEPARATOR )
    then
    menu_null.iposition := 0  ;
       rcl := WinSendMsg(hwndSubMenu, MM_DELETEITEM,
       Mparam(usItemid) ,menu_null );
   end if;
end loop;
end SetSysMenu;

end helpdial;
