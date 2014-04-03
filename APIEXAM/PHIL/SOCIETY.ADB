--society.adb
with text_io;
package body Society is

  -- Dining Philosophers - Ada 95 edition
  -- Society gives unique ID's to people, and registers their names
  -- Michael B. Feldman, The George Washington University, July, 1995.

   protected body get_number is
     entry Yes ( My_ID: out  Unique_DNA_Codes ) when true is
     begin
       phil_pos := phil_pos + 1 ;
       My_id := phil_pos ;
    end Yes ;

   end get_number;

   task body draw_screen  is
   flag :boolean :=false;
   begin
   loop
     accept need_draw do
     Text_IO.Put (Item => ASCII.ESC & "[2J");
     Text_IO.Put (Item => ASCII.ESC & "[44m"); -- blue
     for i in 1..23 loop  text_io.new_line;
       for j in 1..78 loop
           if display.win(i)(j) ='³' and not flag then
              text_io.put( display.win(i)(j));
              Text_IO.Put (Item => ASCII.ESC & "[40m"); -- black
              flag:= true ;
           else if display.win(i)(j) ='³' and flag then
                   Text_IO.Put (Item => ASCII.ESC & "[44m"); -- blue
                   text_io.put( display.win(i)(j));
                   flag:= false;
                else
                   text_io.put( display.win(i)(j));
                end if;
           end if;
       end loop ;
     end loop;
     delay 1.0;
     end need_draw;
  end loop;
 end draw_screen ;

 procedure Pick_Up(I:Table_Type) is
 begin
   loop
     if not In_Use (i) then
        In_Use (i) := true ;  exit;
     end if ;
     delay 0.05 ;
   end loop;
 end PIck_Up;

 procedure Put_Down(I:Table_Type) is
 begin
    In_Use(i) := False;
 end Put_Down;

 begin null;
end Society;

