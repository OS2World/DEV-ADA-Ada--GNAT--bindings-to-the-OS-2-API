-- example dynamic array creation
-- this example demonstrate how
-- to create dynamic array of any
-- type in ADA 95

with addtype; use addtype;
with text_io; use text_io;
procedure dynam is
type pvect is access all ivector;
p : pvect;
i : integer;
package int_io is new integer_io(integer); use int_io;
begin

put(" Enter array length :"); get(i);
p := new ivector(1..i) ;   -- dynamic object creation
for j in 1..i loop p(j) := 2*j; end loop;
new_line;
for j in 1..i loop put(p(j)); end loop;
end dynam;
