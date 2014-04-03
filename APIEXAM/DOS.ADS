------------------------------------------------------------------------------
--                                                                          --
--                               PM Bindings                                --
--                                                                          --
--                                DOS Spec                                  --
--                                                                          --
--                    Binding to the OS/2 DOS API routines                  --
--                                                                          --
--                            $Revision: .15$                               --
--   .15
--   Exec_Program
--                                                                          --
--   Copyright (c) 1994,1995 Dimensional Media Systems, All Rights Reserved --
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
--      Phone - (713) 486-6116                                              --
--      Email - Byow@mci.com                                                --
--                                                                          --
------------------------------------------------------------------------------

with Os2; Use Os2;

package Dos is


  type Result_Codes_Type is
    record
      Dos_Terminate : ULong;
      Result        : ULong;
    end record;


  type Object_Buffer_Type is array (UShort range <>) of Byte;

  type Exec_Flag_Type is (
      Exec_Sync,
      Exec_Async,
      Exec_Async_Result,
      Exec_Trace,
      Exec_Background,
      Exec_Load,
      Exec_Async_Result_DB);


  type Api_Return_Code is new ULong;

  function Exec_Program (
             Object_Buffer : Object_Buffer_Type;
             Exec_Flag     : Exec_Flag_Type;
             Arguments     : String;
             Enviorment    : String;
             Return_Codes  : Result_Codes_Type;
             Program       : String) return Api_Return_Code;

  end Dos;

