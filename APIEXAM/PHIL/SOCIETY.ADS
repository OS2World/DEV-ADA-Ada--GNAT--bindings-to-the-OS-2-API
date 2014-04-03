--society.ads
package Society is

  -- Dining Philosophers - Ada 95 edition
  -- Society gives unique ID's to people, and registers their names
  -- Michael B. Feldman, The George Washington University, July, 1995.

  subtype Unique_DNA_Codes is Positive range 1..5;

  Table_Size : constant := 5;
  subtype Table_Type is Positive range 1 .. Table_Size;
  type    Flags is array(Table_Type) of boolean ;

  phil_pos : integer range 0..5  := 0 ; -- philosopher number

 protected get_number is -- get number
   entry Yes ( My_ID: out  Unique_DNA_Codes );
 end get_number;

  Name_Register : array(Unique_DNA_Codes) of String(1..18) :=

     ("Edsger Dijkstra   ",
      "Bjarne Stroustrup ",
      "Chris Anderson    ",
      "Tucker Taft       ",
      "Jean Ichbiah      ");
   Subtype s80 is string(1..80) ;
   Type show_screen is array (1..25) of s80;
   type  draw is record
   raw:  integer range 1..25 ;
   col:  integer range 1..80 ;
   win:  show_screen  ;
   end record ;

   display :  draw ;

 task draw_screen is
   entry need_draw;
 end draw_screen ;

 In_Use: Flags := (others => False);
 fl    : boolean   ;
 procedure Pick_Up (I:Table_Type);
 procedure Put_Down(I:Table_Type);

end Society;
