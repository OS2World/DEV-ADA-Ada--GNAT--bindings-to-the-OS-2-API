-- scroll
with os2; use os2;
with os2.vio; use os2.vio;
with os2.bse; use os2.bse;
with text_io; use text_io;
procedure scroll is    -- scrolling screen

 LINES       :constant ushort :=25;       -- high screen
 LINE_LENGTH :constant ushort :=80;       -- wide screen
 SCR_LENGTH  :constant ushort := LINES * LINE_LENGTH;
 HANDLE      :constant ushort :=0 ;       -- hendle
 HEIGHT      :constant ushort :=10;       -- high window
                       -- strings for window
subtype str6 is string(1..6);
str : array(1..10) of str6 :=("one...","two...","three.","four..","five..",
                             "six...","seven.","eight.","nine..","ten...");
Top       : ushort       := 0;
Left      : ushort       := 0;
            --  first byte => symbol second byte => attribute !!!
Xcell     : array(0..1) of aliased byte  := (16#58#,16#07#); -- normal, 'X'
blank     : array(0..1) of aliased byte  := (16#20#,16#70#); -- inverse, white
TopRow    : ushort       := 10;       -- window
LeftCol   : ushort       := 24;
BotRow    : ushort       := 20;
RightCol  : ushort       := 50;
lines_n   : ushort       := 1;        -- scrolling lines
attr      : uchar        := 16#70#;   -- inverse
rc        : apiret16;                 -- return code
begin
                         -- fill screen  'X'
  rc:=  VioWrtNCell( Xcell(0)'unchecked_access,
                         SCR_LENGTH, Top, Left, HANDLE );
  for j in 1..height loop
                         -- scrolling up
     if  VioScrollUp(TopRow, LeftCol, BotRow, RightCol,
                         lines_n, blank(0)'unchecked_access, HANDLE )>0
     then put("VioScrollUp error"); goto fin; end if;
                         -- print line in window bottom
     if  VioWrtCharStr( str(integer(j)), 6 , BotRow, LeftCol+1, HANDLE ) > 0
     then put("VioWrtCharStr error"); goto fin; end if;
     if  DosSleep(500)=0 then null; end if;    -- pause
  end loop;
<<fin>> null;
end scroll ;
