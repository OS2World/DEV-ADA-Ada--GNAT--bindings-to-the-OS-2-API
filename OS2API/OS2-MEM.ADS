
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     OS2.MEM                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Memory  part of os/2 api functions                    บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Mem is
pragma Preelaborate (Mem);

   --** Memory management --
subtype PPVOID is PVOID;
 -- Access protection                                                          */
  PAG_READ    :constant ushort:=16#00000001#; -- read access                      */
  PAG_WRITE   :constant ushort:=16#00000002#; -- write access                     */
  PAG_EXECUTE :constant ushort:=16#00000004#; -- execute access                   */
  PAG_GUARD   :constant ushort:=16#00000008#; -- guard protection                 */
  PAG_DEFAULT :constant ushort:=16#00000400#; -- default (initial) access         */
 -- Commit
  PAG_COMMIT  :constant ushort:=16#00000010#; -- commit storage                   */
  PAG_DECOMMIT:constant ushort:=16#00000020#; -- decommit storage                 */
 -- Allocation attributes                                                      */
  OBJ_TILE     :constant ushort:=16#00000040#; -- tile object                      */
  OBJ_PROTECTED:constant ushort:=16#00000080#; -- protect object
  OBJ_GETTABLE :constant ushort:=16#00000100#; -- gettable by other processes      */
  OBJ_GIVEABLE :constant ushort:=16#00000200#; -- giveable to other processes      */
 --      fPERM             (PAG_EXECUTE | PAG_READ | PAG_WRITE)
 --      fSHARE            (OBJ_GETTABLE | OBJ_GIVEABLE)
 -- DosAllocMem flags                                                          */
 --      fALLOC            (OBJ_TILE | PAG_COMMIT | fPERM)
 -- DosAllocSharedMem flags                                                    */
 --      fALLOCSHR         (OBJ_TILE | PAG_COMMIT | fSHARE | fPERM)
 -- DosGetNamedSharedMem flags                                                 */
 --      fGETNMSHR         (fPERM)
 -- DosGetSharedMem flags                                                      */
 --      fGETSHR           (fPERM)
 -- DosGiveSharedMem flags                                                     */
 --      fGIVESHR          (fPERM)
 -- DosSetMem flags                                                            */
 --      fSET         (PAG_COMMIT + PAG_DECOMMIT + PAG_DEFAULT + fPERM)
 -- Dos32SubSet flags                                                          */
  DOSSUB_INIT       :constant ushort:=16#01#; -- initialize memory object for     */
  DOSSUB_GROW       :constant ushort:=16#02#; -- increase size of memory pool     */
  DOSSUB_SPARSE_OBJ :constant ushort:=16#04#; -- indicator for DosSub to          */
  DOSSUB_SERIALIZE  :constant ushort:=16#08#; -- indicates that access to the     */
 -- Allocation type (returned from DosQueryMem)                                */
  PAG_SHARED        :constant ulong :=16#00002000#; -- shared object                    */
  PAG_FREE          :constant ulong :=16#00004000#; -- pages are free                   */
  PAG_BASE          :constant ulong :=16#00010000#; -- first page in object             */

function DosAllocMem(ppb :PPVOID ;
                     cb  :ULONG ;
                     flag:ULONG ) return apiret;
pragma Import(c,DosAllocMem, Link_name=>"_DosAllocMem");

function   DosFreeMem(pb:PVOID ) return apiret;
pragma Import(c,DosFreeMem, Link_name=>"_DosFreeMem");

function DosSetMem(pb  :PVOID ;
                   cb  :ULONG ;
                   flag:ULONG ) return apiret;
pragma Import(c,DosSetMem, Link_name=>"_DosSetMem");

function DosGiveSharedMem(pb  :PVOID ;
                          pd  :PID   ;
                          flag:ULONG ) return apiret;
pragma Import(c,DosGiveSharedMem, Link_name=>"_DosGiveSharedMem");

function  DosGetSharedMem(pb  :PVOID ;
                          flag:ULONG ) return apiret;
pragma Import(c,DosGetSharedMem, Link_name=>"_DosGetSharedMem");

function DosGetNamedSharedMem(ppb    :PPVOID ;
                              pszName:PSZ    ;
                              flag   :ULONG  ) return apiret;
pragma Import(c,DosGetNamedSharedMem, Link_name=>"_DosGetNamedSharedMem");

function DosAllocSharedMem(ppb    :PPVOID ;
                           pszName:PSZ    ;
                           cb     :ULONG  ;
                           flag   :ULONG  ) return apiret;
pragma Import(c,DosAllocSharedMem, Link_name=>"_DosAllocSharedMem");

function DosQueryMem(pb   :PVOID  ;
                     pcb  :PULONG ;
                     pFlag:PULONG ) return apiret;
pragma Import(c,DosQueryMem, Link_name=>"_DosQueryMem");

--   ษอออออออออออออออออออออออออออออออออออออออออป
--   บ #define DosSubAlloc     DosSubAllocMem  บ
--   บ #define DOSSUBALLOC     DosSubAllocMem  บ
--   ศอออออออออออออออออออออออออออออออออออออออออผ

function  DosSubAllocMem(pbBase:PVOID  ;
                         ppb   :PPVOID ;
                         cb    :ULONG  ) return apiret;
pragma Import(c,DosSubAllocMem, Link_name=>"_DosSubAllocMem");

--    ษออออออออออออออออออออออออออออออออออออออป
--    บ#define DosSubFree      DosSubFreeMem บ
--    บ#define DOSSUBFREE      DosSubFreeMem บ
--    ศออออออออออออออออออออออออออออออออออออออผ

function  DosSubFreeMem(pbBase:PVOID ;
                        pb    :PVOID ;
                        cb    :ULONG ) return apiret;
pragma Import(c,DosSubFreeMem, Link_name=>"_DosSubFreeMem");
--    ษอออออออออออออออออออออออออออออออออออออป
--    บ#define DosSubSet       DosSubSetMem บ
--    บ#define DOSSUBSET       DosSubSetMem บ
--    ศอออออออออออออออออออออออออออออออออออออผ

function  DosSubSetMem(pbBase:PVOID ;
                       flag  :ULONG ;
                       cb    :ULONG ) return apiret;
pragma Import(c,DosSubSetMem, Link_name=>"_DosSubSetMem");
--    ษออออออออออออออออออออออออออออออออออออออออป
--    บ#define DosSubUnset     DosSubUnsetMem  บ
--    บ#define DOSSUBUNSET     DosSubUnsetMem  บ
--    ศออออออออออออออออออออออออออออออออออออออออผ

function  DosSubUnsetMem(pbBase:PVOID ) return apiret;
pragma Import(c,DosSubUnsetMem, Link_name=>"_DosSubUnsetMem");
end os2.Mem;
