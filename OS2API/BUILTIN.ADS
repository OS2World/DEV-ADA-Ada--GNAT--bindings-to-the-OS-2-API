
-- ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
-- º       D E S I G N   E N G I N E R I N G              ºDºSº        º
-- º            S O F T W A R E                           ÈÍÊÍ¼        º
-- º                                                                   º
-- º        Package   BUILTIN                                          º
-- º          Common package for working with string                   º
-- º        Author :  Leonid Dulman     1995                           º
-- º                                                                   º
-- ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
package  BUILTIN is
varing_max:integer:=255;

type VARING(len:integer:=varing_max) is record
len_str:integer:=0; -- range 0..varing_max:=0;
cnt_str:string(1..len);
end                    record;

function date_means return string;  --  dd.mm.yy
function time_means return string;  --  hh:mm:cc
-- ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
-- ³      functions and  procedures                         ³
-- ³       for string operations                            ³
-- ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
procedure put_edit(s:string;a:float;pos:integer:=7); -- print
procedure put_edit(s:string;a:integer;pos:integer:=4); -- print
function comp_str(s1,s2:in string)return boolean;--Compare string
function get_i(s:in string)     return integer;--Read number
function get_f(s:in string)     return float  ;
function put_i(item:in integer;pos:integer:=6) return string ;--Write number
function put_e(item:in float;pos:integer:=8 ) return string ;
function put_f(item:in float;pos:integer:=8 ) return string ;
function substr(s:in string;pos:integer:=1;len:integer)return string;
function left  (s:in string;pos:integer          )return string;
function right (s:in string;pos:integer:=1)return string;
function var_len(s:in string)return integer;     -- Length until blank
function index(s:in string;ss:string)return integer;     -- Dispos   substring in string
function index(s:in string;ss:character)return integer;  --
function verify(s:in string;ss:string;pos:integer:=1)return integer;  --
procedure clean(s:in out string);                -- Transfer blanks to end
procedure overlay(s:in out string;pos:integer;ss:string); -- string overlay
procedure overlay(s:in out string;pos:integer;ss:character);
procedure translate(s:in out string;change,map:string);
procedure ctext(s:in out string); -- centr text
procedure upper_low(s:in out string;uplow:character:='u'); -- Upper - Low
-- ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
-- ³      functions and  procedures                         ³
-- ³       for varing operations                            ³
-- ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
procedure put(s:varing; pos:integer); -- string output
function comp_str(s1,s2:in varing)return boolean;--compare string
function substr(s:in varing;pos:integer:=1;len:integer)return varing;
function substr(s:in varing;pos:integer:=1;len:integer)return string;
function left  (s:in varing;pos:integer          )return varing;
function right (s:in varing;pos:integer:=1)return varing;
function left  (s:in varing;pos:integer          )return string;
function right (s:in varing;pos:integer:=1)return string;
function get_i(s:in varing)     return integer; --Read number
function get_f(s:in varing)     return float  ;
function put_i(item:in integer;pos:integer:=6) return varing ;--Write nuber
function put_e(item:in float;pos:integer:=8 ) return varing ;
function put_f(item:in float;pos:integer:=8 ) return varing ;
function var_len(s:in varing)return integer;     -- Length until blak in end
function index(s:in varing;ss:string)return integer;
function verify(s:in varing;ss:string;pos:integer:=1)return integer;
function index(s:in varing;ss:character)return integer;
function "&" (s1,s2:varing) return varing;
procedure clean(s:in out varing);                -- Clear begining blanks
procedure overlay(s:in out varing;pos:integer;ss:varing); -- String overlay
procedure overlay(s:in out varing;pos:integer;ss:string);
procedure overlay(s:in out varing;pos:integer;ss:character);
procedure translate(s:in out varing;change,map:string);
procedure null_len (s:in out varing) ;

-- Input stream string until separator
procedure  begent(s:in out varing;pictend:character;err:in out boolean) ;
procedure helpstr(str:varing;kl:in out integer;
                  err:out boolean; strend:character:=';');

procedure upper_low(s:in out varing;uplow:character:='u');
-- ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
-- ³              functions                                 ³
-- ³     for integer and float  operations                  ³
-- ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
function min(x,y:float) return float;
function max(x,y:float) return float;
function min(x,y:integer) return integer;
function max(x,y:integer) return integer;
function sign(x:integer) return integer;
function sign(x:float) return integer;
-----------------------------------------------------------------------
end BUILTIN;
