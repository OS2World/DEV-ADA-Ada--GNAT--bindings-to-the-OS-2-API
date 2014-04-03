with OS2; Use OS2;
with OS2.Gpi; Use OS2.Gpi;
with System;
package body GPI is
   Background_Mix_Values : constant array (Background_Mix_Type)
                                                     of Long :=
      (Bm_Error            => -1,
       Bm_Default          => 0,
       Bm_Or               => 1,
       Bm_Overpaint        => 2,
       Bm_Leave_Alone      => 5,
       Bm_Xor              => 4,
       Bm_And              => 6,
       Bm_Subtract         => 7,
       Bm_Mask_Src_Not     => 8,
       Bm_Zero             => 9,
       Bm_Not_Merge_Src    => 10,
       Bm_Not_Xor_Src      => 11,
       Bm_Invert           => 12,
       Bm_Merge_Src_Not    => 13,
       Bm_Not_Copy_Src     => 14,
       Bm_Merge_Not_Src    => 15,
       Bm_Not_Mask_Src     => 16,
       Bm_One              => 17,
       Bm_Src_Transparent  => 18,
       Bm_Dest_Transparent => 19);
  ---------------------------------------------------------
    Outline_Values : constant array (Outline_Style_Type)
                                               of Long :=
        (Dro_Fill         => 1,
         Dro_Outline      => 2,
         Dro_Outline_Fill => 3);
  ---------------------------------------------------------
    function Failed_To (Value : Boolean) return Boolean is
      begin
        return not Value;
      end Failed_To;
  ---------------------------------------------------------
   function Set_Background_Mix (
              Ps  : Hps;
              Mix : Background_Mix_Type) return Boolean is
     begin
       return GPISetBackMix (Ps, Background_Mix_Values (Mix)) = 1;
     end Set_Background_Mix;
  ---------------------------------------------------------
   procedure Set_Background_Mix (
              Ps  : Hps;
              Mix : Background_Mix_Type) is
    begin
     if not Set_Background_Mix (Ps, Mix) then
       raise GPI_Error;
     end if;
    end Set_Background_Mix;
  ---------------------------------------------------------
   function Set_Background_Color (
                  Ps    : Hps;
                  Color : Color_Type) return Boolean is
   begin
     return GpiSetBackColor (Ps, Long(Color)) = 1;
   end Set_Background_Color;
  ---------------------------------------------------------
   procedure Set_Background_Color (
                  Ps    : Hps;
                  Color : Color_Type) is
     begin
       if not Set_Background_Color (Ps, Color) then
         raise GPI_Error;
       end if;
     end Set_Background_Color;
  ---------------------------------------------------------
   function Set_Color (
                  Ps    : Hps;
                  Color : Color_Type) return Boolean is
   begin
     return GpiSetColor (Ps, Long(Color)) = 1;
   end Set_Color;
  ---------------------------------------------------------
   procedure Set_Color (
                  Ps    : Hps;
                  Color : Color_Type) is
     begin
       if not Set_Color (Ps, Color) then
         raise GPI_Error;
       end if;
     end Set_Color;
  ---------------------------------------------------------
  function Status_Is (Value : Long) return Status_Type is
    begin
      case Value is
        when 0      => return Error;
        when 1      => return Okay;
        when 2      => return Hits;
        when others => null;
      end case;
      return Error;
    end Status_Is;
  ---------------------------------------------------------
   function Char_String_At (
                  Ps    : Hps;
                  Point : Pointl;
                  Text  : String) return Status_Type is

     pointa : aliased pointl ; for pointa'address use point'address;
     Result : Long;
   begin
     Result := GPICharStringAt (
                 Ps         => Ps,
                 pptlPoint  => Pointa'unchecked_access,
                 lCount     => Long (Text'Length),
                 pchString  => Text (Text'first)'address);

     return Status_Is (Result);
  end Char_String_At;
  ---------------------------------------------------------
   procedure Char_String_At (
                  Ps    : in Hps;
                  Point : in Pointl;
                  Text  : in String) is
    begin
      if Error = Char_String_At (Ps, Point, Text) then
         raise GPI_Error;
      end if;
    end Char_String_At;
  ---------------------------------------------
   function Char_String (
                  Ps    : Hps;
                  Text  : String) return Status_Type is

   Result : Long;
   begin
     Result := GPICharString (
                 Ps           => Ps,
                 lCount       => Long (Text'Length),
                 pchString    => Text (Text'first)'address);
     return Status_Is (Result);
  end Char_String;
  ---------------------------------------------------------
   procedure Char_String (
                  Ps    : in Hps;
                  Text  : in String) is
    begin

      if Error = Char_String (Ps, Text) then
         raise GPI_Error;
      end if;
    end Char_String;
  ---------------------------------------------
   function Set_Current_Position (
              Ps    : Hps;
              Point : Pointl) return Boolean is

   Pointa : aliased pointl ; for pointa'address use point'address;
   Result : Bool;
   begin
     Result := GpiSetCurrentPosition (
                 Ps        => Ps,
                 pptlPoint => Pointa'unchecked_access);

     return Result = 1;
   end Set_Current_Position;

  ---------------------------------------------
   procedure Set_Current_Position (
              Ps    : Hps;
              Point : Pointl) is
    begin
      if not Set_Current_Position (Ps, Point) then
        raise Gpi_Error;
      end if;
    end Set_Current_Position;
  ---------------------------------------------
   function Query_Current_Position (
              Ps    : Hps;
              Point : PPointL) return Boolean is

   Result : Bool;
   begin
     Result := GpiQueryCurrentPosition (
                 Ps        => Ps,
                 pptlPoint => Point);

     return Result = 1;
   end Query_Current_Position;
  ---------------------------------------------
   procedure Query_Current_Position (
              Ps    : in     Hps;
              Point :    out Pointl) is

   Pointa : aliased pointl ; for pointa'address use point'address;
     Result : Bool;
   begin
     Result := GpiQueryCurrentPosition (
                 Ps        => Ps,
                 pptlPoint => Pointa'unchecked_access);

     if Result /= 1 then
       raise GPI_Error;
     end if;
   end Query_Current_Position;
  ---------------------------------------------
   function Erase (Ps : Hps) return Boolean is

     Result : Bool;
   begin
     Result := GpiErase (Ps);
     return Result = 1;
   end Erase;
  ---------------------------------------------
   procedure Erase (Ps : Hps) is
     begin
      if Failed_To (Erase (Ps)) then
        raise GPI_Error;
      end if;
     end Erase;
  ---------------------------------------------
   function Destroy_Ps (Ps : Hps) return Boolean is

   Result : ulong;
   begin
   Result := GpiDestroyPS (Ps);
   return Result = 1;
   end Destroy_Ps;
  ---------------------------------------------
   procedure Destroy_Ps (Ps : in Hps) is
     begin
      if Failed_To (Destroy_Ps (Ps)) then
        raise Gpi_Error;
      end if;
     end Destroy_Ps;
  ---------------------------------------------
   function Move (
              Ps    : Hps;
              Point : Pointl) return Boolean is

   Pointa : aliased pointl ; for pointa'address use point'address;
     Result : Bool;
   begin
     Result := GpiMove (
                 Ps        => Ps,
                 pptlPoint => Pointa'unchecked_access);

     return Result = 1;
   end Move;
  ---------------------------------------------
   procedure Move (
              Ps    : Hps;
              Point : Pointl) is
    begin
      if not Move (Ps, Point) then
        raise Gpi_Error;
      end if;
    end Move;
  ---------------------------------------------
   function Set_Line_End (
              Ps        : Hps;
              Style     : Line_End_Style_Type) return Boolean is
     begin
       return False;
     end Set_Line_End;
  ---------------------------------------------
   procedure Set_Line_End (
              Ps        : in Hps;
              Style     : in Line_End_Style_Type) is
    begin
      null;
    end Set_Line_End;
  ---------------------------------------------
   function Query_Line_End (Ps : Hps)
                                   return Line_End_Style_Type is
     begin
      return Line_End_Style_Type'first;
     end Query_Line_End;
  ---------------------------------------------
   function Set_Line_Join (
              Ps        : Hps;
              Style     : Line_Join_Style_Type) return Boolean is
     begin
       return False;
     end Set_Line_Join;
  ---------------------------------------------
   procedure Set_Line_Join (
              Ps        : in Hps;
              Style     : in Line_Join_Style_Type) is
    begin
      null;
    end Set_Line_Join;
  ---------------------------------------------
   function Query_Line_Join (Ps : Hps)
                                     return Line_Join_Style_Type is
     begin
       return Line_Join_Style_Type'first;
     end Query_Line_Join;
  ---------------------------------------------
   function Line (
              Ps        : Hps;
              End_Point : Pointl) return Status_Type is

   Pointa : aliased pointl ; for pointa'address use End_point'address;
     Result : Long;
   begin

     Result := GpiLine (Ps           => Ps,
                        pptlEndPoint => Pointa'unchecked_access);

     return Status_Is (Result);
   end Line;
  ---------------------------------------------
   procedure Line (
              Ps        : Hps;
              End_Point : Pointl) is
    begin
      if Error = Line (Ps, End_Point) then
        raise Gpi_Error;
      end if;
    end Line;
  ---------------------------------------------
   procedure Line (
              Ps          : Hps;
              Start_Point : Pointl;
              End_Point   : Pointl) is
    begin
      if Failed_To (Set_Current_Position (Ps, Start_Point)) or else
             Error = Line (Ps, End_Point) then
           raise Gpi_Error;
      end if;
    end Line;
  ---------------------------------------------
   function Box (
              Ps            : Hps;
              Corner_Point  : Pointl;
              Outline_Style : Outline_Style_Type;
              Horz_Rounding : Long;
              Vert_Rounding : Long) return Status_Type is
     Corner_P : aliased Pointl ;  for Corner_P'address use Corner_Point'address;
     Result : Long;
   begin
     Result := GpiBox (
                    Ps         => Ps,
                    lControl   => Outline_Values (Outline_Style),
                    pptlPoint  => Corner_P'unchecked_access,
                    lHRound    => Horz_Rounding,
                    lVRound    => Vert_Rounding);

     return Status_Is (long(Result));
   end Box;
  ---------------------------------------------
   procedure Box (
              Ps            : in Hps;
              Corner_Point  : in Pointl;
              Outline_Style : in Outline_Style_Type;
              Horz_Rounding : in Long;
              Vert_Rounding : in Long) is
    begin
     if Error = Box (Ps,
                     Corner_Point,
                     Outline_Style,
                     Horz_Rounding,
                     Vert_Rounding) then
       raise Gpi_Error;
     end if;
    end Box;
  ---------------------------------------------
   procedure Box (
              Ps            : in Hps;
              Start_Corner  : in Pointl;
              End_Corner    : in Pointl;
              Outline_Style : in Outline_Style_Type;
              Horz_Rounding : in Long;
              Vert_Rounding : in Long) is
    begin

      if Failed_To (Set_Current_Position (Ps, Start_Corner)) or else
         Error = Box (Ps,
                      End_Corner,
                      Outline_Style,
                      Horz_Rounding,
                      Vert_Rounding) then
         raise Gpi_Error;
      end if;
    end Box;
 ---------------------------------------------
   function Set_Arc_Parameters (
              Ps         : Hps;
              Parameters : ArcParams) return Boolean is

 parm:aliased ArcParams; for parm'address use Parameters'address;
 Result : Bool;

     begin
       Result := GpiSetArcParams (Ps             => Ps,
                                  parcpArcParams => Parm'unchecked_access);
       return Result = 1;

     end Set_Arc_Parameters;
 ---------------------------------------------
   procedure Set_Arc_Parameters (
              Ps         : in Hps;
              Parameters : in ArcParams) is
     begin
       if not Set_Arc_Parameters (Ps, Parameters) then
          raise Gpi_Error;
       end if;
     end Set_Arc_Parameters;
 ---------------------------------------------
   function Query_Arc_Parameters (
              Ps         : Hps;
              Parameters : PArcParams)
                                          return Boolean is

     Result : Bool;
     begin
       Result := GpiQueryArcParams (Ps             => Ps,
                                    parcpArcParams => Parameters);
       return Result = 1;
     end Query_Arc_Parameters;
 ---------------------------------------------
   procedure Query_Arc_Parameters (
              Ps         : in     Hps;
              Parameters :    out ArcParams) is

parm: aliased ArcParams; for parm'address use Parameters'address;
Result : Bool;
     begin
       Result := GpiQueryArcParams (Ps             => Ps,
                                    parcpArcParams => Parm'unchecked_access);
       if Result /= 1 then
         raise GPI_Error;
       end if;
     end Query_Arc_Parameters;
 ---------------------------------------------
   function Set_Default_Arc_Parameters (
              Ps         : Hps;
              Parameters : ArcParams) return Boolean is

 parm:aliased ArcParams; for parm'address use Parameters'address;
     Result : Bool;
     begin

       Result := GpiSetDefArcParams (Ps            => Ps,
                                     parcpArcParams => Parm'unchecked_access);
       return Result = 1;
     end Set_Default_Arc_Parameters;
 ---------------------------------------------
   procedure Set_Default_Arc_Parameters (
              Ps         : in Hps;
              Parameters : in ArcParams) is
     begin
       if not Set_Default_Arc_Parameters (Ps, Parameters) then
          raise Gpi_Error;
       end if;
     end Set_Default_Arc_Parameters;
 ---------------------------------------------
   function Query_Default_Arc_Parameters (
              Ps         : Hps;
              Parameters : PArcParams)
                                             return Boolean is

     Result : Bool;
     begin

       Result := GpiQueryDefArcParams (Ps             => Ps,
                                       parcpArcParams => Parameters);
       return Result = 1;
     end Query_Default_Arc_Parameters;
 ---------------------------------------------
   procedure Query_Default_Arc_Parameters (
              Ps         : in     Hps;
              Parameters :    out ArcParams) is

parm: aliased ArcParams; for parm'address use Parameters'address;
     Result : Bool;

     begin
       Result := GpiQueryDefArcParams (Ps             => Ps,
                                       parcpArcParams => Parm'unchecked_access);
       if Result /= 1 then
         raise GPI_Error;
       end if;
     end Query_Default_Arc_Parameters;
 ---------------------------------------------
  --GNAT BUG

   function Full_Arc (
              Ps            : Hps;
              Outline_Style : Outline_Style_Type;
              Multiplier    : Multipler_Type) return Status_Type is

      Result : Long;
      Mult   : Long;

     begin
      Mult := 65_536 * Long (Multiplier);
      Result := GpiFullArc (Ps            => Ps,
                            LControl      => Outline_Values (Outline_Style),
                            fxMultiplier  => Mult);
      return Status_Is (Long(Result));

     end Full_Arc;
 ---------------------------------------------
   procedure Full_Arc (
              Ps            : in Hps;
              Outline_Style : in Outline_Style_Type;
              Multiplier    : in Multipler_Type) is
     begin
       if Error = Full_Arc (Ps, Outline_Style, Multiplier) then
         raise Gpi_Error;
       end if;
     end Full_Arc;
 ---------------------------------------------
   procedure Full_Arc (
              Ps            : in Hps;
              Center        : in Pointl;
              Arc_Params    : in ArcParams;
              Outline_Style : in Outline_Style_Type;
              Multiplier    : in Multipler_Type) is
    begin

      if Failed_To (Set_Current_Position (Ps, Center)) or else
         Failed_To (Set_Arc_Parameters (Ps, Arc_Params)) or else
         Error = Full_Arc (Ps, Outline_Style, Multiplier) then
          raise Gpi_Error;
      end if;
end Full_Arc;

end GPI;
