--
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package   ADDTYPE  some array types                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
--
package addtype  is

 type vector is array(integer range <>  )                  of float;
 type matrix is array(integer range <> ,integer range <> ) of float;
 type ivector is array(integer range <>  )                 of integer;
 type imatrix is array(integer range <> ,integer range <> ) of integer;
 type bvector is array(integer range <>  )                  of boolean;
 type bmatrix is array(integer range <> ,integer range <> ) of boolean;
 type tenzor is array(integer range <> ,integer range <>,integer range <>) of float;
 type itenzor is array(integer range <> ,integer range <>,integer range <>) of integer;
 type btenzor is array(integer range <> ,integer range <>,integer range <>) of boolean;
end addtype;
