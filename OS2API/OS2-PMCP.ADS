 -- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 -- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
 -- บ            S O F T W A R E                           ศอสอผ        บ
 -- บ                                                                   บ
 -- บ        Package      OS2.PMcp                                      บ
 -- บ                                                                   บ
 -- บ        Author :  Leonid Dulman     1995 , 1996                    บ
 -- บ                                                                   บ
 -- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
 -- บ                                                                   บ
 -- บ                     Shell API                                     บ
 -- บ                     OS2.INI Access functions                      บ
 -- บ                     Heap Manager Interface                        บ
 -- บ                     Atom Manager Interface                        บ
 -- บ                   Get/Set Error Information Interface             บ
 -- บ                   Dynamic Data Exchange ( DDE) Routines           บ
 -- บ                   Load/Delete Library/Procedure                   บ
 -- บ                     Desktop API definitions                       บ
 -- บ                     Palette Manager API definition                บ
 -- บ                                                                   บ
 -- บ                                                                   บ
 -- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

 package Os2.PMcp is
 pragma Preelaborate (PMcp);

--    Include Shell API
 subtype HPROGRAM is LHANDLE ;       -- hprog
 type PHPROGRAM  is access all HPROGRAM;
 subtype HAPP  is LHANDLE ;
 subtype HINI  is LHANDLE ;
 type PHINI  is access all HINI;

 type PRFPROFILE  is record    -- prfpro
    cchUserName  :ULONG  ;
    pszUserName  :PSZ    ;
    cchSysName   :ULONG  ;
    pszSysName   :PSZ    ;
 end record; -- PRFPROFILE;
 type PPRFPROFILE  is access all PRFPROFILE;

       MAXNAMEL:constant:=60;     --   maximum title length
       MAXPATHL:constant:= 128;   -- maximum path length

    -- program list section
       -- root group handle

 type HPROGARRAY  is record       -- hpga
   ahprog      :HPROGRAM ; --  [1];
 end record; -- HPROGARRAY;
 type PHPROGARRAY  is access all HPROGARRAY;

 type PROGCATEGORY  is access function return ULONG ;       -- progc

 subtype PPROGCATEGORY  is PROGCATEGORY;

    -- values acceptable for PROGCATEGORY for PM groups
 --  PROG_DEFAULT             (PROGCATEGORY)0
 --  PROG_FULLSCREEN          (PROGCATEGORY)1
 --  PROG_WINDOWABLEVIO       (PROGCATEGORY)2
 --  PROG_PM                  (PROGCATEGORY)3
 --  PROG_GROUP               (PROGCATEGORY)5
 --  PROG_REAL                (PROGCATEGORY)4
 --  PROG_VDM                 (PROGCATEGORY)4
 --  PROG_WINDOWEDVDM         (PROGCATEGORY)7
 --  PROG_DLL                 (PROGCATEGORY)6
 --  PROG_PDD                 (PROGCATEGORY)8
 --  PROG_VDD                 (PROGCATEGORY)9
 --  PROG_WINDOW_REAL         (PROGCATEGORY)10
 --  PROG_WINDOW_PROT         (PROGCATEGORY)11
 --  PROG_30_STD              (PROGCATEGORY)11
 --  PROG_WINDOW_AUTO         (PROGCATEGORY)12
 --  PROG_SEAMLESSVDM         (PROGCATEGORY)13
 --  PROG_30_STDSEAMLESSVDM   (PROGCATEGORY)13
 --  PROG_SEAMLESSCOMMON      (PROGCATEGORY)14
 --  PROG_30_STDSEAMLESSCOMMON (PROGCATEGORY)14
 --  PROG_31_STDSEAMLESSVDM   (PROGCATEGORY)15
 --  PROG_31_STDSEAMLESSCOMMON (PROGCATEGORY)16
 --  PROG_31_ENHSEAMLESSVDM   (PROGCATEGORY)17
 --  PROG_31_ENHSEAMLESSCOMMON (PROGCATEGORY)18
 --  PROG_31_ENH              (PROGCATEGORY)19
 --  PROG_31_STD              (PROGCATEGORY)20
 --  PROG_RESERVED            (PROGCATEGORY)255

 type PROGTYPE  is record         -- progt
     progc        :PPROGCATEGORY ;
     fbVisible    :ULONG         ;
 end record; -- PROGTYPE;
 type PPROGTYPE  is access all PROGTYPE;

 --       visibility flag for PROGTYPE structure

 SHE_VISIBLE         :constant Long:= 16#00#;
 SHE_INVISIBLE       :constant Long:= 16#01#;
 SHE_RESERVED        :constant Long:= 16#FF#;

 --       Protected group flag for PROGTYPE structure
 SHE_UNPROTECTED     :constant Long:= 16#00#;
 SHE_PROTECTED       :constant Long:= 16#02#;

 --       Structures associated with 'Prf' calls

 type PROGDETAILS  is record    -- progde
   Length              :ULONG      ;         -- set this to sizeof(PROGDETAILS)
   progt               :PPROGTYPE  ;
   pszTitle            :PSZ        ;       -- any of the pointers can be NULL
   pszExecutable       :PSZ        ;
   pszParameters       :PSZ        ;
   pszStartupDir       :PSZ        ;
   pszIcon             :PSZ        ;
   pszEnvironment      :PSZ        ; -- this is terminated by  /0/0
   swpInitial          :SWP        ;     -- this replaces XYWINSIZE
 end record; -- PROGDETAILS;
 type PPROGDETAILS  is access all PROGDETAILS;

 type PROGTITLE  is record             -- progti
    hprog        :HPROGRAM  ;
    progt        :PPROGTYPE ;
    pszTitle     :PSZ       ;
 end record; -- PROGTITLE;
 type PPROGTITLE  is access all PROGTITLE;

       -- Program List API Function Definitions
       -- Program List API available 'Prf' calls

 function PrfQueryProgramTitles(hin         :HINI       ;
                                hprogGroup  :HPROGRAM   ;
                                pTitles     :PPROGTITLE ;
                                cchBufferMax:ULONG      ;
                                pulCount    :PULONG     )return ULONG;
 pragma Import(c,PrfQueryProgramTitles, Link_name=>"PrfQueryProgramTitles");

       --
       --  NOTE: string information is concatanated after the array of
       --        PROGTITLE structures so you need to allocate storage
       --        greater than sizeof(PROGTITLE)cPrograms to query programs
       --        in a group.
       --
       --  PrfQueryProgramTitles recommended usage to obtain titles of all
       --  programs in a group (Hgroup=SGH_ROOT is for all groups):
       --
       --  BufLen = PrfQueryProgramTitles(Hini; Hgroup;
       --                                  (PPROGTITLE)NULL; 0; &Count)return ULONG;
       --
       --  Alocate buffer of  Buflen
       --
       --  Len = PrfQueryProgramTitles(Hini; Hgroup; (PPROGTITLE)pBuffer;
       --                               BufLen; pCount)return ULONG;
       --
       --

 function PrfAddProgram(hin       :HINI         ;
                        pDetails  :PPROGDETAILS ;
                        hprogGroup:HPROGRAM     )return HPROGRAM;
 pragma Import(c,PrfAddProgram, Link_name=>"PrfAddProgram");

 function PrfChangeProgram(hin     :HINI         ;
                           hprog   :HPROGRAM     ;
                           pDetails:PPROGDETAILS )return BOOL;
 pragma Import(c,PrfChangeProgram, Link_name=>"PrfChangeProgram");

 function PrfQueryDefinition(hin         :HINI         ;
                             hprog       :HPROGRAM     ;
                             pDetails    :PPROGDETAILS ;
                             cchBufferMax:ULONG        )return ULONG;
 pragma Import(c,PrfQueryDefinition, Link_name=>"PrfQueryDefinition");

       --
       --  NOTE: string information is concatanated after the PROGDETAILS
       --        field structure so you need to allocate storage greater
       --        than sizeof(PROGDETAILS) to query programs
       --
       --  PrfQueryDefinition recomended usage:
       --
       --  bufferlen = PrfQueryDefinition(Hini;Hprog;(PPROGDETAILS)NULL;0)
       --
       --  Alocate buffer of bufferlen bytes
       --  set Length field (0 will be supported)
       --
       --  (PPROGDETAILS)pBuffer->Length=sizeof(PPROGDETAILS)
       --
       --  len = PrfQueryDefinition(Hini; Hprog; (PPROGDETAILS)pBuffer;
       --      bufferlen)
       --

 function PrfRemoveProgram(hin  :HINI     ;
                           hprog:HPROGRAM )return BOOL ;
 pragma Import(c,PrfRemoveProgram, Link_name=>"PrfRemoveProgram");

 function PrfQueryProgramHandle(hin         :HINI        ;
                                pszExe      :PSZ         ;
                        phprogArr   :PHPROGARRAY ;
                                cchBufferMax:ULONG       ;
                                pulCount    :PULONG      )return ULONG;
 pragma Import(c,PrfQueryProgramHandle, Link_name=>"PrfQueryProgramHandle");

 function PrfCreateGroup(hin         :HINI  ;
                         pszTitle    :PSZ   ;
                         chVisibility:UCHAR )return HPROGRAM;
 pragma Import(c,PrfCreateGroup, Link_name=>"PrfCreateGroup");

 function PrfDestroyGroup(hin       :HINI     ;
                          hprogGroup:HPROGRAM )return BOOL ;
 pragma Import(c,PrfDestroyGroup, Link_name=>"PrfDestroyGroup");

 function PrfQueryProgramCategory(hin   :HINI ;
                                  pszExe:PSZ  )return PROGCATEGORY  ;
 pragma Import(c,PrfQueryProgramCategory, Link_name=>"PrfQueryProgramCategory");

 function WinStartApp(hwndNotify:HWND         ;
                      pDetails  :PPROGDETAILS ;
                      pszParams :PSZ          ;
                      Reserved  :PVOID        ;
                      fbOptions :ULONG        )return HAPP ;
 pragma Import(c,WinStartApp, Link_name=>"_WinStartApp");

       -- bit values for Options parameter
  SAF_VALIDFLAGS        :constant Long:= 16#001F#;
  SAF_INSTALLEDCMDLINE  :constant Long:= 16#0001#;   -- use installed parameters
  SAF_STARTCHILDAPP     :constant Long:= 16#0002#;   -- related application
  SAF_MAXIMIZED         :constant Long:= 16#0004#;   -- Start App maximized
  SAF_MINIMIZED         :constant Long:= 16#0008#;   -- Start App minimized; if !SAF_MAXIMIZED
  SAF_BACKGROUND        :constant Long:= 16#0010#;   -- Start app in the background

 function WinTerminateApp(hap:HAPP )return BOOL ;
 pragma Import(c,WinTerminateApp, Link_name=>"_WinTerminateApp");

 -- switch list section

 subtype  HSWITCH is LHANDLE ;        -- hsw
 type PHSWITCH  is access all HSWITCH;

 type SWCNTRL   is record         -- swctl
    hwn               :HWND     ;
    hwndIcon          :HWND     ;
    hprog             :HPROGRAM ;
    idProcess         :PID      ;
    idSession         :ULONG    ;
    uchVisibility     :ULONG    ;
    fbJump            :ULONG    ;
    szSwtitle         :Astring(1..MAXNAMEL+4);
    bProgType         :ULONG    ;
 end record; -- SWCNTRL;
 type PSWCNTRL  is access all SWCNTRL;

       -- visibility flag for SWCNTRL structure
 SWL_VISIBLE    :constant ULong:= 16#04#;
 SWL_INVISIBLE  :constant ULong:= 16#01#;
 SWL_GRAYED     :constant ULong:= 16#02#;

       -- jump flag for SWCNTRL structure
 SWL_JUMPABLE    :constant ULong:= 16#02#;
 SWL_NOTJUMPABLE :constant ULong:= 16#01#;


       -- Switching Program functions

 function WinAddSwitchEntry(psw:PSWCNTRL)return HSWITCH ;
 pragma Import(c,WinAddSwitchEntry, Link_name=>"_WinAddSwitchEntry");

 function WinRemoveSwitchEntry(hsw:HSWITCH)return ULONG;
 pragma Import(c,WinRemoveSwitchEntry, Link_name=>"_WinRemoveSwitchEntry");

 type SWENTRY   is record         -- swent
     switch     :HSWITCH ;
     swctl      :SWCNTRL ;
 end record; -- SWENTRY;
 type PSWENTRY  is access all SWENTRY;

 type SWBLOCK    is record        -- swblk
     cswentry    :ULONG   ;
     aswentry    :SWENTRY ;        --  [1];
 end record; -- SWBLOCK;
 type PSWBLOCK  is access all SWBLOCK;

       -- 32-bit versions of these APIs have 32-bit parameters

 function WinChangeSwitchEntry(hswitchSwitch   :HSWITCH  ;
                               pswctlSwitchData:PSWCNTRL )return ULONG;
 pragma Import(c,WinChangeSwitchEntry, Link_name=>"_WinChangeSwitchEntry");

 function WinCreateSwitchEntry(ha              :HAB      ;
                               pswctlSwitchData:PSWCNTRL )return  HSWITCH;
 pragma Import(c,WinCreateSwitchEntry, Link_name=>"_WinCreateSwitchEntry");

 function WinQuerySessionTitle(ha        :HAB   ;
                               usSession :ULONG ;
                               pszTitle  :PSZ   ;
                               usTitlelen:ULONG )return ULONG;
 pragma Import(c,WinQuerySessionTitle, Link_name=>"_WinQuerySessionTitle");

 function WinQuerySwitchEntry(hswitchSwitch   :HSWITCH  ;
                              pswctlSwitchData:PSWCNTRL )return ULONG;
 pragma Import(c,WinQuerySwitchEntry, Link_name=>"_WinQuerySwitchEntry");

 function WinQuerySwitchHandle(hwn       :HWND ;
                               pidProcess:PID  )return HSWITCH  ;
 pragma Import(c,WinQuerySwitchHandle, Link_name=>"_WinQuerySwitchHandle");

 function WinQuerySwitchList(ha                 :HAB      ;
                             pswblkSwitchEntries:PSWBLOCK ;
                             usDataLength       :ULONG    )return ULONG;
 pragma Import(c,WinQuerySwitchList, Link_name=>"_WinQuerySwitchList");

 function WinQueryTaskSizePos(ha              :HAB   ;
                              usScreenGroup   :ULONG ;
                              pswpPositionData:PSWP  )return ULONG;
 pragma Import(c,WinQueryTaskSizePos, Link_name=>"_WinQueryTaskSizePos");

 function WinQueryTaskTitle(usSession :ULONG ;
                            pszTitle  :PSZ   ;
                            usTitlelen:ULONG )return ULONG;
 pragma Import(c,WinQueryTaskTitle, Link_name=>"_WinQueryTaskTitle");

 function WinSwitchToProgram(hswitchSwHandle:HSWITCH )return ULONG;
 pragma Import(c,WinSwitchToProgram, Link_name=>"_WinSwitchToProgram");

       -- OS2.INI Access functions

 function PrfSuspendWriteToDisk(hin     :HINI ;
                                fSuspend:BOOL )return BOOL;
 pragma Import(c,PrfSuspendWriteToDisk, Link_name=>"PrfSuspendWriteToDisk");

 function PrfQueryProfileInt(hin     :HINI  ;
                             pszApp  :PSZ   ;
                             pszKey  :PSZ   ;
                             sDefault:LONG  )return LONG;
 pragma Import(c,PrfQueryProfileInt, Link_name=>"PrfQueryProfileInt");

 function PrfQueryProfileString(hin         :HINI  ;
                                pszApp      :PSZ   ;
                                pszKey      :PSZ   ;
                                pszDefault  :PSZ   ;
                                pBuffer     :PVOID ;
                                cchBufferMax:ULONG )return ULONG;
 pragma Import(c,PrfQueryProfileString, Link_name=>"PrfQueryProfileString");

 function PrfWriteProfileString(hin    :HINI ;
                                pszApp :PSZ  ;
                                pszKey :PSZ  ;
                                pszData:PSZ  )return BOOL ;
 pragma Import(c,PrfWriteProfileString, Link_name=>"PrfWriteProfileString");

 function PrfQueryProfileSize(hin      :HINI   ;
                              pszApp   :PSZ    ;
                              pszKey   :PSZ    ;
                              pulReqLen:PULONG )return BOOL ;
 pragma Import(c,PrfQueryProfileSize, Link_name=>"PrfQueryProfileSize");

 function PrfQueryProfileData(hin       :HINI   ;
                              pszApp    :PSZ    ;
                              pszKey    :PSZ    ;
                              pBuffer   :PVOID  ;
                              pulBuffLen:PULONG )return BOOL ;
 pragma Import(c,PrfQueryProfileData, Link_name=>"PrfQueryProfileData");

 function PrfWriteProfileData(hin       :HINI  ;
                              pszApp    :PSZ   ;
                              pszKey    :PSZ   ;
                              pData     :PVOID ;
                              cchDataLen:ULONG )return BOOL ;
 pragma Import(c,PrfWriteProfileData, Link_name=>"PrfWriteProfileData");

 function PrfOpenProfile(ha         :HAB ;
                         pszFileName:PSZ  )return HINI;
 pragma Import(c,PrfOpenProfile, Link_name=>"PrfOpenProfile");

 function PrfCloseProfile(hin :HINI )return BOOL ;
 pragma Import(c,PrfCloseProfile, Link_name=>"PrfCloseProfile");

 function PrfReset(ha         :HAB         ;
                   pPrfProfl  :PPRFPROFILE )return BOOL;
 pragma Import(c,PrfReset, Link_name=>"PrfReset");

 function PrfQueryProfile(ha         :HAB         ;
                          pPrfProfl  :PPRFPROFILE )return BOOL ;
 pragma Import(c,PrfQueryProfile, Link_name=>"PrfQueryProfile");

function WinQueryCp(hm:HMQ)return ULONG ;
pragma Import(c,WinQueryCp, Link_name=>"_WinQueryCp");

function WinSetCp(hm        :HMQ   ;
                  idCodePage:ULONG )return BOOL32;
pragma Import(c,WinSetCp, Link_name=>"_WinSetCp");

function WinQueryCpList(ha    :HAB    ;
                        ccpMax:ULONG  ;
                        prgcp :PULONG )return ULONG ;
pragma Import(c,WinQueryCpList, Link_name=>"_WinQueryCpList");

function WinCpTranslateString(ha        :HAB   ;
                              cpSrc     :ULONG ;
                              pszSrc    :PSZ   ;
                              cpDst     :ULONG ;
                              cchDestMax:ULONG ;
                              pchDest   :PSZ   )return BOOL32;
pragma Import(c,WinCpTranslateString, Link_name=>"_WinCpTranslateString");

function WinCpTranslateChar(ha   :HAB   ;
                            cpSrc:ULONG ;
                            chSrc:UCHAR ;
                            cpDst:ULONG )return UCHAR  ;
pragma Import(c,WinCpTranslateChar, Link_name=>"_WinCpTranslateChar");

function WinUpper(ha  :HAB   ;
                  idcp:ULONG ;
                  idcc:ULONG ;
                  ps  :PSZ   )return ULONG ;
pragma Import(c,WinUpper, Link_name=>"_WinUpper");

function WinUpperChar(ha  :HAB   ;
                      idcp:ULONG ;
                      idcc:ULONG ;
                      c   :ULONG )return ULONG ;
pragma Import(c,WinUpperChar, Link_name=>"_WinUpperChar");

function WinNextChar(ha  :HAB   ;
                     idcp:ULONG ;
                     idcc:ULONG ;
                     ps  :PSZ   )return PSZ;
pragma Import(c,WinNextChar, Link_name=>"_WinNextChar");

function WinPrevChar(ha      :HAB   ;
                     idcp    :ULONG ;
                     idcc    :ULONG ;
                     pszStart:PSZ   ;
                     ps      :PSZ   )return PSZ;
pragma Import(c,WinPrevChar, Link_name=>"_WinPrevChar");

function WinCompareStrings(ha      :HAB   ;
                           idcp    :ULONG ;
                           idcc    :ULONG ;
                           psz1    :PSZ   ;
                           psz2    :PSZ   ;
                           reserved:ULONG )return ULONG ;
pragma Import(c,WinCompareStrings, Link_name=>"_WinCompareString");

 WCS_ERROR :constant Long:= 0 ;
 WCS_EQ    :constant Long:= 1 ;
 WCS_LT    :constant Long:= 2 ;
 WCS_GT    :constant Long:= 3 ;

--     Heap Manager Interface declarations
--     Atom Manager Interface declarations

subtype  HATOMTBL is  LHANDLE;
subtype  ATOM     is  ULONG  ;

function WinQuerySystemAtomTable return HATOMTBL;
pragma Import(c,WinQuerySystemAtomTable, Link_name=>"_WinQuerySystemAtomTable");

function WinCreateAtomTable(cbInitial:ULONG ;
                            cBuckets :ULONG )return HATOMTBL;
pragma Import(c,WinCreateAtomTable, Link_name=>"_WinCreateAtomTable");

function WinDestroyAtomTable(AtomTbl:HATOMTBL )return HATOMTBL;
pragma Import(c,WinDestroyAtomTable, Link_name=>"_WinDestroyAtomTable");

function WinAddAtom(AtomTbl    :HATOMTBL  ;
                    pszAtomName:PSZ       )return ATOM;
pragma Import(c,WinAddAtom, Link_name=>"_WinAddAtom");

function WinFindAtom(AtomTbl    :HATOMTBL ;
                     pszAtomName:PSZ      )return ATOM;
pragma Import(c,WinFindAtom, Link_name=>"_WinFindAtom");

function WinDeleteAtom(AtomTbl:HATOMTBL ;
                       atm    :ATOM     )return ATOM;
pragma Import(c,WinDeleteAtom, Link_name=>"_WinDeleteAtom");

function WinQueryAtomUsage(AtomTbl:HATOMTBL ;
                           atm    :ATOM     )return ULONG;
pragma Import(c,WinQueryAtomUsage, Link_name=>"_WinQueryAtomUsage");

function WinQueryAtomLength(AtomTbl:HATOMTBL ;
                            atm    :ATOM     )return ULONG;
pragma Import(c,WinQueryAtomLength, Link_name=>"_WinQueryAtomLength");

function WinQueryAtomName(AtomTbl     :HATOMTBL ;
                          atm         :ATOM     ;
                          pchBuffer   :PSZ      ;
                          cchBufferMax:ULONG    )return ULONG;
pragma Import(c,WinQueryAtomName, Link_name=>"_WinQueryAtomName");

--     Error codes for debugging support
--      16#1001#  16#1021#  16#1034#  16#1036#  16#1050# are reserved

 WINDBG_HWND_NOT_DESTROYED           :constant Long:= 16#1022#;
 WINDBG_HPTR_NOT_DESTROYED           :constant Long:= 16#1023#;
 WINDBG_HACCEL_NOT_DESTROYED         :constant Long:= 16#1024#;
 WINDBG_HENUM_NOT_DESTROYED          :constant Long:= 16#1025#;
 WINDBG_VISRGN_SEM_BUSY              :constant Long:= 16#1026#;
 WINDBG_USER_SEM_BUSY                :constant Long:= 16#1027#;
 WINDBG_DC_CACHE_BUSY                :constant Long:= 16#1028#;
 WINDBG_HOOK_STILL_INSTALLED         :constant Long:= 16#1029#;
 WINDBG_WINDOW_STILL_LOCKED          :constant Long:= 16#102a#;
 WINDBG_UPDATEPS_ASSERTION_FAIL      :constant Long:= 16#102b#;
 WINDBG_SENDMSG_WITHIN_USER_SEM      :constant Long:= 16#102c#;
 WINDBG_USER_SEM_NOT_ENTERED         :constant Long:= 16#102d#;
 WINDBG_PROC_NOT_EXPORTED            :constant Long:= 16#102e#;
 WINDBG_BAD_SENDMSG_HWND             :constant Long:= 16#102f#;
 WINDBG_ABNORMAL_EXIT                :constant Long:= 16#1030#;
 WINDBG_INTERNAL_REVISION            :constant Long:= 16#1031#;
 WINDBG_INITSYSTEM_FAILED            :constant Long:= 16#1032#;
 WINDBG_HATOMTBL_NOT_DESTROYED       :constant Long:= 16#1033#;
 WINDBG_WINDOW_UNLOCK_WAIT           :constant Long:= 16#1035#;

--     Get/Set Error Information Interface declarations

type ERRINFO   is record   -- erri
    cbFixedErrInfo   :ULONG   ;
    idError          :ERRORID ;
    cDetailLevel     :ULONG   ;
    offaoffszMsg     :ULONG   ;
    offBinaryData    :ULONG   ;
end record; -- ERRINFO;
type PERRINFO  is access all ERRINFO;

function   WinGetLastError( ha :HAB)return ERRORID ;
pragma Import(c,WinGetLastError, Link_name=>"_WinGetLastError");

function   WinGetErrorInfo(ha :HAB )return PERRINFO;
pragma Import(c,WinGetErrorInfo, Link_name=>"_WinGetErrorInfo");

function  WinFreeErrorInfo(erinfo:PERRINFO )return BOOL32;
pragma Import(c,WinFreeErrorInfo, Link_name=>"_WinFreeErrorInfo");

--     -- include WinSetErrorInfo
--
--  ERRORID APIENTRY WinSetErrorInfo(ERRORID,
--                                   ULONG,
--                                   ...);

 SEI_BREAKPOINT   :constant Long:= 16#8000#;--Always enter an INT 3 breakpt
 SEI_NOBEEP       :constant Long:= 16#4000#;--Do not call DosBeep
 SEI_NOPROMPT     :constant Long:= 16#2000#;--Do not prompt the user
 SEI_DBGRSRVD     :constant Long:= 16#1000#;--Reserved for debug use
--   SEI_DEBUGONLY    (SEI_BREAKPOINT | SEI_NOBEEP | SEI_NOPROMPT | SEI_RESERVED)
--
 SEI_STACKTRACE   :constant Long:= 16#0001#;--save the stack trace
 SEI_REGISTERS    :constant Long:= 16#0002#;--save the registers
 SEI_ARGCOUNT     :constant Long:= 16#0004#;--first USHORT in args is arg count
 SEI_DOSERROR     :constant Long:= 16#0008#;--first USHORT in args is OS2 error code
 SEI_RESERVED     :constant Long:= 16#0FE0#;--Reserved for future use

--   Note that when SEI_ARGCOUNT, SEI_DOSERROR are specified
--   together, then the implied order of the parameters is:
--
--    WinSetErrorInfo( MAKEERRORID( .... ),
--                     SEI_ARGCOUNT | SEI_DOSERROR,
--                     argCount,
--                     dosErrorCode);
--
--        DDE standard system topic and item strings
--
SZDDESYS_TOPIC            :constant string:= "System"        ;
SZDDESYS_ITEM_TOPICS      :constant string:= "Topics"        ;
SZDDESYS_ITEM_SYSITEMS    :constant string:= "SysItems"      ;
SZDDESYS_ITEM_RTNMSG      :constant string:= "ReturnMessage" ;
SZDDESYS_ITEM_STATUS      :constant string:= "Status"        ;
SZDDESYS_ITEM_FORMATS     :constant string:= "Formats"       ;
SZDDESYS_ITEM_SECURITY    :constant string:= "Security"      ;
SZDDESYS_ITEM_ITEMFORMATS :constant string:= "ItemFormats"   ;
SZDDESYS_ITEM_HELP        :constant string:= "Help"          ;
SZDDESYS_ITEM_PROTOCOLS   :constant string:= "Protocols"     ;
SZDDESYS_ITEM_RESTART     :constant string:= "Restart"       ;

--        Dynamic Data Exchange ( DDE) Structure Declarations

type CONVCONTEXT   is record   -- cctxt
   cb                :ULONG ;          -- sizeof( CONVCONTEXT)
   fsContext         :ULONG ;
   idCountry         :ULONG ;
   usCodepage        :ULONG ;
   usLangID          :ULONG ;
   usSubLangID       :ULONG ;
end record; -- CONVCONTEXT;
type PCONVCONTEXT  is access all CONVCONTEXT;

--         DDECTXT_CASESENSITIVE    :constant Long:= 16#0001

type DDEINIT  is record    -- ddei
    cb                  :ULONG   ;         -- sizeof( DDEINIT)
    pszAppName          :PSZ     ;
    pszTopic            :PSZ     ;
    offConvContext      :ULONG   ;
end record; -- DDEINIT;
type PDDEINIT  is access all DDEINIT;

type DDESTRUCT   is record   -- dde
    cbData             :ULONG   ;
    fsStatus           :USHORT  ;
    usFormat           :USHORT  ;
    offszItemName      :USHORT  ;
    offabData          :USHORT  ;
end record; -- DDESTRUCT;
type PDDESTRUCT  is access all DDESTRUCT;

--         DDE constants for wStatus field
 DDE_FACK                   :constant Long:= 16#0001#;
 DDE_FBUSY                  :constant Long:= 16#0002#;
 DDE_FNODATA                :constant Long:= 16#0004#;
 DDE_FACKREQ                :constant Long:= 16#0008#;
 DDE_FRESPONSE              :constant Long:= 16#0010#;
 DDE_NOTPROCESSED           :constant Long:= 16#0020#;
 DDE_FRESERVED              :constant Long:= 16#00C0#;
 DDE_FAPPSTATUS             :constant Long:= 16#FF00#;

--         old DDE public formats - new ones are CF_ constants
--
--         DDEFMT_TEXT                :constant Long:= 16#0001

--        Dynamic Data Exchange ( DDE) Routines
--
function WinDdeInitiate(hwndClient  :HWND         ;
                        pszAppName  :PSZ          ;
                        pszTopicName:PSZ          ;
                        pcctxt      :PCONVCONTEXT )return BOOL32;
pragma Import(c,WinDdeInitiate, Link_name=>"_WinDdeInitiate");

procedure WinDdeRespond(hwndClient  :HWND         ;
                        hwndServer  :HWND         ;
                        pszAppName  :PSZ          ;
                        pszTopicName:PSZ          ;
                        pcctxt      :PCONVCONTEXT );
pragma Import(c,WinDdeRespond, Link_name=>"_WinDdeRespond");

function WinDdePostMsg(hwndTo   :HWND       ;
                       hwndFrom :HWND       ;
                       wm       :ULONG      ;
                       pddest   :PDDESTRUCT ;
                       flOptions:ULONG      )return BOOL32;
pragma Import(c,WinDdePostMsg, Link_name=>"_WinDdePostMsg");

--         DDEPM_RETRY     :constant Long:= 16#00000001#;
--         DDEPM_NOFREE    :constant Long:= 16#00000002#;

--        -- Dynamic Data Exchange ( DDE) Messages

  WM_DDE_FIRST               :constant Long:= 16#00A0#;
  WM_DDE_INITIATE            :constant Long:= 16#00A0#;
  WM_DDE_REQUEST             :constant Long:= 16#00A1#;
  WM_DDE_ACK                 :constant Long:= 16#00A2#;
  WM_DDE_DATA                :constant Long:= 16#00A3#;
  WM_DDE_ADVISE              :constant Long:= 16#00A4#;
  WM_DDE_UNADVISE            :constant Long:= 16#00A5#;
  WM_DDE_POKE                :constant Long:= 16#00A6#;
  WM_DDE_EXECUTE             :constant Long:= 16#00A7#;
  WM_DDE_TERMINATE           :constant Long:= 16#00A8#;
  WM_DDE_INITIATEACK         :constant Long:= 16#00A9#;
  WM_DDE_LAST                :constant Long:= 16#00AF#;
  WM_QUERYCONVERTPOS         :constant Long:= 16#00b0#; -- WM_DBCSFIRST

--     -- Return values for WM_QUERYCONVERTPOS
--      QCP_CONVERT                :constant Long:= 16#0001#;
--      QCP_NOCONVERT              :constant Long:= 16#0000#;

--  Load/Delete Library/Procedure

subtype  HLIB  is HMODULE  ;
subtype  PHLIB is PHMODULE ;

function WinDeleteProcedure(ha     :HAB   ;
                            wndproc:PFNWP )return BOOL32;
pragma Import(c,WinDeleteProcedure, Link_name=>"_WinDeleteProcedure");

function WinDeleteLibrary(ha       :HAB  ;
                          libhandle:HLIB )return BOOL32;
pragma Import(c,WinDeleteLibrary, Link_name=>"_WinDeleteLibrary");

function WinLoadProcedure(ha       :HAB  ;
                          libhandle:HLIB ;
                          procname :PSZ  )return PFNWP  ;
pragma Import(c,WinLoadProcedure, Link_name=>"_WinLoadProcedure");

function WinLoadLibrary(ha     :HAB ;
                        libname:PSZ )return HLIB  ;
pragma Import(c,WinLoadLibrary, Link_name=>"_WinLoadLibrary");

--        Desktop API definitions

type DESKTOP   is record         -- dsk
  cbSize           :ULONG    ;
  hbm              :HBITMAP  ;
  x                :LONG     ;
  y                :LONG     ;
  fl               :ULONG    ;
  lTileCount       :LONG     ;
  szFile           :STRING(1..260);
end record; -- DESKTOP;
type PDESKTOP  is access all DESKTOP;  -- pdsk

function WinSetDesktopBkgnd(hwndDesktop:HWND     ;
                            pdskNew    :PDESKTOP )return HBITMAP;
pragma Import(c,WinSetDesktopBkgnd, Link_name=>"_WinSetDesktopBkgnd");

function WinQueryDesktopBkgnd(hwndDesktop:HWND     ;
                              pdsk       :PDESKTOP )return BOOL32;
pragma Import(c,WinQueryDesktopBkgnd, Link_name=>"_WinQueryDesktopBkgnd");

 SDT_DESTROY         :constant Long:= 16#0001#;
 SDT_NOBKGND         :constant Long:= 16#0002#;
 SDT_TILE            :constant Long:= 16#0004#;
 SDT_SCALE           :constant Long:= 16#0008#;
 SDT_PATTERN         :constant Long:= 16#0010#;
 SDT_CENTER          :constant Long:= 16#0020#;
 SDT_RETAIN          :constant Long:= 16#0040#;
 SDT_LOADFILE        :constant Long:= 16#0080#;

--        Palette Manager API definition

function WinRealizePalette(hwn  :HWND   ;
                           hp   :HPS    ;
                           pcclr:PULONG )return LONG;
pragma Import(c,WinRealizePalette, Link_name=>"_WinRelizePalette");

STR_DLLNAME :constant string:="keyremap" ;

 WM_DBCSFIRST               :constant Long:= 16#00b0#;
 WM_DBCSLAST                :constant Long:= 16#00cf#;

end os2.PMcp;
