
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     OS2.KBD                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               Kbd     support    of os/2 api functions            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Kbd  is
pragma Preelaborate (Kbd);


   subtype HKBD is ushort;
   type PHKBD is access all  HKBD;

function KbdRegister (pszModName:PSZ; pszEntryPt:PSZ ;
                      FunMask:ULONG ) return apiret16;
pragma Import(c,KbdRegister, Link_name=>"_KbdRegister");


 IO_WAIT   :constant ushort := 0 ;
 IO_NOWAIT :constant ushort := 1 ;

function  KbdDeRegister return apiret16;
pragma Import(c,KbdDeRegister, Link_name=>"_KbdDeRegister");

 --   KBDKEYINFO structure, for KbdCharIn and KbdPeek
   type KBDKEYINFO is record    --  kbci
    chChar    : UCHAR   ;
    chScan    : UCHAR   ;
    fbStatus  : UCHAR   ;
    bNlsShift : UCHAR   ;
    fsState   : USHORT  ;
    time      : ULONG   ;
   end record;
   type   PKBDKEYINFO is access all KBDKEYINFO;

function KbdCharIn(pkbci:PKBDKEYINFO; fWait:USHORT ;
                    kbd: HKBD)   return apiret16;
pragma Import(c,KbdCharIn, Link_name=>"_KbdCharIn");

function KbdPeek (pkbci:PKBDKEYINFO;hkb:HKBD)return apiret16;
pragma Import(c,KbdPeek, Link_name=>"_KbdPeek");

--    structure for KbdStringIn()
 type STRINGINBUF is record --  kbsi
    cb    : USHORT;
    cchIn : USHORT;
 end record;
 type PSTRINGINBUF is access all STRINGINBUF;

 function  KbdStringIn (s: PCH ; pchIn :  PSTRINGINBUF ;
                        fsWait:  USHORT ; hkb  : HKBD  )return apiret16;
pragma Import(c,KbdStringIn, Link_name=>"_KbdStringIn");

function KbdFlushBuffer (hkb: HKBD) return apiret16;
pragma Import(c,KbdFlushBuffer, Link_name=>"_KbdFlushBuffer");


--       KBDINFO.fsMask
  KEYBOARD_ECHO_ON                :constant ushort :=16#0001#;
  KEYBOARD_ECHO_OFF               :constant ushort :=16#0002#;
  KEYBOARD_BINARY_MODE            :constant ushort :=16#0004#;
  KEYBOARD_ASCII_MODE             :constant ushort :=16#0008#;
  KEYBOARD_MODIFY_STATE           :constant ushort :=16#0010#;
  KEYBOARD_MODIFY_INTERIM         :constant ushort :=16#0020#;
  KEYBOARD_MODIFY_TURNAROUND      :constant ushort :=16#0040#;
  KEYBOARD_2B_TURNAROUND          :constant ushort :=16#0080#;
  KEYBOARD_SHIFT_REPORT           :constant ushort :=16#0100#;


 --     following constants defined in bsedev.h
 --     KBDINFO.fsState/KBDKEYINFO.fsState/KBDTRANS.fsState

  KBDSTF_RIGHTSHIFT               :constant ushort :=16#0001#;
  KBDSTF_LEFTSHIFT                :constant ushort :=16#0002#;
  KBDSTF_CONTROL                  :constant ushort :=16#0004#;
  KBDSTF_ALT                      :constant ushort :=16#0008#;
  KBDSTF_SCROLLLOCK_ON            :constant ushort :=16#0010#;
  KBDSTF_NUMLOCK_ON               :constant ushort :=16#0020#;
  KBDSTF_CAPSLOCK_ON              :constant ushort :=16#0040#;
  KBDSTF_INSERT_ON                :constant ushort :=16#0080#;
  KBDSTF_LEFTCONTROL              :constant ushort :=16#0100#;
  KBDSTF_LEFTALT                  :constant ushort :=16#0200#;
  KBDSTF_RIGHTCONTROL             :constant ushort :=16#0400#;
  KBDSTF_RIGHTALT                 :constant ushort :=16#0800#;
  KBDSTF_SCROLLLOCK               :constant ushort :=16#1000#;
  KBDSTF_NUMLOCK                  :constant ushort :=16#2000#;
  KBDSTF_CAPSLOCK                 :constant ushort :=16#4000#;
  KBDSTF_SYSREQ                   :constant ushort :=16#8000#;

   -- KBDINFO structure, for KbdSet/GetStatus
   type  KBDINFO is record --           kbst
      cb          :USHORT  ;
      fsMask      :USHORT  ;
      chTurnAround:USHORT  ;
      fsInterim   :USHORT  ;
      fsState     :USHORT  ;
   end record;
   type PKBDINFO is access all KBDINFO;

function  KbdSetStatus (pkbdinf :PKBDINFO;hkb :HKBD)return apiret16;
pragma Import(c,KbdSetStatus, Link_name=>"_KbdSetStatus");

function KbdGetStatus(pkbdinf :PKBDINFO;hkb :HKBD)return apiret16;
pragma Import(c,KbdGetStatus, Link_name=>"_KbdGetStatus");

function KbdSetCp (usReserved:USHORT;pidCP:USHORT;
                   hdb :HKBD) return apiret16;
pragma Import(c,KbdSetCp, Link_name=>"_KbdSetCp");

function KbdGetCp (ulReserved:ULONG;pidCP :PUSHORT;
                   hkb:HKBD) return apiret16;
pragma Import(c,KbdGetCp, Link_name=>"_KbdGetCp");

function KbdOpen (ph:PHKBD) return apiret16;
pragma Import(c,KbdOpen, Link_name=>"_KbdOpen");

function KbdClose (hkb:HKBD) return apiret16;
pragma Import(c,KbdClose, Link_name=>"_KbdClose");

function KbdGetFocus (fWait:USHORT; hkb:HKBD) return apiret16;
pragma Import(c,KbdGetFocus, Link_name=>"_KbdGetFocus");

function KbdFreeFocus(hkb:HKBD)return apiret16;
pragma Import(c,KbdFreeFocus, Link_name=>"_KbdFreeFocus");

function KbdSynch (fsWait:USHORT) return apiret16;
pragma Import(c,KbdSynch, Link_name=>"_KbdSynch");

function KbdSetFgnd return apiret16;
pragma Import(c,KbdSetFgnd, Link_name=>"_KbdSetFgnd");

 --   structure for KbdGetHWID()
type  KBDHWID is record   --   kbhw
      cb         :USHORT ;
      idKbd      :USHORT ;
      usReserved1:USHORT ;
      usReserved2:USHORT ;
end record;
type PKBDHWID is access all KBDHWID;

function KbdGetHWID (phwid:PKBDHWID;hkb:HKBD)  return apiret16;
pragma Import(c,KbdGetHWID, Link_name=>"_KbdGetHWID");

function KbdSetHWID (phwid:PKBDHWID;hkb:HKBD)  return apiret16;
pragma Import(c,KbdSetHWID, Link_name=>"_KbdSetHWID");


--   KBDTRANS.fbStatus
  KBDTRF_SHIFT_KEY_IN             :constant ushort :=16#01#;
  KBDTRF_CONVERSION_REQUEST       :constant ushort :=16#20#;
  KBDTRF_FINAL_CHAR_IN            :constant ushort :=16#40#;
  KBDTRF_INTERIM_CHAR_IN          :constant ushort :=16#80#;

  --  structure for KbdXlate()
type KBDTRANS is record  -- kbxl
    chChar     :UCHAR      ;
    chScan     :UCHAR      ;
    fbStatus   :UCHAR      ;
    bNlsShift  :UCHAR      ;
    fsState    :USHORT     ;
    time       :ULONG      ;
    fsDD       :USHORT     ;
    fsXlate    :USHORT     ;
    fsShift    :USHORT     ;
    sZero      :USHORT     ;
 end record;
 type PKBDTRANS is access all KBDTRANS;

function KbdXlate (pkbdtr:PKBDTRANS;hkb:HKBD) return apiret16;
pragma Import(c,KbdXlate, Link_name=>"_KbdXlate");

function KbdSetCustXt(usCodePage:PUSHORT;hkb:HKBD) return apiret16;
pragma Import(c,KbdSetCustXt, Link_name=>"_KbdSetCustXt");


  KR_KBDCHARIN               :constant ulong :=16#00000001#;
  KR_KBDPEEK                 :constant ulong :=16#00000002#;
  KR_KBDFLUSHBUFFER          :constant ulong :=16#00000004#;
  KR_KBDGETSTATUS            :constant ulong :=16#00000008#;
  KR_KBDSETSTATUS            :constant ulong :=16#00000010#;
  KR_KBDSTRINGIN             :constant ulong :=16#00000020#;
  KR_KBDOPEN                 :constant ulong :=16#00000040#;
  KR_KBDCLOSE                :constant ulong :=16#00000080#;
  KR_KBDGETFOCUS             :constant ulong :=16#00000100#;
  KR_KBDFREEFOCUS            :constant ulong :=16#00000200#;
  KR_KBDGETCP                :constant ulong :=16#00000400#;
  KR_KBDSETCP                :constant ulong :=16#00000800#;
  KR_KBDXLATE                :constant ulong :=16#00001000#;
  KR_KBDSETCUSTXT            :constant ulong :=16#00002000#;

end Os2.Kbd ;
