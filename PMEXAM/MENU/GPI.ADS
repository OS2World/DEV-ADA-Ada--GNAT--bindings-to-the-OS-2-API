with OS2;Use OS2;
with OS2.Gpi;Use OS2.Gpi;
package GPI is

   GPI_Error  : exception;

   type Status_Type is (Okay, Hits, Error);

   type Background_Mix_Type is (
       Bm_Error,
       Bm_Default,
       Bm_Or,
       Bm_Overpaint,
       Bm_Leave_Alone,
       Bm_Xor,
       Bm_And,
       Bm_Subtract,
       Bm_Mask_Src_Not,
       Bm_Zero,
       Bm_Not_Merge_Src,
       Bm_Not_Xor_Src,
       Bm_Invert,
       Bm_Merge_Src_Not,
       Bm_Not_Copy_Src,
       Bm_Merge_Not_Src,
       Bm_Not_Mask_Src,
       Bm_One,
       Bm_Src_Transparent,
       Bm_Dest_Transparent);

   function Set_Background_Mix (
              Ps  : Hps;
              Mix : Background_Mix_Type) return Boolean;

   procedure Set_Background_Mix (
              Ps  : Hps;
              Mix : Background_Mix_Type);

   type Color_Type is private;

   Clr_False        : constant Color_Type;
   Clr_True         : constant Color_Type;
   Clr_Error        : constant Color_Type;
   Clr_Default      : constant Color_Type;

   Clr_White        : constant Color_Type;
   Clr_Black        : constant Color_Type;
   Clr_Background   : constant Color_Type;
   Clr_Blue         : constant Color_Type;
   Clr_Red          : constant Color_Type;
   Clr_Pink         : constant Color_Type;
   Clr_Green        : constant Color_Type;
   Clr_Cyan         : constant Color_Type;
   Clr_Yellow       : constant Color_Type;
   Clr_Neutral      : constant Color_Type;

   Clr_Dark_Gray    : constant Color_Type;
   Clr_Dark_Blue    : constant Color_Type;
   Clr_Dark_Red     : constant Color_Type;
   Clr_Dark_Pink    : constant Color_Type;
   Clr_Dark_Green   : constant Color_Type;
   Clr_Dark_Cyan    : constant Color_Type;
   Clr_Brown        : constant Color_Type;
   Clr_Pale_Gray    : constant Color_Type;

   RGB_Error        : constant Color_Type;
   RGB_Black        : constant Color_Type;
   RGB_Blue         : constant Color_Type;
   RGB_Green        : constant Color_Type;
   RGB_Cyan         : constant Color_Type;
   RGB_Red          : constant Color_Type;
   RGB_Pink         : constant Color_Type;
   RGB_Yellow       : constant Color_Type;
   RGB_White        : constant Color_Type;

  ---------------------------------------------

   function Set_Background_Color (
                  Ps    : Hps;
                  Color : Color_Type) return Boolean;

   procedure Set_Background_Color (
                  Ps    : Hps;
                  Color : Color_Type);

  ---------------------------------------------
   function Set_Color (
                  Ps    : Hps;
                  Color : Color_Type) return Boolean;

   procedure Set_Color (
                  Ps    : Hps;
                  Color : Color_Type);
  ---------------------------------------------
   function Char_String_At (
                  Ps    : Hps;
                  Point : PointL;
                  Text  : String) return Status_Type;

   procedure Char_String_At (
                  Ps    : in Hps;
                  Point : in PointL;
                  Text  : in String);

   function Char_String (
                  Ps    : Hps;
                  Text  : String) return Status_Type;

   procedure Char_String (
                  Ps    : in Hps;
                  Text  : in String);

  ---------------------------------------------

   function Set_Current_Position (
              Ps    : Hps;
              Point : PointL) return Boolean;

   procedure Set_Current_Position (
              Ps    : Hps;
              Point : PointL);

  ---------------------------------------------

   function Query_Current_Position (
              Ps    : Hps;
              Point : PPointL) return Boolean;

   procedure Query_Current_Position (
              Ps    : in     Hps;
              Point :    out PointL);

  ---------------------------------------------
   function Erase (Ps : Hps) return Boolean;
   procedure Erase (Ps : Hps);
  ---------------------------------------------
   function Destroy_Ps (Ps : Hps) return Boolean;
   procedure Destroy_Ps (Ps : in Hps);
  ---------------------------------------------
   function Move (
              Ps    : Hps;
              Point : PointL) return Boolean;

   procedure Move (
              Ps    : Hps;
              Point : PointL);
  ---------------------------------------------
   type Line_End_Style_Type is (
         Line_End_Error,
         Line_End_Default,
         Line_End_Flat,
         Line_End_Square,
         Line_End_Round);

   type Line_Join_Style_Type is (
         Line_Join_Error,
         Line_Join_Default,
         Line_Join_Bevel,
         Line_Join_Round,
         Line_Join_Mitre);

  ---------------------------------------------
   function Set_Line_End (
              Ps        : Hps;
              Style     : Line_End_Style_Type) return Boolean;
   procedure Set_Line_End (
              Ps        : in Hps;
              Style     : in Line_End_Style_Type);
  ---------------------------------------------
   function Query_Line_End (Ps : Hps) return Line_End_Style_Type;
  ---------------------------------------------
   function Set_Line_Join (
              Ps        : Hps;
              Style     : Line_Join_Style_Type) return Boolean;

   procedure Set_Line_Join (
              Ps        : in Hps;
              Style     : in Line_Join_Style_Type);
  ---------------------------------------------
   function Query_Line_Join (Ps : Hps) return Line_Join_Style_Type;
  ---------------------------------------------
   function Line (
              Ps        : Hps;
              End_Point : PointL) return Status_Type;

   procedure Line (
              Ps        : Hps;
              End_Point : PointL);

   procedure Line (
              Ps          : Hps;
              Start_Point : PointL;
              End_Point   : PointL);
  ---------------------------------------------
   type Outline_Style_Type is (
      Dro_Fill,          --Fill the interior of the box without drawing
                         --the outline.
      Dro_Outline,       --Draw the outline of the box.
      Dro_Outline_Fill); --Draw the outline of the box and fill the interior.

   function Box (
              Ps            : Hps;
              Corner_Point  : PointL;
              Outline_Style : Outline_Style_Type;
              Horz_Rounding : Long;
              Vert_Rounding : Long) return Status_Type;

   procedure Box (
              Ps            : in Hps;
              Corner_Point  : in PointL;
              Outline_Style : in Outline_Style_Type;
              Horz_Rounding : in Long;
              Vert_Rounding : in Long);

   procedure Box (
              Ps            : in Hps;
              Start_Corner  : in PointL;
              End_Corner    : in PointL;
              Outline_Style : in Outline_Style_Type;
              Horz_Rounding : in Long;
              Vert_Rounding : in Long);
 ---------------------------------------------

   function Set_Arc_Parameters (
              Ps         : Hps;
              Parameters : ArcParams) return Boolean;

   procedure Set_Arc_Parameters (
              Ps         : in Hps;
              Parameters : in ArcParams);
 ---------------------------------------------
   function Query_Arc_Parameters (
              Ps         : Hps;
              Parameters : PArcParams) return Boolean;

   procedure Query_Arc_Parameters (
              Ps         : in     Hps;
              Parameters :    out ArcParams);
 ---------------------------------------------
   function Set_Default_Arc_Parameters (
              Ps         : Hps;
              Parameters : ArcParams) return Boolean;

   procedure Set_Default_Arc_Parameters (
              Ps         : in Hps;
              Parameters : in ArcParams);
 ---------------------------------------------
   function Query_Default_Arc_Parameters (
              Ps         : Hps;
              Parameters : PArcParams) return Boolean;

   procedure Query_Default_Arc_Parameters (
              Ps         : in     Hps;
              Parameters :    out ArcParams);
 ---------------------------------------------
     type Multipler_Type is range 0 .. 255;  --Will be converted to fixed
                                             --type when implement.

   function Full_Arc (
              Ps            : Hps;
              Outline_Style : Outline_Style_Type;
              Multiplier    : Multipler_Type) return Status_Type;

   procedure Full_Arc (
              Ps            : in Hps;
              Outline_Style : in Outline_Style_Type;
              Multiplier    : in Multipler_Type);

   procedure Full_Arc (
              Ps            : in Hps;
              Center        : in PointL;
              Arc_Params    : in ArcParams;
              Outline_Style : in Outline_Style_Type;
              Multiplier    : in Multipler_Type);
 ---------------------------------------------
 private
   type Color_Type is new Long;

   Clr_False        : constant Color_Type := -5;
   Clr_True         : constant Color_Type := -4;
   Clr_Error        : constant Color_Type := -255;
   Clr_Default      : constant Color_Type := -3;

   Clr_White        : constant Color_Type := -2;
   Clr_Black        : constant Color_Type := -1;
   Clr_Background   : constant Color_Type := 0;
   Clr_Blue         : constant Color_Type := 1;
   Clr_Red          : constant Color_Type := 2;
   Clr_Pink         : constant Color_Type := 3;
   Clr_Green        : constant Color_Type := 4;
   Clr_Cyan         : constant Color_Type := 5;
   Clr_Yellow       : constant Color_Type := 6;
   Clr_Neutral      : constant Color_Type := 7;

   Clr_Dark_Gray    : constant Color_Type := 8;
   Clr_Dark_Blue    : constant Color_Type := 9;
   Clr_Dark_Red     : constant Color_Type := 10;
   Clr_Dark_Pink    : constant Color_Type := 11;
   Clr_Dark_Green   : constant Color_Type := 12;
   Clr_Dark_Cyan    : constant Color_Type := 13;
   Clr_Brown        : constant Color_Type := 14;
   Clr_Pale_Gray    : constant Color_Type := 15;

   RGB_Error        : constant Color_Type := -255;
   RGB_Black        : constant Color_Type := 16#0000_0000#;
   RGB_Blue         : constant Color_Type := 16#0000_00FF#;
   RGB_Green        : constant Color_Type := 16#0000_FF00#;
   RGB_Cyan         : constant Color_Type := 16#0000_FFFF#;
   RGB_Red          : constant Color_Type := 16#00FF_0000#;
   RGB_Pink         : constant Color_Type := 16#00FF_00FF#;
   RGB_Yellow       : constant Color_Type := 16#00FF_FF00#;
   RGB_White        : constant Color_Type := 16#00FF_FFFF#;
end GPI;
