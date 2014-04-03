
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     OS2.NLS                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               NLS support    of os/2 api functions                บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.Nls  is
pragma Preelaborate (Nls);

--** NLS Support --

type COUNTRYCODE is record    -- ctryc --

 country      :ULONG       ;
 codepage     :ULONG       ;
end record;  -- COUNTRYCODE;
type PCOUNTRYCODE is access all COUNTRYCODE;
type USHORT_arr is array(integer range <> ) of ushort;
type COUNTRYINFO  is record   -- ctryi --
  country                 :ULONG       ;
  codepage                :ULONG       ;
  fsDateFmt               :ULONG       ;
  szCurrency              :string(1..5); --[5];
  szThousandsSeparator    :string(1..2); --[2];
  szDecimal               :string(1..2); --[2];
  szDateSeparator         :string(1..2); --[2];
  szTimeSeparator         :string(1..2); --[2];
  fsCurrencyFmt           :UCHAR       ;
  cDecimalPlace           :UCHAR       ;
  fsTimeFmt               :UCHAR       ;
  abReserved1             :USHORT_arr(1..2); --2];
  szDataSeparator         :string(1..2);-- [2];
  abReserved2             :USHORT_arr(1..5); --[5];
end record;  -- COUNTRYINFO;
type  PCOUNTRYINFO is access all COUNTRYINFO ;

--    ษออออออออออออออออออออออออออออออออออออออออออออป
--    บ#define DosGetCtryInfo  DosQueryCtryInfo    บ
--    บ#define DosGetDBCSEv    DosQueryDBCSEnv     บ
--    บ#define DosCaseMap      DosMapCase          บ
--    บ#define DosGetCollate   DosQueryCollate     บ
--    บ#define DosGetCp        DosQueryCp          บ
--    บ#define DosSetProcCp    DosSetProcessCp     บ
--    ศออออออออออออออออออออออออออออออออออออออออออออผ

function DosQueryCtryInfo(cb       :ULONG        ;
                          pcc      :PCOUNTRYCODE ;
                          pci      :PCOUNTRYINFO ;
                          pcbActual:PULONG       ) return apiret;
pragma Import(c,DosQueryCtryInfo, Link_name=>"DosQueryCtryInfo");

function DosQueryDBCSEnv(cb  :ULONG        ;
                         pcc :PCOUNTRYCODE ;
                         pBuf:PCHAR        ) return apiret;
pragma Import(c,DosQueryDBCSEnv, Link_name=>"DosQueryDBCSEnv");

function DosMapCase(cb :ULONG        ;
                    pcc:PCOUNTRYCODE ;
                    pch:PCHAR        ) return apiret;
pragma Import(c,DosMapCase, Link_name=>"DosMapCase");

function  DosQueryCollate(cb  :ULONG        ;
                          pcc :PCOUNTRYCODE ;
                          pch :PCHAR        ;
                          pcch:PULONG       ) return apiret;
pragma Import(c,DosQueryCollate, Link_name=>"DosQueryCollate");

function  DosQueryCp(cb  :ULONG  ;
                     arCP:PULONG ;
                     pcCP:PULONG ) return apiret;
pragma Import(c,DosQueryCp, Link_name=>"DosQueryCp");

function DosSetProcessCp(cp:ULONG ) return apiret;
pragma Import(c,DosSetProcessCp, Link_name=>"DosSetProcessCp");
end Os2.Nls;
