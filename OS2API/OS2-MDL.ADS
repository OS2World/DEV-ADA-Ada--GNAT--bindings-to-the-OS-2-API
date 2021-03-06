
-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �       D E S I G N   E N G I N E R I N G              �D�S�        �
-- �            S O F T W A R E                           藩瞥�        �
-- �                                                                   �
-- �        Package     Os2.Mdl                                        �
-- �                                                                   �
-- �        Author :  Leonid Dulman     1995                           �
-- �                                                                   �
-- �             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            �
-- �                                                                   �
-- �          Module manager support  of os/2 api functions            �
-- �                                                                   �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Mdl  is
pragma Preelaborate (Mdl);

--** Module manager --

function  DosLoadModule(pszName   :PSZ      ;
                        cbName    :ULONG    ;
                        pszModname:PSZ      ;
                        phmod     :PHMODULE ) return apiret;
pragma Import(c,DosLoadModule, Link_name=>"_DosLoadModule");

function DosFreeModule(hmod:HMODULE ) return apiret;
pragma Import(c,DosFreeModule, Link_name=>"_DosFreeModule");

subtype PPFN is PVOID;

function DosQueryProcAddr(hmod   :HMODULE ;
                          ordinal:ULONG   ;
                          pszName:PSZ     ;
                          ppf    :PPFN    )  return apiret;
pragma Import(c,DosQueryProcAddr, Link_name=>"_DosQueryProcAddr");

function  DosQueryModuleHandle(pszModname:PSZ      ;
                               phmod     :PHMODULE ) return apiret;
pragma Import(c,DosQueryModuleHandle, Link_name=>"_DosQueryModuleHandle");

function DosQueryModuleName(hmod  :HMODULE ;
                            cbName:ULONG   ;
                            pch   :PCHAR   ) return apiret;
pragma Import(c,DosQueryModuleName, Link_name=>"_DosQueryModuleName");

 PT_16BIT :constant ushort:= 0;
 PT_32BIT :constant ushort:= 1 ;

function DosQueryProcType(hmod       :HMODULE ;
                          ordinal    :ULONG   ;
                          pszName    :PSZ     ;
                          pulproctype:PULONG  ) return apiret;
pragma Import(c,DosQueryProcType, Link_name=>"_DosQueryProcType");
end Os2.Mdl;
