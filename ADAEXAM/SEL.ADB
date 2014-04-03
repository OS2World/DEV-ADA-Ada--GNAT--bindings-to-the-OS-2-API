-- select example
procedure sel is

task student is
 entry lecture;
end student;

task body student is
begin
 accept lecture do
  null;
 end lecture;
end student;
procedure gohome is
begin null;
end gohome;
begin
   select
--     delay until control_time(15.0);
       delay 15.0;
       gohome;
       then abort
       Student.lecture;
end select;
end sel;
