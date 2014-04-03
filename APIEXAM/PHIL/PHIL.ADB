--phil.adb
with Society;
with Room;
with Random_G;
package body Phil is

  -- Dining Philosophers - Ada 95 edition
  -- Philosopher is an Ada 95 task type with discriminant.

  -- Chopsticks are assigned by a higher authority, which
  --   can vary the assignments to show different algorithms.
  -- Philosopher always grabs First_Grab, then Second_Grab.
  -- Philosopher is oblivious to outside world, but needs to
  --   communicate is life-cycle events the Maitre_D.

  -- Michael B. Feldman, The George Washington University,
  -- July, 1995.

  subtype Think_Times is Positive range 1..8;
  package Think_Length is
    new Random_G (Result_Subtype => Think_Times);

  subtype Meal_Times is Positive range 1..10;
  package Meal_Length is
    new Random_G (Result_Subtype => Meal_Times);

  task body Philosopher  is

    subtype Life_Time is Positive range 1..5;

    Who_Am_I    : society.Unique_DNA_Codes ; -- discrim
    First_Grab  : Positive;
    Second_Grab : Positive;
    Meal_Time   : Meal_Times;
    Think_Time  : Think_Times;

  begin
     Society.get_number.Yes(Who_Am_I) ; -- call entry point protected object
     -- get assigned the first and second chopsticks here
    accept Start_Eating (Chopstick1 : in Positive;
                         Chopstick2 : in Positive) do
      First_Grab  := Chopstick1;
      Second_Grab := Chopstick2;
    end Start_Eating;

    Room.Maitre_D.Report_State (Who_Am_I, Breathing);

    for Meal in Life_Time loop
      Society.Pick_Up(First_Grab);
      Room.Maitre_D.Report_State (Who_Am_I, Got_One_Stick, First_Grab);

      Society.Pick_Up(Second_Grab);

      Room.Maitre_D.Report_State (Who_Am_I, Got_Other_Stick, Second_Grab);

      Meal_Time := Meal_Length.Random_Value;

      Room.Maitre_D.Report_State (Who_Am_I, Eating, Meal_Time, Meal);

      delay Duration (Meal_Time);


      Room.Maitre_D.Report_State (Who_Am_I, Done_Eating);

      Society.Put_Down(First_Grab);

      Society.Put_Down(Second_Grab);

      Think_Time := Think_Length.Random_Value;

      Room.Maitre_D.Report_State (Who_Am_I, Thinking, Think_Time);

      delay Duration (Think_Time);

    end loop;

    Room.Maitre_D.Report_State (Who_Am_I, Dying);


  end Philosopher;

end Phil;
