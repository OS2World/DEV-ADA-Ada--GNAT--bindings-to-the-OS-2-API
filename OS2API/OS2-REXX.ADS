
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.Rexx                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ                 REXX  support                                     บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Rexx is
pragma Preelaborate (Rexx);

--  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
--  บ                                                                   บ
--  บ   #define:              To include:                               บ
--  บ                                                                   บ
--  บ   INCL_REXXSAA          Complete Rexx support                     บ
--  บ   INCL_RXSUBCOM         Rexx subcommand handler support           บ
--  บ   INCL_RXSHV            Rexx shared variable pool support         บ
--  บ   INCL_RXFUNC           Rexx external function support            บ
--  บ   INCL_RXSYSEXIT        Rexx system exit support                  บ
--  บ   INCL_RXMACRO          Rexx macro space support                  บ
--  บ   INCL_RXARI            Rexx asynchronous Trace/Halt support      บ
--  บ                                                                   บ
--  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

    --                            Common
    -- This section defines return codes and constants that are the
    -- same for both 16-bit and 32-bit REXX calls.

    --**    Structure for external interface string (RXSTRING)

type  RXSTRING is record          -- rxstr
  strlength         :ULONG  ;           --   length of string
  strptr            :PCH    ;           --   pointer to string
end record; --  RXSTRING;

type PRXSTRING     is access all RXSTRING;       -- pointer to a RXSTRING

--  #define RXAUTOBUFLEN         256L

    --**    Structure for system exit block (RXSYSEXIT) 32-bit

type  RXSYSEXIT is record            -- syse
sysexit_name      :PSZ   ;                 -- subcom enviro for sysexit
sysexit_code      :LONG  ;                 -- sysexit function code
end record; --  RXSYSEXIT;

type PRXSYSEXIT is access all RXSYSEXIT;         -- pointer to a RXSYSEXIT


    -- XLATOFF
    --**    Macros for RXSTRING manipulation

--  #define RXNULLSTRING(r)      (!(r).strptr)
--  #define RXZEROLENSTRING(r)   ((r).strptr && !(r).strlength)
--  #define RXVALIDSTRING(r)     ((r).strptr && (r).strlength)
--  #define RXSTRLEN(r)          (RXNULLSTRING(r)?0L:(r).strlength)
--  #define RXSTRPTR(r)          (r).strptr
--  #define MAKERXSTRING(r,p,l)  is record(r).strptr=(PCH)p;(r).strlength=(ULONG)l;}

    -- XLATON

    --** Call type codes for use on interpreter startup
--  #define RXCOMMAND       0              -- Program called as Command
--  #define RXSUBROUTINE    1              -- Program called as Subroutin
--  #define RXFUNCTION      2              -- Program called as Function

    --**    Subcommand Interface defines
    --**    Drop Authority for RXSUBCOM interface

--  #define RXSUBCOM_DROPPABLE   0x00--   -- handler to be dropped by all
--  #define RXSUBCOM_NONDROP     0x01     -- process with same PID as the
--                                        -- registrant may drop environ
--
--  --**    Return Codes from RXSUBCOM interface
--
--  #define RXSUBCOM_ISREG       0x01     -- Subcommand is registered
--  #define RXSUBCOM_ERROR       0x01     -- Subcommand Ended in Error
--  #define RXSUBCOM_FAILURE     0x02     -- Subcommand Ended in Failure
--  #define RXSUBCOM_BADENTRY    1001     -- Invalid Entry Conditions
--  #define RXSUBCOM_NOEMEM      1002     -- Insuff stor to complete req
--  #define RXSUBCOM_BADTYPE     1003     -- Bad registration type.
--  #define RXSUBCOM_NOTINIT     1004     -- API system not initialized.
--  #define RXSUBCOM_OK           0       -- Function Complete
--  #define RXSUBCOM_DUP         10       -- Duplicate Environment Name-
--                                        -- but Registration Completed
--  #define RXSUBCOM_MAXREG      20       -- Cannot register more
--                                        -- handlers
--  #define RXSUBCOM_NOTREG      30       -- Name Not Registered
--  #define RXSUBCOM_NOCANDROP   40--     -- Name not droppable
--  #define RXSUBCOM_LOADERR     50       -- Could not load function
--  #define RXSUBCOM_NOPROC     127       -- RXSUBCOM routine - not found
--
--  #endif -- INCL_RXSUBCOM for defines
--
--  --**    Shared Variable Pool Interface defines
--  #ifdef INCL_RXSHV
--
--  --**    Function Codes for Variable Pool Interface (shvcode)
--
--  #define RXSHV_SET          0x00       -- Set var from given value
--  #define RXSHV_FETCH        0x01       -- Copy value of var to buffer
--  #define RXSHV_DROPV        0x02       -- Drop variable
--  #define RXSHV_SYSET        0x03       -- Symbolic name Set variable
--  #define RXSHV_SYFET        0x04       -- Symbolic name Fetch variable
--  #define RXSHV_SYDRO        0x05       -- Symbolic name Drop variable
--  #define RXSHV_NEXTV        0x06       -- Fetch "next" variable
--  #define RXSHV_PRIV         0x07       -- Fetch private information
--  #define RXSHV_EXIT--       0x08       -- Set function exit value
--
--  --**    Return Codes for Variable Pool Interface
--
--  #define RXSHV_NOAVL         144       -- Interface not available
--
--  --**    Return Code Flags for Variable Pool Interface (shvret)
--
--  #define RXSHV_OK--         0x00       -- Execution was OK
--  #define RXSHV_NEWV         0x01       -- Variable did not exist
--  #define RXSHV_LVAR         0x02       -- Last var trans via SHVNEXTV
--  #define RXSHV_TRUN         0x04       -- Truncation occurred-Fetch
--  #define RXSHV_BADN         0x08       -- Invalid variable name
--  #define RXSHV_MEMFL        0x10       -- Out of memory failure
--  #define RXSHV_BADF         0x80       -- Invalid funct code (shvcode)


    --**    Structure of Shared Variable Request Block (SHVBLOCK)
type SHVBLOCK ;
type PSHVBLOCK is access SHVBLOCK;

type  SHVBLOCK is record            -- shvb
 pshvnext        :PSHVBLOCK ;       -- pointer to the next block
 shvname         :RXSTRING  ;       -- Pointer to the name buffer
 shvvalue        :RXSTRING  ;       -- Pointer to the value buffer
 shvnamelen      :ULONG     ;       -- Length of the name value
 shvvaluelen     :ULONG     ;       -- Length of the fetch value
 shvcode         :UCHAR     ;       -- Function code for this block
 shvret          :UCHAR     ;       -- Individual Return Code Flags
end record; --   SHVBLOCK;

    --**    External Function Interface
    --**    Registration Type Identifiers for Available Function Table

--  #define RXFUNC_DYNALINK       1        -- Function Available in DLL
--  #define RXFUNC_CALLENTRY      2        -- Registered as mem entry pt.

    --**    Return Codes from RxFunction interface

--  #define RXFUNC_OK             0        -- REXX-API Call Successful
--  #define RXFUNC_DEFINED       10        -- Function Defined in AFT
--  #define RXFUNC_NOMEM         20        -- Not Enough Mem to Add
--  #define RXFUNC_NOTREG        30        -- Funct Not Registered in AFT
--  #define RXFUNC_MODNOTFND     40        -- Funct Dll Module Not Found
--  #define RXFUNC_ENTNOTFND     50        -- Funct Entry Point Not Found
--  #define RXFUNC_NOTINIT       60        -- API not initialized
--  #define RXFUNC_BADTYPE       70        -- Bad function type

    --**   System Exits defines
    --**    Drop Authority for Rexx Exit interface

--  #define RXEXIT_DROPPABLE     0x00     -- handler to be dropped by all
--  #define RXEXIT_NONDROP       0x01     -- process with same PID as the
                                          -- registrant may drop environ
    --**    Exit return actions

--  #define RXEXIT_HANDLED       0        -- Exit handled exit event
--  #define RXEXIT_NOT_HANDLED   1        -- Exit passes on exit event
--  #define RXEXIT_RAISE_ERROR   (-1)     -- Exit handler error occurred
--
--  --**    Return Codes from RXEXIT interface
--
--  #define RXEXIT_ISREG         0x01     -- Exit is registered
--  #define RXEXIT_ERROR         0x01     -- Exit Ended in Error
--  #define RXEXIT_FAILURE       0x02     -- Exit Ended in Failure
--  #define RXEXIT_BADENTRY      1001     -- Invalid Entry Conditions
--  #define RXEXIT_NOEMEM        1002     -- Insuff stor to complete req
--  #define RXEXIT_BADTYPE       1003     -- Bad registration type.
--  #define RXEXIT_NOTINIT       1004     -- API system not initialized.
--  #define RXEXIT_OK             0       -- Function Complete
--  #define RXEXIT_DUP           10       -- Duplicate Exit Name-
--                                        -- but Registration Completed
--  #define RXEXIT_MAXREG        20       -- Cannot register more
--                                        -- handlers
--  #define RXEXIT_NOTREG        30       -- Name Not Registered
--  #define RXEXIT_NOCANDROP     40       -- Name not droppable
--  #define RXEXIT_LOADERR       50       -- Could not load function
--  #define RXEXIT_NOPROC       127       -- RXEXIT routine - not found
--
--
--
--  -- System Exit function and sub-function definitions
--
--  #define RXENDLST    0                 -- End of exit list.
--  #define RXFNC    2                    -- Process external functions.
--  #define    RXFNCCAL 1                 -- subcode value.
--  #define RXCMD    3                    -- Process host commands.
--  #define    RXCMDHST 1                 -- subcode value.
--  #define RXMSQ    4                    -- Manipulate queue.
--  #define    RXMSQPLL 1                 -- Pull a line from queue
--  #define    RXMSQPSH 2                 -- Place a line on queue
--  #define    RXMSQSIZ 3                 -- Return num of lines on queue
--  #define    RXMSQNAM 20                -- Set active queue name
--  #define RXSIO    5                    -- Session I/O.
--  #define    RXSIOSAY 1                 -- SAY a line to STDOUT
--  #define    RXSIOTRC 2                 -- Trace output
--  #define    RXSIOTRD 3                 -- Read from char stream
--  #define    RXSIODTR 4                 -- DEBUG read from char stream
--  #define    RXSIOTLL 5                 -- Return linelength(N/A OS/2)
--  #define RXHLT    7                    -- Halt processing.
--  #define    RXHLTCLR 1                 -- Clear HALT indicator
--  #define    RXHLTTST 2                 -- Test HALT indicator
--  #define RXTRC    8                    -- Test ext trace indicator.
--  #define    RXTRCTST 1                 -- subcode value.
--  #define RXINI    9                    -- Initialization processing.
--  #define    RXINIEXT 1                 -- subcode value.
--  #define RXTER   10                    -- Termination processing.
--  #define    RXTEREXT 1                 -- subcode value.
--  #define RXNOOFEXITS 11                -- 1 + largest exit number.

subtype  PEXIT is PUCHAR;                 -- ptr to exit parameter block

    --**    Asynchronous Request Interface defines
    --**    Return Codes from Asynchronous Request interface

--  #define RXARI_OK                   0  -- Interface completed
--  #define RXARI_NOT_FOUND            1  -- Target program not found
--  #define RXARI_PROCESSING_ERROR     2  -- Error processing request
--  #endif -- INCL_RXARI for defines
--
--  --**    Macro Space Interface defines
--  #ifdef INCL_RXMACRO
--
--  --**    Registration Search Order Flags
--
--  #define RXMACRO_SEARCH_BEFORE       1  -- Beginning of search order
--  #define RXMACRO_SEARCH_AFTER        2  -- End of search order
--
--
--  --**    Return Codes from RxMacroSpace interface
--
--  #define RXMACRO_OK                 0  -- Macro interface completed
--  #define RXMACRO_NO_STORAGE         1  -- Not Enough Storage Available
--  #define RXMACRO_NOT_FOUND          2  -- Requested function not found
--  #define RXMACRO_EXTENSION_REQUIRED 3  -- File ext required for save
--  #define RXMACRO_ALREADY_EXISTS     4  -- Macro functions exist
--  #define RXMACRO_FILE_ERROR         5  -- File I/O error in save/load
--  #define RXMACRO_SIGNATURE_ERROR    6  -- Incorrect format for load
--  #define RXMACRO_SOURCE_NOT_FOUND   7  -- Requested cannot be found
--  #define RXMACRO_INVALID_POSITION   8  -- Invalid search order pos
--  #define RXMACRO_NOT_INIT           9  -- API not initialized
--  #endif -- INCL_RXMACRO for defines
--
    --                            32-bit
    --

    --**    Main Entry Point to the REXXSAA Interpreter

 function RexxStart (
   name     :LONG ;                        -- Num of args passed to rexx
  pargs     :PRXSTRING;                    -- Array of args passed to rex
  ppath     :PSZ;                          -- [d:][path] filename[.ext]
  ploc      :PRXSTRING;                    -- Loc of rexx proc in memory
  penv      :PSZ;                          -- ASCIIZ initial environment.
  tip       :LONG ;                        -- type (command;subrtn;funct)
  pexit     :PRXSYSEXIT;                   -- SysExit env. names &  codes
  pret      :PUSHORT;                      -- Ret code from if numeric
  pretn     :PRXSTRING ) return LONG;                  -- Retvalue from the rexx proc
pragma Import(c,RexxStart, Link_name=>"RexxStart");

    --**    Subcommand Interface
    -- XLATOFF

    -- This typedef simplifies coding of a Subcommand handler.
--  #pragma linkage(RexxSubcomHandler;system)
type RexxSubcomHandler is access function (pstr:PRXSTRING;
                                           push:PUSHORT;
                                           prs :PRXSTRING) return ULONG;

    --**   RexxRegisterSubcomDll -- Register a DLL entry point
    --**   as a Subcommand handler

function RexxRegisterSubcomDll (
 pname      :PSZ;                          -- Name of subcom handler
 pndll      :PSZ;                          -- Name of DLL
 pprocndll  :PSZ;                          -- Name of procedure in DLL
 parea      :PUCHAR;                       -- User area
 pdrop      :ULONG  ) return APIRET;                   -- Drop authority.
pragma Import(c,RexxRegisterSubcomDll, Link_name=>"RexxRegisterSubcomDll");

    --**   RexxRegisterSubcomExe -- Register an EXE entry point
    --**   as a Subcommand handler

function RexxRegisterSubcomExe (
      pname :PSZ;                          -- Name of subcom handler
      pexe  :PSZ;                          -- address of handler in EXE
      parea :PUCHAR) return APIRET;                    -- User area
pragma Import(c,RexxRegisterSubcomExe, Link_name=>"RexxRegisterSubcomExe");

    --**    RexxQuerySubcom - Query an environment for Existance

function RexxQuerySubcom(
penv        :PSZ;                          -- Name of the Environment
pdll        :PSZ;                          -- DLL Module Name
pstor       :PUSHORT;                      -- Stor for existance code
parea       :PUCHAR ) return APIRET;                   -- Stor for user word
pragma Import(c,RexxQuerySubcom, Link_name=>"RexxQuerySubcom");

    --**    RexxDeregisterSubcom - Drop registration of a Subcommand
    --**    environment

function RexxDeregisterSubcom(
penv        :PSZ;                          -- Name of the Environment
pdll        :PSZ ) return APIRET;                         -- DLL Module Name
pragma Import(c,RexxDeregisterSubcom, Link_name=>"RexxDeregisterSubcom");

    --**    Shared Variable Pool Interface
    --**    RexxVariablePool - Request Variable Pool Service

function RexxVariablePool(plist:PSHVBLOCK) return APIRET; -- Pointer to list of SHVBLOCKs
pragma Import(c,RexxVariablePool, Link_name=>"RexxVariablePool");

    -- This typedef simplifies coding of an External Function.
type RexxFunctionHandler is access function(p1:PUCHAR;
                                     p2:ULONG;
                                     p3: PRXSTRING;
                                     p4:PSZ;
                                     p5: PRXSTRING) return ULONG;

    --**    RexxRegisterFunctionDll - Register a function in the AFT

function RexxRegisterFunctionDll (
  pname    :PSZ;                           -- Name of function to add
  pdllfn   :PSZ;                           -- Dll file name (if in dll)
  pdll     :PSZ) return APIRET;                          -- Entry in dll
pragma Import(c,RexxRegisterFunctionDll, Link_name=>"RexxRegisterFunctionDll");

    --**    RexxRegisterFunctionExe - Register a function in the AFT

function RexxRegisterFunctionExe (
    pnadd  :PSZ;                           -- Name of function to add
    pentr  :PSZ) return APIRET;                          -- Entry point in EXE
pragma Import(c,RexxRegisterFunctionExe, Link_name=>"RexxRegisterFunctionExe");

    --**    RexxDeregisterFunction - Delete a function from the AFT

function RexxDeregisterFunction (pname:PSZ ) return APIRET; -- Name of function to remove
pragma Import(c,RexxDeregisterFunction, Link_name=>"RexxDeregisterFunction");

    --**    RexxQueryFunction - Scan the AFT for a function

function RexxQueryFunction (pname :PSZ ) return APIRET; -- Name of function to find
pragma Import(c,RexxQueryFunction, Link_name=>"RexxQueryFunction");

    --**   System Exits
    --**    Subfunction RXFNCCAL - External Function Calls

--type   RXFNC_FLAGS is record          -- fl
--       unsigned rxfferr  : 1;              -- Invalid call to routine.
--       unsigned rxffnfnd : 1;              -- Function not found.
--       unsigned rxffsub  : 1;              -- Called as a subroutine
--end record; --  RXFNC_FLAGS ;
subtype RXFNC_FLAGS is BYTE;

type   RXFNCCAL_PARM is record        -- fnc
   rxfnc_fl      : RXFNC_FLAGS       ;     -- function flags
   rxfnc_name    : PUCHAR            ;       -- Pointer to function name.
   rxfnc_namel   : USHORT            ;      -- Length of function name.
   rxfnc_que     : PUCHAR            ;        -- Current queue name.
   rxfnc_quel    : USHORT            ;       -- Length of queue name.
   rxfnc_argc    : USHORT            ;       -- Number of args in list.
   rxfnc_argv    : PRXSTRING         ;       -- Pointer to argument list.
   rxfnc_retc    : RXSTRING          ;       -- Return value.
end record; --  RXFNCCAL_PARM;
type PRXFNCCAL_PARM is access all  RXFNCCAL_PARM ;

    --**    Subfunction RXCMDHST -- Process Host Commands

--type Packed  RXCMD_FLAGS is record          -- fl
--       unsigned rxfcfail : 1;              -- Command failed.
--       unsigned rxfcerr  : 1;              -- Command ERROR occurred.
--end record; --  RXCMD_FLAGS;
subtype RXCMD_FLAGS is BYTE;

type  RXCMDHST_PARM is record        -- rx
  rxcmd_fl           :RXCMD_FLAGS      ;      -- error/failure flags
  rxcmd_address      :PUCHAR           ;    -- Pointer to address name.
  rxcmd_addressl     :USHORT           ;   -- Length of address name.
  rxcmd_dll          :PUCHAR           ;        -- dll name for command.
  rxcmd_dll_len      :USHORT           ;    -- Length of dll name.
  rxcmd_command      :RXSTRING         ;    -- The command string.
  rxcmd_retc         :RXSTRING         ;       -- Pointer to return buffer
end record; --  RXCMDHST_PARM;
type PRXCMDHST_PARM is access all RXCMDHST_PARM;

    --**     Subfunction RXMSQPLL -- Pull Entry from Queue

type  RXMSQPLL_PARM is record        -- pll
  rxmsq_retc    :RXSTRING          ;       -- Pointer to dequeued entry
                                           -- buffer.  User allocated.
end record; -- RXMSQPLL_PARM;


    --**    Subfunction RXMSQPSH -- Push Entry on Queue

-- type Packed  RXMSQ_FLAGS is record          -- fl
--        unsigned rxfmlifo : 1;              -- Stack entry LIFO if set
-- end record; --  RXMSQ_FLAGS;
subtype RXMSQ_FLAGS  is byte;

type  RXMSQPSH_PARM is record        -- psh
   rxmsq_fl      :RXMSQ_FLAGS       ;      -- LIFO/FIFO flag
   rxmsq_value   :RXSTRING          ;      -- The entry to be pushed.
end record; --  RXMSQPSH_PARM;
type PRXMSQPSH_PARM is access all  RXMSQPSH_PARM;

    --**    Subfunction RXMSQSIZ -- Return the Current Queue Size

type  RXMSQSIZ_PARM is record        -- siz
   rxmsq_size   :ULONG             ;       -- Number of Lines in Queue
end record; --  RXMSQSIZ_PARM;
type PRXMSQSIZ_PARM is access all RXMSQSIZ_PARM;

    --**    Subfunction RXMSQNAM -- Set Current Queue Name

type  RXMSQNAM_PARM is record        -- nam
   rxmsq_name :  RXSTRING          ;       -- RXSTRING containing
                                           -- queue name.
end record; --  RXMSQNAM_PARM;
type PRXMSQNAM_PARM is access all RXMSQNAM_PARM;

    --**    Subfunction RXSIOSAY -- Perform SAY Clause

type  RXSIOSAY_PARM is record        -- say
  rxsio_string    :RXSTRING          ;     -- String to display.
end record; --  RXSIOSAY_PARM;
type PRXSIOSAY_PARM is access all RXSIOSAY_PARM;

    --**    Subfunction RXSIOTRC -- Write Trace Output

type  RXSIOTRC_PARM is record -- trcparm
  rxsio_string   : RXSTRING          ;     -- Trace line to display.
end record; --  RXSIOTRC_PARM;
type PRXSIOTRC_PARM is access all  RXSIOTRC_PARM;

    --**    Subfunction RXSIOTRD -- Read Input from the Terminal

type  RXSIOTRD_PARM is record        -- trd
  rxsiotrd_retc  :  RXSTRING          ;    -- RXSTRING for output.
end record; --  RXSIOTRD_PARM;
type PRXSIOTRD_PARM is access all RXSIOTRD_PARM;

    --**    Subfunction RXSIODTR -- Read Debug Input from the Terminal

type  RXSIODTR_PARM is record        -- dtr
  rxsiodtr_retc   : RXSTRING          ;    -- RXSTRING for output.
end record; --  RXSIODTR_PARM;
type PRXSIODTR_PARM is access all  RXSIODTR_PARM;

    --**    Subfunction RXHSTTST -- Test for HALT Condition

-- type  RXHLT_FLAGS is record          -- fl Halt flag
--       unsigned rxfhhalt : 1;              -- Set if HALT occurred.
--end record; --  RXHLT_FLAGS;
subtype RXHLT_FLAGS is  BYTE;

type  RXHLTTST_PARM is record        -- tst
  rxhlt_fl      : RXHLT_FLAGS ;            -- Set if HALT occurred
end record; --  RXHLTTST_PARM;
type PRXHLTTST_PARM is access all    RXHLTTST_PARM;

    --**    Subfunction RXTRCTST -- Test for TRACE Condition

-- type  RXTRC_FLAGS is record          -- fl Trace flags
--        unsigned rxftrace : 1;              -- Set to run external trace.
-- end record; --  RXTRC_FLAGS;
subtype RXTRC_FLAGS is BYTE;

type  RXTRCTST_PARM is record        -- tst
  rxtrc_fl      : RXTRC_FLAGS ;            -- Set to run external trace
end record; --  RXTRCTST_PARM;
type PRXTRCTST_PARM is access all RXTRCTST_PARM;

    -- XLATOFF

    -- This typedef simplifies coding of an Exit handler.
type RexxExitHandler is access function (p1:LONG;
                                         p2:LONG;
                                         p3:PEXIT) return APIRET;

    --**      RexxRegisterExitDll - Register a system exit.

function RexxRegisterExitDll (
          nh:PSZ;                          -- Name of the exit handler
        ndll:PSZ;                          -- Name of the DLL
         np :PSZ;                          -- Name of the procedure
       area :PUCHAR;                       -- User area
       drop :ULONG ) return APIRET;                      -- Drop authority
pragma Import(c,RexxRegisterExitDll, Link_name=>"RexxRegisterExitDll");

    --**      RexxRegisterExitExe - Register a system exit.

function RexxRegisterExitExe (
          nh:PSZ;                          -- Name of the exit handler
         pnh:PSZ;                          -- Address of exit handler
       parea:PUCHAR) return APIRET;                      -- User area
pragma Import(c,RexxRegisterExitExe, Link_name=>"RexxRegisterExitExe");

    --**    RexxDeregisterExit - Drop registration of a system exit.

function RexxDeregisterExit (
  exitn     :PSZ;                          -- Exit name
  ndll      :PSZ ) return APIRET;                       -- DLL module name
pragma Import(c,RexxDeregisterExit, Link_name=>"RexxDeregisterExit");

    --**    RexxQueryExit - Query an exit for existance.

function RexxQueryExit (
          p1:PSZ;                          -- Exit name
          p2:PSZ;                          -- DLL Module name.
          p3:PUSHORT;                      -- Existance flag.
          p4:PUCHAR ) return APIRET;                     -- User data.
pragma Import(c,RexxQueryExit, Link_name=>"RexxQueryExit");

    --**    Asynchronous Request Interface
    --**    RexxSetHalt - Request Program Halt

function RexxSetHalt(
         p1: PID;                         -- Process Id
         p2: TID) return APIRET;                        -- Thread Id
pragma Import(c,RexxSetHalt, Link_name=>"RexxSetHalt");

    --**    RexxSetTrace - Request Program Trace

function RexxSetTrace(
          p1:PID;                         -- Process Id
          p2:TID) return APIRET;                        -- Thread Id
pragma Import(c,RexxSetTrace, Link_name=>"RexxSetTrace");

    --**    RexxResetTrace - Turn Off Program Trace

function RexxResetTrace(
         p1: PID;                         -- Process Id
         p2: TID) return APIRET;                        -- Thread Id
pragma Import(c,RexxResetTrace, Link_name=>"RexxResetTrace");

    --**    RexxAddMacro - Register a function in the Macro Space

function RexxAddMacro (
         p1 :PSZ;                         -- Function to add or change
         p2 :PSZ;                         -- Name of file to get function
         p3 :ULONG  ) return APIRET;                    -- Flag indicating search pos
pragma Import(c,RexxAddMacro, Link_name=>"RexxAddMacro");

    --**    RexxDropMacro - Remove a function from the Macro Space

function RexxDropMacro (
          p :PSZ ) return APIRET;                        -- Name of function to remove
pragma Import(c,RexxDropMacro, Link_name=>"RexxDropMacro");

    --**    RexxSaveMacroSpace - Save Macro Space functions to a file

function RexxSaveMacroSpace (
          p1:ULONG ;                      -- Argument count (0==save all)
          p2:PSZ  ;                       -- List of funct names to save
          p3:PSZ) return APIRET;                        -- File to save functions in
pragma Import(c,RexxSaveMacroSpace, Link_name=>"RexxSaveMacroSpace");

    --**    RexxLoadMacroSpace - Load Macro Space functions from a file

function RexxLoadMacroSpace (
         p1 :ULONG ;                      -- Argument count (0==load all)
         p2 :PSZ  ;                       -- List of funct names to load
         p3 :PSZ) return APIRET;                        -- File to load functions from
pragma Import(c,RexxLoadMacroSpace, Link_name=>"RexxLoadMacroSpace");

    --**    RexxQueryMacro - Find a function's search-order position

function RexxQueryMacro (
          p1:PSZ;                         -- Function to search for
          p2:PUSHORT ) return APIRET;                   -- Ptr for position flag return
pragma Import(c,RexxQueryMacro, Link_name=>"RexxQueryMacro");

    --**    RexxReorderMacro - Change a function's search-order
    --**                            position

function RexxReorderMacro(
         p1 :PSZ;                         -- Name of funct change order
         p2 :ULONG  ) return APIRET;                    -- New position for function
pragma Import(c,RexxReorderMacro, Link_name=>"RexxReorderMacro");

    --**    RexxClearMacroSpace - Remove all functions from a MacroSpace

function RexxClearMacroSpace return APIRET;  -- No Arguments.
pragma Import(c,RexxClearMacroSpace, Link_name=>"RexxClearMacroSpace");
end Os2.Rexx;
