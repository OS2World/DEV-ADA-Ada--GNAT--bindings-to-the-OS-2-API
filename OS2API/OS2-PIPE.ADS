
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PIPE                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Pipe      support    of os/2 api functions            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Pipe is
pragma Preelaborate (Pipe);

--** Pipe and queue support --

subtype HQUEUE  is  LHANDLE ;  -- hq --
type PHQUEUE  is access all HQUEUE;

subtype HEV is ULONG;
type PHEV is access all HEV;

type  REQUESTDATA   is record    -- reqqdata --
  pd           :PID         ;
  ulData       :ULONG       ;
end record;  -- REQUESTDATA;
type PREQUESTDATA is access all REQUESTDATA;

 QUE_FIFO              :constant Long:= 0 ;
 QUE_LIFO              :constant Long:= 1 ;
 QUE_PRIORITY          :constant Long:= 2 ;
 QUE_NOCONVERT_ADDRESS :constant Long:= 0 ;
 QUE_CONVERT_ADDRESS   :constant Long:= 4 ;

function  DosCreatePipe(phfRead :PHFILE ;
                        phfWrite:PHFILE ;
                        cb      :ULONG  )return apiret;
pragma Import(c,DosCreatePipe, Link_name=>"_DosCreatePipe");

function   DosCloseQueue(hq:HQUEUE )return apiret;
pragma Import(c,DosCloseQueue, Link_name=>"_DosCloseQueue");

function   DosCreateQueue(phq     :PHQUEUE ;
                          priority:ULONG   ;
                          pszName :PSZ     )return apiret;
pragma Import(c,DosCreateQueue, Link_name=>"_DosCreateQueue");

function   DosOpenQueue(ppd    :PPID    ;
                        phq    :PHQUEUE ;
                        pszName:PSZ     )return apiret;
pragma Import(c,DosOpenQueue, Link_name=>"_DosOpenQueue");

function   DosPeekQueue(hq       :HQUEUE       ;
                        pRequest :PREQUESTDATA ;
                        pcbData  :PULONG       ;
                        ppbuf    :PPVOID       ;
                        element  :PULONG       ;
                        nowait   :BOOL32       ;
                        ppriority:PBYTE        ;
                        hsem     :HEV          )return apiret;
pragma Import(c,DosPeekQueue, Link_name=>"_DosPeekQueue");

function   DosPurgeQueue(hq:HQUEUE )return apiret;
pragma Import(c,DosPurgeQueue, Link_name=>"_DosPurgeQueue");

function   DosQueryQueue(hq        :HQUEUE ;
                         pcbEntries:PULONG )return apiret;
pragma Import(c,DosQueryQueue, Link_name=>"_DosQueryQueue");

function   DosReadQueue(hq       :HQUEUE       ;
                        pRequest :PREQUESTDATA ;
                        pcbData  :PULONG       ;
                        ppbuf    :PPVOID       ;
                        element  :ULONG        ;
                        wait     :BOOL32       ;
                        ppriority:PBYTE        ;
                        hsem     :HEV          )return apiret;
pragma Import(c,DosReadQueue, Link_name=>"_DosReadQueue");

function   DosWriteQueue(hq      :HQUEUE ;
                         request :ULONG  ;
                         cbData  :ULONG  ;
                         pbData  :PVOID  ;
                         priority:ULONG  )return apiret;
pragma Import(c,DosWriteQueue, Link_name=>"_DosWriteQueue");
end Os2.Pipe;
