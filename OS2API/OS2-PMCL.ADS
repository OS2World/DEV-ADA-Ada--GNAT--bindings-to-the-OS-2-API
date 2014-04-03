
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.PMcl                                       บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               PM        System color   functions                  บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Os2.PMcl is
pragma Preelaborate (PMcl);
--     System color ; functions

function WinQuerySysColor(hwndDesktop:HWND ;
                          clr        :LONG ;
                          lReserved  :LONG )return LONG;

pragma Import(c,WinQuerySysColor, Link_name=>"_WinQuerySysColor");

function WinSetSysColors(hwndDesktop:HWND  ;
                         flOptions  :ULONG ;
                         flFormat   :ULONG ;
                         clrFirst   :LONG  ;
                         cclr       :ULONG ;
                         pclr       :PLONG )return BOOL32;
pragma Import(c,WinSetSysColors, Link_name=>"_WinSetSysColors");

 SYSCLR_SHADOWHILITEBGND        :constant Long := -50;
 SYSCLR_SHADOWHILITEFGND        :constant Long := -49;
 SYSCLR_SHADOWTEXT              :constant Long := -48;
 SYSCLR_ENTRYFIELD              :constant Long := -47;
 SYSCLR_MENUDISABLEDTEXT        :constant Long := -46;
 SYSCLR_MENUHILITE              :constant Long := -45;
 SYSCLR_MENUHILITEBGND          :constant Long := -44;
 SYSCLR_PAGEBACKGROUND          :constant Long := -43;
 SYSCLR_FIELDBACKGROUND         :constant Long := -42;
 SYSCLR_BUTTONLIGHT             :constant Long := -41;
 SYSCLR_BUTTONMIDDLE            :constant Long := -40;
 SYSCLR_BUTTONDARK              :constant Long := -39;
 SYSCLR_BUTTONDEFAULT           :constant Long := -38;
 SYSCLR_TITLEBOTTOM             :constant Long := -37;
 SYSCLR_SHADOW                  :constant Long := -36;
 SYSCLR_ICONTEXT                :constant Long := -35;
 SYSCLR_DIALOGBACKGROUND        :constant Long := -34;
 SYSCLR_HILITEFOREGROUND        :constant Long := -33;
 SYSCLR_HILITEBACKGROUND        :constant Long := -32;
 SYSCLR_INACTIVETITLETEXTBGND   :constant Long := -31;
 SYSCLR_ACTIVETITLETEXTBGND     :constant Long := -30;
 SYSCLR_INACTIVETITLETEXT       :constant Long := -29;
 SYSCLR_ACTIVETITLETEXT         :constant Long := -28;
 SYSCLR_OUTPUTTEXT              :constant Long := -27;
 SYSCLR_WINDOWSTATICTEXT        :constant Long := -26;
 SYSCLR_SCROLLBAR               :constant Long := -25;
 SYSCLR_BACKGROUND              :constant Long := -24;
 SYSCLR_ACTIVETITLE             :constant Long := -23;
 SYSCLR_INACTIVETITLE           :constant Long := -22;
 SYSCLR_MENU                    :constant Long := -21;
 SYSCLR_WINDOW                  :constant Long := -20;
 SYSCLR_WINDOWFRAME             :constant Long := -19;
 SYSCLR_MENUTEXT                :constant Long := -18;
 SYSCLR_WINDOWTEXT              :constant Long := -17;
 SYSCLR_TITLETEXT               :constant Long := -16;
 SYSCLR_ACTIVEBORDER            :constant Long := -15;
 SYSCLR_INACTIVEBORDER          :constant Long := -14;
 SYSCLR_APPWORKSPACE            :constant Long := -13;
 SYSCLR_HELPBACKGROUND          :constant Long := -12;
 SYSCLR_HELPTEXT                :constant Long := -11;
 SYSCLR_HELPHILITE              :constant Long := -10;
 SYSCLR_CSYSCOLORS              :constant Long :=  41;
end os2.PMcl;
