
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package    OS2   interface to API and PM functions         บ
-- บ            common block                                           บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
with System;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2 is
pragma Preelaborate(Os2);

-- ===========================================================================
-- + INCL_DOSPROCESS         Process and thread support
-- + INCL_DOSFILEMGR         File Management
-- + INCL_DOSMEMMGR          Memory Management
-- + INCL_DOSSEMAPHORES      Semaphore support
-- + INCL_DOSDATETIME        Date/Time and Timer support
--   INCL_DOSMODULEMGR       Module manager
-- + INCL_DOSRESOURCES       Resource support
--   INCL_DOSNLS             National Language Support
--   INCL_DOSEXCEPTIONS      Exception Management Support
--   INCL_DOSMISC            Miscellaneous
--   INCL_DOSMONITORS        Monitors
--   INCL_DOSQUEUES          Queues
--   INCL_DOSSESMGR          Session Manager Support
--   INCL_DOSDEVICES         Device specific, ring 2 support
--   INCL_DOSNMPIPES         Named Pipes Support
--   INCL_DOSPROFILE         DosProfile API
--   INCL_DOSMVDM            MVDM support
--
-- ===========================================================================
   -------------------
   -- General Types --
   -------------------


subtype PVOID is System.Address;
subtype PVOID16 is System.Address;

type VLONG is range -9_223_372_036_854_775_808
                               .. 9_223_372_036_854_775_807;
for VLONG'size use 64;

type UVLong is mod 16#1_0000_0000_0000_0000#;
for UVLong'size use 64;


type UCHAR  is new unsigned_char;
type USHORT is new unsigned_short;
type ULONG  is new unsigned_long;
type  LONG  is new long_integer;

type ASTRING is array(integer range <>) of aliased CHARACTER;

subtype Short   is Short_Integer ;
subtype BYTE    is UCHAR  ;
subtype SEL     is USHORT ;
subtype APIRET16 is USHORT;
subtype SHANDLE is USHORT ;
subtype LHANDLE is ULONG  ;
subtype BOOL    is ULONG  ;
subtype BOOL32  is ULONG  ;
subtype HMODULE is ULONG  ;
subtype ERRORID is ULONG  ;
subtype APIRET  is ULONG  ;
subtype APIRET32 is ULONG ;
subtype PID     is ULONG  ;
subtype TID     is ULONG  ;
subtype HAB     is ULONG  ;
subtype HDC     is ULONG  ;
subtype HPS     is ULONG  ;
subtype HDS     is ULONG  ;
subtype HMF     is ULONG  ;
subtype HMQ     is ULONG  ;
subtype HRGN    is ULONG  ;
subtype HBITMAP is ULONG  ;
subtype HPAL    is ULONG  ;
subtype HWND    is ULONG  ;
subtype COLOR   is LONG   ;
subtype HSEM    is PVOID  ;
subtype PCH     is PVOID  ;
subtype PSZ     is PVOID  ;
subtype NPSZ    is PVOID  ;
subtype PMPARAM  is PVOID;
subtype  MPARAM  is ULONG;
subtype PMRESULT is PVOID;
subtype  MRESULT is PVOID;
subtype  PFNWP   is PVOID;
subtype  PFN     is PVOID;

   type   PULONG   is access all ULONG;
   type   PLONG    is access all LONG;
   type   PUSHORT  is access all USHORT;
   type   PSHORT   is access all SHORT;
   type   PUCHAR   is access all UCHAR;
   type   PBYTE    is access all BYTE ;
   type   PCHAR    is access all CHARACTER;
   type   PSEL     is access all SEL;
   type   PSHANDLE is access all SHANDLE ;
   type   PLHANDLE is access all LHANDLE ;
   type   PHMODULE is access all HMODULE ;
   type   PERRORID is access all ERRORID ;
   type   PPID     is access all PID     ;
   type   PTID     is access all TID     ;
   type   PHAB     is access all HAB     ;
   type   PHPS     is access all HPS     ;
   type   PHDC     is access all HDC     ;
   type   PHDS     is access all HDS     ;
   type   PHMF     is access all HMF     ;
   type   PHMQ     is access all HMQ     ;
   type   PHRGN    is access all HRGN    ;
   type   PHBITMAP is access all HBITMAP ;
   type   PHPAL    is access all HPAL    ;
   type   PHWND    is access all HWND    ;
   type   PCOLOR   is access all COLOR   ;
   type   PPVOID   is access all PVOID   ;
   type   PHSEM    is access all HSEM    ;

subtype HFILE is LHANDLE ;     -- hf --
type PHFILE   is access all HFILE;

   False32 : constant BOOL32 := 0;
   True32  : constant BOOL32 := 1;
   facesize: constant integer:=32;


type  QWORD is record           -- qword --
ulLo   :ULONG   ;
ulHi   :ULONG   ;
end record; -- QWORD;
type PQWORD is access all QWORD;

type  POINTL is record         -- ptl  --
 x  :LONG  ;
 y  :LONG  ;
end record; -- POINTL;
type  PPOINTL is access all POINTL;

type  POINTS is record          -- pts --
 x  :SHORT ;
 y  :SHORT ;
end record; -- POINTS;
type  PPOINTS  is access all POINTS;

type  RECTL is record           -- rcl --
 xLeft    :LONG  ;
 yBottom  :LONG  ;
 xRight   :LONG  ;
 yTop     :LONG  ;
end record; -- RECTL;
type  PRECTL is access all RECTL;

--        QMSG structure
type QMSG    is record  -- qmsg
   hwn           :HWND    ;
   msg           :ULONG   ;
   mp1           :MPARAM  ;
   mp2           :MPARAM  ;
   time          :ULONG   ;
   ptl           :POINTL  ;
   reserved      :ULONG   ;
end record; -- QMSG;
type PQMSG  is access all QMSG;

type  DRIVDATA is record       -- driv --
 cb              :LONG    ;
 lVersion        :LONG    ;
 szDeviceName    :string(1..32)  ;     --  [32];
 abGeneralData   :string(1..1)   ;     --  [1];
end record; -- DRIVDATA;
type  PDRIVDATA is access all DRIVDATA ;

type  DEVOPENSTRUC is record      -- dop --
    pszLogAddress        :PSZ       ;
    pszDriverName        :PSZ       ;
    pdriv                :PDRIVDATA ;
    pszDataType          :PSZ       ;
    pszComment           :PSZ       ;
    pszQueueProcName     :PSZ       ;
    pszQueueProcParams   :PSZ       ;
    pszSpoolerParams     :PSZ       ;
    pszNetworkParams     :PSZ       ;
   end record; -- DEVOPENSTRUC;
type  PDEVOPENSTRUC is access all  DEVOPENSTRUC ;

type  PRINTDEST is record    -- prntdst --
 cb          :ULONG        ;
 lType       :LONG         ;
 pszToken    :PSZ          ;
 lCount      :LONG         ;
 pdopData    :PSZ          ;
 fl          :ULONG        ;
 pszPrinter  :PSZ          ;
end record; -- PRINTDEST;
type  PPRINTDEST is access all PRINTDEST;

-- font  for Vio/GpiCreateLogFont --
type  FATTRS is record             -- fat --
 usRecordLength   :USHORT  ;
 fsSelection      :USHORT  ;
 lMatch           :LONG    ;
 szFacename       :string (1..FACESIZE) ;         -- [FACESIZE];
 idRegistry       :USHORT  ;
 usCodePage       :USHORT  ;
 lMaxBaselineExt  :LONG    ;
 lAveCharWidth    :LONG    ;
 fsType           :USHORT  ;
 fsFontUse        :USHORT  ;
end record; -- FATTRS;
type  PFATTRS is access all   FATTRS;

-- font metrics returned by GpiQueryFonts and others --
type  PANOSE is record    -- panose --
  bFamilyType        :BYTE   ;
  bSerifStyle        :BYTE   ;
  bWeight            :BYTE   ;
  bProportion        :BYTE   ;
  bContrast          :BYTE   ;
  bStrokeVariation   :BYTE   ;
  bArmStyle          :BYTE   ;
  bLetterform        :BYTE   ;
  bMidline           :BYTE   ;
  bXHeight           :BYTE   ;
  fbPassedISO        :BYTE   ;
  fbFailedISO        :BYTE   ;
end record; -- PANOSE;
type  PPANOSE is access all  PANOSE;

type  FONTMETRICS is record      -- fm --
  szFamilyname         :string(1..FACESIZE)   ;       --  [FACESIZE];
  szFacename           :string(1..FACESIZE)  ;       --[FACESIZE];
  idRegistry           :USHORT   ;
  usCodePage           :USHORT   ;
  lEmHeight            :LONG     ;
  lXHeight             :LONG     ;
  lMaxAscender         :LONG     ;
  lMaxDescender        :LONG     ;
  lLowerCaseAscent     :LONG     ;
  lLowerCaseDescent    :LONG     ;
  lInternalLeading     :LONG     ;
  lExternalLeading     :LONG     ;
  lAveCharWidth        :LONG     ;
  lMaxCharInc          :LONG     ;
  lEmInc               :LONG     ;
  lMaxBaselineExt      :LONG     ;
  sCharSlope           :SHORT    ;
  sInlineDir           :SHORT    ;
  sCharRot             :SHORT    ;
  usWeightClass        :USHORT   ;
  usWidthClass         :USHORT   ;
  sXDeviceRes          :SHORT    ;
  sYDeviceRes          :SHORT    ;
  sFirstChar           :SHORT    ;
  sLastChar            :SHORT    ;
  sDefaultChar         :SHORT    ;
  sBreakChar           :SHORT    ;
  sNominalPointSize    :SHORT    ;
  sMinimumPointSize    :SHORT    ;
  sMaximumPointSize    :SHORT    ;
  fsType               :USHORT   ;
  fsDefn               :USHORT   ;
  fsSelection          :USHORT   ;
  fsCapabilities       :USHORT   ;
  lSubscriptXSize      :LONG     ;
  lSubscriptYSize      :LONG     ;
  lSubscriptXOffset    :LONG     ;
  lSubscriptYOffset    :LONG     ;
  lSuperscriptXSize    :LONG     ;
  lSuperscriptYSize    :LONG     ;
  lSuperscriptXOffset  :LONG     ;
  lSuperscriptYOffset  :LONG     ;
  lUnderscoreSize      :LONG     ;
  lUnderscorePosition  :LONG     ;
  lStrikeoutSize       :LONG     ;
  lStrikeoutPosition   :LONG     ;
  sKerningPairs        :SHORT    ;
  sFamilyClass         :SHORT    ;
  lMatch               :LONG     ;
  FamilyNameAtom       :LONG     ;
  FaceNameAtom         :LONG     ;
   pan                 :PANOSE   ;
end record; -- FONTMETRICS;
type PFONTMETRICS is access all FONTMETRICS;

type ICONINFO  is record  -- icninf --
 cb           :ULONG   ;  -- size of ICONINFO structure --
 fFormat      :ULONG   ;
 pszFileName  :PSZ     ;  -- use when fFormat = ICON_FILE --
 hmod         :HMODULE ;  -- use when fFormat = ICON_RESOURCE --
 resid        :ULONG   ;  -- use when fFormat = ICON_RESOURCE --
 cbIconData   :ULONG   ;  -- use when fFormat = ICON_DATA     --
 pIconData    :PVOID   ;  -- use when fFormat = ICON_DATA     --
end record;
type PICONINFO is access all ICONINFO ;

type SWP   is record   -- swp
   fl                 :ULONG   ;
   cy                 :LONG    ;
   cx                 :LONG    ;
   y                  :LONG    ;
   x                  :LONG    ;
   hwndInsertBehind   :HWND    ;
   hwn                :HWND    ;
   ulReserved1        :ULONG   ;
   ulReserved2        :ULONG   ;
end record; -- SWP;
type PSWP  is access all SWP;

end Os2;
