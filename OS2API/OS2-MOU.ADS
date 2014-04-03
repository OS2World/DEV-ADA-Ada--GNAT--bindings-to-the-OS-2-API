
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     OS2.MOU                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               Mouse   support    of os/2 api functions            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Mou  is
pragma Preelaborate (Mou);

subtype  HMOU is USHORT ;
type PHMOU is access all HMOU;

function  MouRegister (  pszModName  :PSZ ;
                         pszEntryName:PSZ ;
                         flFuns      :ULONG) return apiret16;
pragma Import(c,MouRegister, Link_name=>"MouRegister");

 MR_MOUGETNUMBUTTONS        :constant ulong:=16#00000001#;
 MR_MOUGETNUMMICKEYS        :constant ulong:=16#00000002#;
 MR_MOUGETDEVSTATUS         :constant ulong:=16#00000004#;
 MR_MOUGETNUMQUEEL          :constant ulong:=16#00000008#;
 MR_MOUREADEVENTQUE         :constant ulong:=16#00000010#;
 MR_MOUGETSCALEFACT         :constant ulong:=16#00000020#;
 MR_MOUGETEVENTMASK         :constant ulong:=16#00000040#;
 MR_MOUSETSCALEFACT         :constant ulong:=16#00000080#;
 MR_MOUSETEVENTMASK         :constant ulong:=16#00000100#;
 MR_MOUOPEN                 :constant ulong:=16#00000800#;
 MR_MOUCLOSE                :constant ulong:=16#00001000#;
 MR_MOUGETPTRSHAPE          :constant ulong:=16#00002000#;
 MR_MOUSETPTRSHAPE          :constant ulong:=16#00004000#;
 MR_MOUDRAWPTR              :constant ulong:=16#00008000#;
 MR_MOUREMOVEPTR            :constant ulong:=16#00010000#;
 MR_MOUGETPTRPOS            :constant ulong:=16#00020000#;
 MR_MOUSETPTRPOS            :constant ulong:=16#00040000#;
 MR_MOUINITREAL             :constant ulong:=16#00080000#;
 MR_MOUSETDEVSTATUS         :constant ulong:=16#00100000#;

function   MouDeRegister return apiret16;
pragma Import(c,MouDeRegister, Link_name=>"MouDeRegister");

function  MouFlushQue ( mou:HMOU) return apiret16;
pragma Import(c,MouFlushQue, Link_name=>"MouFlushQue");

 MHKBUTTON1                :constant ushort:=0001;
 MHKBUTTON2                :constant ushort:=0002;
 MHKBUTTON3                :constant ushort:=0004;

       -- ure for MouGet/SetPtrPos() --
type  PTRLOC  is record    -- moupl --
  row        :USHORT ;
  col        :USHORT ;
end record; --PTRLOC;
type PPTRLOC is access all PTRLOC;

function MouGetPtrPos (pmouLoc:PPTRLOC;
                       mou    :HMOU    )  return apiret16;
pragma Import(c,MouGetPtrPos, Link_name=>"_MouGetPtrPos");

function MouSetPtrPos (pmouLoc:PPTRLOC ;
                       mou    :HMOU    ) return apiret16;
pragma Import(c,MouSetPtrPos, Link_name=>"_MouSetPtrPos");

-- ure for MouGet/SetPtrShape() --
type  PTRSHAPE  is record    -- moups --
  cb            :USHORT ;
  col           :USHORT ;
  row           :USHORT ;
  colHot        :USHORT ;
  rowHot        :USHORT ;
end record; --PTRSHAPE;
type PPTRSHAPE is access all PTRSHAPE;

function  MouSetPtrShape (pBuf       :PBYTE      ;
                          pmoupsInfo :PPTRSHAPE ;
                          mou        :HMOU      ) return apiret16;
pragma Import(c,MouSetPtrShape, Link_name=>"_MouSetPtrShape");

function  MouGetPtrShape (pBuf       :PBYTE      ;
                          pmoupsInfo :PPTRSHAPE ;
                          mou        :HMOU      ) return apiret16;
pragma Import(c,MouGetPtrShape, Link_name=>"_MouGetPtrShape");

       -- MouGetDevStatus/MouSetDevStatus device status constants --
 MOUSEQUEUEBUSY        :constant ushort:=16#0001#;
 MOUSEBLOCKREAD        :constant ushort:=16#0002#;
 MOUSEFLUSH            :constant ushort:=16#0004#;
 MOUSEUNSUPPORTEDMODE  :constant ushort:=16#0008#;
 MOUSEDISABLED         :constant ushort:=16#0100#;
 MOUSEMICKEYS          :constant ushort:=16#0200#;

function  MouGetDevStatus (pfsDevStatus:PUSHORT ;
                           mou         :HMOU    ) return apiret16;
pragma Import(c,MouGetDevStatus, Link_name=>"_MouGetDevStatus");

function  MouGetNumButtons (pcButtons:PUSHORT ;
                            mou      :HMOU    ) return apiret16;
pragma Import(c,MouGetNumButtons, Link_name=>"_MouGetNumButtons");

function MouGetNumMickeys (pcMickeys:PUSHORT ;
                           mou      :HMOU    ) return apiret16;
pragma Import(c,MouGetNumMickeys, Link_name=>"_MouGetNumMickeys");

       -- MouReadEventQue --
 MOUNOWAIT      :constant ushort:=0000;
 MOUWAIT        :constant ushort:=0001;

       -- ure for MouReadEventQue() --
type   MOUEVENTINFO is record    -- mouev --
      fs      :USHORT ;
      time    :ULONG  ;
      row     :SHORT  ;
      col     :SHORT  ;
end record; --MOUEVENTINFO;
type PMOUEVENTINFO is access all MOUEVENTINFO;

function  MouReadEventQue (mouevEvent:PMOUEVENTINFO ;
                           pfWait    :PUSHORT       ;
                           mou       :HMOU          ) return apiret16;
pragma Import(c,MouReadEventQue, Link_name=>"_MouReadEventQue");

 -- ure for MouGetNumQueEl() --
type  MOUQUEINFO is record      -- mouqi --
      cEvents       :USHORT ;
      cmaxEvents    :USHORT ;
end record; --MOUQUEINFO;
type PMOUQUEINFO is access all MOUQUEINFO;

function  MouGetNumQueEl (qmouqi:PMOUQUEINFO ;
                          mou   :HMOU        ) return apiret16;
pragma Import(c,MouGetNumQueEl, Link_name=>"_MouGetNumQueEl");

       -- MouGetEventMask/MouSetEventMask events --
 MOUSEMOTION              :constant ushort :=16#0001#;
 MOUSEMOTIONWITHBN1DOWN   :constant ushort :=16#0002#;
 MOUSEBN1DOWN             :constant ushort :=16#0004#;
 MOUSEMOTIONWITHBN2DOWN   :constant ushort :=16#0008#;
 MOUSEBN2DOWN             :constant ushort :=16#0010#;
 MOUSEMOTIONWITHBN3DOWN   :constant ushort :=16#0020#;
 MOUSEBN3DOWN             :constant ushort :=16#0040#;

function MouGetEventMask (pfsEvents:PUSHORT ;
                         mou      :HMOU    ) return apiret16;
pragma Import(c,MouGetEventMask, Link_name=>"_MouGetEventMask");

function  MouSetEventMask (pfsEvents:PUSHORT ;
                           mou      :HMOU    ) return apiret16;
pragma Import(c,MouSetEventMask, Link_name=>"_MouSetEventMask");

       -- ure for MouGet/SetScaleFact() --
type   SCALEFACT is record   -- mousc --
    rowScale      :USHORT ;
    colScale      :USHORT ;
end record; --SCALEFACT;
type PSCALEFACT is access all SCALEFACT;

function  MouGetScaleFact (pmouscFactors:PSCALEFACT ;
                           mou          :HMOU       )return apiret16;
pragma Import(c,MouGetScaleFact, Link_name=>"_MouGetScaleFact");

function  MouSetScaleFact (pmouscFactors:PSCALEFACT ;
                           mou          :HMOU       )return apiret16;
pragma Import(c,MouSetScaleFact, Link_name=>"_MouSetScaleFact");

function  MouOpen (pszDvrName:PSZ   ;
                   pmou      :PHMOU ) return apiret16;
pragma Import(c,MouOpen, Link_name=>"_MouOpen");

function  MouClose (mou:HMOU  ) return apiret16;
pragma Import(c,MouClose, Link_name=>"_MouClose");

       -- ure for MouRemovePtr() --
type  NOPTRRECT is record    -- mourt --
    row       :USHORT ;
    col       :USHORT ;
    cRow      :USHORT ;
    cCol      :USHORT ;
end record; --NOPTRRECT;
type PNOPTRRECT is access all NOPTRRECT;

function  MouRemovePtr (pmourtRect:PNOPTRRECT ;
                        mou       :HMOU       ) return apiret16;
pragma Import(c,MouRemovePtr, Link_name=>"_MouRemovePtr");

function MouDrawPtr (mou:HMOU  ) return apiret16;
pragma Import(c,MouDrawPtr, Link_name=>"_MouDrawPtr");

 MOUNODRAW      :constant ushort:=0001;
 MOUDRAW        :constant ushort:=0000;
 MOUMICKEYS     :constant ushort:=0002;
 MOUPELS        :constant ushort:=0000;


function MouSetDevStatus (pfsDevStatus:PUSHORT ;
                          mou         :HMOU    ) return apiret16;
pragma Import(c,MouSetDevStatus, Link_name=>"_MouSetDevStatus");

function  MouInitReal (ps:PSZ) return apiret16;
pragma Import(c,MouInitReal, Link_name=>"_MouInitReal");

function  MouSynch(pszDvrName:USHORT ) return apiret16;
pragma Import(c,MouSynch, Link_name=>"_MouSynch");

type  THRESHOLD  is record      -- threshold --
   Length         :USHORT ;        -- Length Field            --
   Level1         :USHORT ;        -- First movement level    --
   Lev1Mult       :USHORT ;        -- First level multiplier  --
   Level2         :USHORT ;        -- Second movement level   --
   lev2Mult       :USHORT ;        -- Second level multiplier --
end record; --THRESHOLD;
type PTHRESHOLD is access all THRESHOLD;

function  MouGetThreshold(pthresh:PTHRESHOLD ;
                          mou    :HMOU       ) return apiret16;
pragma Import(c,MouGetThreshold, Link_name=>"_MouGetThreshold");

function  MouSetThreshold(pthresh:PTHRESHOLD ;
                          mou    :HMOU       ) return apiret16;
pragma Import(c,MouSetThreshold, Link_name=>"_MouSetThreshold");

end Os2.mou;
