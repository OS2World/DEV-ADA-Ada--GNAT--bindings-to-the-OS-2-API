-- pad
with os2; use os2;
with os2.vio; use os2.vio;
with os2.bse; use os2.bse;
with os2.kbd; use os2.kbd;
with text_io; use Text_io;
with builtin; use builtin;

procedure pad  is  -- read key information
 WAIT   :constant ushort :=0 ;   -- wait = 0, no wait =   1
 HANDLE :constant ushort :=0 ;   -- kbd handle
 ESC    :constant ushort :=27;   -- ASCII code [Esc] pad
 keydata:aliased  KBDKEYINFO ;
 begin
  loop
                                -- read symbol
    if KbdCharIn ( keydata'unchecked_access, WAIT, HANDLE) > 0
    then put("KbdCharIn error"); goto fin; end if;
                                -- print out char data
        new_line;
        put_edit("Asii=",integer(keydata.chChar));
        put_edit(" Scan=",integer(keydata.chScan));
        put_edit(" Status=",integer(keydata.fbStatus));
        put_edit(" Dshift=",integer(keydata.bNlsShift));
        put_edit(" State =",integer(keydata.fsState));
        put_edit(" Time (milliseconds) = ",integer(keydata.time));
                               -- check for [Esc] key
        exit when  keydata.chChar =  27 ;
  end loop;
<<fin>> null ;
end pad;
