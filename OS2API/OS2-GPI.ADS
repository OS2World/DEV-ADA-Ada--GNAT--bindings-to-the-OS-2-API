
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.Gpi                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995 , 1996                    บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ               PM   GPI Interface                                  บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

package Os2.Gpi is
pragma Preelaborate (Gpi);

--  General GPI return values
 GPI_ERROR    :constant long:=   0;
 GPI_OK       :constant long:=   1;
 GPI_ALTERROR :constant long:=  -1;
--
--  long point number - implicit binary point between 2 and 3 hex digits
--  long point number - implicit binary point between 1st and 2nd hex digits
subtype FIXED88 is  USHORT ;  -- fx88

--   fixed point signed number - implicit binary point between bits 14 and 13.
--                               Bit 15 is the sign bit.
--                               Thus 1.0 is represented by 16384 (0x4000)
--                               and -1.0 is represented by -16384 (0xc000)

subtype FIXED114 is USHORT ; -- fx114
--
--  -- make LONG number from SHORT integer part and USHORT fractional part
--  #define MAKEFIXED(intpart,fractpart) MAKELONG(fractpart,intpart)
--  -- extract fractional part from a fixed quantity
--  #define FIXEDFRAC(fx)                (LOUSHORT(fx))
--  -- extract integer part from a fixed quantity
--  #define FIXEDINT(fx)                 ((SHORT)HIUSHORT(fx))

--  -- structure for size parameters e.g. for GpiCreatePS
type SIZEL    is record          -- sizl
  cx  :LONG ;
  cy  :LONG ;
end record; -- SIZEL;
type PSIZEL  is access all SIZEL;

--  -- return code on GpiQueryLogColorTable,GpiQueryRealColors and GpiQueryPel
CLR_NOINDEX :constant Long:=-254;

--     -- units for GpiCreatePS and others

 PU_ARBITRARY :constant  Long:= 16#0004#;
 PU_PELS      :constant  Long:= 16#0008#;
 PU_LOMETRIC  :constant  Long:= 16#000C#;
 PU_HIMETRIC  :constant  Long:= 16#0010#;
 PU_LOENGLISH :constant  Long:= 16#0014#;
 PU_HIENGLISH :constant  Long:= 16#0018#;
 PU_TWIPS     :constant  Long:= 16#001C#;

       -- format for GpiCreatePS
 GPIF_DEFAULT :constant  Long:=                   0 ;
 GPIF_SHORT   :constant  Long:=              16#0100#;
 GPIF_LONG    :constant  Long:=              16#0200#;

-- PS type for GpiCreatePS
 GPIT_NORMAL :constant  Long:=                    0 ;
 GPIT_MICRO  :constant  Long:=               16#1000#;

-- implicit associate flag for GpiCreatePS
 GPIA_NOASSOC :constant  Long:=                   0 ;
 GPIA_ASSOC   :constant  Long:=              16#4000#;

-- PS Fill type for GpiCreatePS defect: 61035 RickT Add exclusive fill
 GPIM_AREAEXCL :constant  Long:=             16#8000#;

   -- return error for GpiQueryDevice
--  HDC_ERROR                ((HDC)-1L )

-- common GPICONTROL functions

function GpiCreatePS(ha       :HAB    ;
                     dc       :HDC    ;
                     psizlSize:PSIZEL ;
                     flOptions:ULONG  ) return HPS ;
pragma Import(c,GpiCreatePs, Link_name=>"_GpiCreatePs");

function GpiDestroyPS(ps:HPS ) return BOOL;
pragma Import(c,GpiDestroyPS, Link_name=>"_GpiDestroyPS");

function GpiAssociate(ps:HPS ;
                      dc:HDC  ) return BOOL;
pragma Import(c,GpiAssociate, Link_name=>"_GpiAssociate");

function GpiRestorePS(ps   :HPS  ;
                      lPSid:LONG ) return BOOL;
pragma Import(c,GpiRestorePs, Link_name=>"_GpiRestorePs");

function GpiSavePS(ps:HPS  ) return LONG;
pragma Import(c,GpiSavePs, Link_name=>"_GpiSavePs");

function GpiErase(ps:HPS  ) return  BOOL;
pragma Import(c,GpiErase, Link_name=>"_GpiErase");

function GpiQueryDevice(pc:HPS) return  HDC;
pragma Import(c,GpiQueryDevice, Link_name=>"_GpiQueryDevice");

-- options for GpiResetPS
 GRES_ATTRS    :constant  Long:=             16#0001#;
 GRES_SEGMENTS :constant  Long:=             16#0002#;
 GRES_ALL      :constant  Long:=             16#0004#;

-- option masks for PS options used by GpiQueryPs
 PS_UNITS      :constant  Long:=             16#00FC#;
 PS_FORMAT     :constant  Long:=             16#0F00#;
 PS_TYPE       :constant  Long:=             16#1000#;
 PS_MODE       :constant  Long:=             16#2000#;
 PS_ASSOCIATE  :constant  Long:=             16#4000#;
 PS_NORESET    :constant  Long:=             16#8000#;


-- error context returned by GpiErrorSegmentData
 GPIE_SEGMENT  :constant  Long:=                 0 ;
 GPIE_ELEMENT  :constant  Long:=                 1 ;
 GPIE_DATA     :constant  Long:=                 2 ;

   -- control parameter for GpiSetDrawControl
    DCTL_ERASE    :constant  Long:=                 1 ;
    DCTL_DISPLAY  :constant  Long:=                 2 ;
    DCTL_BOUNDARY :constant  Long:=                 3 ;
    DCTL_DYNAMIC  :constant  Long:=                 4 ;
    DCTL_CORRELATE:constant  Long:=                 5 ;

   -- constants for GpiSet/QueryDrawControl
    DCTL_ERROR    :constant  Long:=                 -1 ;
    DCTL_OFF      :constant  Long:=                 0 ;
    DCTL_ON       :constant  Long:=                 1 ;

   -- constants for GpiSet/QueryStopDraw
    SDW_ERROR     :constant  Long:=                 -1 ;
    SDW_OFF       :constant  Long:=                 0 ;
    SDW_ON        :constant  Long:=                 1 ;

-- drawing for GpiSet/QueryDrawingMode
 DM_ERROR         :constant  Long:=              0 ;
 DM_DRAW          :constant  Long:=              1 ;
 DM_RETAIN        :constant  Long:=              2 ;
 DM_DRAWANDRETAIN :constant  Long:=              3 ;

--   other GPICONTROL functions

function GpiResetPS(ps       :HPS   ;
                    flOptions:ULONG ) return BOOL;
pragma Import(c,GpiResetPs, Link_name=>"_GpiResetPs");

function GpiSetPS(ps       :HPS    ;
                  psizlsize:PSIZEL ;
                  flOptions:ULONG  ) return  BOOL;
pragma Import(c,GpiSetPs, Link_name=>"_GpiSetPs");

function GpiQueryPS(ps       :HPS    ;
                    psizlSize:PSIZEL ) return   ULONG;
pragma Import(c,GpiQueryPs, Link_name=>"_GpiQueryPs");

function GpiErrorSegmentData(ps       :HPS   ;
                             plSegment:PLONG ;
                             plContext:PLONG ) return LONG ;
pragma Import(c,GpiErrorSegmentData, Link_name=>"_GpiErrorSegmentData");

function GpiQueryDrawControl(ps      :HPS  ;
                             lControl:LONG ) return LONG;
pragma Import(c,GpiQueryDrawControl, Link_name=>"_GpiQueryDrawControl");

function GpiSetDrawControl(ps      :HPS  ;
                           lControl:LONG ;
                           lValue  :LONG ) return BOOL;
pragma Import(c,GpiSetDrawControl, Link_name=>"_GpiSetDrawControl");

function GpiQueryDrawingMode(ps :HPS ) return  LONG;
pragma Import(c,GpiQueryDrawingMode, Link_name=>"_GpiQueryDrawingMode");

function GpiSetDrawingMode(ps   :HPS  ;
                           lMode:LONG ) return  BOOL;
pragma Import(c,GpiSetDrawingMode, Link_name=>"_GpiSetDrawingMode");

function GpiQueryStopDraw( ps :HPS) return  LONG;
pragma Import(c,GpiQueryStopDraw, Link_name=>"_GpiQueryStopDraw");

function GpiSetStopDraw(ps    :HPS  ;
                        lValue:LONG ) return BOOL;
pragma Import(c,GpiSetStopDraw, Link_name=>"_GpiSetStopDraw");

-- options for GpiSetPickApertureSize
 PICKAP_DEFAULT  :constant  Long:=               0 ;
 PICKAP_REC      :constant  Long:=               2 ;

-- type of correlation for GpiCorrelateChain
 PICKSEL_VISIBLE :constant  Long:=               0 ;
 PICKSEL_ALL     :constant  Long:=               1 ;

-- return code to indicate correlate hit(s)
 GPI_HITS        :constant  Long:=               2 ;

--     picking;  correlation and boundary functions

function GpiCorrelateChain(ps       :HPS     ;
                           lType    :LONG    ;
                           pptlPick :PPOINTL ;
                           lMaxHits :LONG    ;
                           lMaxDepth:LONG    ;
                           pl2      :PLONG   ) return LONG;
pragma Import(c,GpiCorrelateChain, Link_name=>"_GpiCorrelateChain");

function GpiQueryTag(ps   :HPS   ;
                     plTag:PLONG ) return BOOL;
pragma Import(c,GpiQueryTag, Link_name=>"_GpiQueryTag");

function GpiSetTag(ps  :HPS  ;
                   lTag:LONG ) return BOOL;
pragma Import(c,GpiSetTag, Link_name=>"_GpiSetTag");

function GpiQueryPickApertureSize(ps       :HPS    ;
                                  psizlSize:PSIZEL ) return BOOL;
pragma Import(c,GpiQueryPickApertureSize, Link_name=>"_GpiQueryPickApertureSize");

function GpiSetPickApertureSize(ps       :HPS    ;
                                lOptions :LONG   ;
                                psizlSize:PSIZEL ) return BOOL;
pragma Import(c,GpiSetPickApertureSize, Link_name=>"_GpiSetPickApertureSize");

function GpiQueryPickAperturePosition(ps       :HPS     ;
                                      pptlPoint:PPOINTL ) return BOOL;
pragma Import(c,GpiQueryPickAperturePosition, Link_name=>"_GpiQueryPickAperturePosition");

function GpiSetPickAperturePosition(ps      :HPS     ;
                                    pptlPick:PPOINTL ) return BOOL;
pragma Import(c,GpiSetPickAperturePosition, Link_name=>"_GpiSetPickAperturePosition");

function GpiQueryBoundaryData(ps          :HPS    ;
                              prclBoundary:PRECTL ) return BOOL;
pragma Import(c,GpiQueryBoundaryData, Link_name=>"_GpiQueryBoundaryData");

function GpiResetBoundaryData(ps :HPS ) return BOOL;
pragma Import(c,GpiResetBoundaryData, Link_name=>"_GpiResetBoundaryData");

function GpiCorrelateFrom(ps           :HPS     ;
                          lFirstSegment:LONG    ;
                          lLastSegment :LONG    ;
                          lType        :LONG    ;
                          pptlPick     :PPOINTL ;
                          lMaxHits     :LONG    ;
                          lMaxDepth    :LONG    ;
                          plSegTag     :PLONG   ) return  LONG;
pragma Import(c,GpiCorrelateFrom, Link_name=>"_GpiCorrelateFrom");

function GpiCorrelateSegment(ps       :HPS     ;
                             lSegment :LONG    ;
                             lType    :LONG    ;
                             pptlPick :PPOINTL ;
                             lMaxHits :LONG    ;
                             lMaxDepth:LONG    ;
                             alSegTag :PLONG   ) return  LONG;
pragma Import(c,GpiCorrelateSegment, Link_name=>"_GpiCorrelateSegment");

-- data formats for GpiPutData and GpiGetData
   DFORM_NOCONV    :constant  Long:=               0 ;
   DFORM_S370SHORT :constant  Long:=               1 ;
   DFORM_PCSHORT   :constant  Long:=               2 ;
   DFORM_PCLONG    :constant  Long:=               4 ;

-- segment attributes used by GpiSet/QuerySegmentAttrs and others
ATTR_ERROR         :constant  Long:=            -1 ;
ATTR_DETECTABLE    :constant  Long:=            1 ;
ATTR_VISIBLE       :constant  Long:=            2 ;
ATTR_CHAINED       :constant  Long:=            6 ;
ATTR_DYNAMIC       :constant  Long:=            8 ;
ATTR_FASTCHAIN       :constant  Long:=          9 ;
ATTR_PROP_DETECTABLE :constant  Long:=          10 ;
ATTR_PROP_VISIBLE    :constant  Long:=          11 ;

-- attribute on/off values
ATTR_OFF   :constant  Long:=                    0 ;
ATTR_ON    :constant  Long:=                    1 ;

-- segment priority used by GpiSetSegmentPriority and others
 LOWER_PRI  :constant  Long:=                   -1;
 HIGHER_PRI :constant  Long:=                    1 ;

--** segment control functions

function GpiOpenSegment(ps      :HPS  ;
                        lSegment:LONG ) return  BOOL;
pragma Import(c,GpiOpenSegment, Link_name=>"_GpiOpenSegment");

function GpiCloseSegment(ps :HPS ) return BOOL;
pragma Import(c,GpiCloseSegment, Link_name=>"_GpiCloseSegment");

function GpiDeleteSegment(ps    :HPS  ;
                          lSegid:LONG ) return  BOOL;
pragma Import(c,GpiDeleteSegment, Link_name=>"_GpiDeleteSegment");

function GpiQueryInitialSegmentAttrs(ps        :HPS  ;
                                     lAttribute:LONG ) return LONG;
pragma Import(c,GpiQueryInitialSegmentAttrs, Link_name=>"_GpiQueryInitialSegmentAttrs");

function GpiSetInitialSegmentAttrs(ps        :HPS  ;
                                   lAttribute:LONG ;
                                   lValue    :LONG ) return  BOOL;
pragma Import(c,GpiSetInitialSegmentAttrs, Link_name=>"_GpiSetInitialSegmentAttrs");

function GpiQuerySegmentAttrs(ps        :HPS  ;
                              lSegid    :LONG ;
                              lAttribute:LONG ) return  LONG;
pragma Import(c,GpiQuerySegmentAttrs, Link_name=>"_GpiQuerySegmentAttrs");

function GpiSetSegmentAttrs(ps        :HPS  ;
                            lSegid    :LONG ;
                            lAttribute:LONG ;
                            lValue    :LONG ) return  BOOL;
pragma Import(c,GpiSetSegmentAttrs, Link_name=>"_GpiSetSegmentAttrs");

function GpiQuerySegmentPriority(ps       :HPS  ;
                                 lRefSegid:LONG ;
                                 lOrder   :LONG ) return LONG;
pragma Import(c,GpiQuerySegmentPriority, Link_name=>"_GpiQuerySegmentPriority");

function GpiSetSegmentPriority(ps       :HPS  ;
                               lSegid   :LONG ;
                               lRefSegid:LONG ;
                               lOrder   :LONG ) return BOOL;
pragma Import(c,GpiSetSegmentPriority, Link_name=>"_GpiSetSegmentPriority");

function GpiDeleteSegments(ps           :HPS  ;
                           lFirstSegment:LONG ;
                           lLastSegment :LONG ) return  BOOL;
pragma Import(c,GpiDeleteSegments, Link_name=>"_GpiDeleteSegments");

function GpiQuerySegmentNames(ps         :HPS  ;
                              lFirstSegid:LONG ;
                              lLastSegid :LONG ;
                              lMax       :LONG ;
                               alSegids  :PLONG) return LONG;
pragma Import(c,GpiQuerySegmentNames, Link_name=>"_GpiQuerySegmentNames");

--     --** draw functions for segments

function GpiGetData(ps      :HPS   ;
                    lSegid  :LONG  ;
                    plOffset:PLONG ;
                    lFormat :LONG  ;
                    lLength :LONG  ;
                    pbData  :PBYTE ) return  LONG;
pragma Import(c,GpiGetData, Link_name=>"_GpiGetData");

function GpiPutData(ps     :HPS   ;
                    lFormat:LONG  ;
                    plCount:PLONG ;
                    pbData :PBYTE ) return BOOL;
pragma Import(c,GpiPutData, Link_name=>"_GpiPutData");

function GpiDrawChain( ps:HPS ) return BOOL;
pragma Import(c,GpiDrawChain, Link_name=>"_GpiDrawChain");

function GpiDrawFrom(ps           :HPS  ;
                     lFirstSegment:LONG ;
                     lLastSegment :LONG ) return BOOL;
pragma Import(c,GpiDrawFrom, Link_name=>"_GpiDrawFrom");

function GpiDrawSegment(ps      :HPS  ;
                        lSegment:LONG ) return BOOL;
pragma Import(c,GpiDrawSegment, Link_name=>"_GpiDrawSegment");

function GpiDrawDynamics(ps:HPS  ) return BOOL;
pragma Import(c,GpiDrawDynamics, Link_name=>"_GpiDrawDynamics");

function GpiRemoveDynamics(ps         :HPS  ;
                           lFirstSegid:LONG ;
                           lLastSegid :LONG ) return BOOL;
pragma Import(c,GpiRemoveDynamics, Link_name=>"_GpiRemoveDynamics");

-- edit modes used by GpiSet/QueryEditMode
 SEGEM_ERROR   :constant  Long:=                     0 ;
 SEGEM_INSERT  :constant  Long:=                     1 ;
 SEGEM_REPLACE :constant  Long:=                     2 ;

--   segment editing by element functions

function GpiBeginElement(ps     :HPS  ;
                         lType  :LONG ;
                         pszDesc:PSZ  ) return BOOL;
pragma Import(c,GpiBeginElement, Link_name=>"_GpiBeginElement");

function GpiEndElement( ps:HPS ) return BOOL;
pragma Import(c,GpiEndElement, Link_name=>"_GpiEndElement");

function GpiLabel(ps    :HPS  ;
                  lLabel:LONG ) return BOOL;
pragma Import(c,GpiLabel, Link_name=>"_GpiLabel");

function GpiElement(ps     :HPS   ;
                    lType  :LONG  ;
                    pszDesc:PSZ   ;
                    lLength:LONG  ;
                    pbData :PBYTE ) return LONG;
pragma Import(c,GpiElement, Link_name=>"_GpiElement");

function GpiQueryElement(ps        :HPS   ;
                         lOff      :LONG  ;
                         lMaxLength:LONG  ;
                         pbData    :PBYTE ) return LONG;
pragma Import(c,GpiQueryElement, Link_name=>"_GpiQueryElement");

function GpiDeleteElement( ps:HPS ) return BOOL;
pragma Import(c,GpiDeleteElement, Link_name=>"_GpiDeleteElement");

function GpiDeleteElementRange(ps           :HPS  ;
                               lFirstElement:LONG ;
                               lLastElement :LONG ) return  BOOL;
pragma Import(c,GpiDeleteElementRange, Link_name=>"_GpiDeleteElementRange");

function GpiDeleteElementsBetweenLabels(ps         :HPS  ;
                                        lFirstLabel:LONG ;
                                        lLastLabel :LONG ) return  BOOL;
pragma Import(c,GpiDeleteElementsBetweenLabels, Link_name=>"_GpiDeleteElementsBetweenLabels");

function GpiQueryEditMode(ps:HPS  ) return LONG;
pragma Import(c,GpiQueryEditMode, Link_name=>"_GpiQueryEditMode");

function GpiSetEditMode(ps   :HPS  ;
                        lMode:LONG ) return BOOL;
pragma Import(c,GpiSetEditMode, Link_name=>"_GpiSetEditMode");

function GpiQueryElementPointer( ps :HPS) return LONG;
pragma Import(c,GpiQueryElementPointer, Link_name=>"_GpiQueryElementPointer");

function GpiSetElementPointer(ps      :HPS  ;
                              lElement:LONG ) return BOOL;
pragma Import(c,GpiSetElementPointer, Link_name=>"_GpiSetElementPointer");

function GpiOffsetElementPointer(ps     :HPS  ;
                                 loffset:LONG ) return BOOL;
pragma Import(c,GpiOffsetElementPointer, Link_name=>"_GpiOffsetElementPointer");

function GpiQueryElementType(ps     :HPS   ;
                             plType :PLONG ;
                             lLength:LONG  ;
                             pszData:PSZ   ) return LONG;
pragma Import(c,GpiQueryElementType, Link_name=>"_GpiQueryElementType");

function GpiSetElementPointerAtLabel(ps    :HPS  ;
                                     lLabel:LONG ) return BOOL;
pragma Import(c,GpiSetElementPointerAtLabel, Link_name=>"_GpiSetElementPointerAtLabel");

-- co-ordinates space for GpiConvert
 CVTC_WORLD        :constant  Long:=             1 ;
 CVTC_MODEL        :constant  Long:=             2 ;
 CVTC_DEFAULTPAGE  :constant  Long:=             3 ;
 CVTC_PAGE         :constant  Long:=             4 ;
 CVTC_DEVICE       :constant  Long:=             5 ;

-- type of transformation for GpiSetSegmentTransformMatrix
 TRANSFORM_REPLACE :constant  Long:=             0 ;
 TRANSFORM_ADD     :constant  Long:=             1 ;
 TRANSFORM_PREEMPT :constant  Long:=             2 ;

-- transform matrix

type MATRIXLF  is record        -- matlf
    fxM11    :LONG;
    fxM12    :LONG;
     lM13    :LONG;
    fxM21    :LONG;
    fxM22    :LONG;
     lM23    :LONG;
     lM31    :LONG;
     lM32    :LONG;
     lM33    :LONG;
end record; -- MATRIXLF;
type PMATRIXLF  is access all MATRIXLF;

--        --** transform and transform conversion functions

function GpiQuerySegmentTransformMatrix(ps         :HPS       ;
                                        lSegid     :LONG      ;
                                        lCount     :LONG      ;
                                        pmatlfArray:PMATRIXLF ) return BOOL;
pragma Import(c,GpiQuerySegmentTransformMatrix, Link_name=>"_GpiQuerySegmentTransformMatrix");

function GpiSetSegmentTransformMatrix(ps         :HPS       ;
                                      lSegid     :LONG      ;
                                      lCount     :LONG      ;
                                      pmatlfarray:PMATRIXLF ;
                                      lOptions   :LONG      ) return BOOL;
pragma Import(c,GpiSetSegmentTransformMatrix, Link_name=>"_GpiSetSegmentTransformMatrix");

function GpiConvert(ps        :HPS     ;
                    lSrc      :LONG    ;
                    lTarg     :LONG    ;
                    lCount    :LONG    ;
                    aptlPoints:PPOINTL ) return BOOL;
pragma Import(c,GpiConvert, Link_name=>"_GpiConvert");

function GpiConvertWithMatrix(ps         :HPS       ;
                              lCountp    :LONG      ;
                              aptlPoints :PPOINTL   ;
                              lCount     :LONG      ;
                              pmatlfArray:PMATRIXLF ) return BOOL;
pragma Import(c,GpiConvertWithMatrix, Link_name=>"_GpiConvertWithMatrix");

function GpiQueryModelTransformMatrix(ps         :HPS       ;
                                      lCount     :LONG      ;
                                      pmatlfArray:PMATRIXLF ) return BOOL;
pragma Import(c,GpiQueryModelTransformMatrix, Link_name=>"_GpiQueryModelTransformMatrix");

function GpiSetModelTransformMatrix(ps         :HPS       ;
                                    lCount     :LONG      ;
                                    pmatlfArray:PMATRIXLF ;
                                    lOptions   :LONG      ) return BOOL;
pragma Import(c,GpiSetModelTransformMatrix, Link_name=>"_GpiSetModelTransformMatrix");

function GpiCallSegmentMatrix(ps         :HPS       ;
                              lSegment   :LONG      ;
                              lCount     :LONG      ;
                              pmatlfArray:PMATRIXLF ;
                              lOptions   :LONG      ) return LONG;
pragma Import(c,GpiCallSegmentMatrix, Link_name=>"_GpiCallSegmentMatrix");

function GpiQueryDefaultViewMatrix(ps         :HPS       ;
                                   lCount     :LONG      ;
                                   pmatlfArray:PMATRIXLF ) return BOOL;
pragma Import(c,GpiQueryDefaultViewMatrix, Link_name=>"_GpiQueryDefaultViewMatrix");

function GpiSetDefaultViewMatrix(ps         :HPS       ;
                                 lCount     :LONG      ;
                                 pmatlfarray:PMATRIXLF ;
                                 lOptions   :LONG      ) return BOOL;
pragma Import(c,GpiSetDefaultViewMatrix, Link_name=>"_GpiSetDefaultViewMatrix");

function GpiQueryPageViewport(ps          :HPS    ;
                              prclViewport:PRECTL ) return BOOL;
pragma Import(c,GpiQueryPageViewport, Link_name=>"_GpiQueryPageViewport");

function GpiSetPageViewport(ps          :HPS    ;
                            prclViewport:PRECTL ) return BOOL;
pragma Import(c,GpiSetPageViewport, Link_name=>"_GpiSetPageViewport");

function GpiQueryViewingTransformMatrix(ps         :HPS       ;
                                        lCount     :LONG      ;
                                        pmatlfArray:PMATRIXLF ) return BOOL;
pragma Import(c,GpiQueryViewingTransformMatrix, Link_name=>"_GpiQueryViewingTransformMatrix");

function GpiSetViewingTransformMatrix(ps         :HPS       ;
                                      lCount     :LONG      ;
                                      pmatlfArray:PMATRIXLF ;
                                      lOptions   :LONG      ) return BOOL;
pragma Import(c,GpiSetViewingTransformMatrix, Link_name=>"_GpiSetViewingTransformMatrix");

--        --** transform helper routines

function GpiTranslate(p1 :HPS;
                      p2 :PMATRIXLF;
                      p3 :LONG;
                      p4 :PPOINTL) return BOOL;
pragma Import(c,GpiTranslate, Link_name=>"_GpiTranslate");

function GpiScale(p1:HPS;
                  p2:PMATRIXLF;
                  p3:LONG;
                  p4:PLONG;
                  p5:PPOINTL) return BOOL;
pragma Import(c,GpiScale, Link_name=>"_GpiScale");

function GpiRotate(p1:HPS;
                   p2:PMATRIXLF;
                   p3:LONG;
                   p4:LONG;
                   p5:PPOINTL) return BOOL;
pragma Import(c,GpiRotate, Link_name=>"_GpiRotate");

--        --** general clipping functions

function GpiSetGraphicsField(ps       :HPS    ;
                             prclField:PRECTL ) return BOOL;
pragma Import(c,GpiSetGraphicsField, Link_name=>"_GpiSetGraphicsField");

function GpiQueryGraphicsField(ps       :HPS    ;
                               prclField:PRECTL ) return BOOL;
pragma Import(c,GpiQueryGraphicsField, Link_name=>"_GpiQueryGraphicsField");

function GpiSetViewingLimits(ps        :HPS    ;
                             prclLimits:PRECTL ) return BOOL;
pragma Import(c,GpiSetViewingLimits, Link_name=>"_GpiSetViewingLimits");

function GpiQueryViewingLimits(ps        :HPS    ;
                               prclLimits:PRECTL ) return BOOL;
pragma Import(c,GpiQueryViewingLimits, Link_name=>"_GpiQueryViewingLimits");

-- modes for GpiModifyPath
MPATH_STROKE  :constant  Long:=                 6 ;

-- modes for GpiFillPath
FPATH_ALTERNATE :constant  Long:=               0 ;
FPATH_WINDING   :constant  Long:=               2 ;
FPATH_INCL      :constant  Long:=               0 ;
FPATH_EXCL      :constant  Long:=               8 ;

-- modes for GpiSetClipPath
SCP_ALTERNATE  :constant  Long:=                0 ;
SCP_WINDING    :constant  Long:=                2 ;
SCP_AND        :constant  Long:=                4 ;
SCP_RESET      :constant  Long:=                0 ;
SCP_INCL       :constant  Long:=                0 ;
SCP_EXCL       :constant  Long:=                8 ;

  --** Path and Clip Path functions

function GpiBeginPath(ps   :HPS  ;
                      lPath:LONG ) return BOOL;
pragma Import(c,GpiBeginPath, Link_name=>"_GpiBeginPath");

function GpiEndPath( ps:HPS ) return BOOL;
pragma Import(c,GpiEndPath, Link_name=>"_GpiEndPath");

function GpiCloseFigure(ps:HPS  ) return BOOL;
pragma Import(c,GpiCloseFigure, Link_name=>"_GpiCloseFigure");

function GpiModifyPath( ps :HPS;
                       lPath:LONG ;
                       lMode:LONG ) return BOOL;
pragma Import(c,GpiModifyPath, Link_name=>"_GpiModifyPath");

function GpiFillPath(ps      :HPS  ;
                     lPath   :LONG ;
                     lOptions:LONG ) return LONG;
pragma Import(c,GpiFillPath, Link_name=>"_GpiFillPath");

function GpiSetClipPath(ps      :HPS  ;
                        lPath   :LONG ;
                        lOptions:LONG ) return BOOL;
pragma Import(c,GpiSetClipPath, Link_name=>"_GpiSetClipPath");

function GpiOutlinePath(ps      :HPS  ;
                        lPath   :LONG ;
                        lOptions:LONG ) return LONG;
pragma Import(c,GpiOutlinePath, Link_name=>"_GpiOutlinePath");

function GpiPathToRegion(GpiH    :HPS  ;
                         lPath   :LONG ;
                         lOptions:LONG ) return HRGN;
pragma Import(c,GpiPathToRegion, Link_name=>"_GpiPathToRegion");

function GpiStrokePath(ps       :HPS   ;
                       lPath    :LONG  ;
                       flOptions:ULONG ) return LONG;
pragma Import(c,GpiStrokePath, Link_name=>"_GpiStrokePath");

-- options for GpiCreateLogColorTable and others
 LCOL_RESET     :constant  Long:=              16#0001#;
 LCOL_REALIZABLE :constant  Long:=             16#0002#;
 LCOL_PURECOLOR  :constant  Long:=             16#0004#;
 LCOL_OVERRIDE_DEFAULT_COLORS :constant  Long:=16#0008#;
 LCOL_REALIZED                :constant  Long:=16#0010#;

-- format of logical lColor table for GpiCreateLogColorTable and others
 LCOLF_DEFAULT    :constant  Long:=              0 ;
 LCOLF_INDRGB     :constant  Long:=              1 ;
 LCOLF_CONSECRGB  :constant  Long:=              2 ;
 LCOLF_RGB        :constant  Long:=              3 ;
 LCOLF_PALETTE    :constant  Long:=              4 ;

-- options for GpiQueryRealColors and others
 LCOLOPT_REALIZED :constant  Long:=          16#0001#;
 LCOLOPT_INDEX    :constant  Long:=          16#0002#;

   -- return codes from GpiQueryLogColorTable to indicate it is in RGB mode
    QLCT_ERROR    :constant  Long:=                -1;
    QLCT_RGB      :constant  Long:=                -2;

   -- GpiQueryLogColorTable index returned for colors not explicitly loaded
    QLCT_NOTLOADED :constant  Long:=               -1;

-- return codes for GpiQueryColorData
 QCD_LCT_FORMAT    :constant  Long:=             0 ;
 QCD_LCT_LOINDEX   :constant  Long:=             1 ;
 QCD_LCT_HIINDEX   :constant  Long:=             2 ;
 QCD_LCT_OPTIONS   :constant  Long:=             3 ;

-- Palette manager return values
 PAL_ERROR         :constant  Long:=            -1;

-- color flags for GpiCreatePalette and others
 PC_RESERVED       :constant  Long:=               01;
 PC_EXPLICIT       :constant  Long:=               02 ;
 PC_NOCOLLAPSE     :constant  Long:=               04 ;

   --   logical lColor table functions

function GpiCreateLogColorTable(ps       :HPS   ;
                                flOptions:ULONG ;
                                lFormat  :LONG  ;
                                lStart   :LONG  ;
                                lCount   :LONG  ;
                                alTable  :PLONG ) return BOOL;
pragma Import(c,GpiCreateLogColorTable, Link_name=>"_GpiCreateLogColorTable");

function GpiQueryColorData(ps      :HPS  ;
                           lCount  :LONG ;
                            alArray:PLONG) return  BOOL;
pragma Import(c,GpiQueryColorData, Link_name=>"_GpiQueryColorData");

function GpiQueryLogColorTable(ps       :HPS   ;
                               flOptions:ULONG ;
                               lStart   :LONG  ;
                               lCount   :LONG  ;
                               alArray  :PLONG ) return LONG;
pragma Import(c,GpiQueryLogColorTable, Link_name=>"_GpiQueryLogColorTable");

function GpiQueryRealColors(ps       :HPS   ;
                            flOptions:ULONG ;
                            lStart   :LONG  ;
                            lCount   :LONG  ;
                            alColors :PLONG ) return  LONG;
pragma Import(c,GpiQueryRealColors, Link_name=>"_GpiQueryRealColors");

function GpiQueryNearestColor(ps       :HPS   ;
                              flOptions:ULONG ;
                              lRgbIn   :LONG  ) return LONG;
pragma Import(c,GpiQueryNearestColor, Link_name=>"_GpiQueryNearestColor");

function GpiQueryColorIndex(ps       :HPS   ;
                            flOptions:ULONG ;
                            lRgbColor:LONG  ) return LONG;
pragma Import(c,GpiQueryColorIndex, Link_name=>"_GpiQueryColorIndex");

function GpiQueryRGBColor(ps         :HPS   ;
                          flOptions  :ULONG ;
                          lColorIndex:LONG  ) return LONG;
pragma Import(c,GpiQueryRGBColor, Link_name=>"_GpiQueryRGBColor");

--           --Palette manager functions

function GpiCreatePalette(ha       :HAB    ;
                          flOptions:ULONG  ;
                          ulFormat :ULONG  ;
                          ulCount  :ULONG  ;
                          aulTable :PULONG ) return HPAL;
pragma Import(c,GpiCreatePalette, Link_name=>"_GpiCreatePalette");

function GpiDeletePalette( pal:HPAL) return BOOL;
pragma Import(c,GpiDeletePalette, Link_name=>"_GpiDeletePalette");

function GpiSelectPalette(ps :HPS   ;
                          pal:HPAL  ) return HPAL;
pragma Import(c,GpiSelectPalette, Link_name=>"_GpiSelectPalette");

function GpiAnimatePalette(pal     :HPAL   ;
                           ulFormat:ULONG  ;
                           ulStart :ULONG  ;
                           ulCount :ULONG  ;
                           aulTable:PULONG ) return LONG;
pragma Import(c,GpiAnimatePalette, Link_name=>"_GpiAnimatePalette");

function GpiSetPaletteEntries(pal     :HPAL   ;
                              ulFormat:ULONG  ;
                              ulStart :ULONG  ;
                              ulCount :ULONG  ;
                              aulTable:PULONG ) return BOOL;
pragma Import(c,GpiSetPaletteEntries, Link_name=>"_GpiSetPaletteEntries");

function GpiQueryPalette(ps:HPS  ) return HPAL;
pragma Import(c,GpiQueryPalette, Link_name=>"_GpiQueryPalette");

function GpiQueryPaletteInfo(pal      :HPAL   ;
                             ps       :HPS    ;
                             flOptions:ULONG  ;
                             ulStart  :ULONG  ;
                             ulCount  :ULONG  ;
                             aulArray :PULONG ) return LONG;
pragma Import(c,GpiQueryPaletteInfo, Link_name=>"_GpiQueryPaletteInfo");

--     -- default color table indices
--
 CLR_FALSE     :constant Long:=-5 ;
 CLR_TRUE      :constant Long:=-4 ;

 CLR_ERROR     :constant Long:=-255 ;
 CLR_DEFAULT   :constant Long:=-3 ;
 CLR_WHITE     :constant Long:=-2 ;
 CLR_BLACK     :constant Long:=-1 ;
 CLR_BACKGROUND:constant Long:=  0;
 CLR_BLUE      :constant Long:=  1;
 CLR_RED       :constant Long:=  2;
 CLR_PINK      :constant Long:=  3;
 CLR_GREEN     :constant Long:=  4;
 CLR_CYAN      :constant Long:=  5;
 CLR_YELLOW    :constant Long:=  6;
 CLR_NEUTRAL   :constant Long:=  7;

 CLR_DARKGRAY  :constant Long:=  8;
 CLR_DARKBLUE  :constant Long:=  9;
 CLR_DARKRED   :constant Long:= 10;
 CLR_DARKPINK  :constant Long:= 11;
 CLR_DARKGREEN :constant Long:= 12;
 CLR_DARKCYAN  :constant Long:= 13;
 CLR_BROWN     :constant Long:= 14;
 CLR_PALEGRAY  :constant Long:= 15;

-- rgb colors
 RGB_ERROR         :constant  Long:=          (-255);
 RGB_BLACK   :constant  Long:=           16#00000000#;
 RGB_BLUE    :constant  Long:=           16#000000FF#;
 RGB_GREEN   :constant  Long:=           16#0000FF00#;
 RGB_CYAN    :constant  Long:=           16#0000FFFF#;
 RGB_RED     :constant  Long:=           16#00FF0000#;
 RGB_PINK    :constant  Long:=           16#00FF00FF#;
 RGB_YELLOW  :constant  Long:=           16#00FFFF00#;
 RGB_WHITE   :constant  Long:=           16#00FFFFF#;

-- control flags used by GpiBeginArea
 BA_NOBOUNDARY :constant  Long:=                 0 ;
 BA_BOUNDARY   :constant  Long:=             16#0001#;


 BA_ALTERNATE  :constant  Long:=                 0 ;
 BA_WINDING    :constant  Long:=             16#0002#;

 BA_INCL       :constant  Long:=                 0 ;
 BA_EXCL       :constant  Long:=                 8 ;


-- fill options for GpiBox/GpiFullArc
 DRO_FILL      :constant  Long:=                 1 ;
 DRO_OUTLINE   :constant  Long:=                 2 ;
 DRO_OUTLINEFILL :constant  Long:=               3 ;

-- basic pattern symbols
 PATSYM_ERROR    :constant  Long:=              (-1);
 PATSYM_DEFAULT  :constant  Long:=               0 ;
 PATSYM_DENSE1   :constant  Long:=               1 ;
 PATSYM_DENSE2   :constant  Long:=               2 ;
 PATSYM_DENSE3   :constant  Long:=               3 ;
 PATSYM_DENSE4   :constant  Long:=               4 ;
 PATSYM_DENSE5   :constant  Long:=               5 ;
 PATSYM_DENSE6   :constant  Long:=               6 ;
 PATSYM_DENSE7   :constant  Long:=               7 ;
 PATSYM_DENSE8   :constant  Long:=               8 ;
 PATSYM_VERT     :constant  Long:=               9 ;
 PATSYM_HORIZ    :constant  Long:=               10 ;
 PATSYM_DIAG1    :constant  Long:=               11 ;
 PATSYM_DIAG2    :constant  Long:=               12 ;
 PATSYM_DIAG3    :constant  Long:=               13 ;
 PATSYM_DIAG4    :constant  Long:=               14 ;
 PATSYM_NOSHADE  :constant  Long:=               15 ;
 PATSYM_SOLID    :constant  Long:=               16 ;
--     #ifndef INCL_SAADEFS
 PATSYM_HALFTONE :constant  Long:=               17 ;
--     #endif -- no INCL_SAADEFS
 PATSYM_HATCH     :constant  Long:=              18 ;
 PATSYM_DIAGHATCH :constant  Long:=              19 ;
 PATSYM_BLANK     :constant  Long:=              64 ;

-- lcid values for GpiSet/QueryPattern and others
 LCID_ERROR       :constant  Long:=             (-1);
 LCID_DEFAULT     :constant  Long:=              0 ;

   --   global primitive functions

function GpiSetColor(ps    :HPS  ;
                     lColor:LONG ) return BOOL;
pragma Import(c,GpiSetColor, Link_name=>"_GpiSetColor");

function GpiQueryColor( ps:HPS ) return LONG;
pragma Import(c,GpiQueryColor, Link_name=>"_GpiQueryColor");

--        --** line primitive functions

function GpiBox(ps       :HPS     ;
                lControl :LONG    ;
                pptlPoint:PPOINTL ;
                lHRound  :LONG    ;
                lVRound  :LONG    ) return LONG;
pragma Import(c,GpiBox, Link_name=>"_GpiBox");

function GpiMove(ps       :HPS     ;
                 pptlPoint:PPOINTL ) return BOOL;
pragma Import(c,GpiMove, Link_name=>"_GpiMove");

function GpiLine(ps          :HPS     ;
                 pptlEndPoint:PPOINTL ) return LONG;
pragma Import(c,GpiLine, Link_name=>"_GpiLine");

function GpiPolyLine(ps        :HPS     ;
                     lCount    :LONG    ;
                     aptlPoints:PPOINTL ) return LONG;
pragma Import(c,GpiPolyLine, Link_name=>"_GpiPolyLine");

function GpiPolyLineDisjoint(ps        :HPS     ;
                             lCount    :LONG    ;
                             aptlPoints:PPOINTL ) return LONG;
pragma Import(c,GpiPolyLineDisjoint, Link_name=>"_GpiPolyLineDisjoint");

--        --** area primitive functions

function GpiSetPattern(ps            :HPS  ;
                       lPatternSymbol:LONG ) return BOOL;
pragma Import(c,GpiSetPattern, Link_name=>"_GpiSetPattern");

function GpiQueryPattern( ps :HPS) return LONG;
pragma Import(c,GpiQueryPattern, Link_name=>"_GpiQueryPattern");

function GpiBeginArea(ps       :HPS   ;
                      flOptions:ULONG ) return BOOL;
pragma Import(c,GpiBeginArea, Link_name=>"_GpiBeginArea");

function GpiEndArea( ps :HPS) return LONG;
pragma Import(c,GpiEndArea, Link_name=>"_GpiEndArea");

--        --** character primitive functions

function GpiCharString(ps       :HPS  ;
                       lCount   :LONG ;
                       pchString:PCH  ) return LONG;
pragma Import(c,GpiCharString, Link_name=>"_GpiCharString");

function GpiCharStringAt(ps       :HPS     ;
                         pptlPoint:PPOINTL ;
                         lCount   :LONG    ;
                         pchString:PCH     ) return LONG;
pragma Import(c,GpiCharStringAt, Link_name=>"_GpiCharStringAt");

-- mode for GpiSetAttrMode
 AM_ERROR         :constant  Long:=             (-1);
 AM_PRESERVE      :constant  Long:=              0 ;
 AM_NOPRESERVE    :constant  Long:=              1 ;

-- foreground mixes
 FM_ERROR         :constant  Long:=             (-1);
 FM_DEFAULT       :constant  Long:=              0 ;
 FM_OR            :constant  Long:=              1 ;
 FM_OVERPAINT     :constant  Long:=              2 ;
 FM_LEAVEALONE    :constant  Long:=              5 ;

 FM_XOR           :constant  Long:=              4 ;
 FM_AND           :constant  Long:=              6 ;
 FM_SUBTRACT      :constant  Long:=              7 ;
 FM_MASKSRCNOT    :constant  Long:=              8 ;
 FM_ZERO          :constant  Long:=              9 ;
 FM_NOTMERGESRC   :constant  Long:=              10 ;
 FM_NOTXORSRC     :constant  Long:=              11 ;
 FM_INVERT        :constant  Long:=              12 ;
 FM_MERGESRCNOT   :constant  Long:=              13 ;
 FM_NOTCOPYSRC    :constant  Long:=              14 ;
 FM_MERGENOTSRC   :constant  Long:=              15 ;
 FM_NOTMASKSRC    :constant  Long:=              16 ;
 FM_ONE           :constant  Long:=              17 ;

-- background mixes
 BM_ERROR         :constant  Long:=              -1 ;
 BM_DEFAULT       :constant  Long:=              0 ;
 BM_OR            :constant  Long:=              1 ;
 BM_OVERPAINT     :constant  Long:=              2 ;
 BM_LEAVEALONE    :constant  Long:=              5 ;

 BM_XOR           :constant  Long:=              4 ;
 BM_AND           :constant  Long:=              6 ;
 BM_SUBTRACT      :constant  Long:=              7 ;
 BM_MASKSRCNOT    :constant  Long:=              8 ;
 BM_ZERO          :constant  Long:=              9 ;
 BM_NOTMERGESRC   :constant  Long:=              10 ;
 BM_NOTXORSRC     :constant  Long:=              11 ;
 BM_INVERT        :constant  Long:=              12 ;
 BM_MERGESRCNOT   :constant  Long:=              13 ;
 BM_NOTCOPYSRC    :constant  Long:=              14 ;
 BM_MERGENOTSRC   :constant  Long:=              15 ;
 BM_NOTMASKSRC    :constant  Long:=              16 ;
 BM_ONE           :constant  Long:=              17 ;
 BM_SRCTRANSPARENT :constant  Long:=             18 ;
 BM_DESTTRANSPARENT:constant  Long:=             19 ;

-- basic line type styles
 LINETYPE_ERROR    :constant  Long:=             -1;
 LINETYPE_DEFAULT  :constant  Long:=             0 ;
 LINETYPE_DOT      :constant  Long:=             1 ;
 LINETYPE_SHORTDASH :constant  Long:=            2 ;
 LINETYPE_DASHDOT   :constant  Long:=            3 ;
 LINETYPE_DOUBLEDOT :constant  Long:=            4 ;
 LINETYPE_LONGDASH  :constant  Long:=            5 ;
 LINETYPE_DASHDOUBLEDOT :constant  Long:=        6 ;
 LINETYPE_SOLID         :constant  Long:=        7 ;
 LINETYPE_INVISIBLE     :constant  Long:=        8 ;
--     #ifndef INCL_SAADEFS
 LINETYPE_ALTERNATE  :constant  Long:=           9 ;
--     #endif -- no INCL_SAADEFS

-- cosmetic line widths
 LINEWIDTH_ERROR     :constant  Long:=           -1 ;
 LINEWIDTH_DEFAULT   :constant  Long:=           0 ;
 LINEWIDTH_NORMAL    :constant  Long:=   16#00010000#;   -- MAKEFIXED(1;0)
 LINEWIDTH_THICK     :constant  Long:=   16#00020000#;   -- MAKEFIXED(2;0)

-- actual line widths
 LINEWIDTHGEOM_ERROR :constant  Long:=           -1 ;

-- line end styles
 LINEEND_ERROR       :constant  Long:=           -1 ;
 LINEEND_DEFAULT     :constant  Long:=           0 ;
 LINEEND_FLAT        :constant  Long:=           1 ;
 LINEEND_SQUARE      :constant  Long:=           2 ;
 LINEEND_ROUND       :constant  Long:=           3 ;

-- line join styles
 LINEJOIN_ERROR      :constant  Long:=          (-1);
 LINEJOIN_DEFAULT    :constant  Long:=           0 ;
 LINEJOIN_BEVEL      :constant  Long:=           1 ;
 LINEJOIN_ROUND      :constant  Long:=           2 ;
 LINEJOIN_MITRE      :constant  Long:=           3 ;

-- character directions
 CHDIRN_ERROR        :constant  Long:=          (-1);
 CHDIRN_DEFAULT      :constant  Long:=           0 ;
 CHDIRN_LEFTRIGHT    :constant  Long:=           1 ;
 CHDIRN_TOPBOTTOM    :constant  Long:=           2 ;
 CHDIRN_RIGHTLEFT    :constant  Long:=           3 ;
 CHDIRN_BOTTOMTOP    :constant  Long:=           4 ;

-- character text alignments
 TA_NORMAL_HORIZ     :constant  Long:=16#0001#;
 TA_LEFT             :constant  Long:=16#0002#;
 TA_CENTER           :constant  Long:=16#0003#;
 TA_RIGHT            :constant  Long:=16#0004#;
 TA_STANDARD_HORIZ   :constant  Long:=16#0005#;
 TA_NORMAL_VERT      :constant  Long:=16#0100#;
 TA_TOP              :constant  Long:=16#0200#;
 TA_HALF             :constant  Long:=16#0300#;
 TA_BASE             :constant  Long:=16#0400#;
 TA_BOTTOM           :constant  Long:=16#0500#;
 TA_STANDARD_VERT    :constant  Long:=16#0600#;

-- character modes
 CM_ERROR            :constant  Long:=          (-1);
 CM_DEFAULT          :constant  Long:=           0 ;
 CM_MODE1            :constant  Long:=           1 ;
 CM_MODE2            :constant  Long:=           2 ;
 CM_MODE3            :constant  Long:=           3 ;

-- basic marker symbols
 MARKSYM_ERROR         :constant  Long:=        (-1);
 MARKSYM_DEFAULT       :constant  Long:=         0 ;
 MARKSYM_CROSS         :constant  Long:=         1 ;
 MARKSYM_PLUS          :constant  Long:=         2 ;
 MARKSYM_DIAMOND       :constant  Long:=         3 ;
 MARKSYM_SQUARE        :constant  Long:=         4 ;
 MARKSYM_SIXPOINTSTAR  :constant  Long:=         5 ;
 MARKSYM_EIGHTPOINTSTAR:constant  Long:=         6 ;
 MARKSYM_SOLIDDIAMOND  :constant  Long:=         7 ;
 MARKSYM_SOLIDSQUARE   :constant  Long:=         8 ;
 MARKSYM_DOT           :constant  Long:=         9 ;
 MARKSYM_SMALLCIRCLE   :constant  Long:=         10 ;
 MARKSYM_BLANK         :constant  Long:=         64 ;

-- formatting options for GpiCharStringPosAt
 CHS_OPAQUE          :constant  Long:=       16#0001#;
 CHS_VECTOR          :constant  Long:=       16#0002#;
 CHS_LEAVEPOS        :constant  Long:=       16#0008#;
 CHS_CLIP            :constant  Long:=       16#0010#;
 CHS_UNDERSCORE      :constant  Long:=       16#0200#;
 CHS_STRIKEOUT       :constant  Long:=       16#0400#;

-- bundle codes for GpiSetAttributes and GpiQueryAttributes
 PRIM_LINE           :constant  Long:=           1 ;
 PRIM_CHAR           :constant  Long:=           2 ;
 PRIM_MARKER         :constant  Long:=           3 ;
 PRIM_AREA           :constant  Long:=           4 ;
 PRIM_IMAGE          :constant  Long:=           5 ;

-- line bundle mask bits
 LBB_COLOR           :constant  Long:=       16#0001#;
 LBB_BACK_COLOR      :constant  Long:=       16#0002#;
 LBB_MIX_MODE        :constant  Long:=       16#0004#;
 LBB_BACK_MIX_MODE   :constant  Long:=       16#0008#;
 LBB_WIDTH           :constant  Long:=       16#0010#;
 LBB_GEOM_WIDTH      :constant  Long:=       16#0020#;
 LBB_TYPE            :constant  Long:=       16#0040#;
 LBB_END             :constant  Long:=       16#0080#;
 LBB_JOIN            :constant  Long:=       16#0100#;

-- character bundle mask bits
 CBB_COLOR           :constant  Long:=       16#0001#;
 CBB_BACK_COLOR      :constant  Long:=       16#0002#;
 CBB_MIX_MODE        :constant  Long:=       16#0004#;
 CBB_BACK_MIX_MODE   :constant  Long:=       16#0008#;
 CBB_SET             :constant  Long:=       16#0010#;
 CBB_MODE            :constant  Long:=       16#0020#;
 CBB_BOX             :constant  Long:=       16#0040#;
 CBB_ANGLE           :constant  Long:=       16#0080#;
 CBB_SHEAR           :constant  Long:=       16#0100#;
 CBB_DIRECTION       :constant  Long:=       16#0200#;
 CBB_TEXT_ALIGN      :constant  Long:=       16#0400#;
 CBB_EXTRA           :constant  Long:=       16#0800#;
 CBB_BREAK_EXTRA     :constant  Long:=       16#1000#;

-- marker bundle mask bits
 MBB_COLOR           :constant  Long:=       16#0001#;
 MBB_BACK_COLOR      :constant  Long:=       16#0002#;
 MBB_MIX_MODE        :constant  Long:=       16#0004#;
 MBB_BACK_MIX_MODE   :constant  Long:=       16#0008#;
 MBB_SET             :constant  Long:=       16#0010#;
 MBB_SYMBOL          :constant  Long:=       16#0020#;
 MBB_BOX             :constant  Long:=       16#0040#;

-- pattern bundle mask bits
 ABB_COLOR           :constant  Long:=       16#0001#;
 ABB_BACK_COLOR      :constant  Long:=       16#0002#;
 ABB_MIX_MODE        :constant  Long:=       16#0004#;
 ABB_BACK_MIX_MODE   :constant  Long:=       16#0008#;
 ABB_SET             :constant  Long:=       16#0010#;
 ABB_SYMBOL          :constant  Long:=       16#0020#;
 ABB_REF_POINT       :constant  Long:=       16#0040#;

-- image bundle mask bits
 IBB_COLOR           :constant  Long:=       16#0001#;
 IBB_BACK_COLOR      :constant  Long:=       16#0002#;
 IBB_MIX_MODE        :constant  Long:=       16#0004#;
 IBB_BACK_MIX_MODE   :constant  Long:=       16#0008#;

--      structure for GpiSetArcParams and GpiQueryArcParams

type ARCPARAMS    is record      -- arcp
   lP    :LONG ;
   lQ    :LONG ;
   lR    :LONG ;
   lS    :LONG ;
end record; -- ARCPARAMS;
type PARCPARAMS  is access all ARCPARAMS;

--      variation of SIZE used for:FIXEDs
type SIZEF      is record      -- sizfx
   cx    :LONG ;
   cy    :LONG ;
end record; -- SIZEF;
type PSIZEF  is access all SIZEF;

--     structure for gradient parameters e.g. for GpiSetCharAngle
type GRADIENTL   is record       -- gradl
    x   :LONG ;
    y   :LONG ;
end record; -- GRADIENTL;
type PGRADIENTL  is access all GRADIENTL;

--      line bundle for GpiSetAttributes and GpiQueryAttributes
type LINEBUNDLE  is record       -- lbnd
    lColor          :LONG    ;
    lBackColor      :LONG    ;
    usMixMode       :USHORT  ;
    usBackMixMode   :USHORT  ;
    fxWidth         :LONG    ;
    lGeomWidth      :LONG    ;
    usType          :USHORT  ;
    usEnd           :USHORT  ;
    usJoin          :USHORT  ;
    usReserved      :USHORT  ;
end record; -- LINEBUNDLE;
type PLINEBUNDLE  is access all LINEBUNDLE;

--     character bundle for GpiSetAttributes and GpiQueryAttributes
type CHARBUNDLE  is record       -- cbnd
  lColor           :LONG      ;
  lBackColor       :LONG      ;
  usMixMode        :USHORT    ;
  usBackMixMode    :USHORT    ;
  usSet            :USHORT    ;
  usPrecision      :USHORT    ;
  sizfxCell        :SIZEF     ;
  ptlAngle         :POINTL    ;
  ptlShear         :POINTL    ;
  usDirection      :USHORT    ;
  usTextAlign      :USHORT    ;
  fxExtra          :LONG      ;
  fxBreakExtra     :LONG      ;
end record; -- CHARBUNDLE ;
type PCHARBUNDLE  is access all CHARBUNDLE;

--     marker bundle for GpiSetAttributes and GpiQueryAttributes
type MARKERBUNDLE  is record     -- mbnd
    lColor          :LONG   ;
    lBackColor      :LONG   ;
    usMixMode       :USHORT ;
    usBackMixMode   :USHORT ;
    usSet           :USHORT ;
    usSymbol        :USHORT ;
    sizfxCell       :SIZEF  ;
end record; -- MARKERBUNDLE;
type PMARKERBUNDLE  is access all MARKERBUNDLE;

--     -- pattern bundle for GpiSetAttributes and GpiQueryAttributes
type AREABUNDLE  is record    -- pbnd
    lColor          :LONG   ;
    lBackColor      :LONG   ;
    usMixMode       :USHORT ;
    usBackMixMode   :USHORT ;
    usSet           :USHORT ;
    usSymbol        :USHORT ;
    ptlRefPoint     :POINTL ;
end record; -- AREABUNDLE;
type PAREABUNDLE  is access all AREABUNDLE;

--     image bundle for GpiSetAttributes and GpiQueryAttributes
type IMAGEBUNDLE  is record      -- ibmd
  lColor           :LONG   ;
  lBackColor       :LONG   ;
  usMixMode        :USHORT ;
  usBackMixMode    :USHORT ;
end record; -- IMAGEBUNDLE;
type PIMAGEBUNDLE  is access all IMAGEBUNDLE;

--     pointer to any bundle used by GpiSet/QueryAttrs
subtype PBUNDLE is  PVOID;

--     array indices for GpiQueryTextBox
 TXTBOX_TOPLEFT      :constant  Long:=           0 ;
 TXTBOX_BOTTOMLEFT   :constant  Long:=           1 ;
 TXTBOX_TOPRIGHT     :constant  Long:=           2 ;
 TXTBOX_BOTTOMRIGHT  :constant  Long:=           3 ;
 TXTBOX_CONCAT       :constant  Long:=           4 ;
-- array count for GpiQueryTextBox
 TXTBOX_COUNT        :constant  Long:=           5 ;

-- return codes for GpiPtVisible
 PVIS_ERROR          :constant  Long:=           0 ;
 PVIS_INVISIBLE      :constant  Long:=           1 ;
 PVIS_VISIBLE        :constant  Long:=           2 ;

-- return codes for GpiRectVisible
 RVIS_ERROR          :constant  Long:=           0 ;
 RVIS_INVISIBLE      :constant  Long:=           1 ;
 RVIS_PARTIAL        :constant  Long:=           2 ;
 RVIS_VISIBLE        :constant  Long:=           3 ;

--         attribute mode functions

function GpiSetAttrMode(ps   :HPS  ;
                        lMode:LONG ) return BOOL;
pragma Import(c,GpiSetAttrMode, Link_name=>"_GpiSetAttrMode");

function GpiQueryAttrMode(ps :HPS ) return LONG;
pragma Import(c,GpiQueryAttrMode, Link_name=>"_GpiQueryAttrMode");

--        bundle primitive functions

function GpiSetAttrs(ps        :HPS     ;
                     lPrimType :LONG    ;
                     flAttrMask:ULONG   ;
                     flDefMask :ULONG   ;
                     ppbunAttrs:PBUNDLE ) return BOOL;
pragma Import(c,GpiSetAttrs, Link_name=>"_GpiSetAttrs");

function GpiQueryAttrs(ps        :HPS     ;
                       lPrimType :LONG    ;
                       flAttrMask:ULONG   ;
                       ppbunAttrs:PBUNDLE ) return LONG;
pragma Import(c,GpiQueryAttrs, Link_name=>"_GpiQueryAttrs");

--        -- global primitive functions

function GpiSetBackColor(ps    :HPS  ;
                         lColor:LONG ) return BOOL;
pragma Import(c,GpiSetBackColor, Link_name=>"_GpiSetBackColor");

function GpiQueryBackColor(ps:HPS  ) return LONG;
pragma Import(c,GpiQueryBackColor, Link_name=>"_GpiQueryBackColor");

function GpiSetMix(ps      :HPS  ;
                   lMixMode:LONG ) return BOOL;
pragma Import(c,GpiSetMix, Link_name=>"_GpiSetMix");

function GpiQueryMix(ps:HPS) return LONG;
pragma Import(c,GpiQueryMix, Link_name=>"_GpiQueryMix");

function GpiSetBackMix(ps      :HPS  ;
                       lMixMode:LONG ) return BOOL;
pragma Import(c,GpiSetBackMix, Link_name=>"_GpiSetBackMix");

function GpiQueryBackMix(ps:HPS) return LONG;
pragma Import(c,GpiQueryBackMix, Link_name=>"_GpiQueryBackMix");

--         line primitive functions

function GpiSetLineType(ps       :HPS  ;
                        lLineType:LONG ) return BOOL;
pragma Import(c,GpiSetLineType, Link_name=>"_GpiSetLineType");

function GpiQueryLineType(ps:HPS) return LONG;
pragma Import(c,GpiQueryLineType, Link_name=>"_GpiQueryLineType");

function GpiSetLineWidth(ps         :HPS  ;
                         fxLineWidth:LONG ) return BOOL;
pragma Import(c,GpiSetLineWidth, Link_name=>"_GpiSetLineWidth");

function GpiQueryLineWidth(ps:HPS) return LONG;
pragma Import(c,GpiQueryLineWidth, Link_name=>"_GpiQueryLineWidth");

function GpiSetLineWidthGeom(ps        :HPS  ;
                             lLineWidth:LONG ) return BOOL;
pragma Import(c,GpiSetLineWidthGeom, Link_name=>"_GpiSetLineWidthGeom");

function GpiQueryLineWidthGeom(ps:HPS) return LONG;
pragma Import(c,GpiQueryLineWidthGeom, Link_name=>"_GpiQueryLineWidthGeom");

function GpiSetLineEnd(ps      :HPS  ;
                       lLineEnd:LONG ) return BOOL;
pragma Import(c,GpiSetLineEnd, Link_name=>"_GpiSetLineEnd");

function GpiQueryLineEnd(ps:HPS) return LONG;
pragma Import(c,GpiQueryLineEnd, Link_name=>"_GpiQueryLineEnd");

function GpiSetLineJoin(ps       :HPS  ;
                        lLineJoin:LONG ) return BOOL;
pragma Import(c,GpiSetLineJoin, Link_name=>"_GpiSetLineJoin");

function GpiQueryLineJoin(ps:HPS) return LONG;
pragma Import(c,GpiQueryLineJoin, Link_name=>"_GpiQueryLineJoin");

function GpiSetCurrentPosition(ps       :HPS     ;
                               pptlPoint:PPOINTL ) return BOOL;
pragma Import(c,GpiSetCurrentPosition, Link_name=>"_GpiSetCurrentPosition");

function GpiQueryCurrentPosition(ps       :HPS     ;
                                 pptlPoint:PPOINTL ) return BOOL;
pragma Import(c,GpiQueryCurrentPosition, Link_name=>"_GpiQueryCurrentPosition");

--         arc primitive functions

function GpiSetArcParams(ps            :HPS        ;
                         parcpArcParams:PARCPARAMS ) return BOOL;
pragma Import(c,GpiSetArcParams, Link_name=>"_GpiSetArcParams");

function GpiQueryArcParams(ps            :HPS        ;
                           parcpArcParams:PARCPARAMS ) return BOOL;
pragma Import(c,GpiQueryArcParams, Link_name=>"_GpiQueryArcParams");

function GpiPointArc(ps   :HPS     ;
                     pptl2:PPOINTL ) return LONG;
pragma Import(c,GpiPointArc, Link_name=>"_GpiPointArc");

function GpiFullArc(ps          :HPS  ;
                    lControl    :LONG ;
                    fxMultiplier:LONG ) return LONG;
pragma Import(c,GpiFullArc, Link_name=>"_GpiFullArc");

function GpiPartialArc(ps          :HPS     ;
                       pptlCenter  :PPOINTL ;
                       fxMultiplier:LONG    ;
                       fxStartAngle:LONG    ;
                       fxSweepAngle:LONG    ) return LONG;
pragma Import(c,GpiPartialArc, Link_name=>"_GpiPartialArc");

function GpiPolyFillet(ps        :HPS     ;
                       lCount    :LONG    ;
                       aptlPoints:PPOINTL ) return LONG;
pragma Import(c,GpiPolyFillet, Link_name=>"_GpiPolyFillet");

function GpiPolySpline(ps        :HPS     ;
                       lCount    :LONG    ;
                       aptlPoints:PPOINTL ) return LONG;
pragma Import(c,GpiPolySpline, Link_name=>"_GpiPolySpline");

function GpiPolyFilletSharp(ps        :HPS     ;
                            lCount    :LONG    ;
                            aptlPoints:PPOINTL ;
                            afxPoints :PLONG   ) return LONG;
pragma Import(c,GpiPolyFilletSharp, Link_name=>"_GpiPolyFilletSharp");

--         area primitive functions

function GpiSetPatternSet(ps  :HPS  ;
                          lSet:LONG ) return BOOL;
pragma Import(c,GpiSetPatternSet, Link_name=>"_GpiSetPatternSet");

function GpiQueryPatternSet(ps:HPS) return LONG;
pragma Import(c,GpiQueryPatternSet, Link_name=>"_GpiQueryPatternSet");

function GpiSetPatternRefPoint(ps          :HPS     ;
                               pptlRefPoint:PPOINTL ) return BOOL;
pragma Import(c,GpiSetPatternRefPoint, Link_name=>"_GpiSetPatternRefPoint");

function GpiQueryPatternRefPoint(ps          :HPS     ;
                                 pptlRefPoint:PPOINTL ) return BOOL;
pragma Import(c,GpiQueryPatternRefPoint, Link_name=>"_GpiQueryPatternRefPoint");

--        character primitive functions

function GpiQueryCharStringPos(ps           :HPS     ;
                               flOptions    :ULONG   ;
                               lCount       :LONG    ;
                               pchString    :PCH     ;
                               alXincrements:PLONG   ;
                               aptlPositions:PPOINTL ) return BOOL;
pragma Import(c,GpiQueryCharStringPos, Link_name=>"_GpiQueryCharStringPos");

function GpiQueryCharStringPosAt(ps           :HPS     ;
                                 pptlStart    :PPOINTL ;
                                 flOptions    :ULONG   ;
                                 lCount       :LONG    ;
                                 pchString    :PCH     ;
                                 alXincrements:PLONG   ;
                                 aptlPositions:PPOINTL ) return BOOL;
pragma Import(c,GpiQueryCharStringPosAt, Link_name=>"_GpiQueryCharStringPosAt");

function GpiQueryTextBox(ps        :HPS     ;
                         lCount1   :LONG    ;
                         pchString :PCH     ;
                         lCount2   :LONG    ;
                         aptlPoints:PPOINTL ) return BOOL;
pragma Import(c,GpiQueryTextBox, Link_name=>"_GpiQueryTextBox");

function GpiQueryDefCharBox(ps       :HPS    ;
                            psizlSize:PSIZEL ) return BOOL;
pragma Import(c,GpiQueryDefCharBox, Link_name=>"_GpiQueryDefCharBox");

function GpiSetCharSet(ps   :HPS  ;
                       llcid:LONG ) return BOOL;
pragma Import(c,GpiSetCharSet, Link_name=>"_GpiSetCharSet");

function GpiQueryCharSet(ps:HPS) return LONG;
pragma Import(c,GpiQueryCharSet, Link_name=>"_GpiQueryCharSet");

function GpiSetCharBox(ps       :HPS    ;
                       psizfxBox:PSIZEF ) return BOOL;
pragma Import(c,GpiSetCharBox, Link_name=>"_GpiSetCharBox");

function GpiQueryCharBox(ps        :HPS    ;
                         psizfxSize:PSIZEF ) return BOOL;
pragma Import(c,GpiQueryCharBox, Link_name=>"_GpiQueryCharBox");

function GpiSetCharAngle(ps         :HPS        ;
                         pgradlAngle:PGRADIENTL ) return BOOL;
pragma Import(c,GpiSetCharAngle, Link_name=>"_GpiSetCharAngle");

function GpiQueryCharAngle(ps         :HPS        ;
                           pgradlAngle:PGRADIENTL ) return BOOL;
pragma Import(c,GpiQueryCharAngle, Link_name=>"_GpiQueryCharAngle");

function GpiSetCharShear(ps       :HPS     ;
                         pptlAngle:PPOINTL ) return BOOL;
pragma Import(c,GpiSetCharShear, Link_name=>"_GpiSetCharShear");

function GpiQueryCharShear(ps       :HPS     ;
                           pptlShear:PPOINTL ) return BOOL;
pragma Import(c,GpiQueryCharShear, Link_name=>"_GpiQueryCharShear");

function GpiSetCharDirection(ps        :HPS  ;
                             lDirection:LONG ) return BOOL;
pragma Import(c,GpiSetCharDirection, Link_name=>"_GpiSetCharDirection");

function GpiQueryCharDirection(ps:HPS) return LONG;
pragma Import(c,GpiQueryCharDirection, Link_name=>"_GpiQueryCharDirection");

function GpiSetCharMode(ps   :HPS  ;
                        lMode:LONG ) return BOOL;
pragma Import(c,GpiSetCharMode, Link_name=>"_GpiSetCharMode");

function GpiQueryCharMode(ps:HPS) return LONG;
pragma Import(c,GpiQueryCharMode, Link_name=>"_GpiQueryCharMode");

function GpiSetTextAlignment(ps    :HPS  ;
                             lHoriz:LONG ;
                             lVert :LONG ) return BOOL;
pragma Import(c,GpiSetTextAlignment, Link_name=>"_GpiSetTextAlignment");

function GpiQueryTextAlignment(ps     :HPS   ;
                               plHoriz:PLONG ;
                               plVert :PLONG ) return BOOL;
pragma Import(c,GpiQueryTextAlignment, Link_name=>"_GpiQueryTextAlignment");

function GpiCharStringPos(ps       :HPS    ;
                          prclRect :PRECTL ;
                          flOptions:ULONG  ;
                          lCount   :LONG   ;
                          pchString:PCH    ;
                          alAdx    :PLONG  ) return LONG;
pragma Import(c,GpiCharStringPos, Link_name=>"_GpiCharStringPos");

function GpiCharStringPosAt(ps       :HPS     ;
                            pptlStart:PPOINTL ;
                            prclRect :PRECTL  ;
                            flOptions:ULONG   ;
                            lCount   :LONG    ;
                            pchString:PCH     ;
                            alAdx    :PLONG   ) return LONG;
pragma Import(c,GpiCharStringPosAt, Link_name=>"_GpiCharStringPosAt");

function GpiSetCharExtra(ps   :HPS   ;
                         Extra:LONG  ) return BOOL;
pragma Import(c,GpiSetCharExtra, Link_name=>"_GpiSetCharExtra");

function GpiSetCharBreakExtra(ps        :HPS   ;
                              BreakExtra:LONG  ) return BOOL;
pragma Import(c,GpiSetCharBreakExtra, Link_name=>"_GpiSetCharBreakExtra");

function GpiQueryCharExtra(ps   :HPS   ;
                           Extra:PLONG ) return BOOL;
pragma Import(c,GpiQueryCharExtra, Link_name=>"_GpiQueryCharExtra");

function GpiQueryCharBreakExtra(ps        :HPS   ;
                                BreakExtra:PLONG ) return BOOL;
pragma Import(c,GpiQueryCharBreakExtra, Link_name=>"_GpiQueryCharBreakExtra");

--         marker primitive functions

function GpiMarker(ps       :HPS     ;
                   pptlPoint:PPOINTL ) return LONG;
pragma Import(c,GpiMarker, Link_name=>"_GpiMarker");

function GpiPolyMarker(ps        :HPS     ;
                       lCount    :LONG    ;
                       aptlPoints:PPOINTL ) return LONG;
pragma Import(c,GpiPolyMarker, Link_name=>"_GpiPolyMarker");

function GpiSetMarker(ps     :HPS  ;
                      lSymbol:LONG ) return BOOL;
pragma Import(c,GpiSetMarker, Link_name=>"_GpiSetMarker");

function GpiSetMarkerBox(ps        :HPS    ;
                         psizfxSize:PSIZEF ) return BOOL;
pragma Import(c,GpiSetMarkerBox, Link_name=>"_GpiSetMarkerBox");

function GpiSetMarkerSet(ps  :HPS  ;
                         lSet:LONG ) return BOOL;
pragma Import(c,GpiSetMarkerSet, Link_name=>"_GpiSetMarkerSet");

function GpiQueryMarker(ps:HPS) return LONG;
pragma Import(c,GpiQueryMarker, Link_name=>"_GpiQueryMarker");

function GpiQueryMarkerBox(ps        :HPS    ;
                           psizfxSize:PSIZEF ) return BOOL;
pragma Import(c,GpiQueryMarkerBox, Link_name=>"_GpiQueryMarkerBox");

function GpiQueryMarkerSet(ps:HPS) return LONG;
pragma Import(c,GpiQueryMarkerSet, Link_name=>"_GpiQueryMarkerSet");

--         image primitive functions

function GpiImage(ps            :HPS    ;
                  lFormat       :LONG   ;
                  psizlImageSize:PSIZEL ;
                  lLength       :LONG   ;
                  pbData        :PBYTE  ) return LONG;
pragma Import(c,GpiImage, Link_name=>"_GpiImage");

--         miscellaneous primitive functions

function GpiPop(ps    :HPS  ;
                lCount:LONG ) return BOOL;
pragma Import(c,GpiPop, Link_name=>"_GpiPop");

function GpiPtVisible(ps       :HPS     ;
                      pptlPoint:PPOINTL ) return LONG;
pragma Import(c,GpiPtVisible, Link_name=>"_GpiPtVisible");

function GpiRectVisible(ps           :HPS    ;
                        prclRectangle:PRECTL ) return LONG;
pragma Import(c,GpiRectVisible, Link_name=>"_GpiRectVisible");

function GpiComment(ps     :HPS   ;
                    lLength:LONG  ;
                    pbData :PBYTE ) return BOOL;
pragma Import(c,GpiComment, Link_name=>"_GpiComment");

-- return codes from GpiCreateLogFont
 FONT_DEFAULT        :constant  Long:=           1 ;
 FONT_MATCH          :constant  Long:=           2 ;

-- lcid type for GpiQuerySetIds
 LCIDT_FONT          :constant  Long:=           6 ;

 LCIDT_BITMAP        :constant  Long:=           7 ;

-- constant used to delete all lcids by GpiDeleteSetId
 LCID_ALL            :constant  Long:=          (-1);

--      kerning data returned by GpiQueryKerningPairs
type KERNINGPAIRS  is record     -- krnpr
    sFirstChar       :SHORT ;
    sSecondChar      :SHORT ;
    lKerningAmount   :LONG  ;
end record; -- KERNINGPAIRS;
type PKERNINGPAIRS  is access all KERNINGPAIRS;

--     data required by GpiQueryFaceString
type FACENAMEDESC  is record     -- fnd
    usSize          :USHORT ;
    usWeightClass   :USHORT ;
    usWidthClass    :USHORT ;
    usReserved      :USHORT ;
    flOptions       :ULONG  ;
end record; -- FACENAMEDESC;
type PFACENAMEDESC  is access all FACENAMEDESC;

-- FACENAMEDESC 'WeightClass' options for GpiQueryFaceString
 FWEIGHT_DONT_CARE     :constant  Long:=0 ;
 FWEIGHT_ULTRA_LIGHT   :constant  Long:=1 ;
 FWEIGHT_EXTRA_LIGHT   :constant  Long:=2 ;
 FWEIGHT_LIGHT         :constant  Long:=3 ;
 FWEIGHT_SEMI_LIGHT    :constant  Long:= 4 ;
 FWEIGHT_NORMAL        :constant  Long:= 5 ;
 FWEIGHT_SEMI_BOLD     :constant  Long:= 6 ;
 FWEIGHT_BOLD          :constant  Long:=7 ;
 FWEIGHT_EXTRA_BOLD    :constant  Long:=8 ;
 FWEIGHT_ULTRA_BOLD    :constant  Long:=9 ;

-- FACENAMEDESC 'WidthClass' options for GpiQueryFaceString
 FWIDTH_DONT_CARE      :constant  Long:=0 ;
 FWIDTH_ULTRA_CONDENSED:constant  Long:=1 ;
 FWIDTH_EXTRA_CONDENSED:constant  Long:=2 ;
 FWIDTH_CONDENSED      :constant  Long:=3 ;
 FWIDTH_SEMI_CONDENSED :constant  Long:=4 ;
 FWIDTH_NORMAL         :constant  Long:=5 ;
 FWIDTH_SEMI_EXPANDED  :constant  Long:=6 ;
 FWIDTH_EXPANDED       :constant  Long:=7 ;
 FWIDTH_EXTRA_EXPANDED :constant  Long:=8 ;
 FWIDTH_ULTRA_EXPANDED :constant  Long:=9 ;

-- FACENAMEDESC 'options' for GpiQueryFaceString
 FTYPE_ITALIC          :constant  Long:=  16#0001#;
 FTYPE_ITALIC_DONT_CARE:constant  Long:=  16#0002#;
 FTYPE_OBLIQUE         :constant  Long:=  16#0004#;
 FTYPE_OBLIQUE_DONT_CARE:constant  Long:= 16#0008#;
 FTYPE_ROUNDED          :constant  Long:= 16#0010#;
 FTYPE_ROUNDED_DONT_CARE:constant  Long:= 16#0020#;

-- actions for GpiQueryFontAction
 QFA_PUBLIC    :constant  Long:= 1 ;
 QFA_PRIVATE   :constant  Long:= 2 ;
 QFA_ERROR     :constant  Long:=  GPI_ALTERROR ;

-- options for GpiQueryFonts
 QF_PUBLIC     :constant  Long:=             16#0001#;
 QF_PRIVATE    :constant  Long:=             16#0002#;
 QF_NO_GENERIC :constant  Long:=             16#0004#;
 QF_NO_DEVICE  :constant  Long:=             16#0008#;

   -- font file descriptions for GpiQueryFontFileDescriptions
type FFDESCS is array (1..2,1..FACESIZE) of aliased character; -- ffdescs 2*32
subtype PFFDESCS  is PCHAR ;
type FFDESCS2   is record   -- ffdescs2
     cbLength             :ULONG  ;
     cbFacenameOffset     :ULONG  ;
     abFamilyName         :BYTE   ;   --[1];
end record; -- FFDESCS2;
type PFFDESCS2  is access all FFDESCS2;

--         physical and logical font functions
--
function GpiCreateLogFont(ps       :HPS     ;
                          pName    :PSZ     ;
                          lLcid    :LONG    ;
                          pfatAttrs:PFATTRS ) return LONG;
pragma Import(c,GpiCreateLogFont, Link_name=>"_GpiCreateLogFont");

function GpiDeleteSetId(ps   :HPS  ;
                        lLcid:LONG ) return BOOL;
pragma Import(c,GpiDeleteSetId, Link_name=>"_GpiDeleteSetId");

function GpiLoadFonts(ha         :HAB ;
                      pszFilename:PSZ ) return BOOL;
pragma Import(c,GpiLoadFonts, Link_name=>"_GpiLoadFonts");

function GpiUnloadFonts(ha         :HAB ;
                        pszFilename:PSZ ) return BOOL;
pragma Import(c,GpiUnloadFonts, Link_name=>"_GpiUnloadFonts");

function GpiQueryFonts(ps            :HPS          ;
                       flOptions     :ULONG        ;
                       pszFacename   :PSZ          ;
                       plReqFonts    :PLONG        ;
                       lMetricsLength:LONG         ;
                       afmMetrics    :PFONTMETRICS ) return LONG;
pragma Import(c,GpiQueryFonts, Link_name=>"_GpiQueryFonts");

function GpiQueryFontMetrics(ps            :HPS          ;
                             lMetricsLength:LONG         ;
                             pfmMetrics    :PFONTMETRICS ) return BOOL;
pragma Import(c,GpiQueryFontMetrics, Link_name=>"_GpiQueryFontMetrics");

function GpiQueryKerningPairs(ps        :HPS           ;
                              lCount    :LONG          ;
                              akrnprData:PKERNINGPAIRS ) return LONG;
pragma Import(c,GpiQueryKerningPairs, Link_name=>"_GpiQueryKerningPairs");

function GpiQueryWidthTable(ps        :HPS  ;
                            lFirstChar:LONG ;
                            lCount    :LONG ;
                             alData   :PLONG) return BOOL;
pragma Import(c,GpiQueryWidthTable, Link_name=>"_GpiQueryWidthTable");

function GpiQueryNumberSetIds(ps:HPS) return LONG;
pragma Import(c,GpiQueryNumberSetIds, Link_name=>"_GpiQueryNumberSetIds");

function GpiQuerySetIds(ps     :HPS   ;
                        lCount :LONG  ;
                        alTypes:PLONG ;
                        aNames :PSZ   ;
                        allcids:PLONG ) return BOOL;
pragma Import(c,GpiQuerySetIds, Link_name=>"_GpiQuerySetIds");

function GpiQueryFaceString(Ps              :HPS           ;
                            FamilyName      :PSZ           ;
                            attrs           :PFACENAMEDESC ;
                            length          :LONG          ;
                            CompoundFaceName:PSZ           ) return ULONG;
pragma Import(c,GpiQueryFaceString, Link_name=>"_GpiQueryFaceString");

function GpiQueryLogicalFont(Ps    :HPS     ;
                             lcid  :LONG    ;
                             name  :PSZ     ;
                             attrs :PFATTRS ;
                             length:LONG    ) return BOOL;
pragma Import(c,GpiQueryLogicalFont, Link_name=>"_GpiQueryLogicalFont");

function GpiQueryFontAction(anchor :HAB   ;
                            options:ULONG ) return ULONG;
pragma Import(c,GpiQueryFontAction, Link_name=>"_GpiQueryFontAction");

function GpiLoadPublicFonts(ha:HAB;
                            ps:PSZ) return BOOL;
pragma Import(c,GpiLoadPublicFonts, Link_name=>"_GpiLoadPublicFonts");

function GpiUnloadPublicFonts(ha:HAB;
                              ps:PSZ) return BOOL;
pragma Import(c,GpiUnloadPublicFonts, Link_name=>"_GpiUnloadPublicFonts");

function GpiSetCp( ps        :HPS  ;
                   ulCodePage:ULONG) return BOOL  ;
pragma Import(c,GpiSetCp, Link_name=>"_GpiSetCp");

function GpiQueryCp(ps:HPS) return ULONG ;
pragma Import(c,GpiQueryCp, Link_name=>"_GpiQueryCp");

function GpiQueryFullFontFileDescs(ha               :HAB   ;
                                   pszFilename      :PSZ   ;
                                   plCount          :PLONG ;
                                   pNames           :PVOID ;
                                   plNamesBuffLength:PLONG ) return LONG  ;
pragma Import(c,GpiQueryFullFontFileDescs, Link_name=>"_GpiQueryFullFontFileDescs");

function GpiQueryFontFileDescriptions(ha           :HAB      ;
                                      pszFilename  :PSZ      ;
                                      plCount      :PLONG    ;
                                      affdescsNames:PFFDESCS ) return LONG  ;
pragma Import(c,GpiQueryFontFileDescriptions, Link_name=>"_GpiQueryFontFileDescriptions");

-- raster operations defined for GpiBitBlt
 ROP_SRCCOPY   :constant  Long:=             16#00CC#;
 ROP_SRCPAINT  :constant  Long:=             16#00EE#;
 ROP_SRCAND    :constant  Long:=             16#0088#;
 ROP_SRCINVERT :constant  Long:=             16#0066#;
 ROP_SRCERASE  :constant  Long:=             16#0044#;
 ROP_NOTSRCCOPY:constant  Long:=             16#0033#;
 ROP_NOTSRCERASE:constant  Long:=            16#0011#;
 ROP_MERGECOPY  :constant  Long:=            16#00C0#;
 ROP_MERGEPAINT :constant  Long:=            16#00BB#;
 ROP_PATCOPY    :constant  Long:=            16#00F0#;
 ROP_PATPAINT   :constant  Long:=            16#00FB#;
 ROP_PATINVERT  :constant  Long:=            16#005A#;
 ROP_DSTINVERT  :constant  Long:=            16#0055#;
 ROP_ZERO       :constant  Long:=            16#0000#;
 ROP_ONE        :constant  Long:=            16#00FF#;

-- Blt options for GpiBitBlt
 BBO_OR         :constant  Long:=                0 ;
 BBO_AND        :constant  Long:=                1 ;
 BBO_IGNORE     :constant  Long:=                2 ;
 BBO_PAL_COLORS :constant  Long:=                4 ;
 BBO_NO_COLOR_INFO :constant  Long:=             8 ;

-- Fill options for GpiFloodFill
 FF_BOUNDARY   :constant  Long:=                 0 ;
 FF_SURFACE    :constant  Long:=                 1 ;

--     -- error return for GpiSetBitmap
--      HBM_ERROR            ((HBITMAP)-1);
--
--         bitmap and pel functions
--
function GpiBitBlt(psTarget  :HPS     ;
                   psSource  :HPS     ;
                   lCount    :LONG    ;
                   aptlPoints:PPOINTL ;
                   lRop      :LONG    ;
                   flOptions :ULONG   ) return LONG   ;
pragma Import(c,GpiBitBlt, Link_name=>"_GpiBitBlt");

function GpiDeleteBitmap( hbm:HBITMAP) return BOOL   ;
pragma Import(c,GpiDeleteBitmap, Link_name=>"_GpiDeleteBitmap");

function GpiLoadBitmap(ps      :HPS     ;
                       Resource:HMODULE ;
                       idBitmap:ULONG   ;
                       lWidth  :LONG    ;
                       lHeight :LONG    ) return HBITMAP;
pragma Import(c,GpiLoadBitmap, Link_name=>"_GpiLoadBitmap");

function GpiSetBitmap(ps :HPS     ;
                      hbm:HBITMAP ) return HBITMAP;
pragma Import(c,GpiSetBitmap, Link_name=>"_GpiSetBitmap");

function GpiWCBitBlt(psTarget  :HPS     ;
                     hbmSource :HBITMAP ;
                     lCount    :LONG    ;
                     aptlPoints:PPOINTL ;
                     lRop      :LONG    ;
                     flOptions :ULONG   ) return LONG   ;
pragma Import(c,GpiWCBitBlt, Link_name=>"_GpiWCBitBlt");
--
--     --** include bitmap structures and file formats ************************
   -- bitmap parameterization used by GpiCreateBitmap and others
type BITMAPINFOHEADER  is record         -- bmp
  cbFix       :ULONG  ;
  cx          :USHORT ;
  cy          :USHORT ;
  cPlanes     :USHORT ;
  cBitCount   :USHORT ;
end record; --  BITMAPINFOHEADER;
type PBITMAPINFOHEADER  is access all BITMAPINFOHEADER;

   -- RGB data for _BITMAPINFO struct
type RGB   is record              -- rgb
   bBlue   :BYTE ;
   bGreen  :BYTE ;
   bRed    :BYTE ;
end record; --  RGB;

   -- bitmap data used by GpiSetBitmapBits and others
type BITMAPINFO  is record       -- bmi
   cbFix      :ULONG  ;
   cx         :USHORT ;
   cy         :USHORT ;
   cPlanes    :USHORT ;
   cBitCount  :USHORT ;
   argbColor  :RGB    ;   --[1];
   end record; --  BITMAPINFO;
type PBITMAPINFO  is access all BITMAPINFO;

   -- Constants for compression/decompression command

 CBD_COMPRESSION   :constant  Long:=  1 ;
 CBD_DECOMPRESSION :constant  Long:=  2 ;
 CBD_BITS          :constant  Long:=  0 ;

-- Flags for compression/decompression option

 CBD_COLOR_CONVERSION :constant Long:=16#00000001#;

-- Compression scheme in the ulCompression field of the bitmapinfo structure

 BCA_UNCOMP      :constant  Long:=   0 ;
 BCA_HUFFMAN1D   :constant  Long:=   3 ;
 BCA_RLE4        :constant  Long:=   2 ;
 BCA_RLE8        :constant  Long:=   1 ;
 BCA_RLE24       :constant  Long:=   4 ;
 BRU_METRIC      :constant  Long:=   0 ;
 BRA_BOTTOMUP    :constant  Long:=   0 ;
 BRH_NOTHALFTONED   :constant  Long:=0 ;
 BRH_ERRORDIFFUSION :constant  Long:=1 ;
 BRH_PANDA          :constant  Long:=2 ;
 BRH_SUPERCIRCLE    :constant  Long:=3 ;

 BCE_PALETTE        :constant  Long:= -1;
 BCE_RGB            :constant  Long:=0 ;

type BITMAPINFOHEADER2  is record        -- bmp2
   cbFix            :ULONG  ;  -- Length of structure
   cx               :ULONG  ;  -- Bit-map width in pels
   cy               :ULONG  ;  -- Bit-map height in pels
   cPlanes          :USHORT ;  -- Number of bit planes
   cBitCount        :USHORT ;  -- Number of bits per pel within a plane
   ulCompression    :ULONG  ;  -- Compression scheme used to store the bitmap
   cbImage          :ULONG  ;  -- Length of bit-map storage data in bytes
   cxResolution     :ULONG  ;  -- x resolution of target device
   cyResolution     :ULONG  ;  -- y resolution of target device
   cclrUsed         :ULONG  ;  -- Number of color indices used
   cclrImportant    :ULONG  ;  -- Number of important color indices
   usUnits          :USHORT ;  -- Units of measure
   usReserved       :USHORT ;  -- Reserved
   usRecording      :USHORT ;  -- Recording algorithm
   usRendering      :USHORT ;  -- Halftoning algorithm
   cSize1           :ULONG  ;  -- Size value 1
   cSize2           :ULONG  ;  -- Size value 2
   ulColorEncoding  :ULONG  ;  -- Color encoding
   ulIdentifier     :ULONG  ;  -- Reserved for application use
end record; --  BITMAPINFOHEADER2;
type PBITMAPINFOHEADER2  is access all BITMAPINFOHEADER2;

type RGB2   is record        -- rgb2
  bBlue       :BYTE ;        -- Blue component of the color definition
  bGreen      :BYTE ;        -- Green component of the color definition
  bRed        :BYTE ;        -- Red component of the color definition
  fcOptions   :BYTE ;        -- Reserved, must be zero
end record; --  RGB2;
type PRGB2  is access all RGB2;

type BITMAPINFO2  is record       -- bmi2
   cbFix            :ULONG  ;  -- Length of fixed portion of structure
   cx               :ULONG  ;  -- Bit-map width in pels
   cy               :ULONG  ;  -- Bit-map height in pels
   cPlanes          :USHORT ;  -- Number of bit planes
   cBitCount        :USHORT ;  -- Number of bits per pel within a plane
   ulCompression    :ULONG  ;  -- Compression scheme used to store the bitmap
   cbImage          :ULONG  ;  -- Length of bit-map storage data in bytes
   cxResolution     :ULONG  ;  -- x resolution of target device
   cyResolution     :ULONG  ;  -- y resolution of target device
   cclrUsed         :ULONG  ;  -- Number of color indices used
   cclrImportant    :ULONG  ;  -- Number of important color indices
   usUnits          :USHORT ;  -- Units of measure
   usReserved       :USHORT ;  -- Reserved
   usRecording      :USHORT ;  -- Recording algorithm
   usRendering      :USHORT ;  -- Halftoning algorithm
   cSize1           :ULONG  ;  -- Size value 1
   cSize2           :ULONG  ;  -- Size value 2
   ulColorEncoding  :ULONG  ;  -- Color encoding
   ulIdentifier     :ULONG  ;  -- Reserved for application use
   argbColor        :RGB2   ;  -- Color definition record   [1]
end record; --  BITMAPINFO2;
type PBITMAPINFO2  is access all BITMAPINFO2;

type BITMAPFILEHEADER  is record    -- bfh
   usType    :USHORT    ;
   cbSize    :ULONG     ;
   xHotspot  :SHORT     ;
   yHotspot  :SHORT     ;
   offBits   :ULONG     ;
   bmp  :BITMAPINFOHEADER ;
end record; --  BITMAPFILEHEADER;
type PBITMAPFILEHEADER  is access all BITMAPFILEHEADER;

type BITMAPARRAYFILEHEADER    is record     -- bafh
  usType      :USHORT           ;
  cbSize      :ULONG            ;
  offNext     :ULONG            ;
  cxDisplay   :USHORT           ;
  cyDisplay   :USHORT           ;
  bfh         :BITMAPFILEHEADER ;
end record; --  BITMAPARRAYFILEHEADER;
type PBITMAPARRAYFILEHEADER  is access all BITMAPARRAYFILEHEADER;

type BITMAPFILEHEADER2  is record    -- bfh2
  usType     :USHORT            ;
  cbSize     :ULONG             ;
  xHotspot   :SHORT             ;
  yHotspot   :SHORT             ;
  offBits    :ULONG             ;
  bmp2       :BITMAPINFOHEADER2 ;
end record; --  BITMAPFILEHEADER2;
type PBITMAPFILEHEADER2  is access all BITMAPFILEHEADER2;

type BITMAPARRAYFILEHEADER2   is record    -- bafh2
  usType      :USHORT            ;
  cbSize      :ULONG             ;
  offNext     :ULONG             ;
  cxDisplay   :USHORT            ;
  cyDisplay   :USHORT            ;
  bfh2        :BITMAPFILEHEADER2 ;
end record; --  BITMAPARRAYFILEHEADER2;
type PBITMAPARRAYFILEHEADER2  is access all BITMAPARRAYFILEHEADER2;

-- * These are the identifying values that go in the usType field of the
-- * BITMAPFILEHEADER(2) and BITMAPARRAYFILEHEADER(2).
-- * (BFT_ => Bit map File Type)
--
--  BFT_ICON           16#4349      'IC'
--  BFT_BMAP           16#4d42      'BM'
--  BFT_POINTER        16#5450      'PT'
--  BFT_COLORICON      16#4943      'CI'
--  BFT_COLORPOINTER   16#5043      'CP'
--  BFT_BITMAPARRAY    16#4142      'BA'
--
--     -- usage flags for GpiCreateBitmap
--      CBM_INIT        16#0004#;
--
--     -- error return code for GpiSet/QueryBitmapBits
--      BMB_ERROR                     -1;

--        --** bitmap and pel functions

function GpiCreateBitmap(ps           :HPS                ;
                         pbmpNew      :PBITMAPINFOHEADER2 ;
                         flOptions    :ULONG              ;
                         pbInitData   :PBYTE              ;
                         pbmiInfoTable:PBITMAPINFO2       ) return HBITMAP;
pragma Import(c,GpiCreateBitmap, Link_name=>"_GpiCreateBitmap");

function GpiSetBitmapBits(ps           :HPS          ;
                          lScanStart   :LONG         ;
                          lScans       :LONG         ;
                          pbBuffer     :PBYTE        ;
                          pbmiInfoTable:PBITMAPINFO2 ) return LONG  ;
pragma Import(c,GpiSetBitmapBits, Link_name=>"_GpiSetBitmapBits");

function GpiSetBitmapDimension(hbm                 :HBITMAP ;
                               psizlBitmapDimension:PSIZEL  ) return BOOL  ;
pragma Import(c,GpiSetBitmapDimension, Link_name=>"_GpiSetBitmapDimension");

function GpiSetBitmapId(ps   :HPS     ;
                        hbm  :HBITMAP ;
                        lLcid:LONG    ) return BOOL  ;
pragma Import(c,GpiSetBitmapId, Link_name=>"_GpiSetBitmapId");

function GpiQueryBitmapBits( ps           :HPS         ;
                             lScanStart   :LONG        ;
                             lScans       :LONG        ;
                             pbBuffer     :PBYTE       ;
                             pbmiInfoTable:PBITMAPINFO2) return LONG  ;
pragma Import(c,GpiQueryBitmapBits, Link_name=>"_GpiQueryBitmapBits");

function GpiQueryBitmapDimension(hbm                 :HBITMAP ;
                                 psizlBitmapDimension:PSIZEL  ) return BOOL  ;
pragma Import(c,GpiQueryBitmapDimension, Link_name=>"_GpiQueryBitmapDimension");

function GpiQueryBitmapHandle(ps   :HPS  ;
                              lLcid:LONG ) return HBITMAP;
pragma Import(c,GpiQueryBitmapHandle, Link_name=>"_GpiQueryBitmapHandle");

function GpiQueryBitmapParameters(hbm     :HBITMAP           ;
                                  pbmpData:PBITMAPINFOHEADER ) return BOOL  ;
pragma Import(c,GpiQueryBitmapParameters, Link_name=>"_GpiQueryBitmapParameters");

function GpiQueryBitmapInfoHeader(hbm     :HBITMAP            ;
                                  pbmpData:PBITMAPINFOHEADER2 ) return BOOL  ;
pragma Import(c,GpiQueryBitmapInfoHeader, Link_name=>"_GpiQueryBitmapInfoHeader");

function GpiQueryDeviceBitmapFormats(ps     :HPS   ;
                                     lCount :LONG  ;
                                     alArray:PLONG ) return BOOL  ;
pragma Import(c,GpiQueryDeviceBitmapFormats, Link_name=>"_GpiQueryDeviceBitmapFormats");

function GpiSetPel(ps       :HPS     ;
                   pptlPoint:PPOINTL ) return LONG  ;
pragma Import(c,GpiSetPel, Link_name=>"_GpiSetPel");

function GpiQueryPel(ps       :HPS     ;
                     pptlPoint:PPOINTL ) return LONG  ;
pragma Import(c,GpiQueryPel, Link_name=>"_GpiQueryPel");

function GpiFloodFill(ps      :HPS  ;
                      lOptions:LONG ;
                      lColor  :LONG ) return LONG  ;
pragma Import(c,GpiFloodFill, Link_name=>"_GpiFloodFill");

function GpiDrawBits(ps           :HPS          ;
                     pBits        :PVOID        ;
                     pbmiInfoTable:PBITMAPINFO2 ;
                     lCount       :LONG         ;
                     aptlPoints   :PPOINTL      ;
                     lRop         :LONG         ;
                     flOptions    :ULONG        ) return LONG  ;
pragma Import(c,GpiDrawBits, Link_name=>"_GpiDrawBits");

 -- options for GpiCombineRegion
  CRGN_OR        :constant  Long:=                1 ;
  CRGN_COPY      :constant  Long:=                2 ;
  CRGN_XOR       :constant  Long:=                4 ;
  CRGN_AND       :constant  Long:=                6 ;
  CRGN_DIFF      :constant  Long:=                7 ;

 -- usDirection of returned region data for GpiQueryRegionRects
  RECTDIR_LFRT_TOPBOT :constant  Long:=           1 ;
  RECTDIR_RTLF_TOPBOT :constant  Long:=           2 ;
  RECTDIR_LFRT_BOTTOP :constant  Long:=           3 ;
  RECTDIR_RTLF_BOTTOP :constant  Long:=           4 ;

--      control data for GpiQueryRegionRects
type RGNRECT    is record         -- rgnrc
    ircStart      :ULONG  ;
    crc           :ULONG  ;
    crcReturned   :ULONG  ;
    ulDirection   :ULONG  ;
end record; -- RGNRECT;
type PRGNRECT  is access all RGNRECT;

-- return code to indicate type of region for GpiCombineRegion and others
 RGN_ERROR    :constant  Long:=                  0 ;
 RGN_NULL     :constant  Long:=                  1 ;
 RGN_RECT     :constant  Long:=                  2 ;
 RGN_COMPLEX  :constant  Long:=                  3 ;

-- return codes for GpiPtInRegion
 PRGN_ERROR    :constant  Long:=                 0 ;
 PRGN_OUTSIDE  :constant  Long:=                 1 ;
 PRGN_INSIDE   :constant  Long:=                 2 ;

-- return codes for GpiRectInRegion
 RRGN_ERROR    :constant  Long:=                 0 ;
 RRGN_OUTSIDE  :constant  Long:=                 1 ;
 RRGN_PARTIAL  :constant  Long:=                 2 ;
 RRGN_INSIDE   :constant  Long:=                 3 ;

-- return codes for GpiEqualRegion
 EQRGN_ERROR   :constant  Long:=                 0 ;
 EQRGN_NOTEQUAL:constant  Long:=                 1 ;
 EQRGN_EQUAL   :constant  Long:=                 2 ;

-- error return code for GpiSetRegion
--      HRGN_ERROR              ((HRGN)-1);

--       main region functions

function GpiCombineRegion(ps      :HPS  ;
                          hrgnDest:HRGN ;
                          hrgnSrc1:HRGN ;
                          hrgnSrc2:HRGN ;
                          lMode   :LONG ) return LONG;
pragma Import(c,GpiCombineRegion, Link_name=>"_GpiCombineRegion");

function GpiCreateRegion(ps            :HPS    ;
                         lCount        :LONG   ;
                         arclRectangles:PRECTL ) return HRGN;
pragma Import(c,GpiCreateRegion, Link_name=>"_GpiCreateRegion");

function GpiDestroyRegion(ps  :HPS  ;
                          hrg :HRGN ) return BOOL;
pragma Import(c,GpiDestroyRegion, Link_name=>"_GpiDestroyRegion");

function GpiEqualRegion(ps      :HPS  ;
                        hrgnSrc1:HRGN ;
                        hrgnSrc2:HRGN ) return LONG;
pragma Import(c,GpiEqualRegion, Link_name=>"_GpiEqualRegion");

function GpiOffsetRegion(ps        :HPS     ;
                         Hrg       :HRGN    ;
                         pptlOffset:PPOINTL ) return BOOL;
pragma Import(c,GpiOffsetRegion, Link_name=>"_GpiOffsetRegion");

function GpiPaintRegion(ps  :HPS  ;
                        hrg :HRGN ) return LONG;
pragma Import(c,GpiPaintRegion, Link_name=>"_GpiPaintRegion");

function GpiFrameRegion(ps       :HPS    ;
                        hrg      :HRGN   ;
                        thickness:PSIZEL ) return LONG;
pragma Import(c,GpiFrameRegion, Link_name=>"_GpiFrameRegion");

function GpiPtInRegion(ps       :HPS     ;
                       hrg      :HRGN    ;
                       pptlPoint:PPOINTL ) return LONG;
pragma Import(c,GpiPtInRegion, Link_name=>"_GpiPtInRegion");

function GpiQueryRegionBox(ps       :HPS    ;
                           hrg      :HRGN   ;
                           prclBound:PRECTL ) return LONG;
pragma Import(c,GpiQueryRegionBox, Link_name=>"_GpiQueryRegionBox");

function GpiQueryRegionRects(ps           :HPS      ;
                             hrg          :HRGN     ;
                             prclBound    :PRECTL   ;
                             prgnrcControl:PRGNRECT ;
                             prclRect     :PRECTL   ) return BOOL;
pragma Import(c,GpiQueryRegionRects, Link_name=>"_GpiQueryRegionRects");

function GpiRectInRegion(ps      :HPS    ;
                         hrg     :HRGN   ;
                         prclRect:PRECTL ) return LONG;
pragma Import(c,GpiRectInRegion, Link_name=>"_GpiRectInRegion");

function GpiSetRegion(ps            :HPS    ;
                      hrg           :HRGN   ;
                      lcount        :LONG   ;
                      arclRectangles:PRECTL ) return BOOL;
pragma Import(c,GpiSetRegion, Link_name=>"_GpiSetRegion");

--         clip region functions

function GpiSetClipRegion(ps      :HPS   ;
                          hrg     :HRGN  ;
                          phrgnOld:PHRGN ) return LONG;
pragma Import(c,GpiSetClipRegion, Link_name=>"_GpiSetClipRegion");

function GpiQueryClipRegion(ps:HPS) return HRGN;
pragma Import(c,GpiQueryClipRegion, Link_name=>"_GpiQueryClipRegion");

function GpiQueryClipBox(ps       :HPS    ;
                         prclBound:PRECTL ) return LONG;
pragma Import(c,GpiQueryClipBox, Link_name=>"_GpiQueryClipBox");

function GpiExcludeClipRectangle(ps           :HPS    ;
                                 prclRectangle:PRECTL ) return LONG;
pragma Import(c,GpiExcludeClipRectangle, Link_name=>"_GpiExcludeClipRectangle");

function GpiIntersectClipRectangle(ps           :HPS    ;
                                   prclRectangle:PRECTL ) return LONG;
pragma Import(c,GpiIntersectClipRectangle, Link_name=>"_GpiIntersectClipRectangle");

function GpiOffsetClipRegion(ps       :HPS     ;
                             pptlPoint:PPOINTL ) return LONG;
pragma Import(c,GpiOffsetClipRegion, Link_name=>"_GpiOffsetClipRegion");

  -- constants for index values of options array for GpiPlayMetaFile
   PMF_SEGBASE  :constant  Long:=                   0 ;
   PMF_LOADTYPE :constant  Long:=                   1 ;
   PMF_RESOLVE  :constant  Long:=                   2 ;
   PMF_LCIDS    :constant  Long:=                   3 ;
   PMF_RESET    :constant  Long:=                   4 ;
   PMF_SUPPRESS  :constant  Long:=                  5 ;
   PMF_COLORTABLES :constant  Long:=                6 ;
   PMF_COLORREALIZABLE :constant  Long:=            7 ;
   PMF_DEFAULTS        :constant  Long:=            8 ;
   PMF_DELETEOBJECTS   :constant  Long:=            9 ;

  -- options for GpiPlayMetaFile
   RS_DEFAULT         :constant  Long:=            0 ;
   RS_NODISCARD       :constant  Long:=            1 ;
   LC_DEFAULT         :constant  Long:=            0 ;
   LC_NOLOAD          :constant  Long:=            1 ;
   LC_LOADDISC        :constant  Long:=            3 ;
   LT_DEFAULT         :constant  Long:=            0 ;
   LT_NOMODIFY        :constant  Long:=            1 ;
   LT_ORIGINALVIEW    :constant  Long:=            4 ;
   RES_DEFAULT        :constant  Long:=            0 ;
   RES_NORESET        :constant  Long:=            1 ;
   RES_RESET          :constant  Long:=            2 ;
   SUP_DEFAULT        :constant  Long:=            0 ;
   SUP_NOSUPPRESS     :constant  Long:=            1 ;
   SUP_SUPPRESS       :constant  Long:=            2 ;
   CTAB_DEFAULT       :constant  Long:=            0 ;
   CTAB_NOMODIFY      :constant  Long:=            1 ;
   CTAB_REPLACE       :constant  Long:=            3 ;
   CTAB_REPLACEPALETTE:constant  Long:=            4 ;
   CREA_DEFAULT       :constant  Long:=            0 ;
   CREA_REALIZE       :constant  Long:=            1 ;
   CREA_NOREALIZE     :constant  Long:=            2 ;
   CREA_DOREALIZE     :constant  Long:=            3 ;

   DDEF_DEFAULT       :constant  Long:=            0 ;
   DDEF_IGNORE        :constant  Long:=            1 ;
   DDEF_LOADDISC      :constant  Long:=            3 ;
   DOBJ_DEFAULT       :constant  Long:=            0 ;
   DOBJ_NODELETE      :constant  Long:=            1 ;
   DOBJ_DELETE        :constant  Long:=            2 ;
   RSP_DEFAULT        :constant  Long:=            0 ;
   RSP_NODISCARD      :constant  Long:=            1 ;

--         MetaFile functions

function GpiCopyMetaFile(mf:HMF  ) return HMF ;
pragma Import(c,GpiCopyMetaFile, Link_name=>"_GpiCopyMetaFile");

function GpiDeleteMetaFile( mf :HMF) return BOOL;
pragma Import(c,GpiDeleteMetaFile, Link_name=>"_GpiDeleteMetaFile");

function GpiLoadMetaFile(ha         :HAB ;
                         pszFilename:PSZ ) return HMF ;
pragma Import(c,GpiLoadMetaFile, Link_name=>"_GpiLoadMetaFile");

function GpiPlayMetaFile(ps        :HPS   ;
                         mf        :HMF   ;
                         lCount1   :LONG  ;
                         alOptarray:PLONG ;
                         plSegCount:PLONG ;
                         lCount2   :LONG  ;
                         pszDesc   :PSZ   ) return LONG;
pragma Import(c,GpiPlayMetaFile, Link_name=>"_GpiPlayMetaFile");

function GpiQueryMetaFileBits(mf     :HMF   ;
                              lOffset:LONG  ;
                              lLength:LONG  ;
                              pbData :PBYTE ) return BOOL;
pragma Import(c,GpiQueryMetaFileBits, Link_name=>"_GpiQueryMetaFileBits");

function GpiQueryMetaFileLength( mf :HMF) return LONG;
pragma Import(c,GpiQueryMetaFileLength, Link_name=>"_GpiQueryMetaFileLength");

function GpiSaveMetaFile(mf         :HMF ;
                         pszFilename:PSZ ) return BOOL;
pragma Import(c,GpiSaveMetaFile, Link_name=>"_GpiSaveMetaFile");

function GpiSetMetaFileBits(mf      :HMF   ;
                            lOffset :LONG  ;
                            lLength :LONG  ;
                            pbBuffer:PBYTE )return BOOL;
pragma Import(c,GpiSetMetaFileBits, Link_name=>"_GpiSetMetaFileBits");

--      default functions

function GpiQueryDefArcParams(ps            :HPS        ;
                              parcpArcParams:PARCPARAMS ) return BOOL;
pragma Import(c,GpiQueryDefArcParams, Link_name=>"_GpiQueryDefArcParams");

function GpiQueryDefAttrs(ps        :HPS     ;
                          lPrimType :LONG    ;
                          flAttrMask:ULONG   ;
                          ppbunAttrs:PBUNDLE ) return BOOL;
pragma Import(c,GpiQueryDefAttrs, Link_name=>"_GpiQueryDefAttrs");

function GpiQueryDefTag(ps   :HPS   ;
                        plTag:PLONG ) return BOOL;
pragma Import(c,GpiQueryDefTag, Link_name=>"_GpiQueryDefTag");

function GpiQueryDefViewingLimits(ps        :HPS    ;
                                  prclLimits:PRECTL ) return BOOL;
pragma Import(c,GpiQueryDefViewingLimits, Link_name=>"_GpiQueryDefViewingLimits");

function GpiSetDefArcParams(ps            :HPS        ;
                            parcpArcParams:PARCPARAMS ) return BOOL;
pragma Import(c,GpiSetDefArcParams, Link_name=>"_GpiSetDefArcParams");

function GpiSetDefAttrs(ps        :HPS     ;
                        lPrimType :LONG    ;
                        flAttrMask:ULONG   ;
                        ppbunAttrs:PBUNDLE ) return BOOL;
pragma Import(c,GpiSetDefAttrs, Link_name=>"_GpiSetDefAttrs");

function GpiSetDefTag(ps  :HPS  ;
                      lTag:LONG ) return BOOL;
pragma Import(c,GpiSetDefTag, Link_name=>"_GpiSetDefTag");

function GpiSetDefViewingLimits(ps        :HPS    ;
                                prclLimits:PRECTL ) return BOOL;
pragma Import(c,GpiSetDefViewingLimits, Link_name=>"_GpiSetDefViewingLimits");

type POLYGON    is record  -- plygn
   ulPoints    :ULONG       ;
   aPointl     :PPOINTL     ;
end record; -- POLYGON;
type PPOLYGON  is access all POLYGON;

type POLYSET   is record  -- plyst
    ulPolys    :ULONG       ;
    aPolygon   :POLYGON     ;     --[1];
end record; -- POLYSET;
type PPOLYSET  is access all POLYSET;

-- control flags used by GpiPolygons
 POLYGON_NOBOUNDARY    :constant  Long:=              0 ;
 POLYGON_BOUNDARY      :constant  Long:=          16#0001#;

 POLYGON_ALTERNATE     :constant  Long:=              0 ;
 POLYGON_WINDING       :constant  Long:=          16#0002#;

 POLYGON_INCL          :constant  Long:=              0 ;
 POLYGON_EXCL          :constant  Long:=          16#0008#;

function GpiPolygons(ps       :HPS      ;
                     ulCount  :ULONG    ;
                     paplgn   :PPOLYGON ;
                     flOptions:ULONG    ;
                     flModel  :ULONG    ) return LONG;
pragma Import(c,GpiPolygons, Link_name=>"_GpiPolygons");

end os2.Gpi;
