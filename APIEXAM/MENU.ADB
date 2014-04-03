 --  menu
 with os2; use os2;
 with os2.bse; use os2.bse;
 with os2.vio; use os2.vio;
 with os2.mou; use os2.mou;
 with builtin; use builtin;
 procedure menu is
 --  pull down menu
 BUTTON1_MOVE :constant ushort:= 02; -- bit 1 : button 1 push mouse moving
 BUTTON1      :constant ushort:= 04; -- bit 2 : button 1 push
 Blank   : array(0..1) of aliased byte := ( 16#20#,16#07#);
                                         -- blank ,normal attribute
                                         -- clear screen
 MouHandle : aliased  ushort ;               -- mouse handle
 Event     : aliased  MOUEVENTINFO ;
 MouPos    : aliased PTRLOC ;          --  mouse place
 ReadType  : aliased ushort := 1;      --  0 - no wait, 1 - wait
 row       : ushort;
 rc        : apiret16 ;
 norm      :aliased uchar := 16#07#;  -- normal attribute
 revr      :aliased uchar := 16#70#;  -- inverse attribute
 begin
 rc:=  VioScrollUp(0 ,0 ,-1 ,-1 ,-1 ,Blank(0)'unchecked_access ,0 );
 if MouOpen( system.null_address, MouHandle'unchecked_access) > 0 then
    put_edit("MouOpen error rc=",integer(rc)); goto fin ;
 end if;
                                         -- draw standard mouse
 if MouDrawPtr( MouHandle ) > 0 then
    put_edit("MouDrawPtr error rc=",integer(rc)); goto fin;
 end if;

                  -- print  "MENU"
 rc:=  VioWrtCharStrAtt ( "MENU", 4, 0, 0, norm'unchecked_access, 0 );

 loop --    wait mouse event
   if MouReadEventQue( Event'unchecked_access,
                       ReadType'unchecked_access,
                       MouHandle ) > 0 then
      put_edit("MouReadEventQue error rc=",integer(rc)); goto fin;
   end if;
   rc:= MouGetPtrPos( MouPos'unchecked_access, MouHandle );
   if MouPos.col < 4 and  MouPos.row =0  then
                                         -- mark  "MENU"
     rc:=  VioWrtCharStrAtt( "MENU", 4, 0, 0, revr'unchecked_access, 0 );
                                         -- right button push
     if  Event.fs = BUTTON1   then
                                         -- enter submenu cycle
                                         -- снова ожидать события мыши
         while Event.fs = BUTTON1 or Event.fs = BUTTON1_MOVE loop
            rc:= MouReadEventQue( Event'unchecked_access,
                                  ReadType'unchecked_access,
                                  MouHandle );
            rc:= MouGetPtrPos( MouPos'unchecked_access, MouHandle );
            rc:= VioWrtCharStrAtt( "Print", 5, 1, 0,  norm'unchecked_access, 0 );
            rc:= VioWrtCharStrAtt( "Beep ", 4, 2, 0,  norm'unchecked_access, 0 );
            rc:= VioWrtCharStrAtt( "Clear", 5, 3, 0,  norm'unchecked_access, 0 );
            rc:= VioWrtCharStrAtt( "Quit ", 4, 4, 0,  norm'unchecked_access, 0 );
            case MouPos.row is           -- mark theme
              when 1 =>
               rc:= VioWrtCharStrAtt( "Print", 5, 1, 0,  revr'unchecked_access, 0 );
              when 2 =>
               rc:=  VioWrtCharStrAtt( "Beep", 4, 2, 0,  revr'unchecked_access, 0 );
              when 3 =>
               rc:=  VioWrtCharStrAtt( "Clear", 5, 3, 0,  revr'unchecked_access, 0 );
              when 4 =>
               rc:=  VioWrtCharStrAtt( "Quit", 4, 4, 0,  revr'unchecked_access, 0 );
              when others => null ;
            end case;
         end loop; -- end cycle  button relay
         for i in 1..5 loop            -- clear submenu
           rc:= VioWrtNCell( Blank(0)'unchecked_access, 5, ushort(i), 0, 0 );
         end loop;
         case MouPos.row  is  -- action
           when 1 =>                     -- write in row  12
            rc:= VioWrtCharStr( "MESSAGE", 7, 12, 0, 0 );
           when 2 =>                -- speaker
               if DosBeep( 100, 500 ) = 0 then null ; end if;
            when 3 =>                    -- clear row  12
             rc:= VioWrtNCell( Blank(0)'unchecked_access, 7, 12, 0, 0 );
            when 4 => goto fin;         -- exit
            when others => null;
         end case;
       end if;
                                        -- print  "MENU"
      rc:= VioWrtCharStrAtt ( "MENU", 4, 0, 0,  norm'unchecked_access, 0 );
     end if;
 end loop;

 rc:=  MouClose( MouHandle );
 <<fin>> null ;
 end menu;
