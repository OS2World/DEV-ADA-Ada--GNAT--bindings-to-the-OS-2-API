with OS2; Use OS2;
with Os2.pmcp; use Os2.pmcp;
package Win is

  Win_Error : exception;

  System_Default : constant := 0;

 ---------------------------------------------------------------
--  os2 common types
subtype Point_Type is PointL;
subtype Point_Pointer_Type is PPointL;
subtype Short_Point_Type is PointS;

subtype Queue_Message_Type is  QMSG;
subtype Queue_Message_Pointer_Type is PQMSG;
------------------------------------------------
 --Window Handle type

  Null_Window           : constant HWND := 0;
  Null_HWND             : constant HWND := Null_Window;
  Desktop_Window        : constant HWND := 1;
  Top_Window            : constant HWND := 3;
  Bottom_Windw          : constant HWND := 4;
  Object_Handle         : constant HWND := 2;
  Thread_Capture_Handle : constant HWND := 5;

  subtype Id_Type is ULong;

 ------------------------------------------------------------

  subtype Void_Type is ULong;

  function To_Boolean   (Void : Void_Type) return Boolean;
  function To_Short     (Void : Void_Type) return Short;
  function To_U_Short   (Void : Void_Type) return UShort;

 ------------------------------------------------------------

  subtype Queue_Handle_Type is HMQ    ;

  Null_Queue : constant Queue_Handle_Type := 0;
  Null_HMQ   : constant Queue_Handle_Type := Null_Queue;
 -----------------------------------------------------------
  subtype Anchor_Block_Handle_Type is HAB;  --HAB

  Null_Anchor_Block : constant Anchor_Block_Handle_Type := 0;
  Null_HAB          : constant Anchor_Block_Handle_Type := Null_Anchor_Block;
  ----------------------------------------------------------

  subtype Ps_Type is   Hps;
  Null_PS : constant PS_Type:=0;

  ----------------------------------------------------------

  type Bitmap_Handle_Type is private;
  Null_Bitmap : constant Bitmap_Handle_Type;

  ----------------------------------------------------------

  subtype Parameter_Type is Long;
  subtype Time_Type is Long;
  subtype Pixel_Type is Long;
  subtype World_Model_Space_Type
              is Pixel_Type range -134_217_728 .. 134_217_727;

  subtype Device_Screen_Space_Type
              is Pixel_Type range -32_768 .. 32_767;

 ---------------------------------------------------
 -- Messages

  subtype Message_Type is ULong;

  --Standard Window Messages

  Wm_Null                  : constant Message_Type := 16#0000#;
  Wm_Create                : constant Message_Type := 16#0001#;
  Wm_Destroy               : constant Message_Type := 16#0002#;

  Wm_Enable                : constant Message_Type := 16#0004#;
  Wm_Show                  : constant Message_Type := 16#0005#;
  Wm_Move                  : constant Message_Type := 16#0006#;
  Wm_Size                  : constant Message_Type := 16#0007#;
  Wm_Adjust_Window_Pos     : constant Message_Type := 16#0008#;

  Wm_Calc_Valid_Rects      : constant Message_Type := 16#0009#;

  Wm_Set_Window_Params     : constant Message_Type := 16#000A#;
  Wm_Query_Window_Params   : constant Message_Type := 16#000B#;
  Wm_Hit_Test              : constant Message_Type := 16#000C#;
  Wm_Activate              : constant Message_Type := 16#000D#;
  Wm_Set_Focus             : constant Message_Type := 16#000F#;
  Wm_Set_Selection         : constant Message_Type := 16#0010#;

  --Language Support Winproc
  Wm_P_Paint               : constant Message_Type := 16#0011#;
  Wm_P_Set_Focus           : constant Message_Type := 16#0012#;
  Wm_P_Sys_Color_Change    : constant Message_Type := 16#0013#;
  Wm_P_Size                : constant Message_Type := 16#0014#;
  Wm_P_Activate            : constant Message_Type := 16#0015#;
  Wm_P_Control             : constant Message_Type := 16#0016#;

  Wm_Command               : constant Message_Type := 16#0020#;
  Wm_Sys_Command           : constant Message_Type := 16#0021#;
  Wm_Help                  : constant Message_Type := 16#0022#;
  Wm_Paint                 : constant Message_Type := 16#0023#;

  --Used for SAA
  Wm_Timer                 : constant Message_Type := 16#0024#;
  Wm_Sem_1                 : constant Message_Type := 16#0025#;
  Wm_Sem_2                 : constant Message_Type := 16#0026#;
  Wm_Sem_3                 : constant Message_Type := 16#0027#;
  Wm_Sem_4                 : constant Message_Type := 16#0028#;

  Wm_Close                 : constant Message_Type := 16#0029#;
  Wm_Quit                  : constant Message_Type := 16#002A#;
  Wm_Sys_Color_Change      : constant Message_Type := 16#002B#;
  Wm_Sys_Value_Changed     : constant Message_Type := 16#002D#;
  Wm_App_Terminate_Notify  : constant Message_Type := 16#002E#;
  Wm_Pres_Param_Changed    : constant Message_Type := 16#002F#;

  --Control notification messages

  Wm_Control               : constant Message_Type := 16#0030#;
  Wm_V_Scroll              : constant Message_Type := 16#0031#;
  Wm_H_Scroll              : constant Message_Type := 16#0032#;
  Wm_Init_Menu             : constant Message_Type := 16#0033#;
  Wm_Menu_Select           : constant Message_Type := 16#0034#;
  Wm_Menu_End              : constant Message_Type := 16#0035#;
  Wm_Draw_Item             : constant Message_Type := 16#0036#;
  Wm_Measure_Item          : constant Message_Type := 16#0037#;
  Wm_Control_Pointer       : constant Message_Type := 16#0038#;
  Wm_Query_Dlg_Code        : constant Message_Type := 16#003A#;
  Wm_Init_Dgl              : constant Message_Type := 16#003B#;
  Wm_Substitute_String     : constant Message_Type := 16#003C#;
  Wm_Match_Menonic         : constant Message_Type := 16#003D#;
  Wm_Save_Application      : constant Message_Type := 16#003E#;

  --Mouse Messages

  Wm_Mouse_First           : constant Message_Type := 16#0070#;
  Wm_Mouse_Last            : constant Message_Type := 16#0079#;
  Wm_Button_Click_First    : constant Message_Type := 16#0071#;
  Wm_Button_Click_Last     : constant Message_Type := 16#0079#;

  Wm_Mouse_Move            : constant Message_Type := 16#0070#;

  Wm_Button_1_Down         : constant Message_Type := 16#0071#;
  Wm_Button_1_Up           : constant Message_Type := 16#0072#;
  Wm_Button_1_Dbl_Clk      : constant Message_Type := 16#0073#;
  Wm_Button_2_Down         : constant Message_Type := 16#0074#;
  Wm_Button_2_Up           : constant Message_Type := 16#0075#;
  Wm_Button_2_Dbl_Clk      : constant Message_Type := 16#0076#;
  Wm_Button_3_Down         : constant Message_Type := 16#0077#;
  Wm_Button_3_Up           : constant Message_Type := 16#0078#;
  Wm_Button_3_Dbl_Clk      : constant Message_Type := 16#0079#;

  Wm_Ext_Mouse_First       : constant Message_Type := 16#0410#;
  Wm_Ext_Mouse_Last        : constant Message_Type := 16#0419#;

  Wm_Chord                 : constant Message_Type := 16#0410#;
  Wm_Button_1_Motion_Start : constant Message_Type := 16#0411#;
  Wm_Button_1_Motion_End   : constant Message_Type := 16#0412#;
  Wm_Button_1_Click        : constant Message_Type := 16#0413#;
  Wm_Button_2_Motion_Start : constant Message_Type := 16#0414#;
  Wm_Button_2_Motion_End   : constant Message_Type := 16#0415#;
  Wm_Button_2_Click        : constant Message_Type := 16#0416#;
  Wm_Button_3_Motion_Start : constant Message_Type := 16#0417#;
  Wm_Button_3_Motion_End   : constant Message_Type := 16#0418#;
  Wm_Button_3_Click        : constant Message_Type := 16#0419#;

  --Messages 16#041A# - 16#041F# are reserved

  Wm_Mouse_Translate_First : constant Message_Type := 16#0420#;
  Wm_Mouse_Translate_Last  : constant Message_Type := 16#0428#;
  Wm_Begin_Drag            : constant Message_Type := 16#0420#;
  Wm_End_Drag              : constant Message_Type := 16#0421#;
  Wm_Single_Select         : constant Message_Type := 16#0422#;
  Wm_Open                  : constant Message_Type := 16#0423#;
  Wm_Context_Menu          : constant Message_Type := 16#0424#;
  Wm_Text_Edit             : constant Message_Type := 16#0426#;
  Wm_Begin_Select          : constant Message_Type := 16#0427#;
  Wm_End_Select            : constant Message_Type := 16#0428#;

  -- Key/Character input messages

  Wm_Char                  : constant Message_Type := 16#007A#;
  Wm_VIO_Char              : constant Message_Type := 16#007B#;

  Wm_Journal_Notify        : constant Message_Type := 16#007C#;

  --Frame window related message

  Wm_Flash_Window          : constant Message_Type := 16#0040#;
  Wm_Format_Frame          : constant Message_Type := 16#0041#;
  Wm_Update_Frame          : constant Message_Type := 16#0042#;
  Wm_Focus_Change          : constant Message_Type := 16#0043#;

  Wm_Set_Border_Size       : constant Message_Type := 16#0044#;
  Wm_Track_Frame           : constant Message_Type := 16#0045#;
  Wm_Min_Max_Frame         : constant Message_Type := 16#0046#;
  Wm_Set_Icon              : constant Message_Type := 16#0047#;
  Wm_Query_Icon            : constant Message_Type := 16#0048#;
  Wm_Set_Accel_Table       : constant Message_Type := 16#0049#;
  Wm_Query_Accel_Table     : constant Message_Type := 16#004A#;
  Wm_Translate_Accel       : constant Message_Type := 16#004B#;
  Wm_Query_Track_Info      : constant Message_Type := 16#004C#;
  Wm_Query_Border_Size     : constant Message_Type := 16#004D#;
  Wm_Next_Menu             : constant Message_Type := 16#004E#;
  Wm_Erase_Background      : constant Message_Type := 16#004F#;
  Wm_Query_Frame_Info      : constant Message_Type := 16#0050#;
  Wm_Query_Pos_Change      : constant Message_Type := 16#0051#;
  Wm_Owner_Pos_Change      : constant Message_Type := 16#0052#;
  Wm_Cacl_Frame_Rect       : constant Message_Type := 16#0053#;
   -- Note 16#0054# is reserved
  Wm_Window_Pos_Changed    : constant Message_Type := 16#0055#;
  Wm_Adjust_Frame_Pos      : constant Message_Type := 16#0056#;
  Wm_Query_Frame_Ctl_Count : constant Message_Type := 16#0059#;
   -- Note 16#005A# is reserved
  Wm_Query_Help_Info       : constant Message_Type := 16#005B#;
  Wm_Set_Help_Info         : constant Message_Type := 16#005C#;
  Wm_Error                 : constant Message_Type := 16#005D#;
  Wm_Realize_Palette       : constant Message_Type := 16#005E#;

  --Clipboard messages

  Wm_Render_Fmt            : constant Message_Type := 16#0060#;
  Wm_Render_All_Fmts       : constant Message_Type := 16#0061#;
  Wm_Destroy_Clipboard     : constant Message_Type := 16#0062#;
  Wm_Paint_Clipboard       : constant Message_Type := 16#0063#;
  Wm_Size_Clipboard        : constant Message_Type := 16#0064#;
  Wm_H_Scroll_Clipboard    : constant Message_Type := 16#0065#;
  Wm_V_Scroll_Clipboard    : constant Message_Type := 16#0066#;
  Wm_Draw_Clipboard        : constant Message_Type := 16#0067#;

  --Dynamic Data Exchange (DDE) messages

  Wm_DDE_First             : constant Message_Type := 16#00A0#;
  Wm_DDE_Initiate          : constant Message_Type := 16#00A0#;
  Wm_DDE_Request           : constant Message_Type := 16#00A1#;
  Wm_DDE_Ack               : constant Message_Type := 16#00A2#;
  Wm_DDE_Data              : constant Message_Type := 16#00A3#;
  Wm_DDE_Advise            : constant Message_Type := 16#00A4#;
  Wm_DDE_Unadvise          : constant Message_Type := 16#00A5#;
  Wm_DDE_Poke              : constant Message_Type := 16#00A6#;
  Wm_DDE_Execute           : constant Message_Type := 16#00A7#;
  Wm_DDE_Terminate         : constant Message_Type := 16#00A8#;
  Wm_DDE_Initate_Ack       : constant Message_Type := 16#00A9#;
  Wm_DDE_Last              : constant Message_Type := 16#00AF#;

  Wm_Query_Convert_Pos     : constant Message_Type := 16#00B0#;
  Wm_Dbcs_First            : constant Message_Type := 16#00B0#;
  Wm_Dbcs_Loat             : constant Message_Type := 16#00CF#;

  --Help manager message range

  Wm_Help_Base             : constant Message_Type := 16#0F00#;
  Wm_Help_Top              : constant Message_Type := 16#0FFF#;

  --Menu Control Messages

  MM_Insert_Item             : constant Message_Type := 16#0180#;
  MM_Delete_Item             : constant Message_Type := 16#0181#;
  MM_Query_Item              : constant Message_Type := 16#0182#;
  MM_Set_Item                : constant Message_Type := 16#0183#;
  MM_Query_Item_Count        : constant Message_Type := 16#0184#;
  MM_Start_Menu_Mode         : constant Message_Type := 16#0185#;
  MM_End_Menu_Mode           : constant Message_Type := 16#0186#;
  MM_Remove_Item             : constant Message_Type := 16#0188#;
  MM_Select_Item             : constant Message_Type := 16#0189#;
  MM_Query_Selected_Item_Id  : constant Message_Type := 16#018a#;
  MM_Query_Item_Text         : constant Message_Type := 16#018b#;
  MM_Query_Item_Text_Length  : constant Message_Type := 16#018c#;
  MM_Set_Item_Handle         : constant Message_Type := 16#018d#;
  MM_Set_Item_Text           : constant Message_Type := 16#018e#;
  MM_Item_Position_From_Id   : constant Message_Type := 16#018f#;
  MM_Item_Id_From_Position   : constant Message_Type := 16#0190#;
  MM_Query_Item_Attr         : constant Message_Type := 16#0191#;
  MM_Set_Item_Attr           : constant Message_Type := 16#0192#;
  MM_Is_Item_Valid           : constant Message_Type := 16#0193#;
  MM_Query_ITem_Rect         : constant Message_Type := 16#0194#;

  MM_Query_Default_Item_Id   : constant Message_Type := 16#0431#;
  MM_Set_Default_Item_Id     : constant Message_Type := 16#0432#;


  --User messages are defined after Wm_User
  Wm_User                  : constant Message_Type := 16#1000#;


  type MB_Button_Styles_Type is (
        MB_Ok,                 -- Message box contains an
                               -- Okay pushbutton.

        MB_Ok_Cancel,          -- Message box contains both Okay and
                               -- Cancel pushbuttons.

        MB_Cancel,             -- Message box contains a Cancel pushbutton.
        MB_Enter,              -- Message box contains an Enter pushbutton.
        MB_Enter_Cancel,       -- Message box contains both Enter and
                               -- Cancel pushbuttons.

        MB_Retry_Cancel,       -- Message box contains both Retry and
                               -- Cancel pushbuttons.

        MB_Abort_Retry_Ignore, -- Message box contains Abort, Retry, and
                               -- Ignore pushbuttons.

        MB_Yes_No,             -- Message box contains both Yes and
                               -- No pushbuttons.

        MB_Yes_No_Cancel);     -- Message box contains Yes, No, and Cancel
                               -- pushbuttons.

  type MB_Icon_Styles_Type is (
      MB_No_Icon,         -- The message box does not contain an icon.
      MB_Icon_Hand,       -- The message box contains a hand icon.
      MB_Icon_Question,    -- The message box contains a question mark icon.
      MB_Icon_Exclamation, -- The message box contains an exclamation point icon.
      MB_Icon_Asterisk,    -- The message box contains an asterisk icon.
      MB_Information,      -- The message box contains a black information
                           -- `i in a square box.

      MB_Query,            -- The message box contains a question mark in a
                           -- square box.

      MB_Warning,          -- The message box contains a black ! in a
                           -- square box.

      MB_Error);           -- The message box contains a Stop icon on a
                           -- white background.

  type MB_Default_Action_Type is (
      MB_Default_On_Button_1,  --The first button is the default selection.
      MB_Default_On_Button_2,  --The second button is the default selection.
      MB_Default_On_Button_3);  --The third button is the default selection.

  type MB_Modality_Type is (
      MB_Application_Modal, -- The message box is application modal.  This
                            -- is the default case.  The owner is disabled
                            -- so do specfiy the owner as parent if this
                            -- option is used.
      MB_System_Modal);     -- The entire system is stop until this message
                            -- box is cleared.

  type Mb_Response_Type is (
    MB_Enter_Pressed,  -- The Enter pushbutton was pressed.
    MB_Ok_Pressed,     -- The Ok pushbutton was pressed.
    MB_Cancel_Pressed, -- The Cancel pushbutton was pressed.
    MB_Abort_Pressed,  -- The Abort pushbutton was pressed.
    MB_Retry_Pressed,  -- The Retry pushbutton was pressed.
    MB_Ignore_Pressed, -- The Ignore pushbutton was pressed.
    MB_Yes_Pressed,    -- The Yes pushbutton was pressed.
    MB_No_Pressed,     -- The No pushbutton was pressed.
    MB_Help_Pressed,    -- The Help pushbutton was pressed.
    MB_Error);         -- The message box failed because of an error.

  ------------------------------------------------

  type Class_Style_Type is (
       Cs_Size_Redraw,   --Determines whether a window will be redrawn when
                         --sized.

       Cs_Sync_Paint,    --The window is synchronously repainted.
       Cs_Move_Notify,   --When the window is moved a WM_Move message is
                         --posted.

       Cs_Clip_Children, --Causes a window of style WS_Clip_Children to be
                         --created.

       Cs_Clip_Siblings, --Causes a window of style WS_Clip_Siblings to be
                         --created.

       Cs_Parent_Clip,   --Causes a window of style WS_Parent_Clip to be
                         --created.

       Cs_Save_Bits,     --Causes a window of WS_Save_Bits to be created.
       Cs_Public,        --Causes a public window class to be registered.
       Cs_Hit_Test,      --If set a Wm_Hit_Test message is send to the window
                         --before any pointing device messages are sent.
                         --If it is not set then no Wm_Hit_Test message is
                         --sent.

       Cs_Frame);        --All windows are expected to behave as frame windows.

  type Class_Styles_Type is array (Class_Style_Type) of Boolean;

  type Position_Options_Type is (
         Swp_Size,             --Change the size of the window.
         Swp_Move,             --Move the window to the specified x, y
                               --position.

         Swp_Z_Order,          --Move the window either behind or in front of
                               --another window.

         Swp_Show,             --Show the window.
         Swp_Hide,             --Hide the window.  This does not iconfiy
                               --a window.

         Swp_No_Redraw,        --Do not draw the changes.
         Swp_No_Adjust,        --Do not send the WM_Adjust_Window_Pos message
                               --when moving or sizing the window.

         Swp_Activate,         --Actives the Window if it is a framed window.
                               --This option has no effect on other windows.
                               --The window is also made the top most window,
                               --unless Swp_Z_Order is used in which case the
                               --Window in Behind_Window is used.

         Swp_Deactivate,       --Deactivates the Window if it is a framed
                               --window.  It has no effect on other windows.
                               --The window is made the bottom most window
                               --unless the Swp_Z_Order options is also in use.

         Swp_Ext_State_Change, --Unknown? Not in online documentation. ####

         Swp_Minimize,         --Minimizes the window.  The option has no effect
                               --if the window is already minimized.  This
                               --iconfies a window.  This option cannot be used
                               --with the Swp_Maximize or Swp_Restore options.

         Swp_Maximize,         --The window is set to the maximum screen size.
                               --The option has no effect if the window is
                               --already maximized.  This option cannot be used
                               --with the Swp_Minimize or Swp_Restore options.

         Swp_Restore,          --Restores a window to its normal state after a
                               --Swp_Minimize or Swp_Maximize.  This option cannot
                               --be used with the Swp_Minimize or Swp_Maximize
                               --options.  If the Swp_Move or Swp_Size options
                               --are set the new values for size and position
                               --will be used when restoring the window.

         Swp_Focus_Active,     --Window is given the active focus.
         Swp_Focus_Deactivate, --Window loses the focus.
         Swp_No_Auto_Close);   --Unknown.

   type Position_Type is array (Position_Options_Type) of Boolean;

  -----------------------------------------------------------

   type Window_Style_Type is (
      Ws_Sync_Paint,         --The window is synchronously repainted.  This
                             --style is useful when the Class style is
                             --Cs_Sync_Paint.  An applications can the turn
                             --this style on and off to vary the repainting of
                             --the window.

      Ws_Clip_Children,      --The area occupied by a child window should be
                             --excluded when drawing is done to the parent
                             --window.  Normally, the child window's area is
                             --included.

      Ws_Clip_Siblings,      --The area occupied by a sibling's window should
                             --be excluded when drawing is done to the window.
                             --Normally, the sibling's window area is included.

      Ws_Disabled,           --The window is disabled.  Normally a window is
                             --enabled.

      Ws_Maximized,          --The frame window is to be created at maximum
                             --size.

      Ws_Mimimized,          --The frame window is created iconfied.

      Ws_Parent_Clip,        --Controls how a window is clipped when drawing
                             --takes place inside of the window.

      Ws_Save_Bits,          --The contents of the window should be saved when
                             --the window is made visible.
      Ws_Visible,            --The window is made visible.  Normally, the
                             --window is invisible.
      Ws_Animate,            --???

      Ws_Group,              --Used when a window is part of a Dialog Box.
                             --This option identifies the dialog items that
                             --form a group.  The first window of a group
                             --should be specified with this style.  The
                             --following windows should not.  The windows of
                             --a group must also be adjacent siblings.

      Ws_Tab_Stop,           --Used when a window is part of a Dialog Box.
                             --This option identifies a dialog item that the
                             --user can reach by using the TAB key.

      Ws_Multi_Select,       --???

      Fs_Screen_Align,       --The dialog box coordinates are relative to
                             --the top left corner of the screen, rather
                             --than the parent window's top left corner.

      Fs_Mouse_Align,        --The dialog box's top left corner is position
                             --is relative to the mouse pointer at the time
                             --of creation.  The dialog box will stay on
                             --screen if possible.

      Fs_Sizing_Border,      --The window's frame has a border that can be
                             -- sized.

      Fs_Border,             --The window is drawn with a thin border that
                             --cannot be sized.

      Fs_Dialog_Border,      --Window is drawn with the standard dialog box
                             --border.

      Fs_System_Modal,       --The frame window is system modal.

      Fs_No_Byte_Align,      --When set the system will not optimize movement
                             --and sizing of the window.

      Fs_Task_List,          --When set, the program's title is prepended to
                             --the window title text.  The new title is also
                             --entered on the task list. The program title is
                             -- the text used to start the program.

      Fs_No_Move_With_Owner, --The window is not moved when the owning window
                             --is moved.

      Fs_Auto_Icon);         --When redrawing iconized windows the system
                             --redraws the icon and the Wm_Paint message is
                             --not to the application.

   type Window_Styles_Type is array (Window_Style_Type) of Boolean;

   Null_Window_Styles : constant Window_Styles_Type := (others => False);
   Use_Class_Styles   : constant Window_Styles_Type := Null_Window_Styles;

  -----------------------------------------------------------------------------

   type Frame_Control_Flag_Type is (
        Fcf_Title_Bar,           --The frame should have a title bar.
        Fcf_System_Menu,         --The frame should have a system menu.
                                 --The system menu is the menu under the
                                 --application's icon in the upper left corner.

        Fcf_Menu,                --The frame should have a menu bar.

        Fcf_Min_Max,             --The frame should have a Minimize and
                                 --Maximize button.  These button will appear
                                 --in the upper right corner.

        Fcf_Min_Button,          --The frame should have a Minimize button.

        Fcf_Max_Button,          --The frame should have a Maximize button.

        Fcf_Vert_Scroll_Bar,     --The frame should have a vertical scroll bar.

        Fcf_Horz_Scroll_Bar,     --The frame should have a horizontal scroll
                                 -- bar.

        Fcf_Sizing_Border,       --The frame has a border that can be sized.

        Fcf_Border,              --The window is drawn with a thin border that
                                 --cannot be sized.

        Fcf_Dialog_Border,       --Window is drawn with the standard dialog
                                 -- box border.

        Fcf_Accel_Table,         --Loads the accelerator table from the
                                 --resource file that is identified by the
                                 --Create_Standard_Window routine.

        Fcf_Icon,                --An icon is associated with the window
                                 --when it is minimized.  The icon is
                                 --specified by the
                                 --Create_Standard_Window routine.

        Fcf_Shell_Position,      --The shell determines the size and position
                                 --of the window.  Normally, the application
                                 --determines the size and position.

        Fcf_System_Modal,        --The frame window is system modal.

        Fcf_No_Byte_Align,       --When set the system will not optimize
                                 --movement and sizing of the window.

        Fcf_Task_List,           --When set, the program's title is prepended
                                 --to the window title text.  The new title is
                                 --also entered on the task list. The program
                                 --title is the text used to start the program.

        Fcf_No_Move_With_Owner,  --The window is not moved when the owning
                                 --window is moved.

        Fcf_Standard,            --Default window frame.  Is the same as
                                 --   Fcf_Title_Bar, Fcf_System_Menu,
                                 --   Fcf_Min_Button, Fcf_Max_Button,
                                 --   Fcf_Sizing_Border, Fcf_Icon,
                                 --   Fcf_Menu, Fcf_Accel_Table,
                                 --   Fcf_Shell_Position, Fcf_Tasklist.
                                 --If no frame control options are provided
                                 --this is considered the default settings.

        Fcf_Screen_Align,        --The dialog box coordinates are relative
                                 --to the top left corner of the screen, rather
                                 --than the parent window's top left corner.

        Fcf_Mouse_Align,         --The dialog box's top left corner is position
                                 --is relative to the mouse pointer at the time
                                 --of creation.  The dialog box will stay on
                                 --screen if possible.

        Fcf_Auto_Icon,           --When redrawing iconized windows the system
                                 --redraws the icon and the Wm_Paint message is
                                 --not to the application.

        Fcf_Hide_Button,         --Adds a hide button to the title bar.

        Fcf_Hide_Max);           --Hides the minimize and maximize buttons.

  type Frame_Control_Flags_Type is array (Frame_Control_Flag_Type) of Boolean;

  Null_Frame_Flags : constant Frame_Control_Flags_Type := (others => False);

  type Frame_Id_Type is (
         Fid_System_Menu,
         Fid_Titlebar,
         Fid_Min_Max,
         Fid_Menu,
         Fid_Vert_Scroll_Bar,
         Fid_Horz_Scroll_Bar,
         Fid_Client,
         Fid_DBE_App_Stat,
         Fid_DBE_Kbd_Stat,
         Fid_DBE_Pecic,
         Fid_Dbe_KK_Pop_Up);

  -----------------------------------------------------------------------------

   Min_Max_Restore_Usage_Error : exception; --Raise when Swp_Minimize,
                                            --Swp_Maximize or
                                            --Swp_Restore are used together.

   Clear_Position : constant Position_Type := (Others => False);
   Show_Window    : constant Position_Type := (Swp_Size     => True,
                                               Swp_Move     => True,
                                               Swp_Show     => True,
                                               Swp_Activate => True,
                                               Others       => False);
   Iconify_Window : constant Position_Type := (Swp_Minimize => True,
                                               others       => False);
   Restore_Window : constant Position_Type := (Swp_Restore  => True,
                                               Swp_Activate => True,
                                               others       => False);

  ------------------------------------------------

   --Keyboard Types
   type Key_Flag_Type is (
          Kc_None,
          Kc_Char,
          Kc_Virtual_Key,      --Indicates that the Virtual_Key value is valid.

          Kc_Scan_Code,        --Indicates that the scancode is valid.
                               --This is usually set when a WM_Char message
                               --is generated by a user.  If the message is
                               --sent by an application it may not be set.

          Kc_Shift,            --The Shift key was down when the key was
                               --pressed or released.

          Kc_Ctrl,             --The Control key was down when the key was
                               --pressed or released.

          Kc_Atl,              --The Alt key was down when the key was pressed
                               --or released

          Kc_Key_Up,           --The event is a key-up transition.  If false
                               --then the event was a key-down transition.

          Kc_Previous_Down,    --The key was previously down.  If false
                               --then the key was up.

          Kc_Lone_Key,         --Indicates that this was the only key pressed
                               --and release while the key was cycled.

          Kc_Dead_Key,         --The character code is a dead key.  The
                               --application must generate the display for
                               --the key without advancing the
                               --cursor.

          Kc_Composite,        --This character code is combined with the
                               --previous dead
                               --key to from the character code.

          Kc_Invalid_Composite, --The character code is not valid with the
                                --previous dead key.  The application must
                                --advance the cursor past the
                                --dead key image.

          Kc_Toggle,
          Kc_Invalid_Character,
          Kc_DB_CSR_SR_VD1,
          Kc_Db_CSR_SR_VD2);

   type Key_Flags_Type is array (Key_Flag_Type) of Boolean;

   type Virtual_Key_Type is (
           Vk_Button_1,
           Vk_Button_2,
           Vk_Button_3,
           Vk_Break,
           Vk_Backspace,
           Vk_Tab,
           Vk_Back_Tab,
           Vk_New_Line,
           Vk_Shift,
           Vk_Ctrl,
           Vk_Atl,
           Vk_Alt_Graf,
           Vk_Pause,
           Vk_Caps_Lock,
           Vk_Esc,
           Vk_Space,
           Vk_Page_Up,
           Vk_Page_Down,
           Vk_End,
           Vk_Home,
           Vk_Left,
           Vk_Up,
           Vk_Right,
           Vk_Down,
           Vk_Print_Screen,
           Vk_Insert,
           Vk_Delete,
           Vk_Scroll_Lock,
           Vk_Num_Lock,
           Vk_Enter,
           Vk_Sys_Rq,
           Vk_F1,
           Vk_F2,
           Vk_F3,
           Vk_F4,
           Vk_F5,
           Vk_F6,
           Vk_F7,
           Vk_F8,
           Vk_F9,
           Vk_F10,
           Vk_F11,
           Vk_F12,
           Vk_F13,
           Vk_F14,
           Vk_F15,
           Vk_F16,
           Vk_F17,
           Vk_F18,
           Vk_F19,
           Vk_F20,
           Vk_F21,
           Vk_F22,
           Vk_F23,
           Vk_F24,
           Vk_End_Drag,
           Vk_Menu,
           Vk_Null);

   type Key_Press_Info_Type is
      record
        Flags          : Key_Flags_Type;
        Repeat_Count   : Uchar;
        Scan_Code      : Uchar;
        Character_Code : UShort;
        Virtual_Key    : Virtual_Key_Type;
      end record;


  function Key_Info_Is (Message_Parameter_1 : Parameter_Type;
                        Message_Parameter_2 : Parameter_Type)
                                        return Key_Press_Info_Type;
   --For use after recieving a WM_Char message.  Decodes the
   --two message parameters and returns the values in the record.
   --Use with other message will cause errors.

  ------------------------------------------------

  type Command_Source_Type is (
       Cmd_Src_Push_Button,
       Cmd_Src_Menu,
       Cmd_Src_Accelerator,
       Cmd_Src_Font_Dialog,
       Cmd_Src_File_Dialog,
       Cmd_Src_Print_Dialog,
       Cmd_Src_Color_Dialog,
       Cmd_Src_Other);

  type Command_Id_Type is new UShort;

  type Command_Info_Type is
    record
     Id         : Command_Id_Type;
     Source     : Command_Source_Type;
     By_Pointer : Boolean;
   end record;

  function Command_Info_Is (Message_Parameter_1 : Parameter_Type;
                            Message_Parameter_2 : Parameter_Type)
                                              return Command_Info_Type;

   --For use after recieving a Wm_Command message.  Decodes the two
   --message parameters and returns the values in the Command_Info type.
   --Use with other message may cause errors.

  ------------------------------------------------

   type Menu_Style_Type is (
       MIS_Text,
       MIS_Bitmap,
       MIS_Separator,
       MIS_Owner_Draw,
       MIS_Submenu,
       MIS_Mult_Menu,
       MIS_Sys_Command,
       MIS_Help,
       MIS_Static,
       MIS_Button_Separator,
       MIS_Break,
       MIS_Break_Separator,
       MIS_Group,
       MIS_Single);

   type Menu_Attribute_Type is (
        MIA_No_Dismiss,
        MIA_Framed,
        MIA_Checked,
        MIA_Disabled,
        MIA_Highlighted);

   type Menu_Attributes_Type is array (Menu_Attribute_Type) of Boolean;

   type Menu_Position_Type is range -3 .. 1_000;

   MIT_End       : constant Menu_Position_Type := -3;
   MIT_None      : constant Menu_Position_Type := -1;
   MIT_Mem_Error : constant Menu_Position_Type := -1;
   MIT_Error     : constant Menu_Position_Type := -1;
   MIT_First     : constant Menu_Position_Type := -2;
   MIT_Last      : constant Menu_Position_Type := -3;
   MID_None      : constant Menu_Position_Type := MIT_None;
   MID_Error     : constant Menu_Position_Type := -1;

   type Menu_Item_Type is
     record
       Position    : Menu_Position_Type;
       Style       : Menu_Style_Type;
       Attributes  : Menu_Attributes_Type;
       Item_Id     : Command_Id_Type;
       Sub_Menu    : HWND;
       Item_Handle : Bitmap_Handle_Type;
     end record;

  ------------------------------------------------

   type Internal_Menu_Item_Type is private;
   Null_Internal_Menu : constant Internal_Menu_Item_Type;

   function Create_Internal_Menu return Internal_Menu_Item_Type;

   procedure Destroy_Internal_Menu (Internal_Menu : in out Internal_Menu_Item_Type);

   function Convert_To_Internal (Menu_Item : Menu_Item_Type)
                                        return Internal_Menu_Item_Type;

   function Convert_To_External (Menu_Item : Internal_Menu_Item_Type)
                                                  return Menu_Item_Type;

  ------------------------------------------------

   function Query_Menu_Item (
              Menu    : HWND;
              Item_Id : Command_Id_Type) return Menu_Item_Type;

  ------------------------------------------------

   procedure Insert_Menu_Item (
                     Menu      : in HWND;
                     Menu_Data : in Menu_Item_Type;
                     Text      : in String);

  ------------------------------------------------

   procedure Delete_Menu_Item (
                     Menu      : in HWND;
                     Item_Id   : Command_Id_Type);

  ------------------------------------------------

   function Check_Menu_Item (
              Menu    : HWND;
              Item_Id : Command_Id_Type;
              Check   : Boolean) return Boolean;

  ------------------------------------------------

  function Is_Menu_Item_Checked (
              Menu     : HWND;
              Item_Id  : Command_Id_Type) return Boolean;

  ------------------------------------------------

  function Is_Menu_Item_Enabled (
              Menu     : HWND;
              Item_Id  : Command_Id_Type) return Boolean;

  ------------------------------------------------

  function Is_Menu_Item_Valid (
              Menu     : HWND;
              Item_Id  : Command_Id_Type) return Boolean;

  ------------------------------------------------

   function Enable_Menu_Item (
              Menu     : HWND;
              Item_Id  : Command_Id_Type;
              Enable   : Boolean) return Boolean;

  ------------------------------------------------

   function Load_Menu (
                  Owner_Window : HWND;
                  Resource     :  ULong;
                  Menu_Id      : Id_Type) return HWND;

  ------------------------------------------------

   type Pop_Up_Option_Type is (
      Pu_Position_On_Item,
      Pu_Horz_Constrained,
      Pu_Vert_Constrained,
      Pu_None,
      Pu_Mouse_Button_1_Down,
      Pu_Mouse_Button_2_Down,
      Pu_Mouse_Button_3_Down,
      Pu_Select_Item,
      Pu_Mouse_Button_1,
      Pu_Mouse_Button_2,
      Pu_Mouse_Button_3,
      Pu_Keyboard);

   type Pop_Up_Options_Type is array (Pop_Up_Option_Type) of Boolean;

   function Pop_Up_Menu (
        Window       : HWND;
        Frame_Window : HWND;
        Menu_Window  : HWND;
        X            : Pixel_Type;
        Y            : Pixel_Type;
        Item_Id      : Command_Id_Type;
        Options      : Pop_Up_Options_Type) return Boolean;

   procedure Pop_Up_Menu (
        Window       : in HWND;
        Frame_Window : in HWND;
        Menu_Window  : in HWND;
        X            : in Pixel_Type;
        Y            : in Pixel_Type;
        Item_Id      : in Command_Id_Type;
        Options      : in Pop_Up_Options_Type);

  ------------------------------------------------

 subtype Message_Handler_Function is PFNWP ;

-- type Message_Handler_Function is access
--      function (Window              : HWND;
--                Message             : Message_Type;
--                Message_Parameter_1 : Parameter_Type;
--                Message_Parameter_2 : Parameter_Type)
--                                               return ULong;

  ------------------------------------------------

  function Pointer_Is (Parameter : Parameter_Type) return Point_Type;

  ------------------------------------------------

  function Get_Error_Info (Anchor_Block : Anchor_Block_Handle_Type)
                                          return PErrinfo;

  ------------------------------------------------

  function Get_Last_Error (Anchor_Block : Anchor_Block_Handle_Type)
                                                  return ULong;

  ------------------------------------------------

  function Register_Class (Anchor_Block    : Anchor_Block_Handle_Type;
                           Class_Name      : String;
                           Message_Handler : Message_Handler_Function;
                           Class_Style     : Class_Styles_Type;
                           Extra_Storage   : UShort) return Boolean;

  Register_Failed : exception;

  procedure Register_Class (Anchor_Block    : in Anchor_Block_Handle_Type;
                            Class_Name      : in String;
                            Message_Handler : in Message_Handler_Function;
                            Class_Style     : in Class_Styles_Type;
                            Extra_Storage   : in UShort);

  ------------------------------------------------

  function Default_Window_Procedure
                          (Window              : HWND;
                           Message             : Message_Type;
                           Message_Parameter_1 : Parameter_Type;
                           Message_Parameter_2 : Parameter_Type)
                                               return ULong;

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
            New_Window          : PHWND) return HWND;

  ------------------------------------------------

  function Window_From_Id (
            Parent_Window : HWND;
            Frame_Id      : Frame_ID_Type) return HWND;

  ------------------------------------------------


  function Set_Window_Position (
              Window           : HWND;
              Behind_Window    : HWND;
              X                : Device_Screen_Space_Type;
              Y                : Device_Screen_Space_Type;
              Width            : Device_Screen_Space_Type;
              Height           : Device_Screen_Space_Type;
              Position_Options : Position_Type) return Boolean;

  Set_Failed : exception;

  procedure Set_Window_Position (
              Window           : in HWND;
              Behind_Window    : in HWND;
              X                : in Device_Screen_Space_Type;
              Y                : in Device_Screen_Space_Type;
              Width            : in Device_Screen_Space_Type;
              Height           : in Device_Screen_Space_Type;
              Position_Options : in Position_Type);

  ------------------------------------------------

  function Is_Null (Window        : HWND) return Boolean;
  function Is_Null (Bitmap        : Bitmap_Handle_Type) return Boolean;
  function Is_Null (Internal_Menu : Internal_Menu_Item_Type) return Boolean;

  ------------------------------------------------

  Initialization_Failed : exception;

  function Initialize (
                       Options : ULong := System_Default
                            --The only PM option is a value of 0.
                                   ) return Anchor_Block_Handle_Type;

  procedure Initialize (
             Options      : in     ULong := System_Default;
             Anchor_Block :    out Anchor_Block_Handle_Type);

   --Initializes the PM facilities for use by an application.
   --OS/2 PM Function WinInitialize

  ------------------------------------------------

  procedure Terminate_App (Anchor : in out Anchor_Block_Handle_Type);

  function Terminate_App (Anchor : Anchor_Block_Handle_Type) return Boolean;

  --Terminates an OS/2 application and releases the applications resources.

  ------------------------------------------------

  procedure Destroy_Message_Queue (Message_Queue : in out Queue_Handle_Type);

  function Destroy_Message_Queue (Message_Queue : Queue_Handle_Type)
                                                              return Boolean;
   --Destroys the applications message queue.
   --OS/2 PM Function WinDestroyMsgQueue

  ------------------------------------------------

  procedure Destroy_Window (Window : in out HWND);

  function Destroy_Window (Window : HWND) return Boolean;

   --Destroys the specified window.
   --OS/2 PM Function WinDestroyWindow

  ------------------------------------------------

  Message_Queue_Was_Not_Created : exception;

  function Create_Message_Queue (
              Anchor_Block  : Anchor_Block_Handle_Type;
              Queue_Size    : Long := System_Default)
                              return Queue_Handle_Type;

  procedure Create_Message_Queue (
              Anchor_Block  : in     Anchor_Block_Handle_Type;
              Queue_Size    : in     Long := System_Default;
              Queue         :    out Queue_Handle_Type);

     --Most PM function require a Message Queue.  This function should
     --be called right after the Initialize function and before any other
     --PM calls.

     --OS/2 PM Function WinCreateMsgQueue

  ------------------------------------------------

   function Get_Message (
               Anchor_Block : Anchor_Block_Handle_Type;
               Message      : Queue_Message_Pointer_Type;
               Window       : HWND;
               First        : ULong;
               Last         : ULong) return Boolean;

  ------------------------------------------------

   procedure Dispatch_Message (
               Anchor_Block : in Anchor_Block_Handle_Type;
               Message      : in Queue_Message_Pointer_Type);

  ------------------------------------------------

  type Help_Id_Type is new UShort;

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
                                                return MB_Response_Type;


  ------------------------------------------------

   function Send_Message (
         To_Window   : HWND;
         Message     : Message_Type;
         Parameter_1 : Parameter_Type;
         Parameter_2 : Parameter_Type) return Void_Type;

  ------------------------------------------------

   function Post_Message (
         To_Window   : HWND;
         Message     : Message_Type;
         Parameter_1 : Parameter_Type;
         Parameter_2 : Parameter_Type) return Boolean;

  ------------------------------------------------

   function Get_PS (Window : HWND) return PS_Type;

   procedure Release_Ps (Ps_Handle : in out Ps_Type);

  ------------------------------------------------

 private

  type OS2_Menu_Item_Type;
  type Internal_Menu_Item_Type is access OS2_Menu_Item_Type;
  Null_Internal_Menu : constant Internal_Menu_Item_Type := null;
  ------------------------------------------
   type Bitmap_Handle_Type is new ULong;
   Null_Bitmap : constant Bitmap_Handle_Type := 0;
end Win;
