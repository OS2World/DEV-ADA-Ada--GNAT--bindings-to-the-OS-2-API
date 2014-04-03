
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     OS2.VIO                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               Vio     support    of os/2 api functions            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Vio  is
pragma Preelaborate (Vio);

subtype HVIO is USHORT    ;
type   PHVIO is access all HVIO;

function VioRegister (pszModName:PSZ; pszEntryName: PSZ ;
                     flFun1: ULONG ;
                     flFun2: ULONG ) return apiret16;
pragma Import(c,VioRegister, Link_name=>"_VioRegister");

function VioGlobalReg(pszModName:PSZ; pszEntryName: PSZ ;
                     flFun1: ULONG ;flFun2: ULONG ;
                     usReturn:USHORT ) return apiret16;
pragma Import(c,VioGlobalReg, Link_name=>"_VioGlobalReg");

--   first parameter registration constants

 VR_VIOGETCURPOS            :constant ulong:=16#00000001#;
 VR_VIOGETCURTYPE           :constant ulong:=16#00000002#;
 VR_VIOGETMODE              :constant ulong:=16#00000004#;
 VR_VIOGETBUF               :constant ulong:=16#00000008#;
 VR_VIOGETPHYSBUF           :constant ulong:=16#00000010#;
 VR_VIOSETCURPOS            :constant ulong:=16#00000020#;
 VR_VIOSETCURTYPE           :constant ulong:=16#00000040#;
 VR_VIOSETMODE              :constant ulong:=16#00000080#;
 VR_VIOSHOWBUF              :constant ulong:=16#00000100#;
 VR_VIOREADCHARSTR          :constant ulong:=16#00000200#;
 VR_VIOREADCELLSTR          :constant ulong:=16#00000400#;
 VR_VIOWRTNCHAR             :constant ulong:=16#00000800#;
 VR_VIOWRTNATTR             :constant ulong:=16#00001000#;
 VR_VIOWRTNCELL             :constant ulong:=16#00002000#;
 VR_VIOWRTTTY               :constant ulong:=16#00004000#;
 VR_VIOWRTCHARSTR           :constant ulong:=16#00008000#;
 VR_VIOWRTCHARSTRATT        :constant ulong:=16#00010000#;
 VR_VIOWRTCELLSTR           :constant ulong:=16#00020000#;
 VR_VIOSCROLLUP             :constant ulong:=16#00040000#;
 VR_VIOSCROLLDN             :constant ulong:=16#00080000#;
 VR_VIOSCROLLLF             :constant ulong:=16#00100000#;
 VR_VIOSCROLLRT             :constant ulong:=16#00200000#;
 VR_VIOSETANSI              :constant ulong:=16#00400000#;
 VR_VIOGETANSI              :constant ulong:=16#00800000#;
 VR_VIOPRTSC                :constant ulong:=16#01000000#;
 VR_VIOSCRLOCK              :constant ulong:=16#02000000#;
 VR_VIOSCRUNLOCK            :constant ulong:=16#04000000#;
 VR_VIOSAVREDRAWWAIT        :constant ulong:=16#08000000#;
 VR_VIOSAVREDRAWUNDO        :constant ulong:=16#10000000#;
 VR_VIOPOPUP                :constant ulong:=16#20000000#;
 VR_VIOENDPOPUP             :constant ulong:=16#40000000#;
 VR_VIOPRTSCTOGGLE          :constant ulong:=16#80000000#;

--   second parameter registration constants
 VR_VIOMODEWAIT             :constant ulong:=16#00000001#;
 VR_VIOMODEUNDO             :constant ulong:=16#00000002#;
 VR_VIOGETFONT              :constant ulong:=16#00000004#;
 VR_VIOGETCONFIG            :constant ulong:=16#00000008#;
 VR_VIOSETCP                :constant ulong:=16#00000010#;
 VR_VIOGETCP                :constant ulong:=16#00000020#;
 VR_VIOSETFONT              :constant ulong:=16#00000040#;
 VR_VIOGETSTATE             :constant ulong:=16#00000080#;
 VR_VIOSETSTATE             :constant ulong:=16#00000100#;

function  VioDeRegister  return apiret16;
pragma Import(c,VioDeRegister, Link_name=>"_VioDeRegister");

function VioGetBuf (pLVB:PULONG;pcbLVB:PUSHORT;hvi:HVIO)  return apiret16;
pragma Import(c,VioGetBuf, Link_name=>"_VioGetBuf");

function VioGetCurPos (pusRow:PUSHORT ; pusColumn:PUSHORT ;
                       hvi:HVIO )  return apiret16;
pragma Import(c,VioGetCurPos, Link_name=>"_VioGetCurPos");

function  VioSetCurPos (usRow:USHORT ; usColumn:USHORT ;
                        hvi:HVIO )  return apiret16;
pragma Import(c,VioSetCurPos, Link_name=>"_VioSetCurPos");

       -- structure for VioSet/GetCurType() --
type VIOCURSORINFO   is record -- vioci --
     yStart     :USHORT   ;
     cEnd       :USHORT   ;
     cx         :USHORT   ;
     attr       :USHORT   ;
end record;
type PVIOCURSORINFO is access all VIOCURSORINFO;

function VioGetCurType ( CursorInfo:PVIOCURSORINFO;
                         hvi:HVIO)  return apiret16;
pragma Import(c,VioGetCurType, Link_name=>"_VioGetCurType");

function VioSetCurType (CursorInfo:PVIOCURSORINFO;
                        hvi:HVIO ) return apiret16;
pragma Import(c,VioSetCurType, Link_name=>"_VioSetCurType");

--    VIOMODEINFO.color constants
 COLORS_2        :constant ushort:=0001 ;
 COLORS_4        :constant ushort:=0002 ;
 COLORS_16       :constant ushort:=0004 ;
       -- structure for VioSet/GetMode() --

type VIOMODEINFO is record    -- viomi --
     cb                  :USHORT ;
     fbType              :UCHAR  ;
     color               :UCHAR  ;
     col                 :USHORT ;
     row                 :USHORT ;
     hres                :USHORT ;
     vres                :USHORT ;
     fmt_ID              :UCHAR  ;
     attrib              :UCHAR  ;
     buf_addr            :ULONG  ;
     buf_length          :ULONG  ;
     full_length         :ULONG  ;
     partial_length      :ULONG  ;
     ext_data_addr       :PCH    ;
end record;
type PVIOMODEINFO is access all VIOMODEINFO;

 VGMT_OTHER                 :constant ushort:=01;
 VGMT_GRAPHICS              :constant ushort:=02;
 VGMT_DISABLEBURST          :constant ushort:=04;

function VioGetMode ( ModeInfo:PVIOMODEINFO;hvi:HVIO) return apiret16;
pragma Import(c,VioGetMode, Link_name=>"_VioGetMode");

function VioSetMode ( ModeInfo:PVIOMODEINFO;hvi:HVIO ) return apiret16;
pragma Import(c,VioSetMode, Link_name=>"_VioSetMode");

       -- structure for VioGetPhysBuf() --
type VIOPHYSBUF  is record    -- viopb --
          pBuf   :PBYTE    ;
          cb     :ULONG    ;
          asel   :SEL      ;
end record;
type PVIOPHYSBUF is access all VIOPHYSBUF;

function VioGetPhysBuf (PhysBuf:PVIOPHYSBUF ;
                       usReserved:USHORT )  return apiret16;
pragma Import(c,VioGetPhysBuf, Link_name=>"_VioGetPhysBuf");

function VioReadCellStr (pchCellStr:PCH ; cb: USHORT ;
                         usRow:USHORT ;usColumn:USHORT ;
                         hvi:HVIO) return apiret16;
pragma Import(c,VioReadCellStr, Link_name=>"_VioReadCellStr");

function VioReadCharStr ( pchCharStr:PCH ;  cb: USHORT ;
                          usRow:USHORT ;usColumn:USHORT ;
                          hvi:HVIO) return apiret16;
pragma Import(c,VioReadCharStr, Link_name=>"_VioReadCharStr");

function VioWrtCellStr ( pchCellStr:string ;  cb: USHORT ;
                         usRow:USHORT ;usColumn:USHORT ;
                         hvi:HVIO) return apiret16;
pragma Import(c,VioWrtCellStr, Link_name=>"_VioWrtCellStr");

function VioWrtCharStr ( pchCharStr:string ;  cb: USHORT ;
                         usRow:USHORT ;usColumn:USHORT ;
                         hvi:HVIO) return apiret16;
pragma Import(c,VioWrtCharStr, Link_name=>"_VioWrtCharStr");

function VioScrollDn ( usTopRow  :USHORT;
                       usLeftCol :USHORT;
                       usBotRow  :USHORT;
                       usRightCol:USHORT;
                       cbLines   :USHORT;
                       pCell     :PBYTE ;
                       hvi       :HVIO   ) return apiret16;
pragma Import(c,VioScrollDn, Link_name=>"_VioScrollDn");

function  VioScrollUp ( usTopRow  :USHORT;
                        usLeftCol :USHORT;
                        usBotRow  :USHORT;
                        usRightCol:USHORT;
                        cbLines   :USHORT ;
                        pCell     :PBYTE  ;
                        hvi       :HVIO ) return apiret16;
pragma Import(c,VioScrollUp, Link_name=>"_VioScrollUp");

function VioScrollLf (usTopRow  :USHORT ;
                      usLeftCol :USHORT ;
                      usBotRow  :USHORT ;
                      usRightCol:USHORT ;
                      cbCol     :USHORT ;
                      pCell     :PBYTE  ;
                      hvi       :  HVIO )  return apiret16;
pragma Import(c,VioScrollLf, Link_name=>"_VioScrollLf");

function  VioScrollRt (usTopRow  :USHORT ;
                       usLeftCol :USHORT ;
                       usBotRow  :USHORT ;
                       usRightCol:USHORT ;
                       cbCol     :USHORT ;
                       pCell     :PBYTE  ;
                       hvi       :  HVIO )  return apiret16;
pragma Import(c,VioScrollRt, Link_name=>"_VioScrollRt");

function VioWrtNAttr (pAttr   :PBYTE  ;
                      cb      :USHORT ;
                      usRow   :USHORT ;
                      usColumn:USHORT ;
                      hvi     :HVIO    ) return apiret16;
pragma Import(c,VioWrtNAttr, Link_name=>"_VioWrtNAttr");

function  VioWrtNCell (pCell    :PBYTE ;
                        cb      :USHORT;
                        usRow   :USHORT;
                        usColumn:USHORT;
                        hvi     :HVIO  ) return apiret16;
pragma Import(c,VioWrtNCell, Link_name=>"_VioWrtNCell");

function  VioWrtNChar (pChar    :PBYTE ;
                        cb      :USHORT;
                        usRow   :USHORT;
                        usColumn:USHORT;
                        hvi     :HVIO  ) return apiret16;
pragma Import(c,VioWrtNChar, Link_name=>"_VioWrtNChar");

function VioWrtTTY ( pch:string  ;cb :USHORT;hvi :HVIO  ) return apiret16;
pragma Import(c,VioWrtTTY, Link_name=>"_VioWrtTTY");

function  VioWrtCharStrAtt (pch     :string ;
                            cb      :USHORT ;
                            usRow   :USHORT ;
                            usColumn:USHORT ;
                            pAttr   :PBYTE  ;
                            hvi     :HVIO   ) return apiret16;
pragma Import(c,VioWrtCharStrAtt, Link_name=>"_VioWrtCharStrAtt");

 VCC_SBCSCHAR      :constant ushort:= 0 ;
 VCC_DBCSFULLCHAR  :constant ushort:= 1 ;
 VCC_DBCS1STHALF   :constant ushort:= 2 ;
 VCC_DBCS2NDHALF   :constant ushort:= 3 ;

function VioCheckCharType (pType   :PUSHORT ;
                           usRow   :USHORT  ;
                           usColumn:USHORT  ;
                           hvi     :HVIO    ) return apiret16;
pragma Import(c,VioCheckCharType, Link_name=>"_VioCheckCharType");

function VioShowBuf (offLVB:USHORT ;cb:USHORT ;
                     hvi   :HVIO   ) return apiret16;
pragma Import(c,VioShowBuf, Link_name=>"_VioShowBuf");

 ANSI_ON  :constant ushort:=1;
 ANSI_OFF :constant ushort:=0;

function VioSetAnsi (fAnsi:USHORT ; hvi:HVIO )  return apiret16;
pragma Import(c,VioSetAnsi, Link_name=>"_VioSetAnsi");

function VioGetAnsi (fAnsi:USHORT ; hvi:HVIO )  return apiret16;
pragma Import(c,VioGetAnsi, Link_name=>"_VioGetAnsi");

function VioPrtSc (hvi:HVIO) return apiret16;
pragma Import(c,VioPrtSc, Link_name=>"_VioPrtSc");

function VioPrtScToggle (hvi:HVIO) return apiret16;
pragma Import(c,VioPrtScToggle, Link_name=>"_VioPrtScToggle");

 VSRWI_SAVEANDREDRAW    :constant ushort:=0;
 VSRWI_REDRAW           :constant ushort:=1;

 VSRWN_SAVE             :constant ushort:=0;
 VSRWN_REDRAW           :constant ushort:=1;

 UNDOI_GETOWNER         :constant ushort:=0;
 UNDOI_RELEASEOWNER     :constant ushort:=1;

 UNDOK_ERRORCODE        :constant ushort:=0;
 UNDOK_TERMINATE        :constant ushort:=1;

function VioRedrawSize (pcbRedraw:PULONG ) return apiret16;
pragma Import(c,VioRedrawSize, Link_name=>"_VioRedrawSize");

function VioSavRedrawWait (usRedrawInd :USHORT ;
                            pNotifyType:PUSHORT;
                           usReserved  :USHORT  ) return apiret16;
pragma Import(c,VioSavRedrawWait, Link_name=>"_VioSavRedrawWait");

function VioSavRedrawUndo (usOwnerInd:USHORT ;
                           usKillInd :USHORT ;
                           usReserved:USHORT ) return apiret16;
pragma Import(c,VioSavRedrawUndo, Link_name=>"_VioSavRedrawUndo");

 VMWR_POPUP      :constant ushort:=0;
 VMWN_POPUP      :constant ushort:=1;

function VioModeWait (usReqType   :USHORT ;
                       pNotifyType:PUSHORT;
                      usReserved  :USHORT ) return apiret16;
pragma Import(c,VioModeWait, Link_name=>"_VioModeWait");

function VioModeUndo (usOwnerInd:USHORT ;
                      usKillInd :USHORT ;
                      usReserved:USHORT ) return apiret16;
pragma Import(c,VioModeUndo, Link_name=>"_VioModeUndo");

 LOCKIO_NOWAIT       :constant ushort:=0;
 LOCKIO_WAIT         :constant ushort:=1;

 LOCK_SUCCESS        :constant ushort:=0;
 LOCK_FAIL           :constant ushort:=1;

function  VioScrLock (fWait      :USHORT ;
                      pfNotLocked:PUCHAR ;
                      hvi        :HVIO   ) return apiret16;
pragma Import(c,VioScrLock, Link_name=>"_VioScrLock");

function VioScrUnLock (hvi:HVIO ) return apiret16;
pragma Import(c,VioScrUnLock, Link_name=>"_VioScrUnLock");

 VP_NOWAIT                 :constant ushort:=0;
 VP_WAIT                   :constant ushort:=1;
 VP_OPAQUE                 :constant ushort:=0;
 VP_TRANSPARENT            :constant ushort:=2;

function  VioPopUp (pfWait:PUSHORT ; hvi:HVIO ) return apiret16;
pragma Import(c,VioPopUp, Link_name=>"_VioPopUp");

function  VioEndPopUp (hvi:HVIO ) return apiret16;
pragma Import(c,VioEndPopUp, Link_name=>"_VioEndPopUp");

--   VIOCONFIGINFO.adapter constants
 DISPLAY_MONOCHROME      :constant ulong:=16#0000#;
 DISPLAY_CGA             :constant ulong:=16#0001#;
 DISPLAY_EGA             :constant ulong:=16#0002#;
 DISPLAY_VGA             :constant ulong:=16#0003#;
 DISPLAY_8514A           :constant ulong:=16#0007#;
 DISPLAY_IMAGEADAPTER    :constant ulong:=16#0008#;
 DISPLAY_XGA             :constant ulong:=16#0009#;

--   VIOCONFIGINFO.display constants

 MONITOR_MONOCHROME      :constant ulong:=16#0000#;
 MONITOR_COLOR           :constant ulong:=16#0001#;
 MONITOR_ENHANCED        :constant ulong:=16#0002#;
 MONITOR_8503            :constant ulong:=16#0003#;
 MONITOR_851X_COLOR      :constant ulong:=16#0004#;
 MONITOR_8514            :constant ulong:=16#0009#;
 MONITOR_FLATPANEL       :constant ulong:=16#000A#;
 MONITOR_8507_8604       :constant ulong:=16#000B#;
 MONITOR_8515            :constant ulong:=16#000C#;
 MONITOR_9515            :constant ulong:=16#000F#;
 MONITOR_9517            :constant ulong:=16#0011#;
 MONITOR_9518            :constant ulong:=16#0012#;

       -- structure for VioGetConfig() --

type VIOCONFIGINFO is record  -- vioin --
     cb                 :USHORT  ;
     adapter            :USHORT  ;
     display            :USHORT  ;
     cbMemory           :ULONG   ;
     Configuration      :USHORT  ;
     VDHVersion         :USHORT  ;
     Flags              :USHORT  ;
     HWBufferSize       :ULONG   ;
     FullSaveSize       :ULONG   ;
     PartSaveSize       :ULONG   ;
     EMAdaptersOFF      :USHORT  ;
     EMDisplaysOFF      :USHORT  ;
end record;
type PVIOCONFIGINFO is access all VIOCONFIGINFO;

 VIO_CONFIG_CURRENT   :constant ushort:=  0;
 VIO_CONFIG_PRIMARY   :constant ushort:=  1;
 VIO_CONFIG_SECONDARY :constant ushort:=  2;

function VioGetConfig (usConfigId:USHORT        ;
                        pvioin   :PVIOCONFIGINFO;
                        hvi      :HVIO          )  return apiret16;
pragma Import(c,VioGetConfig, Link_name=>"_VioGetConfig");

  -- structure for VioGet/SetFont() --
type VIOFONTINFO is record    -- viofi --
     cb          :USHORT  ;
     typ         :USHORT  ;
     cxCell      :USHORT  ;
     cyCell      :USHORT  ;
     pbData      :PVOID16 ;
     cbData      :USHORT  ;
end record;
type PVIOFONTINFO is access all VIOFONTINFO;

 VGFI_GETCURFONT  :constant ushort:= 0;
 VGFI_GETROMFONT  :constant ushort:= 1;

function  VioGetFont (pviofi:PVIOFONTINFO ;
                      hvi   :HVIO         ) return apiret16;
pragma Import(c,VioGetFont, Link_name=>"_VioGetFont");

function  VioSetFont (pviofi:PVIOFONTINFO ;
                      hvi   :HVIO         ) return apiret16;
pragma Import(c,VioSetFont, Link_name=>"_VioSetFont");

function VioGetCp (usReserved  :USHORT ;
                    pIdCodePage:PUSHORT;
                    hvi        :HVIO   ) return apiret16;
pragma Import(c,VioGetCp, Link_name=>"_VioGetCp");

function VioSetCp (usReserved  :USHORT ;
                    pIdCodePage:PUSHORT;
                    hvi        :HVIO   ) return apiret16;
pragma Import(c,VioSetCp, Link_name=>"_VioSetCp");

type VIOPALSTATE  is record   -- viopal --
     cb           :USHORT  ;
     typ          :USHORT  ;
     iFirst       :USHORT  ;
     acolor       :USHORT  ;
end record;
type PVIOPALSTATE is access all VIOPALSTATE;

type VIOOVERSCAN is record    -- vioos --
     cb        :USHORT  ;
     typ       :USHORT  ;
     color     :USHORT  ;
end record;
type PVIOOVERSCAN is access all VIOOVERSCAN;

type VIOINTENSITY  is record  -- vioint --
     cb       :USHORT  ;
     typ      :USHORT  ;
     fs       :USHORT  ;
end record;
type PVIOINTENSITY is access all VIOINTENSITY;

type VIOCOLORREG is record   -- viocreg --
     cb                :USHORT  ;
     typ               :USHORT  ;
     firstcolorreg     :USHORT  ;
     numcolorregs      :USHORT  ;
     colorregaddr      :PCH     ;
end record;
type PVIOCOLORREG is access all VIOCOLORREG;

type VIOSETULINELOC  is record  -- viouline --
      cb           :USHORT ;
      typ          :USHORT ;
      scanline     :USHORT ;
end record;
type PVIOSETULINELOC is access all VIOSETULINELOC;

type VIOSETTARGET is record   -- viosett --
     cb                   :USHORT  ;
     typ                  :USHORT  ;
     defaultalgorithm     :USHORT  ;
end record;
type PVIOSETTARGET is access all VIOSETTARGET;

function  VioGetState (pState:PVOID ; hvi   :HVIO  )return apiret16;
pragma Import(c,VioGetState, Link_name=>"_VioGetState");

function  VioSetState (pState:PVOID ; hvi   :HVIO  )return apiret16;
pragma Import(c,VioSetState, Link_name=>"_VioSetState");

end Os2.Vio;
