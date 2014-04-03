
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PMcb                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               PM  WinTrackRect( ) information                     บ
-- บ               PM  Clipboard Manager                               บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMcb is
pragma Preelaborate (PMcb);
--
--  Extended Attribute Flags ( Association Table)

 EAF_DEFAULTOWNER  :constant Long:=         16#0001#;
 EAF_UNCHANGEABLE  :constant Long:=         16#0002#;
 EAF_REUSEICON     :constant Long:=         16#0004#;

--  WinTrackRect( ) information
--  WinTrackRect( ) tracking information structure

type TRACKINFO  is record    -- ti
   cxBorder          :LONG    ;
   cyBorder          :LONG    ;
   cxGrid            :LONG    ;
   cyGrid            :LONG    ;
   cxKeyboard        :LONG    ;
   cyKeyboard        :LONG    ;
   rclTrack          :RECTL   ;
   rclBoundary       :RECTL   ;
   ptlMinTrackSize   :POINTL  ;
   ptlMaxTrackSize   :POINTL  ;
   fs                :ULONG   ;
end record; -- TRACKINFO;
type PTRACKINFO  is access all TRACKINFO;

function WinTrackRect(hwn:HWND       ;
                      hp :HPS        ;
                      pti:PTRACKINFO )return BOOL32;
pragma Import(c,WinTrackRect, Link_name=>"_WinTrackRect");

function WinShowTrackRect(hwn  :HWND   ;
                          fShow:BOOL32 )return BOOL32;
pragma Import(c,WinShowTrackRect, Link_name=>"_WinShowTrackRect");

--        WinTrackRect( ) flags

 TF_LEFT       :constant Long:=             16#0001#;
 TF_TOP        :constant Long:=             16#0002#;
 TF_RIGHT      :constant Long:=             16#0004#;
 TF_BOTTOM     :constant Long:=             16#0008#;
-- TF_MOVE  TF_LEFT or TF_TOP or TF_RIGHT or TF_BOTTOM ;
 TF_MOVE       :constant Long:=             16#000F#;
 TF_SETPOINTERPOS  :constant Long:=         16#0010#;
 TF_GRID           :constant Long:=         16#0020#;
 TF_STANDARD       :constant Long:=         16#0040#;
 TF_ALLINBOUNDARY     :constant Long:=      16#0080#;
 TF_VALIDATETRACKRECT :constant Long:=      16#0100#;
 TF_PARTINBOUNDARY    :constant Long:=      16#0200#;

--  Clipboard Manager
--  Clipboard messages

 WM_RENDERFMT         :constant Long:=      16#0060#;
 WM_RENDERALLFMTS     :constant Long:=      16#0061#;
 WM_DESTROYCLIPBOARD  :constant Long:=      16#0062#;
 WM_PAINTCLIPBOARD    :constant Long:=      16#0063#;
 WM_SIZECLIPBOARD     :constant Long:=      16#0064#;
 WM_HSCROLLCLIPBOARD  :constant Long:=      16#0065#;
 WM_VSCROLLCLIPBOARD  :constant Long:=      16#0066#;
 WM_DRAWCLIPBOARD     :constant Long:=      16#0067#;

--        --Standard Clipboard formats

 CF_TEXT              :constant Long:=      1;
 CF_BITMAP            :constant Long:=      2;
 CF_DSPTEXT           :constant Long:=      3;
 CF_DSPBITMAP         :constant Long:=      4;
 CF_METAFILE          :constant Long:=      5;
 CF_DSPMETAFILE       :constant Long:=      6;
 CF_PALETTE           :constant Long:=      9;
 CF_MMPMFIRST         :constant Long:=     10;
 CF_MMPMLAST          :constant Long:=     19;
--
--        --standard DDE and clipboard format stings
--
--        #define SZFMT_TEXT                   "#1"
--        #define SZFMT_BITMAP                 "#2"
--        #define SZFMT_DSPTEXT                "#3"
--        #define SZFMT_DSPBITMAP              "#4"
--        #define SZFMT_METAFILE               "#5"
--        #define SZFMT_DSPMETAFILE            "#6"
--        #define SZFMT_PALETTE                "#9"
--        #define SZFMT_SYLK                   "Sylk"
--        #define SZFMT_DIF                    "Dif"
--        #define SZFMT_TIFF                   "Tiff"
--        #define SZFMT_OEMTEXT                "OemText"
--        #define SZFMT_DIB                    "Dib"
--        #define SZFMT_OWNERDISPLAY           "OwnerDisplay"
--        #define SZFMT_LINK                   "Link"
--        #define SZFMT_METAFILEPICT           "MetaFilePict"
--        #define SZFMT_DSPMETAFILEPICT        "DspMetaFilePict"
--        #define SZFMT_CPTEXT                 "Codepage Text"
--        #define SZDDEFMT_RTF                 "Rich Text Format"
--        #define SZDDEFMT_PTRPICT             "Printer_Picture"

--     Metafiles are the same no matter whether they are used in
--     16-bit or 32-bit applications. While not strictly necessary
--     because of inherent alignment we force packing on a 2 byte
--     boundary to avoid any confusion.

type MFP  is record    -- mfp
  sizeBounds     :POINTL ;  -- metafile notional grid size
  sizeMM         :POINTL ;  -- metafile size high metric units
  cbLength       :ULONG  ;  -- length of metafile data
  mapMode        :USHORT ;  -- a PM metaflie map mode
  reserved       :USHORT ;
  abData         :BYTE   ;  --  [1];   -- metafile Data
end record; -- MFP;
type PMFP  is access all MFP;

--   CPTEXT DDE data are the same no matter whether they are used
--   in 16-bit or 32-bit applications. While not strictly necessary
--   because of inherent alignment we force packing on a 2 byte
--   boundary to avoid any confusion.

type CPTEXT  is record    -- cptxt
      idCountry      :USHORT ;
      usCodepage     :USHORT ;
      usLangID       :USHORT ;
      usSubLangID    :USHORT ;
      abText         :BYTE   ;  --[1];   -- text string starts here
end record; -- CPTEXT;
type PCPTEXT  is access all CPTEXT;

function WinSetClipbrdOwner(ha  :HAB  ;
                            hwn :HWND )return BOOL32  ;
pragma Import(c,WinSetClipbrdOwner, Link_name=>"_WinSetClipbrdOwner");

function WinSetClipbrdData(ha        :HAB   ;
                           ulData    :ULONG ;
                           fmt       :ULONG ;
                           rgfFmtInfo:ULONG )return BOOL32  ;
pragma Import(c,WinSetClipbrdData, Link_name=>"_WinSetClipbrdData");

function WinQueryClipbrdData(ha :HAB   ;
                             fmt:ULONG )return ULONG ;
pragma Import(c,WinQueryClipbrdData, Link_name=>"_WinQueryClipbrdData");

function WinQueryClipbrdFmtInfo(ha         :HAB    ;
                                fmt        :ULONG  ;
                                prgfFmtInfo:PULONG )return BOOL32  ;
pragma Import(c,WinQueryClipbrdFmtInfo, Link_name=>"_WinQueryClipbrdFmtInfo");

function WinSetClipbrdViewer(ha               :HAB  ;
                             hwndNewClipViewer:HWND )return BOOL32  ;
pragma Import(c,WinSetClipbrdViewer, Link_name=>"_WinSetClipbrdViewer");

--        WinSetClipbrdData( ) flags
--
--        #define CFI_OWNERFREE              16#0001
--        #define CFI_OWNERDISPLAY           16#0002
--        #define CFI_POINTER                16#0400
--        #define CFI_HANDLE                 16#0200

function WinEnumClipbrdFmts(ha :HAB   ;
                            fmt:ULONG )return ULONG;
pragma Import(c,WinEnumClipbrdFmts, Link_name=>"_WinEnumClipbrdFmts");

function WinEmptyClipbrd(ha:HAB)return BOOL32  ;
pragma Import(c,WinEmptyClipbrd, Link_name=>"_WinEmptyClipbrd");

function WinOpenClipbrd(ha:HAB)return BOOL32  ;
pragma Import(c,WinOpenClipbrd, Link_name=>"_WinOpenClipbrd");

function WinCloseClipbrd(ha:HAB)return BOOL32  ;
pragma Import(c,WinCloseClipbrd, Link_name=>"_WinCloseClipbrd");

function WinQueryClipbrdOwner(ha:HAB)return HWND  ;
pragma Import(c,WinQueryClipbrdOwner, Link_name=>"_WinQueryClipbrdOwner");

function WinQueryClipbrdViewer(ha:HAB)return HWND  ;
pragma Import(c,WinQueryClipbrdViewer, Link_name=>"_WinQueryClipbrdViewer");
end os2.pmcb ;
