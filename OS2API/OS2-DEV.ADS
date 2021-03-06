
-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �       D E S I G N   E N G I N E R I N G              �D�S�        �
-- �            S O F T W A R E                           藩瞥�        �
-- �                                                                   �
-- �        Package     OS2.Dev                                        �
-- �                                                                   �
-- �        Author :  Leonid Dulman     1995                           �
-- �                                                                   �
-- �             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            �
-- �                                                                   �
-- �             IOCtl     support    of os/2 api functions            �
-- �                                                                   �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Dev  is
pragma Preelaborate (Dev);

-- Device support --
subtype HFILE  is  LHANDLE ;     -- hf --

--   #define DosDevIOCtl2    DosDevIOCtl

function  DosDevConfig(pdevinfo:PVOID ;
                       item    :ULONG ) return apiret;
pragma Import(c,DosDevConfig, Link_name=>"_DosDevConfig");


 DEVINFO_PRINTER      : constant ushort:=   0 ;  -- Number of printers attached
 DEVINFO_RS232        : constant ushort:=   1 ;  -- Number of RS232 ports
 DEVINFO_FLOPPY       : constant ushort:=   2 ;  -- Number of diskette drives
 DEVINFO_COPROCESSOR  : constant ushort:=   3 ;  -- Presence of math coprocessor
 DEVINFO_SUBMODEL     : constant ushort:=   4 ;  -- PC Submodel Type
 DEVINFO_MODEL        : constant ushort:=   5 ;  -- PC Model Type
 DEVINFO_ADAPTER      : constant ushort:=   6 ;  -- Primary display adapter type

function  DosDevIOCtl(hDevice     :HFILE  ;
                      category    :ULONG  ;
                      func        :ULONG  ;
                      pParams     :PVOID  ;
                      cbParmLenMax:ULONG  ;
                      pcbParmLen  :PULONG ;
                      pData       :PVOID  ;
                      cbDataLenMax:ULONG  ;
                      pcbDataLen  :PULONG ) return apiret;
pragma Import(c,DosDevIOCtl, Link_name=>"_DosDevIOCtl");


function  DosPhysicalDisk(func    :ULONG ;
                          pBuf    :PVOID ;
                          cbBuf   :ULONG ;
                          pParams :PVOID ;
                          cbParams:ULONG ) return apiret;
pragma Import(c,DosPhysicalDisk, Link_name=>"_DosPhysicalDisk");


 INFO_COUNT_PARTITIONABLE_DISKS  : constant ushort:=   1 ;  -- # of partitionable disks
 INFO_GETIOCTLHANDLE             : constant ushort:=   2 ;  -- Obtain handle
 INFO_FREEIOCTLHANDLE            : constant ushort:=   3 ;  -- Release handle
end Os2.Dev;
