-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package  OS2.FM                                            บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             files part of os/2 api functions                      บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Fm is
pragma Preelaborate (Fm);

CCHMAXPATH    :constant :=    260;
CCHMAXPATHCOMP:constant :=    256;

type PBOOL32 is access all BOOL32;
type PLONG   is access all LONG  ;
                         -- File manager

     --    DosSetFilePtr() file position codes

 FILE_BEGIN   :constant ulong := 16#0000#; -- Move relative to beginning of file
 FILE_CURRENT :constant ulong := 16#0001#; -- Move relative to current fptr position
 FILE_END     :constant ulong := 16#0002#; -- Move relative to end of file

     -- DosFindFirst/Next Directory handle types --                             บ

HDIR_SYSTEM :constant ulong :=  1;    -- Use system handle

--  HDIR_CREATE      (-1)    -- Allocate a new; unused handle

     -- DosCopy control bits; may be or'ed together --                          บ

 DCPY_EXISTING :constant ulong :=  16#0001#; -- Copy even if target exists
 DCPY_APPEND   :constant ulong :=  16#0002#; -- Append to existing file; do not replace
 DCPY_FAILEAS  :constant ulong :=  16#0004#; -- Fail if EAs not supported on target

     -- DosOpen/DosQFHandState/DosQueryFileInfo et al file attributes; also --  บ
     -- known as Dos File Mode bits... --                                       บ

 FILE_NORMAL   :constant ulong :=  16#0000#;
 FILE_READONLY :constant ulong :=  16#0001#;
 FILE_HIDDEN   :constant ulong :=  16#0002#;
 FILE_SYSTEM   :constant ulong :=  16#0004#;
 FILE_DIRECTORY:constant ulong :=  16#0010#;
 FILE_ARCHIVED :constant ulong :=  16#0020#;
 -- FILE_IGNORE   :constant ulong :=  16#10000#;?? -- ignore file attribute in

     -- DosSetPath/File Info if this bit is set

 MUST_HAVE_READONLY  :constant ulong := FILE_READONLY  * 16#100# or FILE_READONLY ;
 MUST_HAVE_HIDDEN    :constant ulong := FILE_HIDDEN    * 16#100# or FILE_HIDDEN   ;
 MUST_HAVE_SYSTEM    :constant ulong := FILE_SYSTEM    * 16#100# or FILE_SYSTEM   ;
 MUST_HAVE_DIRECTORY :constant ulong := FILE_DIRECTORY * 16#100# or FILE_DIRECTORY;
 MUST_HAVE_ARCHIVED  :constant ulong := FILE_ARCHIVED  * 16#100# or FILE_ARCHIVED ;

     -- DosOpen() actions

 FILE_EXISTED   :constant ulong := 16#0001#;
 FILE_CREATED   :constant ulong := 16#0002#;
 FILE_TRUNCATED :constant ulong := 16#0003#;

     -- DosOpen() open flags
 FILE_OPEN      :constant ulong := 16#0001#;
 FILE_TRUNCATE  :constant ulong := 16#0002#;
 FILE_CREATE    :constant ulong := 16#0010#;

     --     this nibble applies if file already exists        xxxx

 OPEN_ACTION_FAIL_IF_EXISTS    :constant ulong := 16#0000#; -- 0000
 OPEN_ACTION_OPEN_IF_EXISTS    :constant ulong := 16#0001#; -- 0001
 OPEN_ACTION_REPLACE_IF_EXISTS :constant ulong := 16#0002#; -- 0010

     --     this nibble applies if file does not exist         xxxx

 OPEN_ACTION_FAIL_IF_NEW       :constant ulong := 16#0000#; -- 0000
 OPEN_ACTION_CREATE_IF_NEW     :constant ulong := 16#0010#; -- 0001

     -- DosOpen/DosSetFHandState flags --                                       บ

 OPEN_ACCESS_READONLY        :constant ulong:=   16#0000#;-- ---- ---- ---- -000
 OPEN_ACCESS_WRITEONLY       :constant ulong:=   16#0001#;-- ---- ---- ---- -001
 OPEN_ACCESS_READWRITE       :constant ulong:=   16#0002#;-- ---- ---- ---- -010
 OPEN_SHARE_DENYREADWRITE    :constant ulong:=   16#0010#;-- ---- ---- -001 ----
 OPEN_SHARE_DENYWRITE        :constant ulong:=   16#0020#;-- ---- ---- -010 ----
 OPEN_SHARE_DENYREAD         :constant ulong:=   16#0030#;-- ---- ---- -011 ----
 OPEN_SHARE_DENYNONE         :constant ulong:=   16#0040#;-- ---- ---- -100 ----
 OPEN_FLAGS_NOINHERIT        :constant ulong:=   16#0080#;-- ---- ---- 1--- ----
 OPEN_FLAGS_NO_LOCALITY      :constant ulong:=   16#0000#;-- ---- -000 ---- ----
 OPEN_FLAGS_SEQUENTIAL       :constant ulong:=   16#0100#;-- ---- -001 ---- ----
 OPEN_FLAGS_RANDOM           :constant ulong:=   16#0200#;-- ---- -010 ---- ----
 OPEN_FLAGS_RANDOMSEQUENTIAL :constant ulong:=   16#0300#;-- ---- -011 ---- ----
 OPEN_FLAGS_NO_CACHE         :constant ulong:=   16#1000#;-- ---1 ---- ---- ----
 OPEN_FLAGS_FAIL_ON_ERROR    :constant ulong:=   16#2000#;-- --1- ---- ---- ----
 OPEN_FLAGS_WRITE_THROUGH    :constant ulong:=   16#4000#;-- -1-- ---- ---- ----
 OPEN_FLAGS_DASD             :constant ulong:=   16#8000#;-- 1--- ---- ---- ----
 OPEN_FLAGS_NONSPOOLED       :constant ulong:=   16#00040000#;
 OPEN_FLAGS_PROTECTED_HANDLE :constant ulong:=   16#40000000#;

     -- DosSearchPath() constants --                                            บ

 SEARCH_PATH          :constant ulong := 16#0000#;
 SEARCH_CUR_DIRECTORY :constant ulong := 16#0001#;
 SEARCH_ENVIRONMENT   :constant ulong := 16#0002#;
 SEARCH_IGNORENETERRS :constant ulong := 16#0004#;

--   EA Info Levels & Find First/Next
--   API's: DosFindFirst; DosQueryFileInfo; DosQueryPathInfo; DosSetFileInfo;
--   DosSetPathInfo

     -- File info levels&gml All listed API's --

 FIL_STANDARD        :constant ulong :=  1; -- Info level 1; standard file info
 FIL_QUERYEASIZE     :constant ulong :=  2; -- Level 2; return Full EA size
 FIL_QUERYEASFROMLIST:constant ulong :=  3; -- Level 3; return requested EA's

     -- File info levels: Dos...PathInfo only
FIL_QUERYFULLNAME    :constant ulong :=  5;   -- Level 5; return fully qualified
                                              --   name of file
     -- DosFsAttach()  Attact or detach

 FS_ATTACH       :constant ulong :=  0;  -- Attach file server
 FS_DETACH       :constant ulong :=  1;  -- Detach file server
 FS_SPOOLATTACH  :constant ulong :=  2;  -- Register a spooler device
 FS_SPOOLDETACH  :constant ulong :=  3;  -- De-register a spooler device

     -- DosFsCtl()  Routing type

 FSCTL_HANDLE    :constant ulong :=  1; -- File Handle directs req routing
 FSCTL_PATHNAME  :constant ulong :=  2; -- Path Name directs req routing
 FSCTL_FSDNAME   :constant ulong :=  3; -- FSD Name directs req routing

     -- defined FSCTL functions

 FSCTL_ERROR_INFO:constant ulong :=  1; -- return error info from FSD
 FSCTL_MAX_EASIZE:constant ulong :=  2; -- Max ea size for the FSD

type  EASIZEBUF is record       -- for FSCTL fn 2 - max ea size --
  cbMaxEASize          :USHORT  ;    -- max. size of one EA --
  cbMaxEAListSize      :ULONG   ;    -- max size of the full EA List --
end record;  -- EASIZEBUF
type PEASIZEBUF  is access all EASIZEBUF;
                -- DosQueryFSAttach() --
     -- Information level types (defines method of query)

 FSAIL_QUERYNAME :constant ulong :=  1;  -- Return data for a Drive or Device
 FSAIL_DEVNUMBER :constant ulong :=  2;  -- Return data for Ordinal Device #
 FSAIL_DRVNUMBER :constant ulong :=  3;  -- Return data for Ordinal Drive #

     -- Item types (from data structure item "iType")

 FSAT_CHARDEV    :constant ulong :=  1; -- Resident aliased CHARACTER device
 FSAT_PSEUDODEV  :constant ulong :=  2; -- Pusedu-aliased CHARACTER device
 FSAT_LOCALDRV   :constant ulong :=  3; -- Local drive
 FSAT_REMOTEDRV  :constant ulong :=  4; -- Remote drive attached to FSD

type  FSQBUFFER  is record        -- fsqbuf Data structure for QFSAttach
  iType          :USHORT  ;              -- Item type
  cbName         :USHORT  ;             -- Length of item name; sans NULL
  szName         :aliased CHARACTER   ;  --[1]; -- ASCIIZ item name
  cbFSDName      :USHORT  ;          -- Length of FSD name; sans NULL
  szFSDName      :aliased CHARACTER   ;  --[1];    -- ASCIIZ FSD name
  cbFSAData      :USHORT  ;          -- Length of FSD Attach data returned
  rgFSAData      :aliased CHARACTER   ;  -- [1];  -- FSD Attach data from FSD
end record;  -- FSQBUFFER;
type PFSQBUFFER  is access all FSQBUFFER;

type FSQBUFFER2  is record       -- fsqbuf Data structure for QFSAttach--
  iType          :USHORT  ;
  cbName         :USHORT  ;
  cbFSDName      :USHORT  ;
  cbFSAData      :USHORT  ;
  szName         :aliased CHARACTER   ;      -- [1];
  szFSDName      :aliased CHARACTER   ;      -- [1];
  rgFSAData      :aliased CHARACTER   ;      -- [1];
end record;  -- FSQBUFFER2;
type PFSQBUFFER2 is access all FSQBUFFER2;

type SPOOLATTACH is record    -- Data structure for spooler operations --
  hNmPipe      :USHORT  ;            -- Named pipe handle --
  ulKey        :ULONG   ;              -- Attached key --
end record;  -- SPOOLATTACH;
type PSPOOLATTACH  is access all SPOOLATTACH;

 --    File System Drive Information & gml DosQueryFSInfo DosSetFSInfo              *
     -- FS Drive Info Levels

 FSIL_ALLOC      :constant ulong :=  1; -- Drive allocation info (Query only)
 FSIL_VOLSER     :constant ulong :=  2; -- Drive Volum/Serial info

     -- DosQueryFHType()  Handle classes (low 8 bits of Handle Type)

 FHT_DISKFILE :constant ulong :=  16#0000#; -- Disk file handle
 FHT_CHRDEV   :constant ulong :=  16#0001#; -- Character device handle
 FHT_PIPE     :constant ulong :=  16#0002#; -- Pipe handle

     -- Handle bits (high 8 bits of Handle Type)

 FHB_DSKREMOTE     :constant ulong :=    16#8000#; -- Remote disk
 FHB_CHRDEVREMOTE  :constant ulong :=    16#8000#; -- Remote aliased CHARACTER device
 FHB_PIPEREMOTE    :constant ulong :=    16#8000#; -- Remote pipe

        -- File time and date types --
type FTIME  is record           --  ftime
     twosecs : integer range 0..31;
     minutes : integer range 0..59;
     hours   : integer range 0..23;
end record; --ftime;
Word : constant:=2; -- storage element 2 bytes per word
for  FTIME  use record           --  ftime
  twosecs at 0*Word range  0..4;  -- 5
  minutes at 0*Word range  5..10; -- 6
  hours   at 0*Word range 11..15; -- 5
end record; --ftime;

for FTIME'size use 16;
type PFTIME is access all FTIME;

type  FDATE is record           --  fdate
  day     : integer range 1..31;
  month   : integer range 1..12;
  year    : integer range 0..127;
end record; --fdate;

for  FDATE use record           --  fdate
    day     at 0*Word range  0..4;  --  5;
    month   at 0*Word range  5..8;  --  4;
    year    at 0*Word range  9..15; --  7;
  end record; --fdate;
for FDATE'size use 16;
type PFDATE   is access all FDATE;

type VOLUMELABEL is record      -- vol --
 cch             :BYTE ;
 szVolLabel      :string(1..12);  -- [12];
end record;  -- VOLUMELABEL;
type PVOLUMELABEL  is access all VOLUMELABEL;

type FSINFO   is record     -- fsinf --
 fdateCreation :FDATE       ;
 ftimeCreation :FTIME       ;
 vol           :VOLUMELABEL ;
end record;  -- FSINFO;
type PFSINFO is access all FSINFO;

     -- HANDTYPE values

 HANDTYPE_FILE      :constant ulong :=   16#0000#;
 HANDTYPE_DEVICE    :constant ulong :=   16#0001#;
 HANDTYPE_PIPE      :constant ulong :=   16#0002#;
 HANDTYPE_PROTECTED :constant ulong :=   16#4000#;
 HANDTYPE_NETWORK   :constant ulong :=   16#8000#;

type FILELOCK   is record      -- flock --
   lOffset     :LONG ;
   lRange      :LONG ;
end record;  -- FILELOCK;
type PFILELOCK  is access all FILELOCK;


subtype FHLOCK  is ULONG  ;
type  PFHLOCK is access all FHLOCK;

function  DosSetFileLocks(hFl      :HFILE     ;
                          pflUnlock:PFILELOCK ;
                          pflLock  :PFILELOCK ;
                          timeout  :ULONG     ;
                          flags    :ULONG     ) return apiret;
pragma Import(c,DosSetFileLocks, Link_name=>"_DosSetFileLocks");

function DosProtectSetFileLocks(hFl               :HFILE     ;
                                pflUnlock         :PFILELOCK ;
                                pflLock           :PFILELOCK ;
                                timeout           :ULONG     ;
                                flags             :ULONG     ;
                                fhFileHandleLockID:FHLOCK    ) return apiret;
pragma Import(c,DosProtectSetFileLocks, Link_name=>"_DosProtectSetFileLocks");

function DosCancelLockRequest(hFil   :HFILE     ;
                              pflLock:PFILELOCK )  return apiret;
pragma Import(c,DosCancelLockRequest, Link_name=>"_DosCancelLockRequest");

type FILEFINDBUF  is record     -- findbuf --
   fdateCreation          :USHORT ;
   ftimeCreation          :USHORT ;
   fdateLastAccess        :USHORT ;
   ftimeLastAccess        :USHORT ;
   fdateLastWrite         :USHORT ;
   ftimeLastWrite         :USHORT ;
   cbFile                 :ULONG  ;
   cbFileAlloc            :ULONG  ;
   attrFile               :USHORT ;
   cchName                :UCHAR  ;
   achName                :aliased CHARACTER;
end record;  -- FILEFINDBUF;
type PFILEFINDBUF is access all FILEFINDBUF;

type FILEFINDBUF2 is record    -- findbuf2 --
    fdateCreation          :USHORT;
    ftimeCreation          :USHORT;
    fdateLastAccess        :USHORT;
    ftimeLastAccess        :USHORT;
    fdateLastWrite         :USHORT;
    ftimeLastWrite         :USHORT;
    cbFile                 :ULONG ;
    cbFileAlloc            :ULONG ;
    attrFile               :USHORT;
    cbList                 :ULONG ;
    cchName                :UCHAR ;
    achName                :aliased CHARACTER;
end record;  -- FILEFINDBUF2;
type PFILEFINDBUF2 is access all FILEFINDBUF2;

type FILEFINDBUF3   is record                 -- findbuf3 --
    oNextEntryOffset       :ULONG  ;            -- new field --
    fdateCreation          :USHORT ;
    ftimeCreation          :USHORT ;
    fdateLastAccess        :USHORT ;
    ftimeLastAccess        :USHORT ;
    fdateLastWrite         :USHORT ;
    ftimeLastWrite         :USHORT ;
    cbFile                 :ULONG  ;
    cbFileAlloc            :ULONG  ;
    attrFile               :ULONG  ;              -- widened field --
    cchName                :UCHAR  ;
    achName                :aliased CHARACTER;
end record;  -- FILEFINDBUF3;
type PFILEFINDBUF3 is access all FILEFINDBUF3;

type FILEFINDBUF4  is record      -- findbuf4 --
  oNextEntryOffset         :ULONG   ;            -- new field --
  fdateCreation            :USHORT  ;
  ftimeCreation            :USHORT  ;
  fdateLastAccess          :USHORT  ;
  ftimeLastAccess          :USHORT  ;
  fdateLastWrite           :USHORT  ;
  ftimeLastWrite           :USHORT  ;
  cbFile                   :ULONG   ;
  cbFileAlloc              :ULONG   ;
  attrFile                 :ULONG   ;             -- widened field --
  cbList                   :ULONG   ;
  cchName                  :UCHAR   ;
  achName                  :aliased CHARACTER;
end record;  -- FILEFINDBUF4;
type PFILEFINDBUF4  is access all FILEFINDBUF4;

        -- extended attribute structures --

type GEA  is record         -- gea --
   cbName       :BYTE ;        -- name length not including NULL --
   szName       :aliased CHARACTER   ;     -- attribute name --
end record;  -- GEA;
type PGEA is access all GEA;
type gea_list is array(integer range <>) of gea;
type GEALIST is record     -- geal --
     cbList      :ULONG ;       -- total bytes of structure including full list --
     list        :gea_list(1..1) ; -- [1];  -- variable length GEA structures --
end record;  -- GEALIST;
type PGEALIST  is access all GEALIST;

type FEA   is record        -- fea --
  flEA           :BYTE ;           -- flags                              --
  cbName         :BYTE ;        -- name length not including NULL --
  cbValue        :USHORT ;     -- value length --
end record;  -- FEA;
type PFEA is access all FEA;

        -- flags for FEA.fEA --
--      #define FEA_NEEDEA         16#80     -- need EA bit --

type fea_list is array(integer range <>) of fea;
type FEALIST   is record   -- feal --
 cbList        :ULONG ;       -- total bytes of structure including full list --
 list          :fea_list(1..1); --[1];-- variable length FEA structures --
end record;  -- FEALIST;
type PFEALIST is access all FEALIST;

type EAOP  is record        -- eaop --
   fpGEAList        :PGEALIST ; -- general EA list --
   fpFEAList        :PFEALIST ; -- full EA list --
   oError           :ULONG    ;
end record;  -- EAOP;
type PEAOP is access all EAOP;

type FEA2   is record       -- fea2 --
  oNextEntryOffset         :ULONG   ;    -- new field --
  fEA                      :BYTE    ;
  cbName                   :BYTE    ;
  cbValue                  :USHORT  ;
  szName                   :aliased CHARACTER   ; -- new field --
end record;  -- FEA2;
type PFEA2 is access all FEA2;

type FEA2LIST is record     -- fea2l --
   cbList        :ULONG   ;
   list          :fea2;    -- [1];
end record;  -- FEA2LIST;
type PFEA2LIST is access all FEA2LIST;

type GEA2   is record        -- gea2 --
   oNextEntryOffset         :ULONG  ;     -- new field --
   cbName                   :BYTE   ;
   szName                   :aliased CHARACTER   ;            -- new field --
end record;  -- GEA2;
type PGEA2 is access all GEA2;

type GEA2LIST  is record     -- gea2l --
    cbList         :ULONG ;
    list           :gea2  ; --  [1];
end record;  -- GEA2LIST;
type PGEA2LIST is access all GEA2LIST;

type EAOP2  is record        -- eaop2 --
  fpGEA2             :PGEA2LIST   ;       -- GEA set --
  fpFEA2             :PFEA2LIST   ;       -- FEA set --
  oError             :ULONG       ;       -- offset of FEA error --
end record;  -- EAOP2;
type PEAOP2 is access all EAOP2;

--  Equates for the types of EAs that follow the convention that we have
--  established.

--  Values 16#FFFE# thru 16#8000# are reserved.
--  Values 16#0000# thru 16#7fff# are user definable.
--  Value  16#FFFC# is not used

 EAT_BINARY   :constant ulong:=   16#FFFE#;   -- length preceeded binary
 EAT_ASCII    :constant ulong:=   16#FFFD#;   -- length preceeded ASCII
 EAT_BITMAP   :constant ulong:=   16#FFFB#;   -- length preceeded bitmap
 EAT_METAFILE :constant ulong:=   16#FFFA#;   -- length preceeded metafile
 EAT_ICON     :constant ulong:=   16#FFF9#;   -- length preceeded icon
 EAT_EA       :constant ulong:=   16#FFEE#;   -- length preceeded ASCII
                             -- name of associated data (#include)
 EAT_MVMT     :constant ulong:=   16#FFDF#;   -- multi-valued; multi-typed field
 EAT_MVST     :constant ulong:=   16#FFDE#;   -- multi-valued; single-typed field
 EAT_ASN1     :constant ulong:=   16#FFDD#;   -- ASN.1 field


function  DosOpen(pszFileName  :PSZ ;
                  pHf          :PHFILE;
                  pulAction    :PULONG;
                  cbFile       :ULONG ;
                  ulAttribute  :ULONG ;
                  fsOpenFlags  :ULONG ;
                  fsOpenMode   :ULONG ;
                  peaop_2      :PEAOP2) return apiret;
pragma Import(c,DosOpen, Link_name=>"_DosOpen");

function DosProtectOpen(pszFileName  :PSZ   ;
                        pHf          :PHFILE;
                        pulAction    :PULONG;
                        cbFile       :ULONG ;
                        ulAttribute  :ULONG ;
                        fsOpenFlags  :ULONG ;
                        fsOpenMode   :ULONG ;
                        peaop_2      :PEAOP2;
               pfhFileHandleLockID   :PFHLOCK )return apiret;
pragma Import(c,DosProtectOpen, Link_name=>"_DosProtectOpen");

function   DosClose(hFl:HFILE )return apiret;
pragma Import(c,DosClose, Link_name=>"_DosClose");

function  DosProtectClose(hFl               :HFILE ;
                          fhFileHandleLockID:FHLOCK )return apiret;
pragma Import(c,DosProtectClose, Link_name=>"_DosProtectClose");

function   DosRead(hFl       :HFILE ;
                   pBuffer   :PVOID ;
                   cbRead    :ULONG ;
                    pcbActual:PULONG) return apiret;
pragma Import(c,DosRead, Link_name=>"_DosRead");

function  DosProtectRead(hFl                :HFILE ;
                         pBuffer            :PVOID ;
                         cbRead             :ULONG ;
                          pcbActual         :PULONG;
                          fhFileHandleLockID:FHLOCK) return apiret;
pragma Import(c,DosProtectRead, Link_name=>"_DosProtectRead");

function DosWrite(hFl       :HFILE ;
                  pBuffer   :PVOID ;
                  cbWrite   :ULONG ;
                  pcbActual :PULONG) return apiret;
pragma Import(c,DosWrite, Link_name=>"_DosWrite");

function DosProtectWrite(hFl                :HFILE ;
                         pBuffer            :PVOID ;
                         cbWrite            :ULONG ;
                          pcbActual         :PULONG;
                          fhFileHandleLockID:FHLOCK)  return apiret;
pragma Import(c,DosProtectWrite, Link_name=>"_DosProtectWrite");

     -- File time and date types --

type FILESTATUS is record       -- fsts --
    fdateCreation       :FDATE ;
    ftimeCreation       :FTIME ;
    fdateLastAccess     :FDATE ;
    ftimeLastAccess     :FTIME ;
    fdateLastWrite      :FDATE ;
    ftimeLastWrite      :FTIME ;
    cbFile              :ULONG ;
    cbFileAlloc         :ULONG ;
    attrFile            :USHORT;
end record;  -- FILESTATUS;
type PFILESTATUS is access all FILESTATUS;

type FILESTATUS2 is record     -- fsts2 --

  fdateCreation        :FDATE  ;
  ftimeCreation        :FTIME  ;
  fdateLastAccess      :FDATE  ;
  ftimeLastAccess      :FTIME  ;
  fdateLastWrite       :FDATE  ;
  ftimeLastWrite       :FTIME  ;
  cbFile               :ULONG  ;
  cbFileAlloc          :ULONG  ;
  attrFile             :USHORT ;
  cbList               :ULONG  ;
end record;  -- FILESTATUS2;
type PFILESTATUS2 is access all FILESTATUS2;

type FILESTATUS3 is record      -- fsts3 --
   fdateCreation        :FDATE ;
   ftimeCreation        :FTIME ;
   fdateLastAccess      :FDATE ;
   ftimeLastAccess      :FTIME ;
   fdateLastWrite       :FDATE ;
   ftimeLastWrite       :FTIME ;
   cbFile               :ULONG ;
   cbFileAlloc          :ULONG ;
   attrFile             :ULONG ;
end record;  -- FILESTATUS3;
type PFILESTATUS3 is access all FILESTATUS3;

 type FILESTATUS4  is record       -- fsts4 --
    fdateCreation       :FDATE ;
    ftimeCreation       :FTIME ;
    fdateLastAccess     :FDATE ;
    ftimeLastAccess     :FTIME ;
    fdateLastWrite      :FDATE ;
    ftimeLastWrite      :FTIME ;
    cbFile              :ULONG ;
    cbFileAlloc         :ULONG ;
    attrFile            :ULONG ;
    cbList              :ULONG ;
end record;  -- FILESTATUS4;
type PFILESTATUS4  is access all FILESTATUS4;

type FSALLOCATE is record       -- fsalloc --
   idFileSystem      :ULONG ;
   cSectorUnit       :ULONG ;
   cUnit             :ULONG ;
   cUnitAvail        :ULONG ;
   cbSector          :USHORT;
end record;  -- FSALLOCATE;
type PFSALLOCATE is access all FSALLOCATE;

subtype HDIR is LHANDLE ;        -- hdir --
type PHDIR    is access all HDIR;

--  ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
--  บ#define DosOpen2        DosOpen                           บ
--  บ#define DosFindFirst2   DosFindFirst                      บ
--  บ#define DosQFHandState  DosQueryFHState                   บ
--  บ#define DosProtectQFHandState  DosProtectQueryFHState     บ
--  บ#define DosSetFHandState  DosSetFHState                   บ
--  บ#define DosProtectSetFHandState  DosProtectSetFHState     บ
--  บ#define DosQHandType    DosQueryHType                     บ
--  บ#define DosQFSAttach    DosQueryFSAttach                  บ
--  บ#define DosNewSize      DosSetFileSize                    บ
--  บ#define DosProtectNewSize  DosProtectSetFileSize          บ
--  บ#define DosBufReset     DosResetBuffer                    บ
--  บ#define DosChgFilePtr   DosSetFilePtr                     บ
--  บ#define DosProtectChgFilePtr   DosProtectSetFilePtr       บ
--  บ#define DosMkDir        DosCreateDir                      บ
--  บ#define DosMkDir2       DosCreateDir                      บ
--  บ#define DosRmDir        DosDeleteDir                      บ
--  บ#define DosSelectDisk   DosSetDefaultDisk                 บ
--  บ#define DosQCurDisk     DosQueryCurrentDisk               บ
--  บ#define DosChDir        DosSetCurrentDir                  บ
--  บ#define DosQCurDir      DosQueryCurrentDir                บ
--  บ#define DosQFSInfo      DosQueryFSInfo                    บ
--  บ#define DosQVerify      DosQueryVerify                    บ
--  บ#define DosQFileInfo    DosQueryFileInfo                  บ
--  บ#define DosProtectQFileInfo    DosProtectQueryFileInfo    บ
--  บ#define DosQPathInfo    DosQueryPathInfo                  บ
--  ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

function  DosDelete     (pszFile:PSZ )return apiret;
pragma Import(c,DosDelete, Link_name=>"_DosDelete");

function  DosForceDelete(pszFile:PSZ )return apiret;
pragma Import(c,DosForceDelete, Link_name=>"_DosForceDelete");

function DosDupHandle( hFl :HFILE ;
                       pHfl:PHFILE) return apiret;
pragma Import(c,DosDupHandle, Link_name=>"_DosDupHandle");

function  DosQueryFHState(hFl  :HFILE ;
                          pMode:PULONG) return apiret;
pragma Import(c,DosQueryFHState, Link_name=>"_DosQueryFHState");

function  DosProtectQueryFHState(hFl               :HFILE ;
                                 pMode             :PULONG;
                                 fhFileHandleLockID:FHLOCK) return apiret;
pragma Import(c,DosProtectQueryFHState, Link_name=>"_DosProtectQueryFHState");

function DosSetFHState(hFl :HFILE  ;
                       mode:ULONG ) return apiret;
pragma Import(c,DosSetFHState, Link_name=>"_DosSetFHState");

function DosProtectSetFHState(hFl                :HFILE ;
                              mode               :ULONG ;
                               fhFileHandleLockID:FHLOCK)  return apiret;
pragma Import(c,DosProtectSetFHState, Link_name=>"_DosProtectSetFHState");

function DosQueryHType(hFl   :HFILE ;
                        pType:PULONG;
                        pAttr:PULONG)  return apiret;
pragma Import(c,DosQueryHType, Link_name=>"_DosQueryHType");

function DosFindFirst(pszFileSpec:string ;
                      phd        :PHDIR  ;
                      flAttribute:ULONG  ;
                      pfindbuf   :PVOID  ;
                      cbBuf      :ULONG  ;
                      pcFileNames:PULONG ;
                      ulInfoLevel:ULONG  )  return apiret;
pragma Import(c,DosFindFirst, Link_name=>"_DosFindFirst");

function DosFindNext(hD         :HDIR   ;
                     pfindbuf   :PVOID  ;
                     cbfindbuf  :ULONG  ;
                     pcFilenames:PULONG ) return apiret;
pragma Import(c,DosFindNext, Link_name=>"_DosFindNext");

function  DosFindClose(hD :HDIR) return apiret;
pragma Import(c,DosFindClose, Link_name=>"_DosFindClose");

function  DosFSAttach(pszDevice    :PSZ  ;
                      pszFilesystem:PSZ  ;
                       pData       :PVOID;
                       cbData      :ULONG;
                       flag        :ULONG) return apiret;
pragma Import(c,DosFSAttach, Link_name=>"_DosFSAttach");

function DosQueryFSAttach(pszDeviceName :PSZ         ;
                          ulOrdinal     :ULONG       ;
                          ulFSAInfoLevel:ULONG       ;
                          pfsqb         :PFSQBUFFER2 ;
                          pcbBuffLength :PULONG      ) return apiret;
pragma Import(c,DosQueryFSAttach, Link_name=>"_DosQueryFSAttach");

function  DosFSCtl(pData   :PVOID  ;
                   cbData  :ULONG  ;
                   pcbData :PULONG ;
                   pParms  :PVOID  ;
                   cbParms :ULONG  ;
                   pcbParms:PULONG ;
                   func    :ULONG  ;
                   pszRoute:PSZ    ;
                   hFl     :HFILE  ;
                   method  :ULONG  ) return apiret;
pragma Import(c,DosFSCtl, Link_name=>"_DosFSCtl");

function DosSetFileSize(hFl   :HFILE ;
                        cbSize:ULONG ) return apiret;
pragma Import(c,DosSetFileSize, Link_name=>"_DosSetFileSize");

function DosProtectSetFileSize(hFl                :HFILE ;
                               cbSize             :ULONG ;
                                fhFileHandleLockID:FHLOCK) return apiret;
pragma Import(c,DosProtectSetFileSize, Link_name=>"_DosProtectSetFileSize");

function  DosResetBuffer(hFl:HFILE) return apiret;
pragma Import(c,DosResetBuffer, Link_name=>"_DosResetBuffer");

function DosSetFilePtr(hFl      :HFILE ;
                       ib       :LONG  ;
                       method   :ULONG ;
                       ibActual :PULONG) return apiret;
pragma Import(c,DosSetFilePtr, Link_name=>"_DosSetFilePtr");

function  DosProtectSetFilePtr(hFl               :HFILE  ;
                               ib                :LONG   ;
                               method            :ULONG  ;
                               ibActual          :PULONG ;
                               fhFileHandleLockID:FHLOCK ) return apiret;
pragma Import(c,DosProtectSetFilePtr, Link_name=>"_DosProtectSetFilePtr");

function  DosMove(pszOld:PSZ ;
                  pszNew:PSZ ) return apiret;
pragma Import(c,DosMove, Link_name=>"_DosMove");

function  DosCopy(pszOld:PSZ   ;
                  pszNew:PSZ   ;
                  option:ULONG ) return apiret;
pragma Import(c,DosCopy, Link_name=>"_DosCopy");

function DosEditName(metalevel:ULONG ;
                     pszSource:PSZ   ;
                     pszEdit  :PSZ   ;
                     pszTarget:PBYTE ;
                     cbTarget :ULONG ) return apiret;
pragma Import(c,DosEditName, Link_name=>"_DosEditName");

function DosCreateDir(pszDirName:PSZ    ;
                      op2       :PEAOP2 ) return apiret;
pragma Import(c,DosCreateDir, Link_name=>"_DosCreateDir");

function  DosDeleteDir(pszDir:PSZ ) return apiret;
pragma Import(c,DosDeleteDir, Link_name=>"_DosDeleteDir");

function DosSetDefaultDisk(disknum:ULONG ) return apiret;
pragma Import(c,DosSetDefaultDisk, Link_name=>"_DosSetDefaultDisk");

function  DosQueryCurrentDisk(pdisknum:PULONG ;
                              plogical:PULONG ) return apiret;
pragma Import(c,DosQueryCurrentDisk, Link_name=>"_DosQueryCurrentDisk");

function  DosSetCurrentDir( pszDir:PSZ) return apiret;
pragma Import(c,DosSetCurrentDir, Link_name=>"_DosSetCurrentDir");

function DosQueryCurrentDir(disknum:ULONG ;
                            pBuf   :PBYTE ;
                             pcbBuf:PULONG) return apiret;
pragma Import(c,DosQueryCurrentDir, Link_name=>"_DosQueryCurrentDir");

function DosQueryFSInfo(disknum  :ULONG ;
                        infolevel:ULONG ;
                        pBuf     :PVOID ;
                        cbBuf    :ULONG ) return apiret;
pragma Import(c,DosQueryFSInfo, Link_name=>"_DosQueryFSInfo");

function DosSetFSInfo(disknum  :ULONG ;
                      infolevel:ULONG ;
                      pBuf     :PVOID ;
                      cbBuf    :ULONG ) return apiret;
pragma Import(c,DosSetFSInfo, Link_name=>"_DosSetFSInfo");

function  DosQueryVerify(pBl:PBOOL32 ) return apiret;
pragma Import(c,DosQueryVerify, Link_name=>"_DosQueryVerify");

function  DosSetVerify(Bl:BOOL32) return apiret;
pragma Import(c,DosSetVerify, Link_name=>"_DosSetVerify");

function DosSetMaxFH(cFH:ULONG ) return apiret;
pragma Import(c,DosSetMaxFH, Link_name=>"_DosSetMaxFH");

function DosSetRelMaxFH(pcbReqCount:PLONG  ;
                        pcbCurMaxFH:PULONG ) return apiret;
pragma Import(c,DosSetRelMaxFH, Link_name=>"_DosSetRelMaxFH");

function  DosQueryFileInfo(hf         :HFILE ;
                           ulInfoLevel:ULONG ;
                           pInfo      :PVOID ;
                           cbInfoBuf  :ULONG ) return apiret;
pragma Import(c,DosQueryFileInfo, Link_name=>"_DosQueryFileInfo");

function  DosProtectQueryFileInfo(hf                :HFILE;
                                  ulInfoLevel       :ULONG;
                                  pInfo             :PVOID;
                                  cbInfoBuf         :ULONG;
                                  fhFileHandleLockID:FHLOCK) return apiret;
pragma Import(c,DosProtectQueryFileInfo, Link_name=>"_DosProtectQueryFileInfo");

function  DosSetFileInfo(hf         :HFILE ;
                         ulInfoLevel:ULONG ;
                         pInfoBuf   :PVOID ;
                         cbInfoBuf  :ULONG ) return apiret;
pragma Import(c,DosSetFileInfo, Link_name=>"_DosSetFileInfo");

function  DosProtectSetFileInfo(hf                 :HFILE ;
                                ulInfoLevel        :ULONG ;
                                pInfoBuf           :PVOID ;
                                cbInfoBuf          :ULONG ;
                                 fhFileHandleLockID:FHLOCK) return apiret;
pragma Import(c,DosProtectSetFileInfo, Link_name=>"_DosProtectSetFileInfo");

function DosQueryPathInfo(pszPathName:PSZ   ;
                          ulInfoLevel:ULONG ;
                          pInfoBuf   :PVOID ;
                          cbInfoBuf  :ULONG )  return apiret;
pragma Import(c,DosQueryPathInfo, Link_name=>"_DosQueryPathInfo");

function  DosSetPathInfo(pszPathName:PSZ   ;
                         ulInfoLevel:ULONG ;
                         pInfoBuf   :PVOID ;
                         cbInfoBuf  :ULONG ;
                         flOptions  :ULONG ) return apiret;
pragma Import(c,DosSetPathInfo, Link_name=>"_DosSetPathInfo");

     -- defines for DosSetPathInfo -pathinfo flag --
--   #define DSPI_WRTTHRU    16#10    -- write through --

function DosShutdown(ulReserved:ULONG )  return apiret;
pragma Import(c,DosShutdown, Link_name=>"_DosShutdown");

function DosEnumAttribute(ulRefType  :ULONG  ;
                          pvFile     :PVOID  ;
                          ulEntry    :ULONG  ;
                          pvBuf      :PVOID  ;
                          cbBuf      :ULONG  ;
                          pulCount   :PULONG ;
                          ulInfoLevel:ULONG  ) return apiret;
pragma Import(c,DosEnumAttribute, Link_name=>"_DosEnumAttribute");

function  DosProtectEnumAttribute(ulRefType           :ULONG ;
                                  pvFile              :PVOID ;
                                  ulEntry             :ULONG ;
                                  pvBuf               :PVOID ;
                                  cbBuf               :ULONG ;
                                   pulCount           :PULONG;
                                  ulInfoLevel         :ULONG ;
                                  fhFileHandleLockId  :FHLOCK)return apiret;
pragma Import(c,DosProtectEnumAttribute, Link_name=>"_DosProtectEnumAttribute");

type DENA1 is record -- dena1 level 1 info returned from DosEnumAttribute --
     reserved   :UCHAR       ;       -- 0 --
     cbName     :UCHAR       ;         -- length of name exculding NULL --
     cbValue    :USHORT      ;        -- length of value --
     szName     :aliased CHARACTER   ;       --[1]; -- variable length asciiz name --
end record;  -- DENA1;
type PDENA1 is access all DENA1;

subtype DENA2  is FEA2 ;
subtype PDENA2 is PFEA2 ;

     -- Infolevels for DosEnumAttribute
ENUMEA_LEVEL_NO_VALUE :constant ulong:=  1; -- FEA without value

     -- Reference types for DosEnumAttribute

 ENUMEA_REFTYPE_FHANDLE :constant ulong := 0 ;      -- file handle
 ENUMEA_REFTYPE_PATH    :constant ulong := 1 ;      -- path name
 ENUMEA_REFTYPE_MAX     :constant ulong := 1 ;

end Os2.Fm;
