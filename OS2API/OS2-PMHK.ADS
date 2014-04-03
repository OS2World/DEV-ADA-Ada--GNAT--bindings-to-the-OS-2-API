
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PM                                         บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               PM        Hook manager                              บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMhk is
pragma Preelaborate (PMhk);
--
--  Hook manager

function WinSetHook(ha     :HAB     ;
                    hm     :HMQ     ;
                    iHook  :LONG    ;
                    pfnHook:PFN     ;
                    hmod   :HMODULE )return BOOL32;
pragma Import(c,WinSetHook, Link_name=>"_WinSetHook");

function WinReleaseHook(ha     :HAB     ;
                        hm     :HMQ     ;
                        iHook  :LONG    ;
                        pfnHook:PFN     ;
                        hmod   :HMODULE )return BOOL32;
pragma Import(c,WinReleaseHook, Link_name=>"_WinReleaseHook");

function WinCallMsgFilter(ha   :HAB   ;
                          pqms :PQMSG ;
                          msgf :ULONG )return BOOL32;
pragma Import(c,WinCallMsgFilter, Link_name=>"_WinCallMsgFilter");

--          Hook codes
--
--   Whether the hook receives a ( U)SHORT or ( U)LONG parameter depends
--   on the memory model that the hook executes in. 32-bit hook will
--   receive long parameters

--        procedure  SendMsgHook(:HAB ha ;       --installer's hab
--                                 PSMHSTRUCT psmh;   --p send msg struct
--                               :BOOL32 fInterTask);      *--between threads
--
--        #define HK_INPUT                   1
--        function InputHook(:HAB ha ;                 *--installer's hab
--                            PQMSG pQmsg;             *--p qmsg
--                            :ULONG/USHORT fs)return BOOL32;        *--remove/noremove
--
--        HK_MSGFILTER :constant Long:=    2 ;
--        function MsgFilterHook(:HAB ha ;             *--installer's hab
--                                 PQMSG pQmsg;         *--p qmsg
--                                 :ULONG/USHORT msgf)return BOOL32;  *--filter flag
--
--         HK_JOURNALRECORD           3
--        procedure JournalRecordHook(:HAB ha ;         *--installer's hab
--                               PQMSG pQmsg) ;    *--p qmsg
--
--         HK_JOURNALPLAYBACK         4
--        function JournalPlaybackHook(:HAB ha ;      **installer's hab
--                               :BOOL32 fSkip;   *--skip messages
--                                PQMSG pQmsg)return Ulong; *--p qmsg
--
--         HK_HELP                    5
--        function HelpHook(:HAB ha ;                  *--installer's hab
--                          :ULONG/USHORT usMode;      *--mode
--                          :ULONG/USHORT idTopic;     *--main topic
--                          :ULONG/USHORT idSubTopic;  *--sub topic
--                         :PRECTL prcPosition)return BOOL32;      *--associated position
--
--         HK_LOADER                  6
--        function LoaderHook(:HAB ha ;                *--installer's hab
--                        :LONG/USHORT idContext;  *--who called hook
--                         PSZ pszLibname;         *--lib name string
--                         PHLIB hlib;             *--p to lib handle
--                         PSZ pszProcname;        *--procedure name
--                        :PFNWP wndProc)return BOOL32;         *--window procedure
--
--         HK_REGISTERUSERMSG         7
--       function RegisterUserHook(:HAB ha ;          *--installer's hab
--                           :ULONG cUshort;    *--entries in arRMP
--                            PULONG/PUSHORT arRMP; *--RMP array
--                           PBOOL fRegistered)return BOOL32; *--msg parms already reg
--
--         HK_MSGCONTROL              8
--       function MsgControlHook(:HAB ha ;            *--installer's hab
--                           :LONG/SHORT idContext;*--who called hook
--                           :HWND hwn ;          *--SEI window handle
--                           PSZ pszClassname;   *--window class name
--                          :ULONG/USHORT usMsgclass;*--interested msg class *--
--                          :LONG/SHORT idControl;*--SMI_--
--                           PBOOL fSuccess)return BOOL32;    *--mode already set
--
--         HK_PLIST_ENTRY             9
--        function ProgramListEntryHook(:HAB ha ;      *--installer's hab
--                              PPRFHOOKPARMS pProfileHookParams;*--data
--                              PBOOL fNoExecute)return BOOL32;  *--cease hook processing
--
--         HK_PLIST_EXIT              10
--        function ProgramListExitHook(:HAB ha ;       *--installer's hab
--                           PPRFHOOKPARMS pProfileHookParams)return BOOL32;*--data
--
--         HK_FINDWORD                11
--        function FindWordHook( usCodepage;           *--code page to use
--                           PSZ pszText;          *--text to break
--                          :ULONG cb;             *--maximum text size
--                         :ULONG ich;            *--break 'near' here
--                          PULONG pichStart;     *--where break began
--                          PULONG pichEnd;       *--where break ended
--                          PULONG pichNext)return BOOL32;     *--where next word begin
--
--         HK_CODEPAGECHANGED         12
--        procedure CodePageChangedHook( HMQ hmq;       *--msg q handle
--                       :ULONG/USHORT usOldCodepage; *--old code page
--                       :ULONG/USHORT usNewCodepage) ;--new code page
--
--         HK_WINDOWDC                15
--        function WindowDCHook(:HAB  ha ;             *--installer's hab
--                        HDC  hdc;             *--current hdc
--                        :HWND hwn ;            *--current hwn
--                        BOOL)return BOOL32;                *--association flag
--
--         HK_DESTROYWINDOW           16
--        function DestroyWindowHook (:HAB  ha ;       *--installer's hab
--                             :HWND hwn ;      *--destroyed win hwn
--                             :ULONG Reserved)return BOOL32;*--association flag
--
--         HK_CHECKMSGFILTER          20
--        function CheckMsgFilteHook (:HAB  ha ;       *--installer's hab
--                                PQMSG pQmsg;    *--p qmsg
--                               :ULONG/USHORT usFirst;  *--first msg
--                               :ULONG/USHORT usLast;   *--last msg
--                               :ULONG/USHORT fOptions)return BOOL32;*--flags
--
--         HK_MSGINPUT                21
--        function MsgInputHook (:HAB  ha ;          *--installer's hab
--                       PQMSG pQmsg;       *--p qmsg
--                      :BOOL32 fSkip;        *--skip msg
--                      PBOOL pfNoRecord)return BOOL32; *--journal record event
--
--         HK_LOCKUP                  23
--        function LockupHook (:HAB  ha ;              *--installer's hab
--                       :HWND hwn LockupFrame)return BOOL32; *--hwnd
--
--         HK_FLUSHBUF                24
--        function FlushBufHook (:HAB  hab)return BOOL32;           *--installer's hab

--        Current message queue constant
--         HMQ_CURRENT          ( ( HMQ)1)
--
--        WH_MSGFILTER context codes
--         MSGF_DIALOGBOX             1
--         MSGF_MESSAGEBOX            2
--         MSGF_TRACK                 8
--         MSGF_DDEPOSTMSG            3
--
--        HK_HELP Help modes
--         HLPM_FRAME              ( -1)
--         HLPM_WINDOW             ( -2)
--         HLPM_MENU               ( -3)
--
--        HK_SENDMSG structure
--         PM_MODEL_1X      0
--         PM_MODEL_2X      1

type SMHSTRUCT   is record     -- smhs
   mp2       :MPARAM ;
   mp1       :MPARAM ;
   msg       :ULONG  ;
   hwn       :HWND   ;
   model     :ULONG  ;
end record; -- SMHSTRUCT;
type PSMHSTRUCT  is access all SMHSTRUCT;

--        --HK_LOADER context codes
--
--         LHK_DELETEPROC             1
--         LHK_DELETELIB              2
--         LHK_LOADPROC               3
--         LHK_LOADLIB                4
--
--        --HK_MSGCONTROL context codes
--
--         MCHK_MSGINTEREST           1
--         MCHK_CLASSMSGINTEREST      2
--         MCHK_SYNCHRONISATION       3
--         MCHK_MSGMODE               4
--
--        --HK_REGISTERUSERMSG conext codes
--
--         RUMHK_DATATYPE             1
--         RUMHK_MSG                  2

function WinSetClassThunkProc(pszClassname:PSZ ;
                              pfnThunkProc:PFN )return BOOL32;
pragma Import(c,WinSetClassThunkProc, Link_name=>"_WinSetClassThunkProc");

function WinQueryClassThunkProc(pszClassname:PSZ )return PFN  ;
pragma Import(c,WinQueryClassThunkProc, Link_name=>"_WinQueryClassThunkProc");

function WinSetWindowThunkProc(hwn         :HWND ;
                               pfnThunkProc:PFN  )return BOOL32;
pragma Import(c,WinSetWindowThunkProc, Link_name=>"_WinSetWindowThunkProc");

function WinQueryWindowThunkProc( hwn:HWND )return PFN  ;
pragma Import(c,WinQueryWindowThunkProc, Link_name=>"_WinQueryWindowThunkProc");

function WinQueryWindowModel( hwn :HWND)return LONG  ;
pragma Import(c,WinQueryWindowModel, Link_name=>"_WinQueryWindowModel");
end os2.pmhk;
