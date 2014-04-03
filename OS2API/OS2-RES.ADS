
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package  SYSTEM.RES                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               Resource  part of os/2 api functions                บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Res  is
pragma Preelaborate (Res);

   --** Resource support --

   -- Predefined resource types --

 RT_POINTER     :constant Long:=   1; -- mouse pointer shape
 RT_BITMAP      :constant Long:=   2; -- bitmap
 RT_MENU        :constant Long:=   3; -- menu template
 RT_DIALOG      :constant Long:=   4; -- dialog template
 RT_STRING      :constant Long:=   5; -- string tables
 RT_FONTDIR     :constant Long:=   6; -- font directory
 RT_FONT        :constant Long:=   7; -- font
 RT_ACCELTABLE  :constant Long:=   8; -- accelerator tables
 RT_RCDATA      :constant Long:=   9; -- binary data
 RT_MESSAGE     :constant Long:=  10; -- error msg tables
 RT_DLGINCLUDE  :constant Long:=  11; -- dialog include file name
 RT_VKEYTBL     :constant Long:=  12; -- key to vkey tables
 RT_KEYTBL      :constant Long:=  13; -- key to UGL tables
 RT_CHARTBL     :constant Long:=  14; -- glyph to character tables
 RT_DISPLAYINFO :constant Long:=  15; -- screen display information
 RT_FKASHORT    :constant Long:=  16; -- function key area short form
 RT_FKALONG     :constant Long:=  17; -- function key area long form
 RT_HELPTABLE   :constant Long:=  18; -- Help table for Cary Help manager
 RT_HELPSUBTABLE:constant Long:=  19; -- Help subtable for Cary Help manager
 RT_FDDIR       :constant Long:=  20; -- DBCS uniq/font driver directory
 RT_FD          :constant Long:=  21; -- DBCS uniq/font driver
 RT_MAX         :constant Long:=  22; -- 1st unused Resource Type
 -- RF_ORDINALID   :constant Long:= 16#80000000#; ?? -- ordinal id flag in resource table

--      DosGetResource2 DosGetResource

function   DosGetResource(hmod  :HMODULE ;
                          idType:ULONG   ;
                          idName:ULONG   ;
                          ppb   :PPVOID  )return apiret;
pragma Import(c,DosGetResource, Link_name=>"_DosGetResource");

function   DosFreeResource(pb:PVOID )return apiret;
pragma Import(c,DosFreeResource, Link_name=>"_DosFreeResource");

function   DosQueryResourceSize(hmod   :HMODULE ;
                                idt    :ULONG   ;
                                idn    :ULONG   ;
                                pulsize:PULONG  )return apiret;
pragma Import(c,DosQueryResourceSize, Link_name=>"_DosQueryResourceSize");

       --** Resource support --
       -- Predefined resource types --
--    ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
--    บ RT_POINTER      1   -- mouse pointer shape --                          บ
--    บ RT_BITMAP       2   -- bitmap --                                       บ
--    บ RT_MENU         3   -- menu template --                                บ
--    บ RT_DIALOG       4   -- dialog template --                              บ
--    บ RT_STRING       5   -- string tables --                                บ
--    บ RT_FONTDIR      6   -- font directory --                               บ
--    บ RT_FONT         7   -- font --                                         บ
--    บ RT_ACCELTABLE   8   -- accelerator tables --                           บ
--    บ RT_RCDATA       9   -- binary data --                                  บ
--    บ RT_MESSAGE      10  -- error msg     tables --                         บ
--    บ RT_DLGINCLUDE   11  -- dialog include file name --                     บ
--    บ RT_VKEYTBL      12  -- key to vkey tables --                           บ
--    บ RT_KEYTBL       13  -- key to UGL tables --                            บ
--    บ RT_CHARTBL      14  -- glyph to character tables --                    บ
--    บ RT_DISPLAYINFO  15  -- screen display information --                   บ
--    บ RT_FKASHORT     16  -- function key area short form --                 บ
--    บ RT_FKALONG      17  -- function key area long form --                  บ
--    บ RT_HELPTABLE    18  -- Help table for Cary Help manager --             บ
--    บ RT_HELPSUBTABLE 19  -- Help subtable for Cary Help manager --          บ
--    บ RT_FDDIR        20  -- DBCS uniq/font driver directory --              บ
--    บ RT_FD           21  -- DBCS uniq/font driver --                        บ
--    บ RT_MAX          22  -- 1st unused Resource Type --                     บ
--    บ RF_ORDINALID    0x80000000L     -- ordinal id flag in resource table --บ
--    ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
--
end Os2.Res;
