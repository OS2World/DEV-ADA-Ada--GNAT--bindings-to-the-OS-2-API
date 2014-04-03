
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.Npip                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Dos Named Pipes      of os/2 api functions            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Npip is
pragma Preelaborate (Npip);

--** DosNamedPipes API Support --

   --** Data ures used with named pipes **--

subtype HPIPE is LHANDLE ;     -- hp --
type PHPIPE   is access all HPIPE;

type  AVAILDATA is record               -- AVAILDATA --
  cbpipe       :USHORT      ;         -- bytes left in the pipe --
  cbmessage    :USHORT      ;         -- bytes left in the current message --
end record;  -- AVAILDATA;
type PAVAILDATA is access all AVAILDATA;

type  PIPEINFO is record               -- nmpinf --
  cbOut        :USHORT ;                  -- length of outgoing I/O buffer --
  cbIn         :USHORT ;                   -- length of incoming I/O buffer --
  cbMaxInst    :BYTE   ;              -- maximum number of instances   --
  cbCurInst    :BYTE   ;              -- current number of instances   --
  cbName       :BYTE   ;                 -- length of pipe name           --
  szName       :string(1..1);  -- [1];   -- start of name                 --
end record;  -- PIPEINFO;
type PPIPEINFO  is access all PIPEINFO;

type  PIPESEMSTATE is record     -- nmpsmst --
  fStatus    :BYTE   ;         -- type of record; 0 = EOI; 1 = read ok; --
                              -- 2 = write ok; 3 = pipe closed         --
  fFlag      :BYTE   ;           -- additional info; 01 = waiting thread  --
  usKey      :USHORT ;           -- user's key value                      --
  usAvail    :USHORT ;         -- available data/space if status = 1/2  --
end record;  -- PIPESEMSTATE;
type PPIPESEMSTATE is access all PIPESEMSTATE;

 NP_INDEFINITE_WAIT :constant Long :=     -1;
 NP_DEFAULT_WAIT    :constant Long :=      0;

-- DosPeekNmPipe() pipe states --

 NP_STATE_DISCONNECTED :constant Long :=   16#0001#;
 NP_STATE_LISTENING    :constant Long :=   16#0002#;
 NP_STATE_CONNECTED    :constant Long :=   16#0003#;
 NP_STATE_CLOSING      :constant Long :=   16#0004#;

-- DosCreateNPipe open modes --

 NP_ACCESS_INBOUND     :constant Long :=   16#0000#;
 NP_ACCESS_OUTBOUND    :constant Long :=   16#0001#;
 NP_ACCESS_DUPLEX      :constant Long :=   16#0002#;
 NP_INHERIT            :constant Long :=   16#0000#;
 NP_NOINHERIT          :constant Long :=   16#0080#;
 NP_WRITEBEHIND        :constant Long :=   16#0000#;
 NP_NOWRITEBEHIND      :constant Long :=   16#4000#;

-- DosCreateNPipe and DosQueryNPHState state

 NP_READMODE_BYTE      :constant Long :=   16#0000#;
 NP_READMODE_MESSAGE   :constant Long :=   16#0100#;
 NP_TYPE_BYTE          :constant Long :=   16#0000#;
 NP_TYPE_MESSAGE       :constant Long :=   16#0400#;
 NP_END_CLIENT         :constant Long :=   16#0000#;
 NP_END_SERVER         :constant Long :=   16#4000#;
 NP_WAIT               :constant Long :=   16#0000#;
 NP_NOWAIT             :constant Long :=   16#8000#;
 NP_UNLIMITED_INSTANCES:constant Long :=   16#00FF#;

function  DosCallNPipe(pszName  :PSZ    ;
                       pInbuf   :PVOID  ;
                       cbIn     :ULONG  ;
                       pOutbuf  :PVOID  ;
                       cbOut    :ULONG  ;
                       pcbActual:PULONG ;
                       msec     :ULONG  ) return apiret;
pragma Import(c,DosCallNPipe, Link_name=>"_DosCallNPipe");

function  DosConnectNPipe(hpp:HPIPE ) return apiret;
pragma Import(c,DosConnectNPipe, Link_name=>"_DosConnectNPipe");

function  DosDisConnectNPipe(hpp:HPIPE)return apiret;
pragma Import(c,DosDisConnectNPipe, Link_name=>"_DosDisConnectNPipe");

function  DosCreateNPipe(pszName :PSZ    ;
                          Ppipe  :PHPIPE ;
                         openmode:ULONG  ;
                         pipemode:ULONG  ;
                         cbInbuf :ULONG  ;
                         cbOutbuf:ULONG  ;
                         msec    :ULONG  )return apiret;
pragma Import(c,DosCreateNPipe, Link_name=>"_DosCreateNPipe");

function  DosPeekNPipe( pipe    :HPIPE      ;
                       pBuf     :PVOID      ;
                       cbBuf    :ULONG      ;
                       pcbActual:PULONG     ;
                       pAvail   :PAVAILDATA ;
                       pState   :PULONG     )return apiret;
pragma Import(c,DosPeekNPipe, Link_name=>"_DosPeekNPipe");

function  DosQueryNPHState( pipe :HPIPE  ;
                           pState:PULONG )return apiret;
pragma Import(c,DosQueryNPHState, Link_name=>"_DosQueryNPHState");

function  DosQueryNPipeInfo( pipe    :HPIPE ;
                            infolevel:ULONG ;
                            pBuf     :PVOID ;
                            cbBuf    :ULONG )return apiret;
pragma Import(c,DosQueryNPipeInfo, Link_name=>"_DosQueryNPipeInfo");

function DosQueryNPipeSemState(sem  :HSEM          ;
                               pnpss:PPIPESEMSTATE ;
                               cbBuf:ULONG         ) return apiret;
pragma Import(c,DosQueryNPipeSemState, Link_name=>"_DosQueryNPipeSemState");

function  DosRawReadNPipe(pszName:PSZ    ;
                          cb     :ULONG  ;
                          pLen   :PULONG ;
                          pBuf   :PVOID  )return apiret;
pragma Import(c,DosRawReadNPipe, Link_name=>"_DosRawReadNPipe");

function  DosRawWriteNPipe(pszName:PSZ   ;
                           cb     :ULONG )return apiret;
pragma Import(c,DosRawWriteNPipe, Link_name=>"_DosRawWriteNPipe");

function  DosSetNPHState(hpp  :HPIPE ;
                         state:ULONG )return apiret;
pragma Import(c,DosSetNPHState, Link_name=>"_DosSetNPHState");

function  DosSetNPipeSem(hpp:HPIPE ;
                         sem:HSEM  ;
                         key:ULONG )return apiret;
pragma Import(c,DosSetNPipeSem, Link_name=>"_DosSetNPipeSem");

function  DosTransactNPipe(hpp     :HPIPE ;
                           pOutbuf :PVOID ;
                           cbOut   :ULONG ;
                           pInbuf  :PVOID ;
                           cbIn    :ULONG ;
                            pcbRead:PULONG)return apiret;
pragma Import(c,DosTransactNPipe, Link_name=>"_DosTransactNPipe");

function  DosWaitNPipe(pszName:PSZ   ;
                       msec   :ULONG )return apiret;
pragma Import(c,DosWaitNPipe, Link_name=>"_DosWaitNPipe");

 -- values in fStatus --
  NPSS_EOI     :constant Long :=    0 ;   -- End Of Information
  NPSS_RDATA   :constant Long :=    1 ;   -- read data available
  NPSS_WSPACE  :constant Long :=    2 ;   -- write space available
  NPSS_CLOSE   :constant Long :=    3 ;   -- pipe in CLOSING state

 -- values in npss_flag --
  NPSS_WAIT    :constant Long :=    16#01#;  -- waiting thread on end of pipe

 -- defined bits in pipe mode
  NP_NBLK      :constant Long :=    16#8000#; -- non-blocking read/write
  NP_SERVER    :constant Long :=    16#4000#; -- set if server end
  NP_WMESG     :constant Long :=    16#0400#; -- write messages
  NP_RMESG     :constant Long :=    16#0100#; -- read as messages
  NP_ICOUNT    :constant Long :=    16#00FF#; -- instance count field


--   บ --Named pipes may be in one of several states depending on the actions                       บ
--   บ * that have been taken on it by the server end and client end.  The                          บ
--   บ * following state/action table summarizes the valid state transitions:                       บ
--   บ *                                                                                            บ
--   บ * Current state           Action                  Next state                                 บ
--   บ *                                                                                            บ
--   บ *  <none>             server DosMakeNmPipe        DISCONNECTED                               บ
--   บ *  DISCONNECTED       server connect              LISTENING                                  บ
--   บ *  LISTENING          client open                 CONNECTED                                  บ
--   บ *  CONNECTED          server disconn              DISCONNECTED                               บ
--   บ *  CONNECTED          client close                CLOSING                                    บ
--   บ *  CLOSING            server disconn              DISCONNECTED                               บ
--   บ *  CONNECTED          server close                CLOSING                                    บ
--   บ *  <any other>        server close                <pipe deallocated>                         บ
--   บ *                                                                                            บ
--   บ * If a server disconnects his end of the pipe; the client end will enter a                   บ
--   บ * special state in which any future operations (except close)return apiret; on the file      บ
--   บ * descriptor associated with the pipe will return an error.                                  บ
--   บ --                                                                                           บ
--   ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

 --     Values for named pipe state

  NP_DISCONNECTED :constant Long :=       1 ;       -- after pipe creation or Disconnect
  NP_LISTENING    :constant Long :=       2 ;       -- after DosNmPipeConnect
  NP_CONNECTED    :constant Long :=       3 ;       -- after Client open
  NP_CLOSING      :constant Long :=       4 ;       -- after Client or Server close
end Os2.Npip;
