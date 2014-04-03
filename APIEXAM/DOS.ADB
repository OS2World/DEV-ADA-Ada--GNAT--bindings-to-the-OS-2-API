------------------------------------------------------------------------------
--                                                                          --
--                               PM Bindings                                --
--                                                                          --
--                                DOS Body                                  --
--                                                                          --
--                    Binding to the OS/2 DOS API routines                  --
--                                                                          --
--                            $Revision: .1 $                               --
--                                                                          --
--     Copyright (c) 1994 Dimensional Media Systems, All Rights Reserved    --
--                                                                          --
--   The PM bindings are free software; you can redistribute them and/or    --
--   modify them under terms of the GNU General Public License as published --
--   by the Free Software Foundation; either version 2, or (at your         --
--   option) any later version.  The PM bindings are distributed in the     --
--   hope that they will be useful, but WITH OUT ANY WARRANTY; without even --
--   the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR    --
--   PURPOSE.  See the GNU General Public License for more details.  You    --
--   should have received a copy of the GNU General Public License          --
--   distributed with The PM bindings; see file COPYING.  If not, write to  --
--   the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.  --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
--   For more information about these PM bindings and their usage with GNAT --
--   you can contact Bill Yow at                                            --
--                                                                          --
--      Dimensional Media Systems (DMS)                                     --
--      1522 Festival Dr.                                                   --
--      Houston TX, 77062                                                   --
--      Phone - (713) 488-7050                                              --
--      Email - Byow@mci.com                                                --
--                                                                          --
------------------------------------------------------------------------------

with System;
with Os2; Use Os2;

package body Dos is

   Exec_Flag_Values : constant array (Exec_Flag_Type) of ULong := (
      Exec_Sync             => 0,
      Exec_Async            => 1,
      Exec_Async_Result     => 2,
      Exec_Trace            => 3,
      Exec_Background       => 4,
      Exec_Load             => 5,
      Exec_Async_Result_DB  => 6);


  function Exec_Program (
             Object_Buffer : Object_Buffer_Type;
             Exec_Flag     : Exec_Flag_Type;
             Arguments     : String;
             Enviorment    : String;
             Return_Codes  : Result_Codes_Type;
             Program       : String) return Api_Return_Code is

     function DosExecPgm (
         Object_Buffer   : System.Address;
         Buffer_Size     : Long;
         Exec_Flag       : ULong;
         Arguments       : System.Address;
         Enviorment      : System.Address;
         Return_Codes    : System.Address;
         Program         : System.Address) return Api_Return_Code;

         pragma Import (Convention => C,
                        Entity     => DosExecPgm,
                        Link_Name  => "DosExecPgm");

    Args : String (Arguments'first .. Arguments'last + 1);
    Env  : String (Enviorment'first .. Enviorment'last + 1);
    Pgm  : String (Program'first .. Program'last + 1);

  begin

    Args := Arguments & ASCII.Nul;
    Env  := Enviorment & ASCII.Nul;
    Pgm  := Program & ASCII.Nul;

    return DosExecPgm (
            Object_Buffer   => Object_Buffer (Object_Buffer'first)'address,
            Buffer_Size     => Long (Object_Buffer'length),
            Exec_Flag       => Exec_Flag_Values (Exec_Flag),
            Arguments       => Args (Args'first)'address,
            Enviorment      => Env (Env'first)'address,
            Return_Codes    => Return_Codes'address,
            Program         => Pgm (Pgm'first)'address);

   end Exec_Program;

 end Dos;
