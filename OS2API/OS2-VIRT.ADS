
-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �       D E S I G N   E N G I N E R I N G              �D�S�        �
-- �            S O F T W A R E                           藩瞥�        �
-- �                                                                   �
-- �        Package     Os2.Virt                                       �
-- �                                                                   �
-- �        Author :  Leonid Dulman     1995                           �
-- �                                                                   �
-- �             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            �
-- �                                                                   �
-- �                  Virtual DOS Machine API support                  �
-- �                                                                   �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Virt is
pragma Preelaborate (Virt);

-- Virtual DOS Machine API support --

subtype HVDD is  LHANDLE   ;     -- hvdd --
type PHVDD     is access all HVDD;    -- phvdd --

subtype SGID is USHORT;

 function   DosOpenVDD(pszVDD:PSZ   ;
                       phvd  :PHVDD )return apiret;
pragma Import(c,DosOpenVDD, Link_name=>"_DosOpenVDD");

function   DosRequestVDD(hvd     :HVDD  ;
                         sgd     :SGID  ;
                         cmd     :ULONG ;
                         cbInput :ULONG ;
                         pInput  :PVOID ;
                         cbOutput:ULONG ;
                         pOutput :PVOID )return apiret;
pragma Import(c,DosRequestVDD, Link_name=>"_DosRequestVDD");

function   DosCloseVDD(hvd:HVDD )return apiret;
pragma Import(c,DosCloseVDD, Link_name=>"_DosCloseVDD");

function   DosQueryDOSProperty(sgd    :SGID  ;
                               pszName:PSZ   ;
                               cb     :ULONG ;
                               pch    :PSZ   )return apiret;
pragma Import(c,DosQueryDOSProperty, Link_name=>"_DosQueryDOSProperty");

function   DosSetDOSProperty(sgd    :SGID  ;
                             pszName:PSZ   ;
                             cb     :ULONG ;
                             pch    :PSZ   )return apiret;
pragma Import(c,DosSetDOSProperty, Link_name=>"_DosSetDOSProperty");

end Os2.Virt;
