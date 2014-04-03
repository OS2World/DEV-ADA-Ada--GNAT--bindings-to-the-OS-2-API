--  event2
with os2; use os2;
with os2.vio; use os2.vio;
with os2.mou; use os2.mou;
with builtin; use builtin;
procedure mou2 is

BUTTON2 :constant ushort:= 16#10#; --  bit 4 : buttton 2 push
UPPER   :constant ushort:=   5   ;
LOWER   :constant ushort:=  15   ;
LEFT    :constant ushort:=   5   ;
RIGHT   :constant ushort:=  31   ;

str1 :constant string(1..15):= "Test Test Test" & character'val(0);
len  :aliased ushort := ushort(str1'length);
Blank   : array(0..1) of aliased byte := ( 16#20#,16#07#);
                                        -- blank ,normal attribute
                                        -- clear screen
Fill    : array(0..1) of aliased byte := ( 16#20#,16#17#);
    -- blank , blue
MouHandle : aliased  ushort ;               -- mouse handle
Event     : aliased  MOUEVENTINFO ;
ReadType  : aliased ushort := 1;      --  0 - no wait, 1 - wait

MouPos    : aliased PTRLOC ;          --  mouse place
OldCur    : aliased VIOCURSORINFO;    --  old cursor
Cursor    : aliased VIOCURSORINFO;    --  new cursor
row       : ushort;
rc : apiret16    ;                    --  return code
text : string(1..27) := "Event=... row =... col =..." ;
pos  : string(1..3) ;
begin
rc:=  VioScrollUp(0 ,0 ,-1 ,-1 ,-1 ,Blank(0)'unchecked_access ,0 );



rc:=  VioGetCurType( OldCur'unchecked_access, 0 ); -- get old cursor
Cursor.yStart :=  0 ;               -- doing
Cursor.cEnd   :=  0 ;               -- current
Cursor.cx     :=  1 ;               -- cursor
Cursor.attr   := -1 ;               -- invisible

rc:=  VioSetCurType( Cursor'unchecked_access, 0 );

                                        -- get mouse handle
if MouOpen( system.null_address, MouHandle'unchecked_access) > 0 then
   put_edit("MouOpen error rc=",integer(rc)); goto fin ;
end if;

MouPos.col := 40;                  -- cursor position
MouPos.row :=  5;
if MouSetPtrPos( MouPos'unchecked_access, MouHandle ) > 0 then
   put_edit("MouSetPtrPos error rc=",integer(rc)); goto fin ;
end if;
                                        -- draw standard mouse
if MouDrawPtr( MouHandle ) > 0 then
   put_edit("MouDrawPtr error rc=",integer(rc)); goto fin;
end if;
                                        -- light region
for  row in UPPER..LOWER loop
  rc:=    VioWrtNCell( Fill(0)'unchecked_access, RIGHT-LEFT+1, row, LEFT, 0 );
end loop;
                                        -- title

rc:=    VioWrtCharStr(str1         ,len  , UPPER+1, LEFT+1, 0 );

loop --    wait mouse event
  if MouReadEventQue( Event'unchecked_access,
                      ReadType'unchecked_access,
                      MouHandle ) > 0 then
     put_edit("MouReadEventQue error rc=",integer(rc)); goto fin;
  end if;
  rc:= MouGetPtrPos( MouPos'unchecked_access, MouHandle );
  pos := put_i( integer(Event.fs),3);  overlay(text, 7,pos);
  pos := put_i(integer(MouPos.row),3); overlay(text,16,pos);
  pos := put_i(integer(MouPos.col),3); overlay(text,25,pos);
  -- write current mouse information
  rc  := VioWrtCharStr(text         ,27   , UPPER+3, LEFT  , 0 );

  if  Event.fs = BUTTON2   then exit; end if;  -- right buutton

end loop ;
rc:=  MouClose( MouHandle );            -- free mouse handle
rc:=  VioSetCurType(OldCur'unchecked_access, 0 ); -- restore old cursor

<<fin>> null;
end mou2;
