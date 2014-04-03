--diners.adb
with Text_io;
with Society ;
with Room;
procedure Diners is

  -- Dining Philosophers - Ada 95 edition
  -- This is the main program, responsible only for telling the
  --   Maitre_D to get busy.
  -- Michael B. Feldman, The George Washington University,  July, 1995.

begin
  Society.display.win(1)(8..12) := "Start" ;
  Room.Maitre_D.Start_Serving;
exception
 when others => null ;
end Diners;
