
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PMsc                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               PM    Static Control                                บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMsc is
pragma Preelaborate (PMsc);
--
--     Static Control Manager
--
--     Static control styles:
--
--   NOTE: the top 9 bits of the LOWORD of the window flStyle are used for
--   DT_flags.  The lower 7 bits are for SS_styles.  This gives us up
--   to 128 distinct static control types ( we currently use 11 of them).
--
 SS_TEXT           :constant Ulong:=16#0001#;
 SS_GROUPBOX       :constant Ulong:=16#0002#;
 SS_ICON           :constant Ulong:=16#0003#;
 SS_BITMAP         :constant Ulong:=16#0004#;
 SS_FGNDRECT       :constant Ulong:=16#0005#;
 -- INCL_SAADEFS
 SS_HALFTONERECT   :constant Ulong:=16#0006#;
 SS_BKGNDRECT      :constant Ulong:=16#0007#;
 SS_FGNDFRAME      :constant Ulong:=16#0008#;
 SS_HALFTONEFRAME  :constant Ulong:=16#0009#;
 SS_BKGNDFRAME     :constant Ulong:=16#000a#;
 SS_SYSICON        :constant Ulong:=16#000b#;
 SS_AUTOSIZE       :constant Ulong:=16#0040#;

--    Static control messages

 SM_SETHANDLE      :constant Ulong:=16#0100#;
 SM_QUERYHANDLE    :constant Ulong:=16#0101#;

--     Button Controls Subsection
--     Button control styles

 BS_PUSHBUTTON       :constant Ulong:=      0 ;
 BS_CHECKBOX         :constant Ulong:=      1 ;
 BS_AUTOCHECKBOX     :constant Ulong:=      2 ;
 BS_RADIOBUTTON      :constant Ulong:=      3 ;
 BS_AUTORADIOBUTTON  :constant Ulong:=      4 ;
 BS_3STATE           :constant Ulong:=      5 ;
 BS_AUTO3STATE       :constant Ulong:=      6 ;
 BS_USERBUTTON       :constant Ulong:=      7 ;
 BS_PRIMARYSTYLES    :constant Ulong:=16#000f#;
 BS_BITMAP           :constant Ulong:=16#0040#;
 BS_ICON             :constant Ulong:=16#0080#;
 BS_HELP             :constant Ulong:=16#0100#;
 BS_SYSCOMMAND       :constant Ulong:=16#0200#;
 BS_DEFAULT          :constant Ulong:=16#0400#;
 BS_NOPOINTERFOCUS   :constant Ulong:=16#0800#;
 BS_NOBORDER         :constant Ulong:=16#1000#;
 BS_NOCURSORSELECT   :constant Ulong:=16#2000#;
 BS_AUTOSIZE         :constant Ulong:=16#4000#;

--    Binary resources may be bound into application executables or
--    passed as a parameter when creating a window or dialog
--    Currently they must be the same for both 16-bit and 32-bit
--    so we pack the structures.

type BTNCDATA    is record   -- btncd
  cb               :USHORT  ;
  fsCheckState     :USHORT  ;
  fsHiliteState    :USHORT  ;
  hImage           :LHANDLE ;
end record; -- BTNCDATA;
type PBTNCDATA  is access all BTNCDATA;

--     User button structure ( passed in WM_CONTROL msg)

type USERBUTTON    is record    -- ubtn
    hwn            :HWND    ;
    hp             :HPS     ;
    fsState        :ULONG   ;
    fsStateOld     :ULONG   ;
end record; -- USERBUTTON;
type PUSERBUTTON  is access all USERBUTTON;

--     Button control messages
--
 BM_CLICK                   :constant Ulong:=16#0120#;
 BM_QUERYCHECKINDEX         :constant Ulong:=16#0121#;
 BM_QUERYHILITE             :constant Ulong:=16#0122#;
 BM_SETHILITE               :constant Ulong:=16#0123#;
 BM_QUERYCHECK              :constant Ulong:=16#0124#;
 BM_SETCHECK                :constant Ulong:=16#0125#;
 BM_SETDEFAULT              :constant Ulong:=16#0126#;
--
--     Button notification codes
--
 BN_CLICKED      :constant Ulong:=  1 ;
 BN_DBLCLICKED   :constant Ulong:=  2 ;
 BN_PAINT        :constant Ulong:=  3 ;
--
--     BN_PAINT button draw state codes ( must be in high byte)
--
 BDS_HILITED    :constant Ulong:=16#0100#;
 BDS_DISABLED   :constant Ulong:=16#0200#;
 BDS_DEFAULT    :constant Ulong:=16#0400#;

--     Entryfield controls Subsection
--
--     Entry field  styles
--
 ES_LEFT        :constant Ulong:=16#00000000#;
 ES_CENTER      :constant Ulong:=16#00000001#;
 ES_RIGHT       :constant Ulong:=16#00000002#;
 ES_AUTOSCROLL  :constant Ulong:=16#00000004#;
 ES_MARGIN      :constant Ulong:=16#00000008#;
 ES_AUTOTAB     :constant Ulong:=16#00000010#;
 ES_READONLY    :constant Ulong:=16#00000020#;
 ES_COMMAND     :constant Ulong:=16#00000040#;
 ES_UNREADABLE  :constant Ulong:=16#00000080#;
 ES_AUTOSIZE    :constant Ulong:=16#00000200#;
 ES_ANY         :constant Ulong:=16#00000000#;
 ES_SBCS        :constant Ulong:=16#00001000#;
 ES_DBCS        :constant Ulong:=16#00002000#;
 ES_MIXED       :constant Ulong:=16#00003000#;

--     combo box styles
--
 CBS_SIMPLE        :constant Ulong:=16#0001#;
 CBS_DROPDOWN      :constant Ulong:=16#0002#;
 CBS_DROPDOWNLIST  :constant Ulong:=16#0004#;
--
--    Use this bit for drop down combo boxes that do not want to
--    receive a CBN_ENTER on a single click in their list boxes.
--    This is for compatibility with releases prior to OS/2 2.0 which
--    did not send this message
--
 CBS_COMPATIBLE   :constant Ulong:=16#0008#;

--   The following edit and listbox styles may be used in conjunction
--   with CBS_ styles
--   ES_AUTOTAB ES_ANY ES_SBCS ES_DBCS ES_MIXED LS_HORZSCROL#;

--    IDs of combobox entry field and listbox.
--
 CBID_LIST         :constant Ulong:=16#029A#;
 CBID_EDIT         :constant Ulong:=16#029B#;
 CBM_SHOWLIST      :constant Ulong:=16#0170#;
 CBM_HILITE        :constant Ulong:=16#0171#;
 CBM_ISLISTSHOWING :constant Ulong:=16#0172#;

 CBN_EFCHANGE  :constant Ulong:=   1 ;
 CBN_EFSCROLL  :constant Ulong:=   2 ;
 CBN_MEMERROR  :constant Ulong:=   3 ;
 CBN_LBSELECT  :constant Ulong:=   4 ;
 CBN_LBSCROLL  :constant Ulong:=   5 ;
 CBN_SHOWLIST  :constant Ulong:=   6 ;
 CBN_ENTER     :constant Ulong:=   7 ;

--       Binary resources may be bound into application executables or
--       passed as a parameter when creating a window or dialog
--       Currently they must be the same for both 16-bit and 32-bit
--       so we pack the structures.

type ENTRYFDATA  is record     -- efd
      cb             :USHORT  ;
      cchEditLimit   :USHORT  ;
      ichMinSel      :USHORT  ;
      ichMaxSel      :USHORT  ;
end record; -- ENTRYFDATA;
type PENTRYFDATA  is access all ENTRYFDATA;

--     Entry Field  messages

 EM_QUERYCHANGED            :constant Ulong:=16#0140#;
 EM_QUERYSEL                :constant Ulong:=16#0141#;
 EM_SETSEL                  :constant Ulong:=16#0142#;
 EM_SETTEXTLIMIT            :constant Ulong:=16#0143#;
 EM_CUT                     :constant Ulong:=16#0144#;
 EM_COPY                    :constant Ulong:=16#0145#;
 EM_CLEAR                   :constant Ulong:=16#0146#;
 EM_PASTE                   :constant Ulong:=16#0147#;
 EM_QUERYFIRSTCHAR          :constant Ulong:=16#0148#;
 EM_SETFIRSTCHAR            :constant Ulong:=16#0149#;
 EM_QUERYREADONLY           :constant Ulong:=16#014a#;
 EM_SETREADONLY             :constant Ulong:=16#014b#;
 EM_SETINSERTMODE           :constant Ulong:=16#014c#;

--     Entry Field notification messages

 EN_SETFOCUS                :constant Ulong:=16#0001#;
 EN_KILLFOCUS               :constant Ulong:=16#0002#;
 EN_CHANGE                  :constant Ulong:=16#0004#;
 EN_SCROLL                  :constant Ulong:=16#0008#;
 EN_MEMERROR                :constant Ulong:=16#0010#;
 EN_OVERFLOW                :constant Ulong:=16#0020#;
 EN_INSERTMODETOGGLE        :constant Ulong:=16#0040#;

--  Multiple Line Entrys
--      MLE Window styles ( in addition to WS_* )

 MLS_WORDWRAP               :constant Ulong:=16#00000001#;
 MLS_BORDER                 :constant Ulong:=16#00000002#;
 MLS_VSCROLL                :constant Ulong:=16#00000004#;
 MLS_HSCROLL                :constant Ulong:=16#00000008#;
 MLS_READONLY               :constant Ulong:=16#00000010#;
 MLS_IGNORETAB              :constant Ulong:=16#00000020#;
 MLS_DISABLEUNDO            :constant Ulong:=16#00000040#;

--     MLE External Data Types

subtype IPT  is LONG   ;       -- insertion point
subtype PIPT is PLONG  ;       -- insertion point
subtype PIX  is LONG   ;       -- pixel
subtype LINE is ULONG  ;       -- Line number

type  FORMATRECT  is record    -- MLEFRD
   cxFormat   :LONG ;           -- format rectangle width
   cyFormat   :LONG ;           -- format rectangle height
end record; -- MLEFORMATRECT;
type PMLEFORMATRECT  is access all FORMATRECT;

type  MLECTLDATA  is record    -- MLECTL
  cbCtlData       :USHORT   ;  -- Length of the MLECTLDATA structure
  afIEFormat      :USHORT   ;  -- import/export format
  cchText         :ULONG    ;  -- text limit
  iptAnchor       :IPT      ;  -- beginning of selection
  iptCursor       :IPT      ;  -- ending of selection
  cxFormat        :LONG     ;  -- format rectangle width
  cyFormat        :LONG     ;  -- format rectangle height
  afFormatFlags   :ULONG    ;  -- formatting rectangle flags
end record; -- MLECTLDATA;
type PMLECTLDATA  is access all MLECTLDATA;

--     afFormatFlags mask

 MLFFMTRECT_LIMITHORZ       :constant Ulong:=16#00000001#;
 MLFFMTRECT_LIMITVERT       :constant Ulong:=16#00000002#;
 MLFFMTRECT_MATCHWINDOW     :constant Ulong:=16#00000004#;
 MLFFMTRECT_FORMATRECT      :constant Ulong:=16#00000007#;

--     afIEFormat - Import/Export Format flags

 MLFIE_CFTEXT         :constant Ulong:=      0 ;
 MLFIE_NOTRANS        :constant Ulong:=      1 ;
 MLFIE_WINFMT         :constant Ulong:=      2 ;
 MLFIE_RTF            :constant Ulong:=      3 ;

--     MLN_OVERFLOW structure

type  MLEOVERFLOW  is record    -- overflow
    afErrInd      :ULONG;     -- see mask below
   nBytesOver     :LONG ;     -- number of bytes overflowed
   pixHorzOver    :LONG ;     -- number of pixels horizontally overflow
   pixVertOver    :LONG ;     -- number of pixels vertically overflowed
end record; --  MLEOVERFLOW;
type PMLEOVERFLOW  is access all MLEOVERFLOW;

--     afErrInd - error format rectangle flags

 MLFEFR_RESIZE              :constant Ulong:=16#00000001#;
 MLFEFR_TABSTOP             :constant Ulong:=16#00000002#;
 MLFEFR_FONT                :constant Ulong:=16#00000004#;
 MLFEFR_TEXT                :constant Ulong:=16#00000008#;
 MLFEFR_WORDWRAP            :constant Ulong:=16#00000010#;
 MLFETL_TEXTBYTES           :constant Ulong:=16#00000020#;

--     MLN_MARGIN structure

type  MLEMARGSTRUCT  is record      -- margin
  afMargins   :USHORT ;      -- margin indicator
  usMouMsg    :USHORT ;      -- mouse message
  iptNear     :IPT    ;      -- the geometrically nearest insertion point
end record; -- MLEMARGSTRUCT;
type PMLEMARGSTRUCT  is access all MLEMARGSTRUCT;

--     afFlags - margin notification indicators

 MLFMARGIN_LEFT             :constant Ulong:=16#0001#;
 MLFMARGIN_BOTTOM           :constant Ulong:=16#0002#;
 MLFMARGIN_RIGHT            :constant Ulong:=16#0003#;
 MLFMARGIN_TOP              :constant Ulong:=16#0004#;
--
--     MLM_QUERYSELECTION flags

 MLFQS_MINMAXSEL   :constant Ulong:= 0 ;
 MLFQS_MINSEL      :constant Ulong:= 1 ;
 MLFQS_MAXSEL      :constant Ulong:= 2 ;
 MLFQS_ANCHORSEL   :constant Ulong:= 3 ;
 MLFQS_CURSORSEL   :constant Ulong:= 4 ;
--
--     MLN_CLPBDFAIL flags
--
 MLFCLPBD_TOOMUCHTEXT       :constant Ulong:=16#00000001#;
 MLFCLPBD_ERROR             :constant Ulong:=16#00000002#;

--     MLM_SEARCH structure

type  SEARCH    is record   -- search
   cb           :USHORT ;    -- size of search spec structure
   pchFind      :PCHAR  ;    -- string to search for
   pchReplace   :PCHAR  ;    -- string to replace with
   cchFind      :SHORT  ;    -- length of pchFindString
   cchReplace   :SHORT  ;    -- length of replace string
   iptStart     :IPT    ;    -- point at which to start search
                             -- (negative indicates cursor pt)
                             -- becomes pt where string found
   iptStop      :IPT    ;    -- point at which to stop search
                             -- (negative indicates EOT)
   cchFound     :USHORT ;    -- Length of found string at iptStart
end record; -- SEARCH;
type PSEARCH  is access all SEARCH;

--     MLM_SEARCH style flags

 MLFSEARCH_CASESENSITIVE    :constant Ulong:=16#00000001#;
 MLFSEARCH_SELECTMATCH      :constant Ulong:=16#00000002#;
 MLFSEARCH_CHANGEALL        :constant Ulong:=16#00000004#;

--     MLE messages - MLM from :constant Ulong:=16#01b0 to :constant Ulong:=16#01de; MLN from :constant Ulong:=16#0001 to :constant Ulong:=16#000f
--
--        formatting messages
 MLM_SETTEXTLIMIT           :constant Ulong:=16#01b0#;
 MLM_QUERYTEXTLIMIT         :constant Ulong:=16#01b1#;
 MLM_SETFORMATRECT          :constant Ulong:=16#01b2#;
 MLM_QUERYFORMATRECT        :constant Ulong:=16#01b3#;
 MLM_SETWRAP                :constant Ulong:=16#01b4#;
 MLM_QUERYWRAP              :constant Ulong:=16#01b5#;
 MLM_SETTABSTOP             :constant Ulong:=16#01b6#;
 MLM_QUERYTABSTOP           :constant Ulong:=16#01b7#;
 MLM_SETREADONLY            :constant Ulong:=16#01b8#;
 MLM_QUERYREADONLY          :constant Ulong:=16#01b9#;

--     -- text content manipulation and queries messages
 MLM_QUERYCHANGED           :constant Ulong:=16#01ba#;
 MLM_SETCHANGED             :constant Ulong:=16#01bb#;
 MLM_QUERYLINECOUNT         :constant Ulong:=16#01bc#;
 MLM_CHARFROMLINE           :constant Ulong:=16#01bd#;
 MLM_LINEFROMCHAR           :constant Ulong:=16#01be#;
 MLM_QUERYLINELENGTH        :constant Ulong:=16#01bf#;
 MLM_QUERYTEXTLENGTH        :constant Ulong:=16#01c0#;
--
--        text import and export messages
 MLM_FORMAT                 :constant Ulong:=16#01c1#;
 MLM_SETIMPORTEXPORT        :constant Ulong:=16#01c2#;
 MLM_IMPORT                 :constant Ulong:=16#01c3#;
 MLM_EXPORT                 :constant Ulong:=16#01c4#;
 MLM_DELETE                 :constant Ulong:=16#01c6#;
 MLM_QUERYFORMATLINELENGTH  :constant Ulong:=16#01c7#;
 MLM_QUERYFORMATTEXTLENGTH  :constant Ulong:=16#01c8#;
 MLM_INSERT                 :constant Ulong:=16#01c9#;
--
--        selection messages
 MLM_SETSEL         :constant Ulong:=16#01ca#;
 MLM_QUERYSEL       :constant Ulong:=16#01cb#;
 MLM_QUERYSELTEXT   :constant Ulong:=16#01cc#;

--        undo and redo messages
 MLM_QUERYUNDO              :constant Ulong:=16#01cd#;
 MLM_UNDO                   :constant Ulong:=16#01ce#;
 MLM_RESETUNDO              :constant Ulong:=16#01cf#;
--
--        text attributes messages
 MLM_QUERYFONT              :constant Ulong:=16#01d0#;
 MLM_SETFONT                :constant Ulong:=16#01d1#;
 MLM_SETTEXTCOLOR           :constant Ulong:=16#01d2#;
 MLM_QUERYTEXTCOLOR         :constant Ulong:=16#01d3#;
 MLM_SETBACKCOLOR           :constant Ulong:=16#01d4#;
 MLM_QUERYBACKCOLOR         :constant Ulong:=16#01d5#;

--        scrolling messages
 MLM_QUERYFIRSTCHAR         :constant Ulong:=16#01d6#;
 MLM_SETFIRSTCHAR           :constant Ulong:=16#01d7#;
--
--        clipboard messages
 MLM_CUT                    :constant Ulong:=16#01d8#;
 MLM_COPY                   :constant Ulong:=16#01d9#;
 MLM_PASTE                  :constant Ulong:=16#01da#;
 MLM_CLEAR                  :constant Ulong:=16#01db#;
--
--        display manipulation messages
 MLM_ENABLEREFRESH          :constant Ulong:=16#01dc#;
 MLM_DISABLEREFRESH         :constant Ulong:=16#01dd#;

--        search message
 MLM_SEARCH                 :constant Ulong:=16#01de#;
 MLM_QUERYIMPORTEXPORT      :constant Ulong:=16#01df#;
--
--        notification messages
 MLN_OVERFLOW               :constant Ulong:=16#0001#;
 MLN_PIXHORZOVERFLOW        :constant Ulong:=16#0002#;
 MLN_PIXVERTOVERFLOW        :constant Ulong:=16#0003#;
 MLN_TEXTOVERFLOW           :constant Ulong:=16#0004#;
 MLN_VSCROLL                :constant Ulong:=16#0005#;
 MLN_HSCROLL                :constant Ulong:=16#0006#;
 MLN_CHANGE                 :constant Ulong:=16#0007#;
 MLN_SETFOCUS               :constant Ulong:=16#0008#;
 MLN_KILLFOCUS              :constant Ulong:=16#0009#;
 MLN_MARGIN                 :constant Ulong:=16#000a#;
 MLN_SEARCHPAUSE            :constant Ulong:=16#000b#;
 MLN_MEMERROR               :constant Ulong:=16#000c#;
 MLN_UNDOOVERFLOW           :constant Ulong:=16#000d#;
 MLN_CLPBDFAIL              :constant Ulong:=16#000f#;

--     Listboxes
--
--        List box styles
--
 LS_MULTIPLESEL             :constant Ulong:=16#00000001#;
 LS_OWNERDRAW               :constant Ulong:=16#00000002#;
 LS_NOADJUSTPOS             :constant Ulong:=16#00000004#;
 LS_HORZSCROLL              :constant Ulong:=16#00000008#;
 LS_EXTENDEDSEL             :constant Ulong:=16#00000010#;

--      List box notification messages

 LN_SELECT               :constant Ulong:=   1 ;
 LN_SETFOCUS             :constant Ulong:=   2 ;
 LN_KILLFOCUS            :constant Ulong:=   3 ;
 LN_SCROLL               :constant Ulong:=   4 ;
 LN_ENTER                :constant Ulong:=   5 ;

--        List box messages

 LM_QUERYITEMCOUNT          :constant Ulong:=16#0160#;
 LM_INSERTITEM              :constant Ulong:=16#0161#;
 LM_SETTOPINDEX             :constant Ulong:=16#0162#;
 LM_DELETEITEM              :constant Ulong:=16#0163#;
 LM_SELECTITEM              :constant Ulong:=16#0164#;
 LM_QUERYSELECTION          :constant Ulong:=16#0165#;
 LM_SETITEMTEXT             :constant Ulong:=16#0166#;
 LM_QUERYITEMTEXTLENGTH     :constant Ulong:=16#0167#;
 LM_QUERYITEMTEXT           :constant Ulong:=16#0168#;
 LM_SETITEMHANDLE           :constant Ulong:=16#0169#;
 LM_QUERYITEMHANDLE         :constant Ulong:=16#016a#;
 LM_SEARCHSTRING            :constant Ulong:=16#016b#;
 LM_SETITEMHEIGHT           :constant Ulong:=16#016c#;
 LM_QUERYTOPINDEX           :constant Ulong:=16#016d#;
 LM_DELETEALL               :constant Ulong:=16#016e#;

--        List box constants
--
--     #define LIT_CURSOR                 ( -4)
--     #define LIT_ERROR                  ( -3)
--     #define LIT_MEMERROR               ( -2)
--     #define LIT_NONE                   ( -1)
--     #define LIT_FIRST                  ( -1)
--
--     -- For LM_INSERTITEM msg
--
--     #define LIT_END                    ( -1)
--     #define LIT_SORTASCENDING          ( -2)
--     #define LIT_SORTDESCENDING         ( -3)
--
--     -- For LM_SEARCHSTRING msg
--
 LSS_SUBSTRING              :constant Ulong:=16#0001#;
 LSS_PREFIX                 :constant Ulong:=16#0002#;
 LSS_CASESENSITIVE          :constant Ulong:=16#0004#;

--        Useful macros
--
--     LONG/SHORT WinDeleteLboxItem(:HWND hwn Lbox;:LONG/SHORT index)
--        deletes item index from the listbox.
--        returns the number of items left.
--
--     #define WinDeleteLboxItem( hwn Lbox; index) \
--     ( (:LONG)WinSendMsg( hwn Lbox; LM_DELETEITEM; MPFROMLONG( index)return \
--     ( MPARAM)NULL))
--
--     LONG/SHORT WinInsertLboxItem(:HWND hwn Lbox;:LONG/SHORT index; PSZ psz)
--        inserts psz into a listbox at index.  Index may be an LIT_ constant.
--        returns the actual index where it was inserted.
--
--     #define WinInsertLboxItem( hwn Lbox; index; psz) \
--     ( (:LONG)WinSendMsg( hwn Lbox; LM_INSERTITEM; MPFROMLONG( index)return \
--     MPFROMP( psz)))
--
--
--     LONG/SHORT WinQueryLboxCount(:HWND hwn Lbox)
--        returns the number of items in the listbox.
--
--     *************************************************************************--
--     #define WinQueryLboxCount( hwn Lbox) \
--     ( (:LONG)WinSendMsg( hwn Lbox; LM_QUERYITEMCOUNT; ( MPARAM)NULL; \
--     ( MPARAM)NULL))
--
--     LONG/SHORT WinQueryLboxItemText(:HWND hwn Lbox;:LONG/SHORT index; PSZ psz;:SHORT cchMax)
--        fills psz with the text if item index.
--        returns the text length copied.
--
--     #define WinQueryLboxItemText( hwn Lbox; index; psz; cchMax) \
--     ( (:LONG)WinSendMsg( hwn Lbox; LM_QUERYITEMTEXT; \
--     MPFROM2SHORT( ( index)return ( cchMax))return MPFROMP( psz)))
--
--     LONG/SHORT WinQueryLboxItemTextLength(:HWND hwn Lbox;:LONG/SHORT index)
--        returns the length of item index.
--
--
--     #define WinQueryLboxItemTextLength( hwn Lbox; index)         \
--     ( (:SHORT)WinSendMsg( hwn Lbox; LM_QUERYITEMTEXTLENGTH;    \
--     MPFROMSHORT( index)return ( MPARAM)NULL))
--
--     BOOL32 WinSetLboxItemText(:HWND hwn Lbox;:LONG/SHORT index; PSZ psz)
--        sets the text of item index to psz.
--        returns fSuccess.
--
--     #define WinSetLboxItemText( hwn Lbox; index; psz) \
--     ( ( BOOL)WinSendMsg( hwn Lbox; LM_SETITEMTEXT; \
--     MPFROMLONG( index)return MPFROMP( psz)))
--
--     LONG/SHORT WinQueryLboxSelectedItem(:HWND hwn Lbox)
--        returns the item index selected. ( for single selection only)
--
--     #define WinQueryLboxSelectedItem( hwn Lbox) \
--     ( (:LONG)WinSendMsg( hwn Lbox; LM_QUERYSELECTION; MPFROMLONG( LIT_FIRST)return \
--     ( MPARAM)NULL))

--     --**--Menu Manager Subsection
--     -- Menu control styles
--
 MS_ACTIONBAR           :constant Ulong:=16#00000001#;
 MS_TITLEBUTTON         :constant Ulong:=16#00000002#;
 MS_VERTICALFLIP        :constant Ulong:=16#00000004#;
 MS_CONDITIONALCASCADE  :constant Ulong:=16#00000040#;

function WinLoadMenu(hwndFrame:HWND    ;
                     hmod     :HMODULE ;
                     idMenu   :ULONG   )return HWND;
pragma Import(c,WinLoadMenu, Link_name=>"_WinLoadMenu");

--      Menu control messages
--
 MM_INSERTITEM              :constant Ulong:=16#0180#;
 MM_DELETEITEM              :constant Ulong:=16#0181#;
 MM_QUERYITEM               :constant Ulong:=16#0182#;
 MM_SETITEM                 :constant Ulong:=16#0183#;
 MM_QUERYITEMCOUNT          :constant Ulong:=16#0184#;
 MM_STARTMENUMODE           :constant Ulong:=16#0185#;
 MM_ENDMENUMODE             :constant Ulong:=16#0186#;
 MM_REMOVEITEM              :constant Ulong:=16#0188#;
 MM_SELECTITEM              :constant Ulong:=16#0189#;
 MM_QUERYSELITEMID          :constant Ulong:=16#018a#;
 MM_QUERYITEMTEXT           :constant Ulong:=16#018b#;
 MM_QUERYITEMTEXTLENGTH     :constant Ulong:=16#018c#;
 MM_SETITEMHANDLE           :constant Ulong:=16#018d#;
 MM_SETITEMTEXT             :constant Ulong:=16#018e#;
 MM_ITEMPOSITIONFROMID      :constant Ulong:=16#018f#;
 MM_ITEMIDFROMPOSITION      :constant Ulong:=16#0190#;
 MM_QUERYITEMATTR           :constant Ulong:=16#0191#;
 MM_SETITEMATTR             :constant Ulong:=16#0192#;
 MM_ISITEMVALID             :constant Ulong:=16#0193#;
 MM_QUERYITEMRECT           :constant Ulong:=16#0194#;
 MM_QUERYDEFAULTITEMID      :constant Ulong:=16#0431#;
 MM_SETDEFAULTITEMID        :constant Ulong:=16#0432#;
--     #define MTI_INCLUDED

type mti    is record   -- mti
     afStyle     :USHORT ;      -- Style Flags
     pad         :USHORT ;      -- pad for template
     idItem      :USHORT ;      -- Item ID
     c           :CHAR   ;      -- [2];
     c2          :CHAR   ;
end record; -- MTI;

type mt     is record   -- mt
    len          :ULONG  ;     -- Length of template in bytes
    codepage     :USHORT ;     -- Codepage
    reserved     :USHORT ;     -- Reserved.
    cMti         :USHORT ;     -- Count of template items.
    rgMti        :MTI    ;     --   [1]; Array of template items.
end record; -- MT;
type LPMT is access all  MT ;

function WinCreateMenu(hwndParent:HWND  ;
                       lpm       :PVOID )return HWND;
pragma Import(c,WinCreateMenu, Link_name=>"_WinCreateMenu");

--     Owner Item Structure ( Also used for listboxes)

type OWNERITEM    is record  -- oi
    hwn           :HWND    ;
    hp            :HPS     ;
    fsState       :ULONG   ;
    fsAttribute   :ULONG   ;
    fsStateOld    :ULONG   ;
    fsAttributeOld:ULONG   ;
    rclItem       :RECTL   ;
    idItem        :LONG    ; -- This field contains idItem for menus; iItem for lb.
    hItem         :ULONG   ;
end record; -- OWNERITEM;
type POWNERITEM  is access all OWNERITEM;

--      Menu item
--
--      Binary resources may be bound into application executables or
--      passed as a parameter when creating a window or dialog
--      Currently they must be the same for both 16-bit and 32-bit
--      so we pack the structures.

    type MENUITEM is record     -- mi
   iPosition     :SHORT   ;
   afStyle       :USHORT  ;
   afAttribute   :USHORT  ;
   id            :USHORT  ;
   hwndSubMenu   :HWND    ;
   hItem         :ULONG   ;
end record; -- MENUITEM;
type PMENUITEM  is access all MENUITEM;

--     #define MIT_END                    ( -1)
--     #define MIT_NONE                   ( -1)
--     #define MIT_MEMERROR               ( -1)
--     #define MIT_ERROR                  ( -1)
--     #define MIT_FIRST                  ( -2)
--     #define MIT_LAST                   ( -3)
--     #define MID_NONE                   MIT_NONE
--     #define MID_ERROR                  ( -1)
--
--     Menu item styles & attributes
--
 MIS_TEXT                   :constant Ulong:=16#0001#;
 MIS_BITMAP                 :constant Ulong:=16#0002#;
 MIS_SEPARATOR              :constant Ulong:=16#0004#;
 MIS_OWNERDRAW              :constant Ulong:=16#0008#;
 MIS_SUBMENU                :constant Ulong:=16#0010#;
 MIS_MULTMENU               :constant Ulong:=16#0020#;    -- multiple choice submenu
 MIS_SYSCOMMAND             :constant Ulong:=16#0040#;
 MIS_HELP                   :constant Ulong:=16#0080#;
 MIS_STATIC                 :constant Ulong:=16#0100#;
 MIS_BUTTONSEPARATOR        :constant Ulong:=16#0200#;
 MIS_BREAK                  :constant Ulong:=16#0400#;
 MIS_BREAKSEPARATOR         :constant Ulong:=16#0800#;
 MIS_GROUP                  :constant Ulong:=16#1000#;    -- multiple choice group start
--        In multiple choice submenus a style of 'single' denotes the item is a
--        radiobutton.  Absence of this style defaults the item to a checkbox.
 MIS_SINGLE                 :constant Ulong:=16#2000#;

 MIA_NODISMISS              :constant Ulong:=16#0020#;
 MIA_FRAMED                 :constant Ulong:=16#1000#;
 MIA_CHECKED                :constant Ulong:=16#2000#;
 MIA_DISABLED               :constant Ulong:=16#4000#;
 MIA_HILITED                :constant Ulong:=16#8000#;

function WinPopupMenu(hwndParent:HWND ;
                      hwndOwner :HWND ;
                      hwndMenu  :HWND ;
                      x         :LONG ;
                      y         :LONG ;
                      idItem    :LONG ;
                      fs        :ULONG)return  BOOL32;
pragma Import(c,WinPopupMenu, Link_name=>"_WinPopupMenu");

--     Values of fs in WinPopupMenu call
--
--     #define PU_POSITIONONITEM          :constant Ulong:=16#0001 -- Need idItem parameter
--     #define PU_HCONSTRAIN              :constant Ulong:=16#0002 -- Keep menu on left and right edge
--     #define PU_VCONSTRAIN              :constant Ulong:=16#0004 -- Keep menu on top and bottom edge
--     #define PU_NONE                    :constant Ulong:=16#0000 -- If invoked by keyboard
--     #define PU_MOUSEBUTTON1DOWN        :constant Ulong:=16#0008 -- If invoked by button 1
--     #define PU_MOUSEBUTTON2DOWN        :constant Ulong:=16#0010 -- If invoked by button 2
--     #define PU_MOUSEBUTTON3DOWN        :constant Ulong:=16#0018 -- If invoked by button 3
--     #define PU_SELECTITEM              :constant Ulong:=16#0020 -- Set selected item ( use with kbd)
--     #define PU_MOUSEBUTTON1            :constant Ulong:=16#0040 -- If button1 use allowed
--     #define PU_MOUSEBUTTON2            :constant Ulong:=16#0080 -- If button2 use allowed
--     #define PU_MOUSEBUTTON3            :constant Ulong:=16#0100 -- If button3 use allowed
--     #define PU_KEYBOARD                :constant Ulong:=16#0200 -- If keyboard use allowed
--
--     -- Useful macros
--
--     BOOL32 WinCheckMenuItem(:HWND hwn Menu;:ULONG/USHORT id; BOOL32 fcheck)
--        Sets the check state of menuitem #id to fcheck.
--        returns fSuccess.
--
--     #define WinCheckMenuItem( hwn Menu; id; fcheck) \
--     ( ( BOOL)WinSendMsg( hwn Menu; MM_SETITEMATTR; \
--     MPFROM2SHORT( id; TRUE)return \
--     MPFROM2SHORT( MIA_CHECKED; (:USHORT)( fcheck) ? MIA_CHECKED : 0)))
--
--     BOOL32 WinIsMenuItemChecked(:HWND hwn Menu;:USHORT/ULONG id)
--        returns the check state of menuitem #id.
--
--     #define WinIsMenuItemChecked( hwn Menu; id) \
--     ( ( BOOL)WinSendMsg( hwn Menu; MM_QUERYITEMATTR; \
--     MPFROM2SHORT( id; TRUE)return \
--     MPFROMLONG( MIA_CHECKED)))
--
--     BOOL32 WinEnableMenuItem(:HWND hwn Menu;:ULONG/USHORT id; BOOL32 fenable)
--        sets the enable state of menuitem #id to fenable.
--        returns fSuccess.
--
--     #define WinEnableMenuItem( hwn Menu; id; fEnable) \
--     ( ( BOOL)WinSendMsg( hwn Menu; MM_SETITEMATTR; \
--     MPFROM2SHORT( id; TRUE)return \
--     MPFROM2SHORT( MIA_DISABLED; (:USHORT)( fEnable) ? 0 : MIA_DISABLED)))
--
--     BOOL32 WinIsMenuItemEnabled(:HWND hwn Menu;:USHORT/ULONG id)
--        returns the enable state of menuitem #id.
--
--     #define WinIsMenuItemEnabled( hwn Menu; id)  \
--     ( !( BOOL)WinSendMsg( hwn Menu; MM_QUERYITEMATTR; \
--     MPFROM2SHORT( id; TRUE)return \
--     MPFROMLONG( MIA_DISABLED)))
--
--     BOOL32 WinSetMenuItemText(:HWND hwn Menu;:ULONG/USHORT id; PSZ psz)
--        sets the text of menuitem #id.
--        returns fSuccess.
--
--     #define WinSetMenuItemText( hwn Menu; id; psz) \
--     ( ( BOOL)WinSendMsg( hwn Menu; MM_SETITEMTEXT; \
--     MPFROMLONG( id)return MPFROMP( psz)))
--
--     BOOL32 WinIsMenuItemValid(:HWND hwn Menu;:ULONG/USHORT id)
--        Returns TRUE if the specified item is a valid choice.
--
--     #define WinIsMenuItemValid( hwn Menu; id) \
--     ( ( BOOL)WinSendMsg( hwn Menu; MM_ISITEMVALID; \
--     MPFROM2SHORT( id; TRUE)return MPFROMLONG( FALSE)))

--     Scroll Bar controls Subsection
--
--      Scroll Bar styles
--
--     #define SBS_HORZ                   0#;
--     #define SBS_VERT                   1#;
--     #define SBS_THUMBSIZE              2#;
--     #define SBS_AUTOTRACK              4#;
--     #define SBS_AUTOSIZE               :constant Ulong:=16#2000#;
--
--     -- Scroll Bar messages
--
--     #define SBM_SETSCROLLBAR           :constant Ulong:=16#01a0
--     #define SBM_SETPOS                 :constant Ulong:=16#01a1
--     #define SBM_QUERYPOS               :constant Ulong:=16#01a2
--     #define SBM_QUERYRANGE             :constant Ulong:=16#01a3
--     #define SBM_SETTHUMBSIZE           :constant Ulong:=16#01a6
--
--     -- Scroll Bar Commands
--
--     #define SB_LINEUP                  1
--     #define SB_LINEDOWN                2
--     #define SB_LINELEFT                1
--     #define SB_LINERIGHT               2
--     #define SB_PAGEUP                  3
--     #define SB_PAGEDOWN                4
--     #define SB_PAGELEFT                3
--     #define SB_PAGERIGHT               4
--     #define SB_SLIDERTRACK             5
--     #define SB_SLIDERPOSITION          6
--     #define SB_ENDSCROL#;      7

--         Binary resources may be bound into application executables or
--         passed as a parameter when creating a window or dialog
--         Currently they must be the same for both 16-bit and 32-bit
--         so we pack the structures.

type SBCDATA  is record    -- sbcd
     cb         :USHORT  ;
     sHilite    :USHORT :=0 ;   -- reserved; should be set to zero
     posFirst   :SHORT   ;
     posLast    :SHORT   ;
     posThumb   :SHORT   ;
     cVisible   :SHORT   ;
     cTotal     :SHORT   ;
end record; -- SBCDATA;
type PSBCDATA  is access all SBCDATA;

--     Frame Manager Common subsection
--
--      Binary resources may be bound into application executables or
--      passed as a parameter when creating a window or dialog
--      Currently they must be the same for both 16-bit and 32-bit
--      so we pack the structures.

type FRAMECDATA  is record    -- fcdata
    cb              :USHORT  ;
    flCreateFlags   :ULONG   ;
    hmodResources   :USHORT  ;
    idResources     :USHORT  ;
end record; -- FRAMECDATA;
type PFRAMECDATA  is access all FRAMECDATA;

--      Frame window styles
--      All unused FCF_xxx bits are reserved

 FCF_TITLEBAR       :constant ULONG:=16#00000001#;
 FCF_SYSMENU        :constant ULONG:=16#00000002#;
 FCF_MENU           :constant ULONG:=16#00000004#;
 FCF_SIZEBORDER     :constant ULONG:=16#00000008#;
 FCF_MINBUTTON      :constant ULONG:=16#00000010#;
 FCF_MAXBUTTON      :constant ULONG:=16#00000020#;
 FCF_MINMAX         :constant ULONG:=16#00000030#; -- minmax means BOTH buttons
 FCF_VERTSCROLL     :constant ULONG:=16#00000040#;
 FCF_HORZSCROLL     :constant ULONG:=16#00000080#;
 FCF_DLGBORDER      :constant ULONG:=16#00000100#;
 FCF_BORDER         :constant ULONG:=16#00000200#;
 FCF_SHELLPOSITION  :constant ULONG:=16#00000400#;
 FCF_TASKLIST       :constant ULONG:=16#00000800#;
 FCF_NOBYTEALIGN    :constant ULONG:=16#00001000#;
 FCF_NOMOVEWITHOWNER:constant ULONG:=16#00002000#;
 FCF_ICON           :constant ULONG:=16#00004000#;
 FCF_ACCELTABLE     :constant ULONG:=16#00008000#;
 FCF_SYSMODAL       :constant ULONG:=16#00010000#;
 FCF_SCREENALIGN    :constant ULONG:=16#00020000#;
 FCF_MOUSEALIGN     :constant ULONG:=16#00040000#;
 FCF_HIDEBUTTON     :constant ULONG:=16#01000000#;
 FCF_HIDEMAX        :constant ULONG:=16#01000020#; -- hidemax means BOTH buttons
 FCF_DBE_APPSTAT    :constant ULONG:=16#80000000#;
 FCF_AUTOICON       :constant ULONG:=16#40000000#;
 FCF_STANDARD       :constant ULONG:=16#0000CC3F#;
--
--     -- FCF_TITLEBAR | FCF_SYSMENU | FCF_MENU | FCF_SIZEBORDER | FCF_MINMAX |
--     FCF_ICON | FCF_ACCELTABLE | FCF_SHELLPOSITION | FCF_TASKLIST
--
 FS_ICON                    :constant Ulong:=16#00000001#;
 FS_ACCELTABLE              :constant Ulong:=16#00000002#;
 FS_SHELLPOSITION           :constant Ulong:=16#00000004#;
 FS_TASKLIST                :constant Ulong:=16#00000008#;
 FS_NOBYTEALIGN             :constant Ulong:=16#00000010#;
 FS_NOMOVEWITHOWNER         :constant Ulong:=16#00000020#;
 FS_SYSMODAL                :constant Ulong:=16#00000040#;
 FS_DLGBORDER               :constant Ulong:=16#00000080#;
 FS_BORDER                  :constant Ulong:=16#00000100#;
 FS_SCREENALIGN             :constant Ulong:=16#00000200#;
 FS_MOUSEALIGN              :constant Ulong:=16#00000400#;
 FS_SIZEBORDER              :constant Ulong:=16#00000800#;
 FS_AUTOICON                :constant Ulong:=16#00001000#;
 FS_DBE_APPSTAT             :constant Ulong:=16#00008000#;
 FS_STANDARD                :constant Ulong:=16#0000000F#;
--
--     -- FS_ICON | FS_ACCELTABLE | FS_SHELLPOSITION | FS_TASKLIST
--
--     -- Frame Window Flags accessed via WinSet/QueryWindowUShort( QWS_FLAGS)
--
 FF_FLASHWINDOW             :constant Ulong:=16#0001#;
 FF_ACTIVE                  :constant Ulong:=16#0002#;
 FF_FLASHHILITE             :constant Ulong:=16#0004#;
 FF_OWNERHIDDEN             :constant Ulong:=16#0008#;
 FF_DLGDISMISSED            :constant Ulong:=16#0010#;
 FF_OWNERDISABLED           :constant Ulong:=16#0020#;
 FF_SELECTED                :constant Ulong:=16#0040#;
 FF_NOACTIVATESWP           :constant Ulong:=16#0080#;

function WinCreateStdWindow(hwndParent    :HWND    ;
                            flStyle       :ULONG   ;
                            pflCreateFlags:PULONG  ;
                            pszClientClass:PSZ     ;
                            pszTitle      :PSz     ;
                            styleClient   :ULONG   ;
                            hmod          :HMODULE ;
                            idResources   :ULONG   ;
                            phwndClient   :PHWND   )return HWND ;
pragma Import(c,WinCreateStdWindow, Link_name=>"_WinCreateStdWindow");

function WinFlashWindow(hwndFrame:HWND   ;
                        fFlash   :BOOL32 )return BOOL32 ;
pragma Import(c,WinFlashWindow, Link_name=>"_WinFlashWindow");

--     Frame window related messages
--
 WM_FLASHWINDOW             :constant Ulong:=16#0040#;
 WM_FORMATFRAME             :constant Ulong:=16#0041#;
 WM_UPDATEFRAME             :constant Ulong:=16#0042#;
 WM_FOCUSCHANGE             :constant Ulong:=16#0043#;
 WM_SETBORDERSIZE           :constant Ulong:=16#0044#;
 WM_TRACKFRAME              :constant Ulong:=16#0045#;
 WM_MINMAXFRAME             :constant Ulong:=16#0046#;
 WM_SETICON                 :constant Ulong:=16#0047#;
 WM_QUERYICON               :constant Ulong:=16#0048#;
 WM_SETACCELTABLE           :constant Ulong:=16#0049#;
 WM_QUERYACCELTABLE         :constant Ulong:=16#004a#;
 WM_TRANSLATEACCEL          :constant Ulong:=16#004b#;
 WM_QUERYTRACKINFO          :constant Ulong:=16#004c#;
 WM_QUERYBORDERSIZE         :constant Ulong:=16#004d#;
 WM_NEXTMENU                :constant Ulong:=16#004e#;
 WM_ERASEBACKGROUND         :constant Ulong:=16#004f#;
 WM_QUERYFRAMEINFO          :constant Ulong:=16#0050#;
 WM_QUERYFOCUSCHAIN         :constant Ulong:=16#0051#;
 WM_OWNERPOSCHANGE          :constant Ulong:=16#0052#;
 WM_CALCFRAMERECT           :constant Ulong:=16#0053#;
--     -- Note 16#0054# is reserved
 WM_WINDOWPOSCHANGED        :constant Ulong:=16#0055#;
 WM_ADJUSTFRAMEPOS          :constant Ulong:=16#0056#;
 WM_QUERYFRAMECTLCOUNT      :constant Ulong:=16#0059#;
--        -- Note  16#005A# is reserved
 WM_QUERYHELPINFO        :constant Ulong:=16#005B#;
 WM_SETHELPINFO          :constant Ulong:=16#005C#;
 WM_ERROR                :constant Ulong:=16#005D#;
 WM_REALIZEPALETTE       :constant Ulong:=16#005E#;

--        WM_QUERYFRAMEINFO constants

 FI_FRAME                :constant Ulong:=16#00000001#;
 FI_OWNERHIDE            :constant Ulong:=16#00000002#;
 FI_ACTIVATEOK           :constant Ulong:=16#00000004#;
 FI_NOMOVEWITHOWNER      :constant Ulong:=16#00000008#;

function WinCreateFrameControls(hwndFrame:HWND        ;
                                pfcdata  :PFRAMECDATA ;
                                pszTitle :PSZ         )return BOOL32 ;
pragma Import(c,WinCreateFrameControls, Link_name=>"_WinCreateFrameControls");

function WinCalcFrameRect(hwndFrame:HWND   ;
                          prcl     :PRECTL ;
                          fClient  :BOOL32 )return BOOL32 ;
pragma Import(c,WinCalcFrameRect, Link_name=>"_WinCalcFrameRect");

function WinGetMinPosition(hwn :HWND    ;
                           psw :PSWP    ;
                           pptl:PPOINTL )return BOOL32 ;
pragma Import(c,WinGetMinPosition, Link_name=>"_WinGetMinPosition");

function WinGetMaxPosition(hwn :HWND ;
                           psw :PSWP )return BOOL32 ;
pragma Import(c,WinGetMaxPosition, Link_name=>"_WinGetMaxPosition");

subtype  HSAVEWP is LHANDLE ;      -- hsvwp

function WinSaveWindowPos(hsvwp:HSAVEWP ;
                          psw  :PSWP    ;
                          cswp :ULONG   )return BOOL32;
pragma Import(c,WinSaveWindowPos, Link_name=>"_WinSaveWindowPos");

--     -- Frame control IDs
--
 FID_SYSMENU                :constant Ulong:=16#8002#;
 FID_TITLEBAR               :constant Ulong:=16#8003#;
 FID_MINMAX                 :constant Ulong:=16#8004#;
 FID_MENU                   :constant Ulong:=16#8005#;
 FID_VERTSCROLL             :constant Ulong:=16#8006#;
 FID_HORZSCROLL             :constant Ulong:=16#8007#;
 FID_CLIENT                 :constant Ulong:=16#8008#;
--     -- Note :constant Ulong:=16#8009 is reserved
 FID_DBE_APPSTAT            :constant Ulong:=16#8010#;
 FID_DBE_KBDSTAT            :constant Ulong:=16#8011#;
 FID_DBE_PECIC              :constant Ulong:=16#8012#;
 FID_DBE_KKPOPUP            :constant Ulong:=16#8013#;
--
--     -- Standard WM_SYSCOMMAND command values
--
 SC_SIZE                    :constant Ulong:=16#8000#;
 SC_MOVE                    :constant Ulong:=16#8001#;
 SC_MINIMIZE                :constant Ulong:=16#8002#;
 SC_MAXIMIZE                :constant Ulong:=16#8003#;
 SC_CLOSE                   :constant Ulong:=16#8004#;
 SC_NEXT                    :constant Ulong:=16#8005#;
 SC_APPMENU                 :constant Ulong:=16#8006#;
 SC_SYSMENU                 :constant Ulong:=16#8007#;
 SC_RESTORE                 :constant Ulong:=16#8008#;
 SC_NEXTFRAME               :constant Ulong:=16#8009#;
 SC_NEXTWINDOW              :constant Ulong:=16#8010#;
 SC_TASKMANAGER             :constant Ulong:=16#8011#;
 SC_HELPKEYS                :constant Ulong:=16#8012#;
 SC_HELPINDEX               :constant Ulong:=16#8013#;
 SC_HELPEXTENDED            :constant Ulong:=16#8014#;
 SC_SWITCHPANELIDS          :constant Ulong:=16#8015#;
 SC_DBE_FIRST               :constant Ulong:=16#8018#;
 SC_DBE_LAST                :constant Ulong:=16#801F#;
 SC_BEGINDRAG               :constant Ulong:=16#8020#;
 SC_ENDDRAG                 :constant Ulong:=16#8021#;
 SC_SELECT                  :constant Ulong:=16#8022#;
 SC_OPEN                    :constant Ulong:=16#8023#;
 SC_CONTEXTMENU             :constant Ulong:=16#8024#;
 SC_CONTEXTHELP             :constant Ulong:=16#8025#;
 SC_TEXTEDIT                :constant Ulong:=16#8026#;
 SC_BEGINSELECT             :constant Ulong:=16#8027#;
 SC_ENDSELECT               :constant Ulong:=16#8028#;
 SC_WINDOW                  :constant Ulong:=16#8029#;
 SC_HIDE                    :constant Ulong:=16#802a#;
--
--       Frame controls
--
--     ----Title bar controls
--     -- Title bar control messages
--
--     #define TBM_SETHILITE              :constant Ulong:=16#01e3
--     #define TBM_QUERYHILITE            :constant Ulong:=16#01e4

--     Rectangle routines

function WinCopyRect(ha     :HAB    ;
                     prclDst:PRECTL ;
                     prclSrc:PRECTL )return BOOL32;
pragma Import(c,WinCopyRect, Link_name=>"_WinCopyRect");

function WinSetRect(ha     :HAB    ;
                    prcl   :PRECTL ;
                    xLeft  :LONG   ;
                    yBottom:LONG   ;
                    xRight :LONG   ;
                    yTop   :LONG   )return BOOL32;
pragma Import(c,WinSetRect, Link_name=>"_WinSetRect");

function WinIsRectEmpty(ha  :HAB    ;
                        prcl:PRECTL )return BOOL32;
pragma Import(c,WinIsRectEmpty, Link_name=>"_WinIsRectEmpty");

function WinEqualRect(ha   :HAB    ;
                      prcl1:PRECTL ;
                      prcl2:PRECTL )return BOOL32;
pragma Import(c,WinEqualRect, Link_name=>"_WinEqualRect");

function WinSetRectEmpty(ha  :HAB    ;
                         prcl:PRECTL )return BOOL32;
pragma Import(c,WinSetRectEmpty, Link_name=>"_WinSetRectEmpty");

function WinOffsetRect(ha  :HAB    ;
                       prcl:PRECTL ;
                       cx  :LONG   ;
                       cy  :LONG   )return BOOL32;
pragma Import(c,WinOffsetRect, Link_name=>"_WinOffsetRect");

function WinInflateRect(ha  :HAB    ;
                        prcl:PRECTL ;
                        cx  :LONG   ;
                        cy  :LONG   )return BOOL32;
pragma Import(c,WinInflateRect, Link_name=>"_WinInflateRect");

function WinPtInRect(ha  :HAB     ;
                     prcl:PRECTL  ;
                     pptl:PPOINTL )return BOOL32;
pragma Import(c,WinPtInRect, Link_name=>"_WinPtInRect");

function WinIntersectRect(ha      :HAB    ;
                          prclDst :PRECTL ;
                          prclSrc1:PRECTL ;
                          prclSrc2:PRECTL )return BOOL32;
pragma Import(c,WinIntersectRect, Link_name=>"_WinIntersectRect");

function WinUnionRect(ha      :HAB    ;
                      prclDst :PRECTL ;
                      prclSrc1:PRECTL ;
                      prclSrc2:PRECTL )return BOOL32;
pragma Import(c,WinUnionRect, Link_name=>"_WinUnionRect");

function WinSubtractRect(ha      :HAB    ;
                         prclDst :PRECTL ;
                         prclSrc1:PRECTL ;
                         prclSrc2:PRECTL )return BOOL32;
pragma Import(c,WinSubtractRect, Link_name=>"_WinSubtractRect");

function WinMakeRect(ha  :HAB    ;
                     pwrc:PRECTL )return BOOL32;
pragma Import(c,WinMakeRect, Link_name=>"_WinMakeRect");

function WinMakePoints(ha  :HAB     ;
                       pwpt:PPOINTL ;
                       cwpt:ULONG   )return BOOL32;
pragma Import(c,WinMakePoints, Link_name=>"_WinMakePoints");

--          System values
--
function WinQuerySysValue(hwndDesktop:HWND ;
                          iSysValue  :LONG )return LONG;
pragma Import(c,WinQuerySysValue, Link_name=>"_WinQuerySysValue");

function WinSetSysValue(hwndDesktop:HWND ;
                        iSysValue  :LONG ;
                        lValue     :LONG )return BOOL32 ;
pragma Import(c,WinSetSysValue, Link_name=>"_WinSetSysValue");

 SV_SWAPBUTTON           :constant Ulong:=    0  ;
 SV_DBLCLKTIME           :constant Ulong:=    1  ;
 SV_CXDBLCLK             :constant Ulong:=    2  ;
 SV_CYDBLCLK             :constant Ulong:=    3  ;
 SV_CXSIZEBORDER         :constant Ulong:=    4  ;
 SV_CYSIZEBORDER         :constant Ulong:=    5  ;
 SV_ALARM                :constant Ulong:=    6  ;
 SV_RESERVEDFIRST1       :constant Ulong:=    7  ;
 SV_RESERVEDLAST1        :constant Ulong:=    8  ;
 SV_CURSORRATE           :constant Ulong:=    9  ;
 SV_FIRSTSCROLLRATE      :constant Ulong:=    10 ;
 SV_SCROLLRATE           :constant Ulong:=    11 ;
 SV_NUMBEREDLISTS        :constant Ulong:=    12 ;
 SV_WARNINGFREQ          :constant Ulong:=    13 ;
 SV_NOTEFREQ             :constant Ulong:=    14 ;
 SV_ERRORFREQ            :constant Ulong:=    15 ;
 SV_WARNINGDURATION      :constant Ulong:=    16 ;
 SV_NOTEDURATION         :constant Ulong:=    17 ;
 SV_ERRORDURATION        :constant Ulong:=    18 ;
 SV_RESERVEDFIRST        :constant Ulong:=    19 ;
 SV_RESERVEDLAST         :constant Ulong:=    19 ;
 SV_CXSCREEN             :constant Ulong:=    20 ;
 SV_CYSCREEN             :constant Ulong:=    21 ;
 SV_CXVSCROLL            :constant Ulong:=    22 ;
 SV_CYHSCROLL            :constant Ulong:=    23 ;
 SV_CYVSCROLLARROW       :constant Ulong:=    24 ;
 SV_CXHSCROLLARROW       :constant Ulong:=    25 ;
 SV_CXBORDER             :constant Ulong:=    26 ;
 SV_CYBORDER             :constant Ulong:=    27 ;
 SV_CXDLGFRAME           :constant Ulong:=    28 ;
 SV_CYDLGFRAME           :constant Ulong:=    29 ;
 SV_CYTITLEBAR           :constant Ulong:=    30 ;
 SV_CYVSLIDER            :constant Ulong:=    31 ;
 SV_CXHSLIDER            :constant Ulong:=    32 ;
 SV_CXMINMAXBUTTON       :constant Ulong:=    33 ;
 SV_CYMINMAXBUTTON       :constant Ulong:=    34 ;
 SV_CYMENU               :constant Ulong:=    35 ;
 SV_CXFULLSCREEN         :constant Ulong:=    36 ;
 SV_CYFULLSCREEN         :constant Ulong:=    37 ;
 SV_CXICON               :constant Ulong:=    38 ;
 SV_CYICON               :constant Ulong:=    39 ;
 SV_CXPOINTER            :constant Ulong:=    40 ;
 SV_CYPOINTER            :constant Ulong:=    41 ;
 SV_DEBUG                :constant Ulong:=    42 ;
 SV_CMOUSEBUTTONS        :constant Ulong:=    43 ;
 SV_CPOINTERBUTTONS      :constant Ulong:=    43 ;
 SV_POINTERLEVEL         :constant Ulong:=    44 ;
 SV_CURSORLEVEL          :constant Ulong:=    45 ;
 SV_TRACKRECTLEVEL       :constant Ulong:=    46 ;
 SV_CTIMERS              :constant Ulong:=    47 ;
 SV_MOUSEPRESENT         :constant Ulong:=    48 ;
 SV_CXBYTEALIGN          :constant Ulong:=    49 ;
 SV_CXALIGN              :constant Ulong:=    49 ;
 SV_CYBYTEALIGN          :constant Ulong:=    50 ;
 SV_CYALIGN              :constant Ulong:=    50 ;

--   The following value enables any greater value to be set by WinSetSysVlaue.
--   Values of 51-55 are spare for extra non-settable system values
--   This is to enable the setting of SV_EXTRAKEYBEEP by applications.
--
 SV_NOTRESERVED         :constant Ulong:=     56 ;
 SV_EXTRAKEYBEEP        :constant Ulong:=     57 ;

--   The following system value controls whether PM controls the keyboard
--   lights for light key keystrokes ( else applications will)

 SV_SETLIGHTS           :constant Ulong:=     58 ;
 SV_INSERTMODE          :constant Ulong:=     59 ;
 SV_MENUROLLDOWNDELAY   :constant Ulong:=     64 ;
 SV_MENUROLLUPDELAY     :constant Ulong:=     65 ;
 SV_ALTMNEMONIC         :constant Ulong:=     66 ;
 SV_TASKLISTMOUSEACCESS :constant Ulong:=     67 ;
 SV_CXICONTEXTWIDTH     :constant Ulong:=     68 ;
 SV_CICONTEXTLINES      :constant Ulong:=     69 ;
 SV_CHORDTIME           :constant Ulong:=     70 ;
 SV_CXCHORD             :constant Ulong:=     71 ;
 SV_CYCHORD             :constant Ulong:=     72 ;
 SV_CXMOTIONSTART       :constant Ulong:=     73 ;
 SV_CYMOTIONSTART       :constant Ulong:=     74 ;
 SV_BEGINDRAG           :constant Ulong:=     75 ;
 SV_ENDDRAG             :constant Ulong:=     76 ;
 SV_SINGLESELECT        :constant Ulong:=     77 ;
 SV_OPEN                :constant Ulong:=     78 ;
 SV_CONTEXTMENU         :constant Ulong:=     79 ;
 SV_CONTEXTHELP         :constant Ulong:=     80 ;
 SV_TEXTEDIT            :constant Ulong:=     81 ;
 SV_BEGINSELECT         :constant Ulong:=     82 ;
 SV_ENDSELECT           :constant Ulong:=     83 ;
 SV_BEGINDRAGKB         :constant Ulong:=     84 ;
 SV_ENDDRAGKB           :constant Ulong:=     85 ;
 SV_SELECTKB            :constant Ulong:=     86 ;
 SV_OPENKB              :constant Ulong:=     87 ;
 SV_CONTEXTMENUKB       :constant Ulong:=     88 ;
 SV_CONTEXTHELPKB       :constant Ulong:=     89 ;
 SV_TEXTEDITKB          :constant Ulong:=     90 ;
 SV_BEGINSELECTKB       :constant Ulong:=     91 ;
 SV_ENDSELECTKB         :constant Ulong:=     92 ;
 SV_ANIMATION           :constant Ulong:=     93 ;
 SV_ANIMATIONSPEED      :constant Ulong:=     94 ;
 SV_MONOICONS           :constant Ulong:=     95 ;
 SV_KBDALTERED          :constant Ulong:=     96 ;
 SV_PRINTSCREEN         :constant Ulong:=     97 ;
 SV_CSYSVALUES          :constant Ulong:=     98 ;

--     Presentation parameter structures.

type PARAM  is record    -- param
   id  :ULONG  ;
   cb  :ULONG  ;
   ab  :BYTE   ;    --[1];
end record; -- PARAM;
type PPARAM  is access all PARAM;
type NPPARAM  is access all PARAM;

type PRESPARAMS  is record    -- pres
   cb      :ULONG ;
   aparam  :PARAM ;     -- [1];
end record; -- PRESPARAMS;
type PPRESPARAMS  is access all PRESPARAMS;
type NPPRESPARAMS  is access all PRESPARAMS;

--     --Presentation parameter APIs

 function WinSetPresParam(hwn    :HWND  ;
                          id     :ULONG ;
                          cbParam:ULONG ;
                          pbParam:PVOID )return BOOL32 ;
pragma Import(c,WinSetPresParam, Link_name=>"_WinSetPresParam");

function WinQueryPresParam(hwn  :HWND   ;
                           id1  :ULONG  ;
                           id2  :ULONG  ;
                           pulId:PULONG ;
                           cbBuf:ULONG  ;
                           pbBuf:PVOID  ;
                           fs   :ULONG  )return ULONG;
pragma Import(c,WinQueryPresParam, Link_name=>"_WinQueryPresParam");

function WinRemovePresParam(hwn :HWND  ;
                            id  :ULONG )return BOOL32 ;
pragma Import(c,WinRemovePresParam, Link_name=>"_WinRemovePresParam");

--     Presentation parameter types.

 PP_FOREGROUNDCOLOR                      :constant Ulong:=16#1#;
 PP_FOREGROUNDCOLORINDEX                 :constant Ulong:=16#2#;
 PP_BACKGROUNDCOLOR                      :constant Ulong:=16#3#;
 PP_BACKGROUNDCOLORINDEX                 :constant Ulong:=16#4#;
 PP_HILITEFOREGROUNDCOLOR                :constant Ulong:=16#5#;
 PP_HILITEFOREGROUNDCOLORINDEX           :constant Ulong:=16#6#;
 PP_HILITEBACKGROUNDCOLOR                :constant Ulong:=16#7#;
 PP_HILITEBACKGROUNDCOLORINDEX           :constant Ulong:=16#8#;
 PP_DISABLEDFOREGROUNDCOLOR              :constant Ulong:=16#9#;
 PP_DISABLEDFOREGROUNDCOLORINDEX         :constant Ulong:=16#10#;
 PP_DISABLEDBACKGROUNDCOLOR              :constant Ulong:=16#11#;
 PP_DISABLEDBACKGROUNDCOLORINDEX         :constant Ulong:=16#12#;
 PP_BORDERCOLOR                          :constant Ulong:=16#13#;
 PP_BORDERCOLORINDEX                     :constant Ulong:=16#14#;
 PP_FONTNAMESIZE                         :constant Ulong:=16#15#;
 PP_FONTHANDLE                           :constant Ulong:=16#16#;
 PP_RESERVED                             :constant Ulong:=16#17#;
 PP_ACTIVECOLOR                          :constant Ulong:=16#18#;
 PP_ACTIVECOLORINDEX                     :constant Ulong:=16#19#;
 PP_INACTIVECOLOR                        :constant Ulong:=16#20#;
 PP_INACTIVECOLORINDEX                   :constant Ulong:=16#21#;
 PP_ACTIVETEXTFGNDCOLOR                  :constant Ulong:=16#22#;
 PP_ACTIVETEXTFGNDCOLORINDEX             :constant Ulong:=16#23#;
 PP_ACTIVETEXTBGNDCOLOR                  :constant Ulong:=16#24#;
 PP_ACTIVETEXTBGNDCOLORINDEX             :constant Ulong:=16#25#;
 PP_INACTIVETEXTFGNDCOLOR                :constant Ulong:=16#26#;
 PP_INACTIVETEXTFGNDCOLORINDEX           :constant Ulong:=16#27#;
 PP_INACTIVETEXTBGNDCOLOR                :constant Ulong:=16#28#;
 PP_INACTIVETEXTBGNDCOLORINDEX           :constant Ulong:=16#29#;
 PP_SHADOW                               :constant Ulong:=16#30#;
 PP_MENUFOREGROUNDCOLOR                  :constant Ulong:=16#31#;
 PP_MENUFOREGROUNDCOLORINDEX             :constant Ulong:=16#32#;
 PP_MENUBACKGROUNDCOLOR                  :constant Ulong:=16#33#;
 PP_MENUBACKGROUNDCOLORINDEX             :constant Ulong:=16#34#;
 PP_MENUHILITEFGNDCOLOR                  :constant Ulong:=16#35#;
 PP_MENUHILITEFGNDCOLORINDEX             :constant Ulong:=16#36#;
 PP_MENUHILITEBGNDCOLOR                  :constant Ulong:=16#37#;
 PP_MENUHILITEBGNDCOLORINDEX             :constant Ulong:=16#38#;
 PP_MENUDISABLEDFGNDCOLOR                :constant Ulong:=16#39#;
 PP_MENUDISABLEDFGNDCOLORINDEX           :constant Ulong:=16#40#;
 PP_MENUDISABLEDBGNDCOLOR                :constant Ulong:=16#41#;
 PP_MENUDISABLEDBGNDCOLORINDEX           :constant Ulong:=16#42#;
 PP_USER                                 :constant Ulong:=16#8000#;

--     Flags for WinQueryPresParams( )

 QPF_NOINHERIT        :constant Ulong:=16#0001#; -- Don't inherit
 QPF_ID1COLORINDEX    :constant Ulong:=16#0002#; -- Convert id1 color index into RGB
 QPF_ID2COLORINDEX    :constant Ulong:=16#0004#; -- Convert id2 color index into RGB
 QPF_PURERGBCOLOR     :constant Ulong:=16#0008#; -- Return pure RGB colors
 QPF_VALIDFLAGS       :constant Ulong:=16#000F#; -- Valid WinQueryPresParams( ) flags.
end Os2.PMsc;
