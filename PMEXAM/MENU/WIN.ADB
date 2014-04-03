with System;
with Text_IO;
with OS2; use OS2;
with OS2.PMwb; use OS2.PMwb;
with OS2.PMwd; use OS2.PMwd;
with OS2.PMSC; use OS2.PMsc;
with OS2.PMCP; use OS2.PMCP;

with Unchecked_Conversion;
with Unchecked_Deallocation;

package body Win is

  Short_True     : constant Ushort := 1;
  Short_False    : constant Ushort := 0;

  Long_True      : constant Ulong := 1;
  Long_False     : constant Ulong := 0;

  Boolean_Value  : constant array (Boolean) of Ulong := (0, 1);

  Boolean_Result : constant array (Ulong range 0 .. 1)
                     of Boolean := (False, True);

  MB_Response : constant array (Ushort range 1 .. 9)
                   of MB_Response_Type :=
     (1 => MB_Ok_Pressed,
      2 => MB_Cancel_Pressed,
      3 => Mb_Abort_Pressed,
      4 => Mb_Retry_Pressed,
      5 => Mb_Ignore_Pressed,
      6 => Mb_Yes_Pressed,
      7 => Mb_No_Pressed,
      8 => Mb_Help_Pressed,
      9 => Mb_Enter_Pressed);

  MB_Buttons : constant array (Mb_Button_Styles_Type) of Ulong :=
     (MB_Ok                 => 16#0000#,
      MB_Ok_Cancel          => 16#0001#,
      MB_Cancel             => 16#0006#,
      MB_Enter              => 16#0007#,
      MB_Enter_Cancel       => 16#0008#,
      MB_Retry_Cancel       => 16#0002#,
      MB_Abort_Retry_Ignore => 16#0003#,
      MB_Yes_No             => 16#0004#,
      MB_Yes_No_Cancel      => 16#0005#);

  MB_Icons : constant array (Mb_Icon_Styles_Type) of Ulong :=
      (Mb_No_Icon          => 16#0000#,
       Mb_Icon_Hand        => 16#0040#,
       Mb_Icon_Question    => 16#0010#,
       Mb_Icon_Exclamation => 16#0020#,
       Mb_Icon_Asterisk    => 16#0030#,
       Mb_Information      => 16#0030#,
       Mb_Query            => 16#0010#,
       Mb_Warning          => 16#0020#,
       Mb_Error            => 16#0040#);

  MB_Action : constant array (Mb_Default_Action_Type) of Ulong :=
       (MB_Default_on_Button_1 => 16#0000#,
        MB_Default_on_Button_2 => 16#0100#,
        MB_Default_on_Button_3 => 16#0200#);

  MB_Modality : constant array (Mb_Modality_Type) of Ulong :=
       (Mb_Application_Modal => 16#0000#,
        Mb_System_Modal      => 16#1000#);

  MB_Help     : constant array (Boolean)
                    of Ulong := (16#0000#, 16#2000#);
  MB_Moveable : constant array (Boolean)
                    of Ulong := (16#0000#, 16#4000#);

  ------------------------------------------------

  Win_Style_Values : constant array (Class_Style_Type) of Ulong :=
       (Cs_Size_Redraw    => 16#0000_0004#,
        Cs_Sync_Paint     => 16#0200_0000#,
        Cs_Move_Notify    => 16#0000_0001#,
        Cs_Clip_Children  => 16#2000_0000#,
        Cs_Clip_Siblings  => 16#1000_0000#,
        Cs_Parent_Clip    => 16#0800_0000#,
        Cs_Save_Bits      => 16#0400_0000#,
        Cs_Public         => 16#0000_0010#,
        Cs_Hit_Test       => 16#0000_0008#,
        Cs_Frame          => 16#0000_0020#);

  ------------------------------------------------

   Win_Position_Values : constant array (Position_Options_Type)
                                                     of Ulong :=
       (Swp_Size             => 16#0001#,
        Swp_Move             => 16#0002#,
        Swp_Z_Order          => 16#0004#,
        Swp_Show             => 16#0008#,
        Swp_Hide             => 16#0010#,
        Swp_No_Redraw        => 16#0020#,
        Swp_No_Adjust        => 16#0040#,
        Swp_Activate         => 16#0080#,
        Swp_Deactivate       => 16#0100#,
        Swp_Ext_State_Change => 16#0200#,
        Swp_Minimize         => 16#0400#,
        Swp_Maximize         => 16#0800#,
        Swp_Restore          => 16#1000#,
        Swp_Focus_Active     => 16#2000#,
        Swp_Focus_Deactivate => 16#4000#,
        Swp_No_Auto_Close    => 16#8000#);

  ------------------------------------------------

   Window_Style_Values : constant array (Window_Style_Type)
                                        of Ulong := (
      Ws_Sync_Paint         => 16#0200_0000#,
      Ws_Clip_Children      => 16#2000_0000#,
      Ws_Clip_Siblings      => 16#1000_0000#,
      Ws_Disabled           => 16#4000_0000#,
      Ws_Maximized          => 16#0080_0000#,
      Ws_Mimimized          => 16#0100_0000#,
      Ws_Parent_Clip        => 16#0800_0000#,
      Ws_Save_Bits          => 16#0400_0000#,
      Ws_Visible            => 16#8000_0000#,
      Ws_Animate            => 16#0040_0000#,
      Ws_Group              => 16#0001_0000#,
      Ws_Tab_Stop           => 16#0002_0000#,
      Ws_Multi_Select       => 16#0004_0000#,

      Fs_Screen_Align       => 16#0000_0200#,
      Fs_Mouse_Align        => 16#0000_0400#,
      Fs_Sizing_Border      => 16#0000_0800#,
      Fs_Border             => 16#0000_0100#,
      Fs_Dialog_Border      => 16#0000_0080#,
      Fs_System_Modal       => 16#0000_0040#,
      Fs_No_Byte_Align      => 16#0000_0010#,
      Fs_Task_List          => 16#0000_0008#,
      Fs_No_Move_With_Owner => 16#0000_0020#,
      Fs_Auto_Icon          => 16#0000_1000#);

  ------------------------------------------------

   Frame_Values : constant array (Frame_Control_Flag_Type)
                   of Ulong := (
        Fcf_Title_Bar          => 16#0000_0001#,
        Fcf_System_Menu        => 16#0000_0002#,
        Fcf_Menu               => 16#0000_0004#,
        Fcf_Min_Max            => 16#0000_0030#,
        Fcf_Min_Button         => 16#0000_0010#,
        Fcf_Max_Button         => 16#0000_0020#,
        Fcf_Vert_Scroll_Bar    => 16#0000_0040#,
        Fcf_Horz_Scroll_Bar    => 16#0000_0080#,
        Fcf_Sizing_Border      => 16#0000_0008#,
        Fcf_Border             => 16#0000_0200#,
        Fcf_Dialog_Border      => 16#0000_0100#,
        Fcf_Accel_Table        => 16#0000_8000#,
        Fcf_Icon               => 16#0000_4000#,
        Fcf_Shell_Position     => 16#0000_0400#,
        Fcf_System_Modal       => 16#0001_0000#,
        Fcf_No_Byte_Align      => 16#0000_1000#,
        Fcf_Task_List          => 16#0000_0800#,
        Fcf_No_Move_With_Owner => 16#0000_2000#,
        Fcf_Standard           => 16#0000_CC3F#,
        Fcf_Screen_Align       => 16#0002_0000#,
        Fcf_Mouse_Align        => 16#0004_0000#,
        Fcf_Auto_Icon          => 16#4000_0000#,
        Fcf_Hide_Button        => 16#0100_0000#,
        Fcf_Hide_Max           => 16#0100_0020#);

  Frame_Id_Values : constant array (Frame_Id_Type) of Ulong := (
         Fid_System_Menu      => 16#8002#,
         Fid_Titlebar         => 16#8003#,
         Fid_Min_Max          => 16#8004#,
         Fid_Menu             => 16#8005#,
         Fid_Vert_Scroll_Bar  => 16#8006#,
         Fid_Horz_Scroll_Bar  => 16#8007#,
         Fid_Client           => 16#8008#,
         Fid_DBE_App_Stat     => 16#8010#,
         Fid_DBE_Kbd_Stat     => 16#8011#,
         Fid_DBE_Pecic        => 16#8012#,
         Fid_Dbe_KK_Pop_Up    => 16#8013#);

   Command_Source_Values : constant array (Ushort range 0 .. 7)
                            of Command_Source_Type :=
       (0 => Cmd_Src_Other,
        1 => Cmd_Src_Push_Button,
        2 => Cmd_Src_Menu,
        3 => Cmd_Src_Accelerator,
        4 => Cmd_Src_Font_Dialog,
        5 => Cmd_Src_File_Dialog,
        6 => Cmd_Src_Print_Dialog,
        7 => Cmd_Src_Color_Dialog);

  ------------------------------------------------

   MIS_Values : constant array (Menu_Style_Type) of Ushort := (
       MIS_Text             => 16#0001#,
       MIS_Bitmap           => 16#0002#,
       MIS_Separator        => 16#0004#,
       MIS_Owner_Draw       => 16#0008#,
       MIS_Submenu          => 16#0010#,
       MIS_Mult_Menu        => 16#0020#,
       MIS_Sys_Command      => 16#0030#,
       MIS_Help             => 16#0080#,
       MIS_Static           => 16#0100#,
       MIS_Button_Separator => 16#0200#,
       MIS_Break            => 16#0400#,
       MIS_Break_Separator  => 16#0800#,
       MIS_Group            => 16#1000#,
       MIS_Single           => 16#2000#);

  ------------------------------------------------

   MIA_Values : constant array (Menu_Attribute_Type) of Ushort := (
        MIA_No_Dismiss  => 16#0020#,
        MIA_Framed      => 16#1000#,
        MIA_Checked     => 16#2000#,
        MIA_Disabled    => 16#4000#,
        MIA_Highlighted => 16#8000#);

  ------------------------------------------------

   Pop_Up_Values : constant array (Pop_Up_Option_Type) of Ushort := (
      Pu_Position_On_Item     => 16#0001#,
      Pu_Horz_Constrained     => 16#0002#,
      Pu_Vert_Constrained     => 16#0004#,
      Pu_None                 => 16#0000#,
      Pu_Mouse_Button_1_Down  => 16#0008#,
      Pu_Mouse_Button_2_Down  => 16#0010#,
      Pu_Mouse_Button_3_Down  => 16#0018#,
      Pu_Select_Item          => 16#0020#,
      Pu_Mouse_Button_1       => 16#0040#,
      Pu_Mouse_Button_2       => 16#0080#,
      Pu_Mouse_Button_3       => 16#0100#,
      Pu_Keyboard             => 16#0200#);

  ------------------------------------------------

   type OS2_Menu_Item_Type is
      record
        IPosition   : Short;
        Style       : Ushort;
        Attribute   : Ushort;
        Id          : Ushort;
        SubMenu     : HWND;
        Item_Handle : Ulong;
      end record;

  ------------------------------------------------
  function Create_Standard_Window (
            Parent_Window       : HWND;
            Window_Styles       : Window_Styles_Type;
            Frame_Control_Flags : Frame_Control_Flags_Type;
            Class_Name          : String;
            Window_Title        : String;
            Class_Style         : Class_Styles_Type;
            Resource            : ULong;
            Resource_ID         : ULong;
            New_Window          : PHWND)
                                     return HWND is

       Class_Str   : String (Class_Name'first .. Class_Name'last + 1);
       Title_Str   : String (Window_Title'first .. Window_Title'last + 1);

       Frame_Value : Aliased ULong := 0;
       Win_Style   : ULong := 0;
       Style       : ULong := 0;
       hwndFrame   : HWND;

    begin
      Class_Str (Class_Str'first .. Class_Str'last - 1) := Class_Name;
      Class_Str (Class_Str'last) := Ascii.Nul;

      Title_Str (Title_Str'first .. Title_Str'last - 1) := Window_Title;
      Title_Str (Title_Str'last) := Ascii.Nul;

      for I in Frame_Control_Flags'range loop
        if Frame_Control_Flags (I) then
           Frame_Value := Frame_Value + Frame_Values (I);
        end if;
      end loop;

      for I in Window_Styles'range loop
        if Window_Styles (I) then
           Win_Style := Win_Style + Window_Style_Values (I);
        end if;
      end loop;

       for I in Class_Style'range loop
         if Class_Style (I) then
           Style := Style + Win_Style_Values (I);
         end if;
       end loop;

 hwndFrame:=   WinCreateStdWindow (
        hwndParent                 => Parent_Window,
        flStyle                    => Win_Style,
        pflCreateFlags             => Frame_Value'unchecked_Access,
        pszClientClass             => Class_Str (Class_Str'first)'address,
        pszTitle                   => Title_Str (Title_Str'first)'address,
        styleClient                => Style,
        hmod                       => Resource,
        idResources                => Resource_Id,
        phwndClient                => New_Window);

      return  hwndFrame;
  end Create_Standard_Window;
  ------------------------------------------------

   function Failed (Value : Boolean) return Boolean is
     begin
       return not Value;
     end Failed;
  ------------------------------------------------

  function To_Boolean   (Void : Void_Type) return Boolean is
    begin
      return Void = 1;
    end To_Boolean;

  ------------------------------------------------
  function To_Short     (Void : Void_Type) return Short is
    begin
      return Short (Void);
    end To_Short;

  ------------------------------------------------
  function To_U_Short   (Void : Void_Type) return Ushort is
    begin
      return Ushort (Void);
    end To_U_Short;

  ------------------------------------------------
  function Parm_to_SPT is new Unchecked_Conversion (
                                 Target => Short_Point_Type,
                                 Source => Win.Parameter_Type);

  ------------------------------------------------
  function Is_Null (Window       : HWND) return Boolean is
    begin
      return Window = Null_Window;
    end Is_Null;

  ------------------------------------------------
  ------------------------------------------------
  function Is_Null (Bitmap        : Bitmap_Handle_Type) return Boolean is
    begin
      return Bitmap = Null_Bitmap;
    end Is_Null;

  ------------------------------------------------
  function Is_Null (Internal_Menu : Internal_Menu_Item_Type) return Boolean is
    begin
      return Internal_Menu = Null_Internal_Menu;
    end Is_Null;

  ------------------------------------------------
  function Get_Error_Info (Anchor_Block : Anchor_Block_Handle_Type)
                                     return PErrinfo is

    begin
      return WinGetErrorInfo (Anchor_Block);
    end Get_Error_Info;

  ------------------------------------------------
  function Get_Last_Error (Anchor_Block : Anchor_Block_Handle_Type)
                                                  return Ulong is


      Error : Ulong;
    begin

      Text_IO.Put ("Ulong Size => ");
      Text_Io.Put_Line (Integer'Image (Ulong'size));

      Error := WinGetLastError (Anchor_Block);
      Text_Io.Put ("Error num is ");
      Text_Io.Put_Line (Integer'image (Integer (Error)));
      return Error;
    end Get_Last_Error;

  ------------------------------------------------
  function Initialize (
                       Options : Ulong := System_Default
                                       ) return Anchor_Block_Handle_Type  is

    begin

      return WinInitialize (Options);
    end Initialize;

  ------------------------------------------------
  procedure Initialize (
               Options      : in     Ulong := System_Default;
               Anchor_Block :    out Anchor_Block_Handle_Type) is
    begin
      Anchor_Block := Initialize (Options);
      --Currently OS/2 does not use the Anchor_Block parameter.  It is
      --usally set to null and not used.
    end Initialize;

  ------------------------------------------------

   function Register_Class (Anchor_Block   : Anchor_Block_Handle_Type;
                           Class_Name      : String;
                           Message_Handler : Message_Handler_Function;
                           Class_Style     : Class_Styles_Type;
                           Extra_Storage   : Ushort)
                                                        return Boolean is

       Class_Str : String (Class_Name'first .. Class_Name'last + 1);

       Style     : Ulong := 0;

       Result    : Ulong;

    begin
       Class_Str (Class_Str'first .. Class_Str'last - 1) := Class_Name;
       Class_Str (Class_Str'last) := Ascii.Nul;

       for I in Class_Style'range loop
         if Class_Style (I) then
           Style := Style + Win_Style_Values (I);
         end if;
       end loop;

       Result := WinRegisterClass (
             ha           => Anchor_Block,
             pszClassName => Class_Str (Class_Str'first)'address,
             pfnWndProc   => Message_Handler,
             flStyle      => Style,
             cbWindowData => Ulong(Extra_Storage));

       if Result = 1 then   return True; end if;

      return False;

    end Register_Class;

  ------------------------------------------------

  procedure Register_Class (Anchor_Block    : Anchor_Block_Handle_Type;
                            Class_Name      : String;
                            Message_Handler : Message_Handler_Function;
                            Class_Style     : Class_Styles_Type;
                            Extra_Storage   : Ushort) is
   begin
    if Register_Class (Anchor_Block,
                       Class_Name,
                       Message_Handler,
                       Class_Style,
                       Extra_Storage) then
      null;
    else
      raise Register_Failed;
    end if;
   end Register_Class;

  ------------------------------------------------

   Kc_Flag_Values : constant array (Key_Flag_Type) of Ushort :=
       (Kc_None              => 16#0000#,
        Kc_Char              => 16#0001#,
        Kc_Virtual_Key       => 16#0002#,
        Kc_Scan_Code         => 16#0004#,
        Kc_Shift             => 16#0008#,
        Kc_Ctrl              => 16#0010#,
        Kc_Atl               => 16#0020#,
        Kc_Key_Up            => 16#0040#,
        Kc_Previous_Down     => 16#0080#,
        Kc_Lone_Key          => 16#0100#,
        Kc_Dead_Key          => 16#0200#,
        Kc_Composite         => 16#0400#,
        Kc_Invalid_Composite => 16#0800#,
        Kc_Toggle            => 16#1000#,
        Kc_Invalid_Character => 16#2000#,
        Kc_DB_CSR_SR_VD1     => 16#4000#,
        Kc_Db_CSR_SR_VD2     => 16#8000#);


    function Set_Flags (Key_Flag_Values : Ushort)
                                              return Key_Flags_Type is
       Values : Ushort := Key_Flag_Values;
       Flags  : Key_Flags_Type := (Others => False);

    begin

       if Key_Flag_Values = 0 then
          Flags (Kc_None) := True;
       else

         for I in reverse Flags'range loop

           exit when I = Flags'first;

           if Values >= Kc_Flag_Values (I) then
              Flags (I) := True;
              Values := Values - Kc_Flag_Values (I);
           end if;

         end loop;
       end if;

       return Flags;
   end Set_Flags;

  ------------------------------------------------

   function Set_Virtual_Key (Virtual_Code : Ushort)
                                            return Virtual_Key_Type is
      V_Key : Virtual_Key_Type;
     begin

       if Virtual_Code in 16#01# .. 16#38# then
          V_Key := Virtual_Key_Type'Val (Integer (Virtual_Code) - 1);
       else
          V_Key := Vk_Null;
       end if;

       if V_Key = Vk_F10 then
          V_Key := Vk_Menu;
       end if;

       return V_Key;
     end Set_Virtual_Key;

 ------------------------------------------------

  type CM_1_Type is
    record
     Flags    : UShort;
     Repeat   : Uchar;
     Scancode : Uchar;
    end record;

  function Parm_To_Cm_1 is new Unchecked_Conversion (
                                    Source => Parameter_Type,
                                    Target => Cm_1_Type);

  type Cm_2_Type is
    record
     Char_Code    : Ushort;
     Virtual_Code : Ushort;
    end record;

  function Parm_To_Cm_2 is new Unchecked_Conversion (
                                    Source => Parameter_Type,
                                    Target => Cm_2_Type);

 function Key_Info_Is (Message_Parameter_1 : Parameter_Type;
                       Message_Parameter_2 : Parameter_Type)
                                     return Key_Press_Info_Type is
     Info : Key_Press_Info_Type;

     Cm_1 : Cm_1_Type;
     Cm_2 : Cm_2_Type;

    begin

      Cm_1 := Parm_To_Cm_1 (Message_Parameter_1);
      Cm_2 := Parm_To_Cm_2 (Message_Parameter_2);

      Info.Flags          := Set_Flags (Cm_1.Flags);
      Info.Repeat_Count   := Cm_1.Repeat;
      Info.Scan_Code      := Cm_1.Scancode;

      Info.Character_Code := Cm_2.Char_Code;
      Info.Virtual_Key    := Set_Virtual_Key (Cm_2.Virtual_Code);

      return Info;

    end Key_Info_Is;

  ------------------------------------------------

  type Command_Info_2_Type is
    record
     Source     : Ushort;
     By_Pointer : Ushort;
    end record;

  function Parm_To_CI_2 is new Unchecked_Conversion (
                                   Source => Parameter_Type,
                                   Target => Command_Info_2_Type);

  function Command_Info_Is (Message_Parameter_1 : Parameter_Type;
                            Message_Parameter_2 : Parameter_Type)
                                          return Command_Info_Type is
     Info   : Command_Info_Type;
     Info_2 : Command_Info_2_Type;
    begin

      Info.Id         := Command_Id_Type (Message_Parameter_1);
      Info_2          := Parm_To_Ci_2 (Message_Parameter_2);
      Info.Source     := Command_Source_Values (Info_2.Source);
      Info.By_Pointer := Info_2.By_Pointer = 1;

      return Info;
    end Command_Info_Is;

  ------------------------------------------------

  function Pointer_Is (Parameter : Parameter_Type) return Point_Type is
     Spt : Short_Point_Type;
   begin
     Spt := Parm_To_Spt (Parameter);
     return (Pixel_Type (Spt.X), Pixel_Type (Spt.Y));
   end Pointer_Is;

  ------------------------------------------------

     type Two_Shorts is
       record
         Short_1 : Ushort;
         Short_2 : Ushort;
       end record;

     function Shorts_To_Mp is new Unchecked_Conversion (
                                           Target => Parameter_Type,
                                           Source => Two_Shorts);

     function Check_Menu_Item (
              Menu    : HWND;
              Item_Id : Command_Id_Type;
              Check   : Boolean) return Boolean is

       Mp_1   : Parameter_Type;
       Mp_2   : Parameter_Type;

       Values : Two_Shorts;

       Result : Boolean;

     begin

        Values.Short_1 := Ushort (Item_Id);
        Values.Short_2 := Short_True;
        Mp_1 := Shorts_To_Mp (Values);

        Values.Short_1 := MIA_Values (Mia_Checked);

        if Check then
          Values.Short_2 := MIA_Values (Mia_Checked);
        else
          Values.Short_2 := Short_False;
        end if;

        Mp_2 := Shorts_To_Mp (Values);

        Result := To_Boolean (
                    Send_Message (
                        To_Window   => Menu,
                        Message     => MM_Set_Item_Attr,
                        Parameter_1 => Mp_1,
                        Parameter_2 => Mp_2));

        return Result;

      end Check_Menu_Item;

  ------------------------------------------------

  function Is_Menu_Item_Checked (
              Menu     : HWND;
              Item_Id  : Command_Id_Type) return Boolean is
    begin
      return False;
    end Is_Menu_Item_Checked;

  ------------------------------------------------

  function Is_Menu_Item_Enabled (
              Menu     : HWND;
              Item_Id  : Command_Id_Type) return Boolean is
    begin
      return False;
    end Is_Menu_Item_Enabled;

  ------------------------------------------------

  function Is_Menu_Item_Valid (
              Menu     : HWND;
              Item_Id  : Command_Id_Type) return Boolean is
    begin
      return False;
    end Is_Menu_Item_Valid;

  ------------------------------------------------

    function Enable_Menu_Item (
              Menu     : HWND;
              Item_Id  : Command_Id_Type;
              Enable   : Boolean) return Boolean is

       Mp_1   : Parameter_Type;
       Mp_2   : Parameter_Type;

       Values : Two_Shorts;

       Result : Boolean;

     begin

        Values.Short_1 := Ushort (Item_Id);
        Values.Short_2 := Short_True;
        Mp_1 := Shorts_To_Mp (Values);

        Values.Short_1 := MIA_Values (Mia_Disabled);

        if Enable then
          Values.Short_2 := MIA_Values (Mia_Disabled);
        else
          Values.Short_2 := Short_False;
        end if;

        Mp_2 := Shorts_To_Mp (Values);

        Result := To_Boolean (
                    Send_Message (
                        To_Window   => Menu,
                        Message     => MM_Set_Item_Attr,
                        Parameter_1 => Mp_1,
                        Parameter_2 => Mp_2));

        return Result;

      end Enable_Menu_Item;

  ------------------------------------------------

   function Load_Menu (
                  Owner_Window : HWND;
                  Resource     :  ULong;
                  Menu_Id      : Id_Type) return HWND is


      Result : HWND;

   begin

     Result := WinLoadMenu (
                                  Owner_Window,
                                  Resource,
                                  Menu_Id);

     return Result;
   end Load_Menu;

  ------------------------------------------------

   function Convert_Pop_Up_Options (Options : Pop_Up_Options_Type) return Ushort is
     Value : Ushort := 0;
   begin
     for I in Options'range loop
       if Options (I) then
         Value := Value + Pop_Up_Values (I);
       end if;
     end loop;
     return Value;
   end Convert_Pop_Up_Options;

  ------------------------------------------------

   function Pop_Up_Menu (
        Window       : HWND;
        Frame_Window : HWND;
        Menu_Window  : HWND;
        X            : Pixel_Type;
        Y            : Pixel_Type;
        Item_Id      : Command_Id_Type;
        Options      : Pop_Up_Options_Type) return Boolean is

      Result : Ulong;
      opt    : Ulong;
   begin
      opt    := Ulong(Convert_Pop_Up_Options (Options));
      Result := WinPopupMenu (
                   hwndParent => Window,
                   hwndOwner  => Frame_Window,
                   hwndMenu   => Menu_Window,
                   x          => X,
                   y          => Y,
                   idItem     => Long (Item_Id),
                   fs         => opt  );

      return Result = 1;
   end Pop_Up_Menu;

  -------------------------------------------------------
   procedure Pop_Up_Menu (
        Window       : in HWND;
        Frame_Window : in HWND;
        Menu_Window  : in HWND;
        X            : in Pixel_Type;
        Y            : in Pixel_Type;
        Item_Id      : in Command_Id_Type;
        Options      : in Pop_Up_Options_Type) is
    begin
      if Failed (Pop_Up_Menu (
                   Window       => Window,
                   Frame_Window => Frame_Window,
                   Menu_Window  => Menu_Window,
                   X            => X,
                   Y            => Y,
                   Item_Id      => Item_Id,
                   Options      => Options)) then
         raise Win_Error;
      end if;
    end Pop_Up_Menu;

  ------------------------------------------------

   function Create_Internal_Menu return Internal_Menu_Item_Type is
     begin
       return new OS2_Menu_Item_Type;
     end Create_Internal_Menu;

  ------------------------------------------------
   procedure Reclaim_Internal_Menu is new Unchecked_Deallocation (
                                             OS2_Menu_Item_Type,
                                             Internal_Menu_Item_Type);

   procedure Destroy_Internal_Menu (Internal_Menu : in out Internal_Menu_Item_Type) is
     begin
       Reclaim_Internal_Menu (Internal_Menu);
       Internal_Menu := Null_Internal_Menu;
     end Destroy_Internal_Menu;

  ------------------------------------------------

   function Make_Mia_Value (Atts : Menu_Attributes_Type) return Ushort is
     Value : Ushort := 0;
   begin

     for I in Atts'range loop
       if Atts (I) then
         Value := Value + Mia_Values (I);
       end if;
     end loop;

     return Value;
   end Make_Mia_Value;

  ------------------------------------------------


   function Convert_To_Internal (Menu_Item : Menu_Item_Type)
                                        return Internal_Menu_Item_Type is
       I_Menu : Internal_Menu_Item_Type;
     begin
       I_Menu := Create_Internal_Menu;

       I_Menu.IPosition   := Short (Menu_Item.Position);
       I_Menu.Style       := MIS_Values (Menu_Item.Style);
       I_Menu.Attribute   := Make_MIA_Value (Menu_Item.Attributes);
       I_Menu.Id          := Ushort (Menu_Item.Item_Id);
       I_Menu.SubMenu     := Menu_Item.Sub_Menu;
       I_Menu.Item_Handle := Ulong (Menu_Item.Item_Handle);

       return I_Menu;

     end Convert_To_Internal;

  ------------------------------------------------

   function Convert_To_Style (Value : Ushort)
                                         return Menu_Style_Type is
     begin

       for I in MIS_Values'range loop
         if MIS_Values (I) = Value then
           return I;
         end if;
       end loop;

       return Mis_Text;
     end Convert_To_Style;

  ------------------------------------------------

   function Convert_To_Attribute (Value : Ushort)
                                       return Menu_Attributes_Type is
      Atts : Menu_Attributes_Type;
      Val  : Ushort := Value;

     begin

       Atts := (others => False);
       for I in reverse MIA_Values'range loop

         if Val >= MIA_Values (I) then
            Atts (I) := True;
            Val := Val - Mia_Values (I);
         end if;

       end loop;

       return Atts;

     end Convert_To_Attribute;

  ------------------------------------------------

   function Convert_To_External (Menu_Item : Internal_Menu_Item_Type)
                                                  return Menu_Item_Type is
      Data : Menu_Item_Type;
     begin

       Data.Position    := Menu_Position_Type (Menu_Item.IPosition);
       Data.Style       := Convert_To_Style (Menu_Item.Style);
       Data.Attributes  := Convert_To_Attribute (Menu_Item.Attribute);
       Data.Item_Id     := Command_Id_Type (Menu_Item.ID);
       Data.Sub_Menu    := Menu_Item.SubMenu;
       Data.Item_Handle := Bitmap_Handle_Type (Menu_Item.Item_Handle);

       return Data;

     end Convert_To_External;

  ------------------------------------------------

     function Addr_To_Parm is new Unchecked_Conversion (
                                 Target => Win.Parameter_Type,
                                 Source => System.Address);

     function Int_Menu_To_Addr is new Unchecked_Conversion (
                                 Target => Win.Parameter_Type,
                                 Source => Internal_Menu_Item_Type);

     function Addr_To_Int_Menu is new Unchecked_Conversion (
                                 Target => Internal_Menu_Item_Type,
                                 Source => System.Address);

  ------------------------------------------------

   function Query_Menu_Item (
              Menu    : HWND;
              Item_Id : Command_Id_Type) return Menu_Item_Type is

      Data    : Menu_Item_Type      ;
      I_Menu  : OS2_Menu_Item_Type;
      Mp_1    : Parameter_Type;
      Mp_2    : Parameter_Type;
      Mp_Data : Two_Shorts;

      Good  : Boolean;
     begin

      Mp_Data.Short_1 := Ushort (Item_Id);
      Mp_Data.Short_2 := Short_True;

      Mp_1 := Shorts_To_Mp (Mp_Data);
      Mp_2 := Addr_To_Parm (I_Menu'address);

      Good := To_Boolean (
                  Send_Message (
                    To_Window   => Menu,
                    Message     => MM_Query_Item,
                    Parameter_1 => Mp_1,
                    Parameter_2 => Mp_2));

      if Good then
         return Convert_To_External (Addr_To_Int_Menu (I_Menu'address));
      else
         Text_Io.Put_Line ("The Send Message in Query_Menu_Item failed");
         raise Win_Error;
      end if;

      return Data;

     end Query_Menu_Item;

  ------------------------------------------------

   procedure Insert_Menu_Item (
                     Menu      : in HWND;
                     Menu_Data : in Menu_Item_Type;
                     Text      : in String) is

      I_Menu  : Internal_Menu_Item_Type;
      Mp_1    : Parameter_Type;
      Mp_2    : Parameter_Type;
      Str     : String (Text'first .. Text'last + 1);

      Good  : Boolean;
     begin

      Str := Text & ASCII.Nul;

      I_Menu := Convert_To_Internal (Menu_Data);

      Mp_1   := Int_Menu_To_Addr (I_Menu);
      Mp_2   := Addr_To_Parm (Str (Str'first)'address);

      Good := To_Boolean (
                  Send_Message (
                    To_Window   => Menu,
                    Message     => MM_Insert_Item,
                    Parameter_1 => Mp_1,
                    Parameter_2 => Mp_2));

      if Good then
         null;
      else
         Text_Io.Put_Line ("Insert Menu Failed");
      end if;

     end Insert_Menu_Item;

  ------------------------------------------------

   procedure Delete_Menu_Item (
                     Menu      : in HWND;
                     Item_Id   : Command_Id_Type) is
      Mp_1    : Parameter_Type;
      Mp_Data : Two_Shorts;

      Count   : Integer := 0;
      Good    : Boolean := False;
     begin

      Mp_Data.Short_1 := Ushort (Item_Id);
      Mp_Data.Short_2 := Short_True;

      Mp_1 := Shorts_To_Mp (Mp_Data);

      Good := To_Boolean (Send_Message (
                    To_Window   => Menu,
                    Message     => MM_Delete_Item,
                    Parameter_1 => Mp_1,
                    Parameter_2 => 0));
      if Good then
        null;
      else
        Text_Io.Put_Line ("Delete Menu Item Failed");
      end if;

     end Delete_Menu_Item;

  ------------------------------------------------

  function Default_Window_Procedure
                          (Window              : HWND;
                           Message             : Message_Type;
                           Message_Parameter_1 : Parameter_Type;
                           Message_Parameter_2 : Parameter_Type)
                                              return Ulong is

      Result : Ulong;
    begin
      Result := WinDefWindowProc (
                         hwn       => Window,
                         Msg       => Message,
                         Mp1       => Ulong(Message_Parameter_1),
                         Mp2       => Ulong(Message_Parameter_2));
      return Result;

    end Default_Window_Procedure;

  ------------------------------------------------

  function Window_From_Id (
            Parent_Window : HWND;
            Frame_Id      : Frame_Id_Type) return HWND is

     Window : HWND;
   begin

     Window := WinWindowFromId (
                hwndParent    => Parent_Window,
                id            => Frame_id_Values (Frame_ID));

     return Window;
   end Window_From_Id;
  ------------------------------------------------
  function Set_Window_Position (
              Window           : HWND;
              Behind_Window    : HWND;
              X                : Device_Screen_Space_Type;
              Y                : Device_Screen_Space_Type;
              Width            : Device_Screen_Space_Type;
              Height           : Device_Screen_Space_Type;
              Position_Options : Position_Type) return Boolean is

     Pos_Value : Ulong := 0;

   begin

     if Boolean_Value (Position_Options (Swp_Minimize)) +
        Boolean_Value (Position_Options (Swp_Maximize)) +
        Boolean_Value (Position_Options (Swp_Restore)) > 1 then
          raise Min_Max_Restore_Usage_Error;
     end if;

     for I in Position_Options'range loop
       if Position_Options (I) then
         Pos_Value := Pos_Value + Win_Position_Values (I);
       end if;
     end loop;

     return 0 /= WinSetWindowPos (
                 hwn                => Window,
                 hwndInsertBehind   => Behind_Window,
                 x                  => X,
                 y                  => Y,
                 cx                 => Width,
                 cy                 => Height,
                  fl                => Pos_Value);
   end Set_Window_Position;

  ------------------------------------------------

  procedure Set_Window_Position (
              Window           : in HWND;
              Behind_Window    : in HWND;
              X                : in Device_Screen_Space_Type;
              Y                : in Device_Screen_Space_Type;
              Width            : in Device_Screen_Space_Type;
              Height           : in Device_Screen_Space_Type;
              Position_Options : in Position_Type) is
    begin
      if Set_Window_Position (Window,
                              Behind_Window,
                              X, Y,
                              Width, Height,
                              Position_Options) then
        null;
      else
        raise Set_Failed;
      end if;
    end Set_Window_Position;

  ------------------------------------------------

 function Terminate_App (Anchor : Anchor_Block_Handle_Type) return Boolean is

   begin
     return WinTerminate (Anchor) /= 0;
   end Terminate_App;

  ------------------------------------------------

  function Create_Message_Queue (
              Anchor_Block  : Anchor_Block_Handle_Type;
              Queue_Size    : Long := System_Default)
                              return Queue_Handle_Type is
   begin
     return WinCreateMsgQueue (Anchor_Block, Queue_Size);
   end Create_Message_Queue;

  ------------------------------------------------

  procedure Create_Message_Queue (
              Anchor_Block  : in     Anchor_Block_Handle_Type;
              Queue_Size    : in     Long := System_Default;
              Queue         :    out Queue_Handle_Type) is
     Temp_Queue : Queue_Handle_Type := Null_Queue;
    begin
      Temp_Queue := Create_Message_Queue (Anchor_Block, Queue_Size);

      if Is_Null (Temp_Queue) then
        raise Message_Queue_Was_Not_Created;
      end if;

      Queue := Temp_Queue;
    end Create_Message_Queue;

  ------------------------------------------------

  procedure Terminate_App (Anchor : in out Anchor_Block_Handle_Type) is
    Temp : Boolean;
   begin
    Temp   := Terminate_App (Anchor);
    Anchor := Null_Anchor_Block;
   end Terminate_App;

  ------------------------------------------------

  procedure Destroy_Message_Queue (Message_Queue : in out Queue_Handle_Type) is
    Temp : Boolean;
   begin
     Temp := Destroy_Message_Queue (Message_Queue);
     --Could add a check here and raise an exception if the message queue is
     --not destroyed. BJY 1/31/94
     Message_Queue := Null_Queue;
   end Destroy_Message_Queue;

  ------------------------------------------------

  function Destroy_Message_Queue (Message_Queue : Queue_Handle_Type)
                                                            return Boolean is

   begin
     return WinDestroyMsgQueue (Message_Queue) /= 0;
   end Destroy_Message_Queue;

  ------------------------------------------------

  procedure Destroy_Window (Window : in out HWND) is
     Temp : Boolean;
    begin
     Temp := Destroy_Window (Window);
     --Could add a check and raise and exception if the windows
     --is not destroyed.  BJY 1/31/94
     Window := Null_Window;
    end Destroy_Window;

  ------------------------------------------------

  function Destroy_Window (Window : HWND) return Boolean is

   begin
     return WinDestroyWindow (Window) /= 0;
   end Destroy_Window;

  ------------------------------------------------

   function Make_Style (
            Buttons        : MB_Button_Styles_Type;
            Icons          : MB_Icon_Styles_Type;
            Default_Action : MB_Default_Action_Type;
            Modality       : MB_Modality_Type := MB_Application_Modal;
            Help_Button    : Boolean          := False;
            Moveable       : Boolean          := True)
                                            return Ulong is
       Style_Value : Ulong := 0;
     begin
       Style_Value := Mb_Buttons (Buttons)
                       + MB_Icons (Icons)
                        + MB_Action (Default_Action)
                         + MB_Modality (Modality)
                          + MB_Help (Help_Button)
                           + MB_Moveable (Moveable);
       return Style_Value;
     end Make_Style;

  ------------------------------------------------

  function Message_Box (
            Parent_Window  : HWND;
            Request_Owner  : HWND;
            Message        : String;
            Title          : String;
            Help_Id        : Help_Id_Type;
            Buttons        : MB_Button_Styles_Type;
            Icons          : MB_Icon_Styles_Type;
            Default_Action : MB_Default_Action_Type;
            Modality       : MB_Modality_Type := MB_Application_Modal;
            Help_Button    : Boolean          := False;
            Moveable       : Boolean          := True)
                                            return MB_Response_Type is

       Response : Ushort;
       Style    : Ulong;

       Text_Str  : String (Message'first .. Message'last + 1);
       Title_Str : String (Title'first .. Title'last + 1);

    begin

      Text_Str (Text_Str'first .. Text_Str'last - 1) := Message;
      Text_Str (Text_Str'last) := AscII.Nul;

      Title_Str (Title_Str'first .. Title_Str'last - 1) := Title;
      Title_Str (Title_Str'last) := AscII.Nul;

      Style := Make_Style (Buttons,
                           Icons,
                           Default_Action,
                           Modality,
                           Help_Button,
                           Moveable);

      Response := Ushort( WinMessageBox (
                              hwndParent  => Parent_Window,
                              hwndOwner   => Request_Owner,
                              pszText     => Text_Str (Text_Str'first)'address,
                              pszCaption  => Title_Str (Title_Str'first)'address,
                              idWindow    => Ulong  (Help_Id),
                              flStyle     => Style)
                             ) ;

      if Response in MB_Response'range then
         return Mb_Response (Response);
      end if;

      return Mb_Error;

    end Message_Box;

  ------------------------------------------------

   function Get_Message (
               Anchor_Block : Anchor_Block_Handle_Type;
               Message      : Queue_Message_Pointer_Type;
               Window       : HWND;
               First        : Ulong;
               Last         : Ulong) return Boolean is

     begin
        return WinGetMsg (Anchor_Block, Message, Window, First, Last) = 1;
     end Get_Message;

  ------------------------------------------------

   procedure Dispatch_Message (
               Anchor_Block : in Anchor_Block_Handle_Type;
               Message      : in Queue_Message_Pointer_Type) is

    Junk : Ulong;
   PJunk : Mresult:=junk'address;

   begin
   PJunk :=  WinDispatchMsg (Anchor_Block, Message);
   end Dispatch_Message;

  ------------------------------------------------

   function Send_Message (
         To_Window   : HWND;
         Message     : Message_Type;
         Parameter_1 : Parameter_Type;
         Parameter_2 : Parameter_Type) return Void_Type is

     Result : Void_Type;
   begin
     Result := Ulong (WinSendMsg (
                hwn         => To_Window,
                msg         => Message,
                mp1         => Ulong(Parameter_1),
                mp2         => Ulong(Parameter_2))
               ) ;


     return Result;
   end Send_Message;

  ------------------------------------------------

   function Post_Message (
         To_Window   : HWND;
         Message     : Message_Type;
         Parameter_1 : Parameter_Type;
         Parameter_2 : Parameter_Type) return Boolean is

     begin
       return WinPostMsg (To_Window, Message,
       Ulong(Parameter_1),
       Ulong(Parameter_2) ) >0;
     end Post_Message;

  ------------------------------------------------

   function Get_PS (Window : HWND) return Ps_Type is

     begin
       return WinGetPS (Window);
     end Get_Ps;

  ------------------------------------------------


   procedure Release_Ps (Ps_Handle : in out Ps_Type) is

    begin
      if WinReleasePs (PS_Handle) = 1 then
         PS_Handle := Null_Ps;
      end if;
    end Release_Ps;
  ------------------------------------------------
end Win;
