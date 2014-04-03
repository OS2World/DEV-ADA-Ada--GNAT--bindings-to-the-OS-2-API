
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package  OS2.SEM                                           บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             synchronization                                       บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;          use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
-- with System;                use System;
-- with System.OS2Lib.Threads; use System.OS2Lib.Threads;

package os2.sem is
pragma Preelaborate (Sem);

   --  Semaphore Attributes

   DC_SEM_SHARED : constant := 16#01#;
   --  DosCreateMutex, DosCreateEvent, and DosCreateMuxWait use it to indicate
   --  whether the semaphore is shared or private when the PSZ is null

   DCMW_WAIT_ANY : constant := 16#02#;
   --  DosCreateMuxWait option for wait on any event/mutex to occur

   DCMW_WAIT_ALL : constant := 16#04#;
   --  DosCreateMuxWait option for wait on all events/mutexes to occur

   SEM_INDEFINITE_WAIT  : constant ULONG := -1;
   SEM_IMMEDIATE_RETURN : constant ULONG :=  0;

-- subtype HSEM is System.Address;
-- type PHSEM is access all HSEM;

   type SEMRECORD is
      record
         hsemCur : HSEM;
         ulUser  : ULONG;
      end record;
   type PSEMRECORD is access all SEMRECORD;


   subtype HEV is ulong;
   type PHEV is access all HEV;

   subtype HMTX is ulong;
   type PHMTX is access all HMTX;
   subtype HMUX is ulong;
   type PHMUX is access all HMUX;

   function DosCreateEventSem
     (pszName   : PSZ;
      f_phev    : PHEV;
      flAttr    : ULONG;
      fState    : BOOL32)
      return      APIRET;
   pragma Import (C, DosCreateEventSem, Link_Name => "_DosCreateEventSem");

   function DosOpenEventSem
     (pszName   : PSZ;
      F_phev    : PHEV)
      return      APIRET;
   pragma Import (C, DosOpenEventSem, Link_Name => "_DosOpenEventSem");

   function DosCloseEventSem
     (F_hev     : HEV)
      return      APIRET;
   pragma Import (C, DosCloseEventSem, Link_Name => "_DosCloseEventSem");

   function DosResetEventSem
     (F_hev     : HEV;
      pulPostCt : PULONG)
      return      APIRET;
   pragma Import (C, DosResetEventSem, Link_Name => "_DosResetEventSem");

   function DosPostEventSem
     (F_hev     : HEV)
      return      APIRET;
   pragma Import (C, DosPostEventSem, Link_Name => "_DosPostEventSem");

   function DosWaitEventSem
     (F_hev     : HEV;
      ulTimeout : ULONG)
      return      APIRET;
   pragma Import (C, DosWaitEventSem, Link_Name => "_DosWaitEventSem");

   function DosQueryEventSem
     (F_hev     : HEV;
      pulPostCt : PULONG)
      return      APIRET;
   pragma Import (C, DosQueryEventSem, Link_Name => "_DosQueryEventSem");

   function DosCreateMutexSem
     (pszName   : PSZ;
      F_phmtx   : PHMTX;
      flAttr    : ULONG;
      fState    : BOOL32)
      return      APIRET;
   pragma Import (C, DosCreateMutexSem, Link_Name => "_DosCreateMutexSem");

   function DosOpenMutexSem
     (pszName   : PSZ;
      F_phmtx   : PHMTX)
      return      APIRET;
   pragma Import (C, DosOpenMutexSem, Link_Name => "_DosOpenMutexSem");

   function DosCloseMutexSem
     (F_hmtx    : HMTX)
      return      APIRET;
   pragma Import (C, DosCloseMutexSem, Link_Name => "_DosCloseMutexSem");

   function DosRequestMutexSem
     (F_hmtx    : HMTX;
      ulTimeout : ULONG)
      return      APIRET;
   pragma Import (C, DosRequestMutexSem, Link_Name => "_DosRequestMutexSem");

   function DosReleaseMutexSem
     (F_hmtx    : HMTX)
      return      APIRET;
   pragma Import (C, DosReleaseMutexSem, Link_Name => "_DosReleaseMutexSem");

   function DosQueryMutexSem
     (F_hmtx    : HMTX;
      F_ppid    : PPID;
      F_ptid    : PTID;
      pulCount  : PULONG)
      return      APIRET;
   pragma Import (C, DosQueryMutexSem, Link_Name => "_DosQueryMutexSem");

   function DosCreateMuxWaitSem
     (pszName   : PSZ;
      F_phmux   : PHMUX;
      cSemRec   : ULONG;
      pSemRec   : PSEMRECORD;
      flAttr    : ULONG)
      return      APIRET;
   pragma Import (C, DosCreateMuxWaitSem, Link_Name => "_DosCreateMuxWaitSem");

   function DosOpenMuxWaitSem
     (pszName   : PSZ;
      F_phmux   : PHMUX)
      return      APIRET;
   pragma Import (C, DosOpenMuxWaitSem, Link_Name => "_DosOpenMuxWaitSem");

   function DosCloseMuxWaitSem
     (F_hmux    : HMUX)
      return      APIRET;
   pragma Import (C, DosCloseMuxWaitSem, Link_Name => "_DosCloseMuxWaitSem");

   function DosWaitMuxWaitSem
     (F_hmux    : HMUX;
      ulTimeout : ULONG;
      pulUser   : PULONG)
      return      APIRET;
   pragma Import (C, DosWaitMuxWaitSem, Link_Name => "_DosWaitMuxWaitSem");

   function DosAddMuxWaitSem
     (F_hmux    : HMUX;
      pSemRec   : PSEMRECORD)
      return      APIRET;
   pragma Import (C, DosAddMuxWaitSem, Link_Name => "_DosAddMuxWaitSem");

   function DosDeleteMuxWaitSem
     (F_hmux    : HMUX;
      F_hsem    : HSEM)
      return      APIRET;
   pragma Import (C, DosDeleteMuxWaitSem, Link_Name => "_DosDeleteMuxWaitSem");

   function DosQueryMuxWaitSem
     (F_hmux    : HMUX;
     pcSemRec   : PULONG;
     pSemRec    : PSEMRECORD;
     pflAttr    : PULONG)
     return       APIRET;
   pragma Import (C, DosQueryMuxWaitSem, Link_Name => "_DosQueryMuxWaitSem");

end OS2.sem;
