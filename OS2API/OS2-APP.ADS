
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.App                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Exception support    of os/2 api functions            บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.App  is
pragma Preelaborate (App);
   -- AppType returned in by DosQueryAppType in pFlags as follows          --
 FAPPTYP_NOTSPEC         :constant:=16#0000#;
 FAPPTYP_NOTWINDOWCOMPAT :constant:=16#0001#;
 FAPPTYP_WINDOWCOMPAT    :constant:=16#0002#;
 FAPPTYP_WINDOWAPI       :constant:=16#0003#;
 FAPPTYP_BOUND           :constant:=16#0008#;
 FAPPTYP_DLL             :constant:=16#0010#;
 FAPPTYP_DOS             :constant:=16#0020#;
 FAPPTYP_PHYSDRV         :constant:=16#0040#;  -- physical device driver       --
 FAPPTYP_VIRTDRV         :constant:=16#0080#;  -- virtual device driver        --
 FAPPTYP_PROTDLL         :constant:=16#0100#;  -- 'protected memory' dll       --
 FAPPTYP_WINDOWSREAL     :constant:=16#0200#;  -- Windows real mode app        --
 FAPPTYP_WINDOWSPROT     :constant:=16#0400#;  -- Windows protect mode app     --
 FAPPTYP_WINDOWSPROT31   :constant:=16#1000#;  -- Windows 3.1 protect mode app --
 FAPPTYP_32BIT           :constant:=16#4000#;
 FAPPTYP_EXETYPE         :constant:=16#0003#;
 EAT_APPTYP_PMAPI        :constant:=16#00#;          -- Uses PM API --
 EAT_APPTYP_DOS          :constant:=16#01#;          -- DOS APP --
 EAT_APPTYP_PMW          :constant:=16#02#;          -- Window compatible --
 EAT_APPTYP_NOPMW        :constant:=16#03#;          -- Not Window compatible --
 EAT_APPTYP_EXETYPE      :constant:=16#03#;          -- EXE type mask --
 -- EAT_APPTYP_RESERVED     ~(EAT_APPTYP_EXETYPE)
end os2.app;
