
-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �       D E S I G N   E N G I N E R I N G              �D�S�        �
-- �            S O F T W A R E                           藩瞥�        �
-- �                                                                   �
-- �        Package     Os2.PMtm                                       �
-- �                                                                   �
-- �        Author :  Leonid Dulman     1995 , 1996                    �
-- �                                                                   �
-- �             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            �
-- �                                                                   �
-- �               PM   Timer manager                                  �
-- �                                                                   �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMtm is
pragma Preelaborate (PMtm);
--     Timer manager

function WinStartTimer(ha       :HAB   ;
                       hwn      :HWND  ;
                       idTimer  :ULONG ;
                       dtTimeout:ULONG )return ULONG;
pragma Import(c,WinStartTimer, Link_name=>"_WinStartTimer");

function WinStopTimer(ha     :HAB   ;
                      hwn    :HWND  ;
                      idTimer:ULONG )return BOOL32  ;
pragma Import(c,WinStopTimer, Link_name=>"_WinStopTimer");

function WinGetCurrentTime(ha :HAB )return ULONG ;
pragma Import(c,WinGetCurrentTime, Link_name=>"_WinGetCurrentTime");

 TID_CURSOR        :constant ulong:=16#ffff#;  -- Reserved cursor timer ID
 TID_SCROLL        :constant ulong:=16#fffe#;  -- Reserved scrolling timer ID
 TID_FLASHWINDOW   :constant ulong:=16#fffd#;  -- Reserved for window flashing timer ID
 TID_USERMAX       :constant ulong:=16#7fff#;  -- Maximum user timer ID

end os2.PMtm;
