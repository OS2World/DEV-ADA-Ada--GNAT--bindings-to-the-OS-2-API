
-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ       D E S I G N   E N G I N E R I N G              บDบSบ        บ
-- บ            S O F T W A R E                           ศอสอผ        บ
-- บ                                                                   บ
-- บ        Package     Os2.Err                                        บ
-- บ                                                                   บ
-- บ        Author :  Leonid Dulman     1995                           บ
-- บ                                                                   บ
-- บ             GNU ADA RUNTIME LIBRARY (GNARL) COMPONENTS            บ
-- บ                                                                   บ
-- บ             Base Os2 Error                                        บ
-- บ                                                                   บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

package Os2.Err  is
pragma Preelaborate (Err);

 NO_ERROR                        : constant := 0    ;
 ERROR_INVALID_FUNCTION          : constant := 1    ;
 ERROR_FILE_NOT_FOUND            : constant := 2    ;
 ERROR_PATH_NOT_FOUND            : constant := 3    ;
 ERROR_TOO_MANY_OPEN_FILES       : constant := 4    ;
 ERROR_ACCESS_DENIED             : constant := 5    ;
 ERROR_INVALID_HANDLE            : constant := 6    ;
 ERROR_ARENA_TRASHED             : constant := 7    ;
 ERROR_NOT_ENOUGH_MEMORY         : constant := 8    ;
 ERROR_INVALID_BLOCK             : constant := 9    ;
 ERROR_BAD_ENVIRONMENT           : constant := 10   ;
 ERROR_BAD_FORMAT                : constant := 11   ;
 ERROR_INVALID_ACCESS            : constant := 12   ;
 ERROR_INVALID_DATA              : constant := 13   ;
 ERROR_INVALID_DRIVE             : constant := 15   ;
 ERROR_CURRENT_DIRECTORY         : constant := 16   ;
 ERROR_NOT_SAME_DEVICE           : constant := 17   ;
 ERROR_NO_MORE_FILES             : constant := 18   ;
 ERROR_WRITE_PROTECT             : constant := 19   ;
 ERROR_BAD_UNIT                  : constant := 20   ;
 ERROR_NOT_READY                 : constant := 21   ;
 ERROR_BAD_COMMAND               : constant := 22   ;
 ERROR_CRC                       : constant := 23   ;
 ERROR_BAD_LENGTH                : constant := 24   ;
 ERROR_SEEK                      : constant := 25   ;
 ERROR_NOT_DOS_DISK              : constant := 26   ;
 ERROR_SECTOR_NOT_FOUND          : constant := 27   ;
 ERROR_OUT_OF_PAPER              : constant := 28   ;
 ERROR_WRITE_FAULT               : constant := 29   ;
 ERROR_READ_FAULT                : constant := 30   ;
 ERROR_GEN_FAILURE               : constant := 31   ;
 ERROR_SHARING_VIOLATION         : constant := 32   ;
 ERROR_LOCK_VIOLATION            : constant := 33   ;
 ERROR_WRONG_DISK                : constant := 34   ;
 ERROR_FCB_UNAVAILABLE           : constant := 35   ;
 ERROR_SHARING_BUFFER_EXCEEDED   : constant := 36   ;
 ERROR_CODE_PAGE_MISMATCHED      : constant := 37   ;
 ERROR_HANDLE_EOF                : constant := 38   ;
 ERROR_HANDLE_DISK_FULL          : constant := 39   ;
 -- ERROR_BAD_COMMAND               : constant := 40   ;
 -- ERROR_CRC                       : constant := 41   ;
 -- ERROR_BAD_LENGTH                : constant := 42   ;
 -- ERROR_SEEK                      : constant := 43   ;
 -- ERROR_NOT_DOS_DISK              : constant := 44   ;
 -- ERROR_SECTOR_NOT_FOUND          : constant := 45   ;
 -- ERROR_OUT_OF_PAPER              : constant := 46   ;
 -- ERROR_WRITE_FAULT               : constant := 47   ;
 -- ERROR_READ_FAULT                : constant := 48   ;
 -- ERROR_GEN_FAILURE               : constant := 49   ;
 ERROR_NOT_SUPPORTED             : constant := 50   ;
 ERROR_REM_NOT_LIST              : constant := 51   ;
 ERROR_DUP_NAME                  : constant := 52   ;
 ERROR_BAD_NETPATH               : constant := 53   ;
 ERROR_NETWORK_BUSY              : constant := 54   ;
 ERROR_DEV_NOT_EXIST             : constant := 55   ;
 ERROR_TOO_MANY_CMDS             : constant := 56   ;
 ERROR_ADAP_HDW_ERR              : constant := 57   ;
 ERROR_BAD_NET_RESP              : constant := 58   ;
 ERROR_UNEXP_NET_ERR             : constant := 59   ;
 ERROR_BAD_REM_ADAP              : constant := 60   ;
 ERROR_PRINTQ_FULL               : constant := 61   ;
 ERROR_NO_SPOOL_SPACE            : constant := 62   ;
 ERROR_PRINT_CANCELLED           : constant := 63   ;
 ERROR_NETNAME_DELETED           : constant := 64   ;
 ERROR_NETWORK_ACCESS_DENIED     : constant := 65   ;
 ERROR_BAD_DEV_TYPE              : constant := 66   ;
 ERROR_BAD_NET_NAME              : constant := 67   ;
 ERROR_TOO_MANY_NAMES            : constant := 68   ;
 ERROR_TOO_MANY_SESS             : constant := 69   ;
 ERROR_SHARING_PAUSED            : constant := 70   ;
 ERROR_REQ_NOT_ACCEP             : constant := 71   ;
 ERROR_REDIR_PAUSED              : constant := 72   ;
 ERROR_SBCS_ATT_WRITE_PROT       : constant := 73   ;
 ERROR_SBCS_GENERAL_FAILURE      : constant := 74   ;
 ERROR_XGA_OUT_MEMORY            : constant := 75   ;
 ERROR_FILE_EXISTS               : constant := 80   ;
 ERROR_DUP_FCB                   : constant := 81   ;
 ERROR_CANNOT_MAKE               : constant := 82   ;
 ERROR_FAIL_I24                  : constant := 83   ;
 ERROR_OUT_OF_STRUCTURES         : constant := 84   ;
 ERROR_ALREADY_ASSIGNED          : constant := 85   ;
 ERROR_INVALID_PASSWORD          : constant := 86   ;
 ERROR_INVALID_PARAMETER         : constant := 87   ;
 ERROR_NET_WRITE_FAULT           : constant := 88   ;
 ERROR_NO_PROC_SLOTS             : constant := 89   ;
 ERROR_SYS_COMP_NOT_LOADED       : constant := 90   ;
 ERR_TSTOVFL                     : constant := 91   ;
 ERR_TSTDUP                      : constant := 92   ;
 ERROR_NO_ITEMS                  : constant := 93   ;
 ERROR_INTERRUPT                 : constant := 95   ;
 ERROR_DEVICE_IN_USE             : constant := 99   ;
 ERROR_TOO_MANY_SEMAPHORES       : constant := 100  ;
 ERROR_EXCL_SEM_ALREADY_OWNED    : constant := 101  ;
 ERROR_SEM_IS_SET                : constant := 102  ;
 ERROR_TOO_MANY_SEM_REQUESTS     : constant := 103  ;
 ERROR_INVALID_AT_INTERRUPT_TIME : constant := 104  ;
 ERROR_SEM_OWNER_DIED            : constant := 105  ;
 ERROR_SEM_USER_LIMIT            : constant := 106  ;
 ERROR_DISK_CHANGE               : constant := 107  ;
 ERROR_DRIVE_LOCKED              : constant := 108  ;
 ERROR_BROKEN_PIPE               : constant := 109  ;
 ERROR_OPEN_FAILED               : constant := 110  ;
 ERROR_BUFFER_OVERFLOW           : constant := 111  ;
 ERROR_DISK_FULL                 : constant := 112  ;
 ERROR_NO_MORE_SEARCH_HANDLES    : constant := 113  ;
 ERROR_INVALID_TARGET_HANDLE     : constant := 114  ;
 ERROR_PROTECTION_VIOLATION      : constant := 115  ;
 ERROR_VIOKBD_REQUEST            : constant := 116  ;
 ERROR_INVALID_CATEGORY          : constant := 117  ;
 ERROR_INVALID_VERIFY_SWITCH     : constant := 118  ;
 ERROR_BAD_DRIVER_LEVEL          : constant := 119  ;
 ERROR_CALL_NOT_IMPLEMENTED      : constant := 120  ;
 ERROR_SEM_TIMEOUT               : constant := 121  ;
 ERROR_INSUFFICIENT_BUFFER       : constant := 122  ;
 ERROR_INVALID_NAME              : constant := 123  ;
 ERROR_INVALID_LEVEL             : constant := 124  ;
 ERROR_NO_VOLUME_LABEL           : constant := 125  ;
 ERROR_MOD_NOT_FOUND             : constant := 126  ;
 ERROR_PROC_NOT_FOUND            : constant := 127  ;
 ERROR_WAIT_NO_CHILDREN          : constant := 128  ;
 ERROR_CHILD_NOT_COMPLETE        : constant := 129  ;
 ERROR_DIRECT_ACCESS_HANDLE      : constant := 130  ;
 ERROR_NEGATIVE_SEEK             : constant := 131  ;
 ERROR_SEEK_ON_DEVICE            : constant := 132  ;
 ERROR_IS_JOIN_TARGET            : constant := 133  ;
 ERROR_IS_JOINED                 : constant := 134  ;
 ERROR_IS_SUBSTED                : constant := 135  ;
 ERROR_NOT_JOINED                : constant := 136  ;
 ERROR_NOT_SUBSTED               : constant := 137  ;
 ERROR_JOIN_TO_JOIN              : constant := 138  ;
 ERROR_SUBST_TO_SUBST            : constant := 139  ;
 ERROR_JOIN_TO_SUBST             : constant := 140  ;
 ERROR_SUBST_TO_JOIN             : constant := 141  ;
 ERROR_BUSY_DRIVE                : constant := 142  ;
 ERROR_SAME_DRIVE                : constant := 143  ;
 ERROR_DIR_NOT_ROOT              : constant := 144  ;
 ERROR_DIR_NOT_EMPTY             : constant := 145  ;
 ERROR_IS_SUBST_PATH             : constant := 146  ;
 ERROR_IS_JOIN_PATH              : constant := 147  ;
 ERROR_PATH_BUSY                 : constant := 148  ;
 ERROR_IS_SUBST_TARGET           : constant := 149  ;
 ERROR_SYSTEM_TRACE              : constant := 150  ;
 ERROR_INVALID_EVENT_COUNT       : constant := 151  ;
 ERROR_TOO_MANY_MUXWAITERS       : constant := 152  ;
 ERROR_INVALID_LIST_FORMAT       : constant := 153  ;
 ERROR_LABEL_TOO_LONG            : constant := 154  ;
 ERROR_TOO_MANY_TCBS             : constant := 155  ;
 ERROR_SIGNAL_REFUSED            : constant := 156  ;
 ERROR_DISCARDED                 : constant := 157  ;
 ERROR_NOT_LOCKED                : constant := 158  ;
 ERROR_BAD_THREADID_ADDR         : constant := 159  ;
 ERROR_BAD_ARGUMENTS             : constant := 160  ;
 ERROR_BAD_PATHNAME              : constant := 161  ;
 ERROR_SIGNAL_PENDING            : constant := 162  ;
 ERROR_UNCERTAIN_MEDIA           : constant := 163  ;
 ERROR_MAX_THRDS_REACHED         : constant := 164  ;
 ERROR_MONITORS_NOT_SUPPORTED    : constant := 165  ;
 ERROR_UNC_DRIVER_NOT_INSTALLED  : constant := 166  ;
 ERROR_LOCK_FAILED               : constant := 167  ;
 ERROR_SWAPIO_FAILED             : constant := 168  ;
 ERROR_SWAPIN_FAILED             : constant := 169  ;
 ERROR_BUSY                      : constant := 170  ;
 ERROR_INT_TOO_LONG              : constant := 171  ;
 ERROR_CANCEL_VIOLATION          : constant := 173  ;
 ERROR_ATOMIC_LOCK_NOT_SUPPORTED : constant := 174  ;
 ERROR_READ_LOCKS_NOT_SUPPORTED  : constant := 175  ;
 ERROR_INVALID_SEGMENT_NUMBER    : constant := 180  ;
 ERROR_INVALID_CALLGATE          : constant := 181  ;
 ERROR_INVALID_ORDINAL           : constant := 182  ;
 ERROR_ALREADY_EXISTS            : constant := 183  ;
 ERROR_NO_CHILD_PROCESS          : constant := 184  ;
 ERROR_CHILD_ALIVE_NOWAIT        : constant := 185  ;
 ERROR_INVALID_FLAG_NUMBER       : constant := 186  ;
 ERROR_SEM_NOT_FOUND             : constant := 187  ;
 ERROR_INVALID_STARTING_CODESEG  : constant := 188  ;
 ERROR_INVALID_STACKSEG          : constant := 189  ;
 ERROR_INVALID_MODULETYPE        : constant := 190  ;
 ERROR_INVALID_EXE_SIGNATURE     : constant := 191  ;
 ERROR_EXE_MARKED_INVALID        : constant := 192  ;
 ERROR_BAD_EXE_FORMAT            : constant := 193  ;
 ERROR_ITERATED_DATA_EXCEEDS_64k : constant := 194  ;
 ERROR_INVALID_MINALLOCSIZE      : constant := 195  ;
 ERROR_DYNLINK_FROM_INVALID_RING : constant := 196  ;
 ERROR_IOPL_NOT_ENABLED          : constant := 197  ;
 ERROR_INVALID_SEGDPL            : constant := 198  ;
 ERROR_AUTODATASEG_EXCEEDS_64k   : constant := 199  ;
 ERROR_RING2SEG_MUST_BE_MOVABLE  : constant := 200  ;
 ERROR_RELOC_CHAIN_XEEDS_SEGLIM  : constant := 201  ;
 ERROR_INFLOOP_IN_RELOC_CHAIN    : constant := 202  ;
 ERROR_ENVVAR_NOT_FOUND          : constant := 203  ;
 ERROR_NOT_CURRENT_CTRY          : constant := 204  ;
 ERROR_NO_SIGNAL_SENT            : constant := 205  ;
 ERROR_FILENAME_EXCED_RANGE      : constant := 206  ;
 ERROR_RING2_STACK_IN_USE        : constant := 207  ;
 ERROR_META_EXPANSION_TOO_LONG   : constant := 208  ;
 ERROR_INVALID_SIGNAL_NUMBER     : constant := 209  ;
 ERROR_THREAD_1_INACTIVE         : constant := 210  ;
 ERROR_INFO_NOT_AVAIL            : constant := 211  ;
 ERROR_LOCKED                    : constant := 212  ;
 ERROR_BAD_DYNALINK              : constant := 213  ;
 ERROR_TOO_MANY_MODULES          : constant := 214  ;
 ERROR_NESTING_NOT_ALLOWED       : constant := 215  ;
 ERROR_CANNOT_SHRINK             : constant := 216  ;
 ERROR_ZOMBIE_PROCESS            : constant := 217  ;
 ERROR_STACK_IN_HIGH_MEMORY      : constant := 218  ;
 ERROR_INVALID_EXITROUTINE_RING  : constant := 219  ;
 ERROR_GETBUF_FAILED             : constant := 220  ;
 ERROR_FLUSHBUF_FAILED           : constant := 221  ;
 ERROR_TRANSFER_TOO_LONG         : constant := 222  ;
 ERROR_FORCENOSWAP_FAILED        : constant := 223  ;
 ERROR_SMG_NO_TARGET_WINDOW      : constant := 224  ;
 ERROR_NO_CHILDREN               : constant := 228  ;
 ERROR_INVALID_SCREEN_GROUP      : constant := 229  ;
 ERROR_BAD_PIPE                  : constant := 230  ;
 ERROR_PIPE_BUSY                 : constant := 231  ;
 ERROR_NO_DATA                   : constant := 232  ;
 ERROR_PIPE_NOT_CONNECTED        : constant := 233  ;
 ERROR_MORE_DATA                 : constant := 234  ;
 ERROR_VC_DISCONNECTED           : constant := 240  ;
 ERROR_CIRCULARITY_REQUESTED     : constant := 250  ;
 ERROR_DIRECTORY_IN_CDS          : constant := 251  ;
 ERROR_INVALID_FSD_NAME          : constant := 252  ;
 ERROR_INVALID_PATH              : constant := 253  ;
 ERROR_INVALID_EA_NAME           : constant := 254  ;
 ERROR_EA_LIST_INCONSISTENT      : constant := 255  ;
 ERROR_EA_LIST_TOO_LONG          : constant := 256  ;
 ERROR_NO_META_MATCH             : constant := 257  ;
 ERROR_FINDNOTIFY_TIMEOUT        : constant := 258  ;
 ERROR_NO_MORE_ITEMS             : constant := 259  ;
 ERROR_SEARCH_STRUC_REUSED       : constant := 260  ;
 ERROR_CHAR_NOT_FOUND            : constant := 261  ;
 ERROR_TOO_MUCH_STACK            : constant := 262  ;
 ERROR_INVALID_ATTR              : constant := 263  ;
 ERROR_INVALID_STARTING_RING     : constant := 264  ;
 ERROR_INVALID_DLL_INIT_RING     : constant := 265  ;
 ERROR_CANNOT_COPY               : constant := 266  ;
 ERROR_DIRECTORY                 : constant := 267  ;
 ERROR_OPLOCKED_FILE             : constant := 268  ;
 ERROR_OPLOCK_THREAD_EXISTS      : constant := 269  ;
 ERROR_VOLUME_CHANGED            : constant := 270  ;
 ERROR_FINDNOTIFY_HANDLE_IN_USE  : constant := 271  ;
 ERROR_FINDNOTIFY_HANDLE_CLOSED  : constant := 272  ;
 ERROR_NOTIFY_OBJECT_REMOVED     : constant := 273  ;
 ERROR_ALREADY_SHUTDOWN          : constant := 274  ;
 ERROR_EAS_DIDNT_FIT             : constant := 275  ;
 ERROR_EA_FILE_CORRUPT           : constant := 276  ;
 ERROR_EA_TABLE_FULL             : constant := 277  ;
 ERROR_INVALID_EA_HANDLE         : constant := 278  ;
 ERROR_NO_CLUSTER                : constant := 279  ;
 ERROR_CREATE_EA_FILE            : constant := 280  ;
 ERROR_CANNOT_OPEN_EA_FILE       : constant := 281  ;
 ERROR_EAS_NOT_SUPPORTED         : constant := 282  ;
 ERROR_NEED_EAS_FOUND            : constant := 283  ;
 ERROR_DUPLICATE_HANDLE          : constant := 284  ;
 ERROR_DUPLICATE_NAME            : constant := 285  ;
 ERROR_EMPTY_MUXWAIT             : constant := 286  ;
 ERROR_MUTEX_OWNED               : constant := 287  ;
 ERROR_NOT_OWNER                 : constant := 288  ;
 ERROR_PARAM_TOO_SMALL           : constant := 289  ;
 ERROR_TOO_MANY_HANDLES          : constant := 290  ;
 ERROR_TOO_MANY_OPENS            : constant := 291  ;
 ERROR_WRONG_TYPE                : constant := 292  ;
 ERROR_UNUSED_CODE               : constant := 293  ;
 ERROR_THREAD_NOT_TERMINATED     : constant := 294  ;
 ERROR_INIT_ROUTINE_FAILED       : constant := 295  ;
 ERROR_MODULE_IN_USE             : constant := 296  ;
 ERROR_NOT_ENOUGH_WATCHPOINTS    : constant := 297  ;
 ERROR_TOO_MANY_POSTS            : constant := 298  ;
 ERROR_ALREADY_POSTED            : constant := 299  ;
 ERROR_ALREADY_RESET             : constant := 300  ;
 ERROR_SEM_BUSY                  : constant := 301  ;
 ERROR                           : constant := 302  ;
 ERROR_INVALID_PROCID            : constant := 303  ;
 ERROR_INVALID_PDELTA            : constant := 304  ;
 ERROR_NOT_DESCENDANT            : constant := 305  ;
 ERROR_NOT_SESSION_MANAGER       : constant := 306  ;
 ERROR_INVALID_PCLASS            : constant := 307  ;
 ERROR_INVALID_SCOPE             : constant := 308  ;
 ERROR_INVALID_THREADID          : constant := 309  ;
 ERROR_DOSSUB_SHRINK             : constant := 310  ;
 ERROR_DOSSUB_NOMEM              : constant := 311  ;
 ERROR_DOSSUB_OVERLAP            : constant := 312  ;
 ERROR_DOSSUB_BADSIZE            : constant := 313  ;
 ERROR_DOSSUB_BADFLAG            : constant := 314  ;
 ERROR_DOSSUB_BADSELECTOR        : constant := 315  ;
 ERROR_MR_MSG_TOO_LONG           : constant := 316  ;
 ERROR_MR_MID_NOT_FOUND          : constant := 317  ;
 ERROR_MR_UN_ACC_MSGF            : constant := 318  ;
 ERROR_MR_INV_MSGF_FORMAT        : constant := 319  ;
 ERROR_MR_INV_IVCOUNT            : constant := 320  ;
 ERROR_MR_UN_PERFORM             : constant := 321  ;
 ERROR_TS_WAKEUP                 : constant := 322  ;
 ERROR_TS_SEMHANDLE              : constant := 323  ;
 ERROR_TS_NOTIMER                : constant := 324  ;
 ERROR_TS_HANDLE                 : constant := 326  ;
 ERROR_TS_DATETIME               : constant := 327  ;
 ERROR_SYS_INTERNAL              : constant := 328  ;
 ERROR_QUE_CURRENT_NAME          : constant := 329  ;
 ERROR_QUE_PROC_NOT_OWNED        : constant := 330  ;
 ERROR_QUE_PROC_OWNED            : constant := 331  ;
 ERROR_QUE_DUPLICATE             : constant := 332  ;
 ERROR_QUE_ELEMENT_NOT_EXIST     : constant := 333  ;
 ERROR_QUE_NO_MEMORY             : constant := 334  ;
 ERROR_QUE_INVALID_NAME          : constant := 335  ;
 ERROR_QUE_INVALID_PRIORITY      : constant := 336  ;
 ERROR_QUE_INVALID_HANDLE        : constant := 337  ;
 ERROR_QUE_LINK_NOT_FOUND        : constant := 338  ;
 ERROR_QUE_MEMORY_ERROR          : constant := 339  ;
 ERROR_QUE_PREV_AT_END           : constant := 340  ;
 ERROR_QUE_PROC_NO_ACCESS        : constant := 341  ;
 ERROR_QUE_EMPTY                 : constant := 342  ;
 ERROR_QUE_NAME_NOT_EXIST        : constant := 343  ;
 ERROR_QUE_NOT_INITIALIZED       : constant := 344  ;
 ERROR_QUE_UNABLE_TO_ACCESS      : constant := 345  ;
 ERROR_QUE_UNABLE_TO_ADD         : constant := 346  ;
 ERROR_QUE_UNABLE_TO_INIT        : constant := 347  ;
 ERROR_VIO_INVALID_MASK          : constant := 349  ;
 ERROR_VIO_PTR                   : constant := 350  ;
 ERROR_VIO_APTR                  : constant := 351  ;
 ERROR_VIO_RPTR                  : constant := 352  ;
 ERROR_VIO_CPTR                  : constant := 353  ;
 ERROR_VIO_LPTR                  : constant := 354  ;
 ERROR_VIO_MODE                  : constant := 355  ;
 ERROR_VIO_WIDTH                 : constant := 356  ;
 ERROR_VIO_ATTR                  : constant := 357  ;
 ERROR_VIO_ROW                   : constant := 358  ;
 ERROR_VIO_COL                   : constant := 359  ;
 ERROR_VIO_TOPROW                : constant := 360  ;
 ERROR_VIO_BOTROW                : constant := 361  ;
 ERROR_VIO_RIGHTCOL              : constant := 362  ;
 ERROR_VIO_LEFTCOL               : constant := 363  ;
 ERROR_SCS_CALL                  : constant := 364  ;
 ERROR_SCS_VALUE                 : constant := 365  ;
 ERROR_VIO_WAIT_FLAG             : constant := 366  ;
 ERROR_VIO_UNLOCK                : constant := 367  ;
 ERROR_SGS_NOT_SESSION_MGR       : constant := 368  ;
 ERROR_SMG_INVALID_SGID          : constant := 369  ;
 ERROR_SMG_NOSG                  : constant := 370  ;
 ERROR_SMG_NO_SESSIONS           : constant := 370  ;
 ERROR_SMG_GRP_NOT_FOUND         : constant := 371  ;
 ERROR_SMG_SET_TITLE             : constant := 372  ;
 ERROR_KBD_PARAMETER             : constant := 373  ;
 ERROR_KBD_NO_DEVICE             : constant := 374  ;
 ERROR_KBD_INVALID_IOWAIT        : constant := 375  ;
 ERROR_KBD_INVALID_LENGTH        : constant := 376  ;
 ERROR_KBD_INVALID_ECHO_MASK     : constant := 377  ;
 ERROR_KBD_INVALID_INPUT_MASK    : constant := 378  ;
 ERROR_MON_INVALID_PARMS         : constant := 379  ;
 ERROR_MON_INVALID_DEVNAME       : constant := 380  ;
 ERROR_MON_INVALID_HANDLE        : constant := 381  ;
 ERROR_MON_BUFFER_TOO_SMALL      : constant := 382  ;
 ERROR_MON_BUFFER_EMPTY          : constant := 383  ;
 ERROR_MON_DATA_TOO_LARGE        : constant := 384  ;
 ERROR_MOUSE_NO_DEVICE           : constant := 385  ;
 ERROR_MOUSE_INV_HANDLE          : constant := 386  ;
 ERROR_MOUSE_INV_PARMS           : constant := 387  ;
 ERROR_MOUSE_CANT_RESET          : constant := 388  ;
 ERROR_MOUSE_DISPLAY_PARMS       : constant := 389  ;
 ERROR_MOUSE_INV_MODULE          : constant := 390  ;
 ERROR_MOUSE_INV_ENTRY_PT        : constant := 391  ;
 ERROR_MOUSE_INV_MASK            : constant := 392  ;
 NO_ERROR_MOUSE_NO_DATA          : constant := 393  ;
 NO_ERROR_MOUSE_PTR_DRAWN        : constant := 394  ;
 ERROR_INVALID_FREQUENCY         : constant := 395  ;
 ERROR_NLS_NO_COUNTRY_FILE       : constant := 396  ;
 ERROR_NLS_OPEN_FAILED           : constant := 397  ;
 ERROR_NLS_NO_CTRY_CODE          : constant := 398  ;
 ERROR_NLS_TABLE_TRUNCATED       : constant := 399  ;
 ERROR_NLS_BAD_TYPE              : constant := 400  ;
 ERROR_NLS_TYPE_NOT_FOUND        : constant := 401  ;
 ERROR_VIO_SMG_ONLY              : constant := 402  ;
 ERROR_VIO_INVALID_ASCIIZ        : constant := 403  ;
 ERROR_VIO_DEREGISTER            : constant := 404  ;
 ERROR_VIO_NO_POPUP              : constant := 405  ;
 ERROR_VIO_EXISTING_POPUP        : constant := 406  ;
 ERROR_KBD_SMG_ONLY              : constant := 407  ;
 ERROR_KBD_INVALID_ASCIIZ        : constant := 408  ;
 ERROR_KBD_INVALID_MASK          : constant := 409  ;
 ERROR_KBD_REGISTER              : constant := 410  ;
 ERROR_KBD_DEREGISTER            : constant := 411  ;
 ERROR_MOUSE_SMG_ONLY            : constant := 412  ;
 ERROR_MOUSE_INVALID_ASCIIZ      : constant := 413  ;
 ERROR_MOUSE_INVALID_MASK        : constant := 414  ;
 ERROR_MOUSE_REGISTER            : constant := 415  ;
 ERROR_MOUSE_DEREGISTER          : constant := 416  ;
 ERROR_SMG_BAD_ACTION            : constant := 417  ;
 ERROR_SMG_INVALID_CALL          : constant := 418  ;
 ERROR_SCS_SG_NOTFOUND           : constant := 419  ;
 ERROR_SCS_NOT_SHELL             : constant := 420  ;
 ERROR_VIO_INVALID_PARMS         : constant := 421  ;
 ERROR_VIO_FUNCTION_OWNED        : constant := 422  ;
 ERROR_VIO_RETURN                : constant := 423  ;
 ERROR_SCS_INVALID_FUNCTION      : constant := 424  ;
 ERROR_SCS_NOT_SESSION_MGR       : constant := 425  ;
 ERROR_VIO_REGISTER              : constant := 426  ;
 ERROR_VIO_NO_MODE_THREAD        : constant := 427  ;
 ERROR_VIO_NO_SAVE_RESTORE_THD   : constant := 428  ;
 ERROR_VIO_IN_BG                 : constant := 429  ;
 ERROR_VIO_ILLEGAL_DURING_POPUP  : constant := 430  ;
 ERROR_SMG_NOT_BASESHELL         : constant := 431  ;
 ERROR_SMG_BAD_STATUSREQ         : constant := 432  ;
 ERROR_QUE_INVALID_WAIT          : constant := 433  ;
 ERROR_VIO_LOCK                  : constant := 434  ;
 ERROR_MOUSE_INVALID_IOWAIT      : constant := 435  ;
 ERROR_VIO_INVALID_HANDLE        : constant := 436  ;
 ERROR_VIO_ILLEGAL_DURING_LOCK   : constant := 437  ;
 ERROR_VIO_INVALID_LENGTH        : constant := 438  ;
 ERROR_KBD_INVALID_HANDLE        : constant := 439  ;
 ERROR_KBD_NO_MORE_HANDLE        : constant := 440  ;
 ERROR_KBD_CANNOT_CREATE_KCB     : constant := 441  ;
 ERROR_KBD_CODEPAGE_LOAD_INCOMPL : constant := 442  ;
 ERROR_KBD_INVALID_CODEPAGE_ID   : constant := 443  ;
 ERROR_KBD_NO_CODEPAGE_SUPPORT   : constant := 444  ;
 ERROR_KBD_FOCUS_REQUIRED        : constant := 445  ;
 ERROR_KBD_FOCUS_ALREADY_ACTIVE  : constant := 446  ;
 ERROR_KBD_KEYBOARD_BUSY         : constant := 447  ;
 ERROR_KBD_INVALID_CODEPAGE      : constant := 448  ;
 ERROR_KBD_UNABLE_TO_FOCUS       : constant := 449  ;
 ERROR_SMG_SESSION_NON_SELECT    : constant := 450  ;
 ERROR_SMG_SESSION_NOT_FOREGRND  : constant := 451  ;
 ERROR_SMG_SESSION_NOT_PARENT    : constant := 452  ;
 ERROR_SMG_INVALID_START_MODE    : constant := 453  ;
 ERROR_SMG_INVALID_RELATED_OPT   : constant := 454  ;
 ERROR_SMG_INVALID_BOND_OPTION   : constant := 455  ;
 ERROR_SMG_INVALID_SELECT_OPT    : constant := 456  ;
 ERROR_SMG_START_IN_BACKGROUND   : constant := 457  ;
 ERROR_SMG_INVALID_STOP_OPTION   : constant := 458  ;
 ERROR_SMG_BAD_RESERVE           : constant := 459  ;
 ERROR_SMG_PROCESS_NOT_PARENT    : constant := 460  ;
 ERROR_SMG_INVALID_DATA_LENGTH   : constant := 461  ;
 ERROR_SMG_NOT_BOUND             : constant := 462  ;
 ERROR_SMG_RETRY_SUB_ALLOC       : constant := 463  ;
 ERROR_KBD_DETACHED              : constant := 464  ;
 ERROR_VIO_DETACHED              : constant := 465  ;
 ERROR_MOU_DETACHED              : constant := 466  ;
 ERROR_VIO_FONT                  : constant := 467  ;
 ERROR_VIO_USER_FONT             : constant := 468  ;
 ERROR_VIO_BAD_CP                : constant := 469  ;
 ERROR_VIO_NO_CP                 : constant := 470  ;
 ERROR_VIO_NA_CP                 : constant := 471  ;
 ERROR_INVALID_CODE_PAGE         : constant := 472  ;
 ERROR_CPLIST_TOO_SMALL          : constant := 473  ;
 ERROR_CP_NOT_MOVED              : constant := 474  ;
 ERROR_MODE_SWITCH_INIT          : constant := 475  ;
 ERROR_CODE_PAGE_NOT_FOUND       : constant := 476  ;
 ERROR_UNEXPECTED_SLOT_RETURNED  : constant := 477  ;
 ERROR_SMG_INVALID_TRACE_OPTION  : constant := 478  ;
 ERROR_VIO_INTERNAL_RESOURCE     : constant := 479  ;
 ERROR_VIO_SHELL_INIT            : constant := 480  ;
 ERROR_SMG_NO_HARD_ERRORS        : constant := 481  ;
 ERROR_CP_SWITCH_INCOMPLETE      : constant := 482  ;
 ERROR_VIO_TRANSPARENT_POPUP     : constant := 483  ;
 ERROR_CRITSEC_OVERFLOW          : constant := 484  ;
 ERROR_CRITSEC_UNDERFLOW         : constant := 485  ;
 ERROR_VIO_BAD_RESERVE           : constant := 486  ;
 ERROR_INVALID_ADDRESS           : constant := 487  ;
 ERROR_ZERO_SELECTORS_REQUESTED  : constant := 488  ;
 ERROR_NOT_ENOUGH_SELECTORS_AVA  : constant := 489  ;
 ERROR_INVALID_SELECTOR          : constant := 490  ;
 ERROR_SMG_INVALID_PROGRAM_TYPE  : constant := 491  ;
 ERROR_SMG_INVALID_PGM_CONTROL   : constant := 492  ;
 ERROR_SMG_INVALID_INHERIT_OPT   : constant := 493  ;
 ERROR_VIO_EXTENDED_SG           : constant := 494  ;
 ERROR_VIO_NOT_PRES_MGR_SG       : constant := 495  ;
 ERROR_VIO_SHIELD_OWNED          : constant := 496  ;
 ERROR_VIO_NO_MORE_HANDLES       : constant := 497  ;
 ERROR_VIO_SEE_ERROR_LOG         : constant := 498  ;
 ERROR_VIO_ASSOCIATED_DC         : constant := 499  ;
 ERROR_KBD_NO_CONSOLE            : constant := 500  ;
 ERROR_MOUSE_NO_CONSOLE          : constant := 501  ;
 ERROR_MOUSE_INVALID_HANDLE      : constant := 502  ;
 ERROR_SMG_INVALID_DEBUG_PARMS   : constant := 503  ;
 ERROR_KBD_EXTENDED_SG           : constant := 504  ;
 ERROR_MOU_EXTENDED_SG           : constant := 505  ;
 ERROR_SMG_INVALID_ICON_FILE     : constant := 506  ;
 ERROR_TRC_PID_NON_EXISTENT      : constant := 507  ;
 ERROR_TRC_COUNT_ACTIVE          : constant := 508  ;
 ERROR_TRC_SUSPENDED_BY_COUNT    : constant := 509  ;
 ERROR_TRC_COUNT_INACTIVE        : constant := 510  ;
 ERROR_TRC_COUNT_REACHED         : constant := 511  ;
 ERROR_NO_MC_TRACE               : constant := 512  ;
 ERROR_MC_TRACE                  : constant := 513  ;
 ERROR_TRC_COUNT_ZERO            : constant := 514  ;
 ERROR_SMG_TOO_MANY_DDS          : constant := 515  ;
 ERROR_SMG_INVALID_NOTIFICATION  : constant := 516  ;
 ERROR_LF_INVALID_FUNCTION       : constant := 517  ;
 ERROR_LF_NOT_AVAIL              : constant := 518  ;
 ERROR_LF_SUSPENDED              : constant := 519  ;
 ERROR_LF_BUF_TOO_SMALL          : constant := 520  ;
 ERROR_LF_BUFFER_CORRUPTED       : constant := 521  ;
 ERROR_LF_BUFFER_FULL            : constant := 521  ;
 ERROR_LF_INVALID_DAEMON         : constant := 522  ;
 ERROR_LF_INVALID_RECORD         : constant := 522  ;
 ERROR_LF_INVALID_TEMPL          : constant := 523  ;
 ERROR_LF_INVALID_SERVICE        : constant := 523  ;
 ERROR_LF_GENERAL_FAILURE        : constant := 524  ;
 ERROR_LF_INVALID_ID             : constant := 525  ;
 ERROR_LF_INVALID_HANDLE         : constant := 526  ;
 ERROR_LF_NO_ID_AVAIL            : constant := 527  ;
 ERROR_LF_TEMPLATE_AREA_FULL     : constant := 528  ;
 ERROR_LF_ID_IN_USE              : constant := 529  ;
 ERROR_MOU_NOT_INITIALIZED       : constant := 530  ;
 ERROR_MOUINITREAL_DONE          : constant := 531  ;
 ERROR_DOSSUB_CORRUPTED          : constant := 532  ;
 ERROR_MOUSE_CALLER_NOT_SUBSYS   : constant := 533  ;
 ERROR_ARITHMETIC_OVERFLOW       : constant := 534  ;
 ERROR_TMR_NO_DEVICE             : constant := 535  ;
 ERROR_TMR_INVALID_TIME          : constant := 536  ;
 ERROR_PVW_INVALID_ENTITY        : constant := 537  ;
 ERROR_PVW_INVALID_ENTITY_TYPE   : constant := 538  ;
 ERROR_PVW_INVALID_SPEC          : constant := 539  ;
 ERROR_PVW_INVALID_RANGE_TYPE    : constant := 540  ;
 ERROR_PVW_INVALID_COUNTER_BLK   : constant := 541  ;
 ERROR_PVW_INVALID_TEXT_BLK      : constant := 542  ;
 ERROR_PRF_NOT_INITIALIZED       : constant := 543  ;
 ERROR_PRF_ALREADY_INITIALIZED   : constant := 544  ;
 ERROR_PRF_NOT_STARTED           : constant := 545  ;
 ERROR_PRF_ALREADY_STARTED       : constant := 546  ;
 ERROR_PRF_TIMER_OUT_OF_RANGE    : constant := 547  ;
 ERROR_PRF_TIMER_RESET           : constant := 548  ;
 ERROR_HPFS_CHKDSK_NO_PARM_SPACE : constant := 549  ;
 ERROR_HPFS_CHKDSK_NORECOGNIZE   : constant := 550  ;
 ERROR_HPFS_CHKDSK_NOROOT_FIND   : constant := 551  ;
 ERROR_HPFS_CHKDSK_NOFIX_FS      : constant := 552  ;
 ERROR_HPFS_CHKDSK_CORRECT_FS    : constant := 553  ;
 ERROR_HPFS_CHKDSK_ORGAN_FIX     : constant := 554  ;
 ERROR_HPFS_CHKDSK_RELOC_BBPDATA : constant := 555  ;
 ERROR_HPFS_CHKDSK_REM_CORRU_BLO : constant := 556  ;
 ERROR_HPFS_CHKDSK_REM_CORRUP_FIL: constant := 557  ;
 ERROR_HPFS_CHKDSK_FIX_SPACE_ALLO: constant := 558  ;
 ERROR_HPFS_NOT_FORMATTED_DISK   : constant := 559  ;
 ERROR_HPFS_CHKDSK_COR_ALLOC     : constant := 560  ;
 ERROR_HPFS_CHKDSK_SEARC_UNALLOC : constant := 561  ;
 ERROR_HPFS_CHKDSK_DET_LOST_DATA : constant := 562  ;
 ERROR_HPFS_CHKDSK_PERCENT_SEARC : constant := 563  ;
 ERROR_HPFS_CHKDSK_LOST_DATASEARC: constant := 564  ;
 ERROR_HPFS_CHKDSK_CRIT_NOREAD   : constant := 565  ;
 ERROR_HPFS_CHKDSK_DISK_INUSE    : constant := 566  ;
 ERROR_HPFS_CHKDSK_RECOVTMP_RELOC: constant := 567  ;
 ERROR_HPFS_TOTAL_DISK_SPACE     : constant := 568  ;
 ERROR_HPFS_DIR_KBYTES           : constant := 569  ;
 ERROR_HPFS_FILE_KBYTES          : constant := 570  ;
 ERROR_HPFS_KBYTES_AVAILABLE     : constant := 571  ;
 ERROR_HPFS_CHKDSK_PLACE_REC_FILE: constant := 572  ;
 ERROR_HPFS_CHKDSK_RECO_DIR_AS   : constant := 573  ;
 ERROR_HPFS_CHKDSK_PLACEED_DATA  : constant := 574  ;
 ERROR_HPFS_CHKDSK_RECOV_EA      : constant := 575  ;
 ERROR_HPFS_CHKDSK_FIND_EA_INTEM : constant := 576  ;
 ERROR_HPFS_CHKDSK_RELOC_TEMP_EA : constant := 577  ;
 ERROR_HPFS_CHKDSK_RELOC_AC_LIST : constant := 578  ;
 ERROR_HPFS_CHKDSK_LIST_NORELOC  : constant := 579  ;
 ERROR_HPFS_CHKDSK_TRUN_EA_LIST  : constant := 580  ;
 ERROR_HPFS_CHKDSK_TRUN_EA_NAME  : constant := 581  ;
 ERROR_HPFS_CHKDSK_TRUN_EA_BBLOCK: constant := 582  ;
 ERROR_HPFS_CHKDSK_REM_INVALID_EA: constant := 583  ;
 ERROR_HPFS_CHKDSK_FIX_EA_ALLOC  : constant := 584  ;
 ERROR_HPFS_CHKDSK_FIX_ALACCCTRL : constant := 585  ;
 ERROR_HPFS_CHKDSK_ACCTR_LIST_BBL: constant := 586  ;
 ERROR_HPFS_CHKDSK_REM_ACLIST    : constant := 587  ;
 ERROR_HPFS_CHKDSK_FOUND_DATANORL: constant := 588  ;
 ERROR_HPFS_WRONG_VERSION        : constant := 589  ;
 ERROR_HPFS_CHKDSK_FOUND_DATATEMP: constant := 590  ;
 ERROR_HPFS_CHKDSK_FIX_TEMPSTATUS: constant := 591  ;
 ERROR_HPFS_CHKDSK_FIX_NEEDEADATA: constant := 592  ;
 ERROR_HPFS_RECOVER_PARM_ERROR   : constant := 593  ;
 ERROR_HPFS_RECOV_FILE_NOT_FOUND : constant := 594  ;
 ERROR_HPFS_RECOV_UNKNOWN_ERROR  : constant := 595  ;
 ERROR_HPFS_RECOV_NOT_ENOUGH_MEM : constant := 596  ;
 ERROR_HPFS_RECOV_NOWRITE_DATA   : constant := 597  ;
 ERROR_HPFS_RECOV_NOTEMP_CREATE  : constant := 598  ;
 ERROR_HPFS_RECOV_EA_NOREAD      : constant := 599  ;
 ERROR_HPFS_RECOV_FILE_BYTES     : constant := 600  ;
 ERROR_HPFS_RECOV_BAD_BYTES_RECOV: constant := 601  ;
 ERROR_HPFS_RECOV_FILEBYTES_NOREC: constant := 602  ;
 ERROR_HPFS_RECOV_DISK_INUSE     : constant := 603  ;
 ERROR_HPFS_RECOV_FILE_NODELETE  : constant := 604  ;
 ERROR_HPFS_RECOV_NOCREATE_NEWFIL: constant := 605  ;
 ERROR_HPFS_RECOV_SYSTEM_ERROR   : constant := 606  ;
 ERROR_HPFS_SYS_PARM_ERROR       : constant := 607  ;
 ERROR_HPFS_SYS_CANNOT_INSTALL   : constant := 608  ;
 ERROR_HPFS_SYS_DRIVE_NOTFORMATED: constant := 609  ;
 ERROR_HPFS_SYS_FILE_NOCREATE    : constant := 610  ;
 ERROR_HPFS_SIZE_EXCEED          : constant := 611  ;
 ERROR_HPFS_SYNTAX_ERR           : constant := 612  ;
 ERROR_HPFS_NOTENOUGH_MEM        : constant := 613  ;
 ERROR_HPFS_WANT_MEM             : constant := 614  ;
 ERROR_HPFS_GET_RETURNED         : constant := 615  ;
 ERROR_HPFS_SET_RETURNED         : constant := 616  ;
 ERROR_HPFS_BOTH_RETURNED        : constant := 617  ;
 ERROR_HPFS_STOP_RETURNED        : constant := 618  ;
 ERROR_HPFS_SETPRTYRETURNED      : constant := 619  ;
 ERROR_HPFS_ALCSG_RETURNED       : constant := 620  ;
 ERROR_HPFS_MSEC_SET             : constant := 621  ;
 ERROR_HPFS_OPTIONS              : constant := 622  ;
 ERROR_HPFS_POS_NUM_VALUE        : constant := 623  ;
 ERROR_HPFS_VALUE_TOO_LARGE      : constant := 624  ;
 ERROR_HPFS_LAZY_NOT_VALID       : constant := 625  ;
 ERROR_HPFS_VOLUME_ERROR         : constant := 626  ;
 ERROR_HPFS_VOLUME_DIRTY         : constant := 627  ;
 ERROR_HPFS_NEW_SECTOR           : constant := 628  ;
 ERROR_HPFS_FORMAT_PARM_ERROR    : constant := 629  ;
 ERROR_HPFS_CANNOT_ACCESS_CONFIG : constant := 630  ;
 ERROR_HPFS_RECOV_FILE           : constant := 631  ;
 ERROR_HPFS_CHKDSK_KBYTES_RESERVE: constant := 632  ;
 ERROR_HPFS_CHKDSK_KBYTES_IN_EA  : constant := 633  ;
 ERROR_HPFS_BYTEBUF_SET          : constant := 634  ;
 ERROR_HPFS_FORMATTING_COMPLETE  : constant := 635  ;
 ERROR_HPFS_WRONG_VOLUME_LABEL   : constant := 636  ;
 ERROR_HPFS_FMAT_TOO_MANY_DRS    : constant := 637  ;
 ERROR_VDD_UNSUPPORTED_ACCESS    : constant := 638  ;
 ERROR_VDD_LOCK_USEAGE_DENIED    : constant := 639  ;
 ERROR_TIMEOUT                   : constant := 640  ;
 ERROR_VDM_DOWN                  : constant := 641  ;
 ERROR_VDM_LIMIT                 : constant := 642  ;
 ERROR_VDD_NOT_FOUND             : constant := 643  ;
 ERROR_INVALID_CALLER            : constant := 644  ;
 ERROR_PID_MISMATCH              : constant := 645  ;
 ERROR_INVALID_VDD_HANDLE        : constant := 646  ;
 ERROR_VLPT_NO_SPOOLER           : constant := 647  ;
 ERROR_VCOM_DEVICE_BUSY          : constant := 648  ;
 ERROR_VLPT_DEVICE_BUSY          : constant := 649  ;
 ERROR_NESTING_TOO_DEEP          : constant := 650  ;
 ERRRR_VDD_MISSING               : constant := 651  ;

subtype err_str is string(1..36);

type Err_list_type is array(1..651) of err_str ;
Err_list:          Err_List_type := (
"ERROR_INVALID_FUNCTION          1   ",
"ERROR_FILE_NOT_FOUND            2   ",
"ERROR_PATH_NOT_FOUND            3   ",
"ERROR_TOO_MANY_OPEN_FILES       4   ",
"ERROR_ACCESS_DENIED             5   ",
"ERROR_INVALID_HANDLE            6   ",
"ERROR_ARENA_TRASHED             7   ",
"ERROR_NOT_ENOUGH_MEMORY         8   ",
"ERROR_INVALID_BLOCK             9   ",
"ERROR_BAD_ENVIRONMENT           10  ",
"ERROR_BAD_FORMAT                11  ",
"ERROR_INVALID_ACCESS            12  ",
"ERROR_INVALID_DATA              13  ",
"ERROR_NONSYSTEM                 14  ",
"ERROR_INVALID_DRIVE             15  ",
"ERROR_CURRENT_DIRECTORY         16  ",
"ERROR_NOT_SAME_DEVICE           17  ",
"ERROR_NO_MORE_FILES             18  ",
"ERROR_WRITE_PROTECT             19  ",
"ERROR_BAD_UNIT                  20  ",
"ERROR_NOT_READY                 21  ",
"ERROR_BAD_COMMAND               22  ",
"ERROR_CRC                       23  ",
"ERROR_BAD_LENGTH                24  ",
"ERROR_SEEK                      25  ",
"ERROR_NOT_DOS_DISK              26  ",
"ERROR_SECTOR_NOT_FOUND          27  ",
"ERROR_OUT_OF_PAPER              28  ",
"ERROR_WRITE_FAULT               29  ",
"ERROR_READ_FAULT                30  ",
"ERROR_GEN_FAILURE               31  ",
"ERROR_SHARING_VIOLATION         32  ",
"ERROR_LOCK_VIOLATION            33  ",
"ERROR_WRONG_DISK                34  ",
"ERROR_FCB_UNAVAILABLE           35  ",
"ERROR_SHARING_BUFFER_EXCEEDED   36  ",
"ERROR_CODE_PAGE_MISMATCHED      37  ",
"ERROR_HANDLE_EOF                38  ",
"ERROR_HANDLE_DISK_FULL          39  ",
"ERROR_BAD_COMMAND               40  ",
"ERROR_CRC                       41  ",
"ERROR_BAD_LENGTH                42  ",
"ERROR_SEEK                      43  ",
"ERROR_NOT_DOS_DISK              44  ",
"ERROR_SECTOR_NOT_FOUND          45  ",
"ERROR_OUT_OF_PAPER              46  ",
"ERROR_WRITE_FAULT               47  ",
"ERROR_READ_FAULT                48  ",
"ERROR_GEN_FAILURE               49  ",
"ERROR_NOT_SUPPORTED             50  ",
"ERROR_REM_NOT_LIST              51  ",
"ERROR_DUP_NAME                  52  ",
"ERROR_BAD_NETPATH               53  ",
"ERROR_NETWORK_BUSY              54  ",
"ERROR_DEV_NOT_EXIST             55  ",
"ERROR_TOO_MANY_CMDS             56  ",
"ERROR_ADAP_HDW_ERR              57  ",
"ERROR_BAD_NET_RESP              58  ",
"ERROR_UNEXP_NET_ERR             59  ",
"ERROR_BAD_REM_ADAP              60  ",
"ERROR_PRINTQ_FULL               61  ",
"ERROR_NO_SPOOL_SPACE            62  ",
"ERROR_PRINT_CANCELLED           63  ",
"ERROR_NETNAME_DELETED           64  ",
"ERROR_NETWORK_ACCESS_DENIED     65  ",
"ERROR_BAD_DEV_TYPE              66  ",
"ERROR_BAD_NET_NAME              67  ",
"ERROR_TOO_MANY_NAMES            68  ",
"ERROR_TOO_MANY_SESS             69  ",
"ERROR_SHARING_PAUSED            70  ",
"ERROR_REQ_NOT_ACCEP             71  ",
"ERROR_REDIR_PAUSED              72  ",
"ERROR_SBCS_ATT_WRITE_PROT       73  ",
"ERROR_SBCS_GENERAL_FAILURE      74  ",
"ERROR_XGA_OUT_MEMORY            75  ",
"ERROR_NONSYSTEM                 76  ",
"ERROR_NONSYSTEM                 77  ",
"ERROR_NONSYSTEM                 78  ",
"ERROR_NONSYSTEM                 79  ",
"ERROR_FILE_EXISTS               80  ",
"ERROR_DUP_FCB                   81  ",
"ERROR_CANNOT_MAKE               82  ",
"ERROR_FAIL_I24                  83  ",
"ERROR_OUT_OF_STRUCTURES         84  ",
"ERROR_ALREADY_ASSIGNED          85  ",
"ERROR_INVALID_PASSWORD          86  ",
"ERROR_INVALID_PARAMETER         87  ",
"ERROR_NET_WRITE_FAULT           88  ",
"ERROR_NO_PROC_SLOTS             89  ",
"ERROR_SYS_COMP_NOT_LOADED       90  ",
"ERR_TSTOVFL                     91  ",
"ERR_TSTDUP                      92  ",
"ERROR_NO_ITEMS                  93  ",
"ERROR_NONSYSTEM                 94  ",
"ERROR_INTERRUPT                 95  ",
"ERROR_NONSYSTEM                 96  ",
"ERROR_NONSYSTEM                 97  ",
"ERROR_NONSYSTEM                 98  ",
"ERROR_DEVICE_IN_USE             99  ",
"ERROR_TOO_MANY_SEMAPHORES       100 ",
"ERROR_EXCL_SEM_ALREADY_OWNED    101 ",
"ERROR_SEM_IS_SET                102 ",
"ERROR_TOO_MANY_SEM_REQUESTS     103 ",
"ERROR_INVALID_AT_INTERRUPT_TIME 104 ",
"ERROR_SEM_OWNER_DIED            105 ",
"ERROR_SEM_USER_LIMIT            106 ",
"ERROR_DISK_CHANGE               107 ",
"ERROR_DRIVE_LOCKED              108 ",
"ERROR_BROKEN_PIPE               109 ",
"ERROR_OPEN_FAILED               110 ",
"ERROR_BUFFER_OVERFLOW           111 ",
"ERROR_DISK_FULL                 112 ",
"ERROR_NO_MORE_SEARCH_HANDLES    113 ",
"ERROR_INVALID_TARGET_HANDLE     114 ",
"ERROR_PROTECTION_VIOLATION      115 ",
"ERROR_VIOKBD_REQUEST            116 ",
"ERROR_INVALID_CATEGORY          117 ",
"ERROR_INVALID_VERIFY_SWITCH     118 ",
"ERROR_BAD_DRIVER_LEVEL          119 ",
"ERROR_CALL_NOT_IMPLEMENTED      120 ",
"ERROR_SEM_TIMEOUT               121 ",
"ERROR_INSUFFICIENT_BUFFER       122 ",
"ERROR_INVALID_NAME              123 ",
"ERROR_INVALID_LEVEL             124 ",
"ERROR_NO_VOLUME_LABEL           125 ",
"ERROR_MOD_NOT_FOUND             126 ",
"ERROR_PROC_NOT_FOUND            127 ",
"ERROR_WAIT_NO_CHILDREN          128 ",
"ERROR_CHILD_NOT_COMPLETE        129 ",
"ERROR_DIRECT_ACCESS_HANDLE      130 ",
"ERROR_NEGATIVE_SEEK             131 ",
"ERROR_SEEK_ON_DEVICE            132 ",
"ERROR_IS_JOIN_TARGET            133 ",
"ERROR_IS_JOINED                 134 ",
"ERROR_IS_SUBSTED                135 ",
"ERROR_NOT_JOINED                136 ",
"ERROR_NOT_SUBSTED               137 ",
"ERROR_JOIN_TO_JOIN              138 ",
"ERROR_SUBST_TO_SUBST            139 ",
"ERROR_JOIN_TO_SUBST             140 ",
"ERROR_SUBST_TO_JOIN             141 ",
"ERROR_BUSY_DRIVE                142 ",
"ERROR_SAME_DRIVE                143 ",
"ERROR_DIR_NOT_ROOT              144 ",
"ERROR_DIR_NOT_EMPTY             145 ",
"ERROR_IS_SUBST_PATH             146 ",
"ERROR_IS_JOIN_PATH              147 ",
"ERROR_PATH_BUSY                 148 ",
"ERROR_IS_SUBST_TARGET           149 ",
"ERROR_SYSTEM_TRACE              150 ",
"ERROR_INVALID_EVENT_COUNT       151 ",
"ERROR_TOO_MANY_MUXWAITERS       152 ",
"ERROR_INVALID_LIST_FORMAT       153 ",
"ERROR_LABEL_TOO_LONG            154 ",
"ERROR_TOO_MANY_TCBS             155 ",
"ERROR_SIGNAL_REFUSED            156 ",
"ERROR_DISCARDED                 157 ",
"ERROR_NOT_LOCKED                158 ",
"ERROR_BAD_THREADID_ADDR         159 ",
"ERROR_BAD_ARGUMENTS             160 ",
"ERROR_BAD_PATHNAME              161 ",
"ERROR_SIGNAL_PENDING            162 ",
"ERROR_UNCERTAIN_MEDIA           163 ",
"ERROR_MAX_THRDS_REACHED         164 ",
"ERROR_MONITORS_NOT_SUPPORTED    165 ",
"ERROR_UNC_DRIVER_NOT_INSTALLED  166 ",
"ERROR_LOCK_FAILED               167 ",
"ERROR_SWAPIO_FAILED             168 ",
"ERROR_SWAPIN_FAILED             169 ",
"ERROR_BUSY                      170 ",
"ERROR_INT_TOO_LONG              171 ",
"ERROR_CANCEL_VIOLATION          173 ",
"ERROR_ATOMIC_LOCK_NOT_SUPPORTED 174 ",
"ERROR_READ_LOCKS_NOT_SUPPORTED  175 ",
"ERROR_INVALID_SEGMENT_NUMBER    180 ",
"ERROR_INVALID_CALLGATE          181 ",
"ERROR_INVALID_ORDINAL           182 ",
"ERROR_ALREADY_EXISTS            183 ",
"ERROR_NO_CHILD_PROCESS          184 ",
"ERROR_CHILD_ALIVE_NOWAIT        185 ",
"ERROR_INVALID_FLAG_NUMBER       186 ",
"ERROR_SEM_NOT_FOUND             187 ",
"ERROR_INVALID_STARTING_CODESEG  188 ",
"ERROR_INVALID_STACKSEG          189 ",
"ERROR_INVALID_MODULETYPE        190 ",
"ERROR_INVALID_EXE_SIGNATURE     191 ",
"ERROR_EXE_MARKED_INVALID        192 ",
"ERROR_BAD_EXE_FORMAT            193 ",
"ERROR_ITERATED_DATA_EXCEEDS_64k 194 ",
"ERROR_INVALID_MINALLOCSIZE      195 ",
"ERROR_DYNLINK_FROM_INVALID_RING 196 ",
"ERROR_IOPL_NOT_ENABLED          197 ",
"ERROR_INVALID_SEGDPL            198 ",
"ERROR_AUTODATASEG_EXCEEDS_64k   199 ",
"ERROR_RING2SEG_MUST_BE_MOVABLE  200 ",
"ERROR_RELOC_CHAIN_XEEDS_SEGLIM  201 ",
"ERROR_INFLOOP_IN_RELOC_CHAIN    202 ",
"ERROR_ENVVAR_NOT_FOUND          203 ",
"ERROR_NOT_CURRENT_CTRY          204 ",
"ERROR_NO_SIGNAL_SENT            205 ",
"ERROR_FILENAME_EXCED_RANGE      206 ",
"ERROR_RING2_STACK_IN_USE        207 ",
"ERROR_META_EXPANSION_TOO_LONG   208 ",
"ERROR_INVALID_SIGNAL_NUMBER     209 ",
"ERROR_THREAD_1_INACTIVE         210 ",
"ERROR_INFO_NOT_AVAIL            211 ",
"ERROR_LOCKED                    212 ",
"ERROR_BAD_DYNALINK              213 ",
"ERROR_TOO_MANY_MODULES          214 ",
"ERROR_NESTING_NOT_ALLOWED       215 ",
"ERROR_CANNOT_SHRINK             216 ",
"ERROR_ZOMBIE_PROCESS            217 ",
"ERROR_STACK_IN_HIGH_MEMORY      218 ",
"ERROR_INVALID_EXITROUTINE_RING  219 ",
"ERROR_GETBUF_FAILED             220 ",
"ERROR_FLUSHBUF_FAILED           221 ",
"ERROR_TRANSFER_TOO_LONG         222 ",
"ERROR_FORCENOSWAP_FAILED        223 ",
"ERROR_SMG_NO_TARGET_WINDOW      224 ",
"ERROR_NONSYSTEM                 225 ",
"ERROR_NONSYSTEM                 226 ",
"ERROR_NONSYSTEM                 227 ",
"ERROR_NO_CHILDREN               228 ",
"ERROR_INVALID_SCREEN_GROUP      229 ",
"ERROR_BAD_PIPE                  230 ",
"ERROR_PIPE_BUSY                 231 ",
"ERROR_NO_DATA                   232 ",
"ERROR_PIPE_NOT_CONNECTED        233 ",
"ERROR_MORE_DATA                 234 ",
"ERROR_NONSYSTEM                 235 ",
"ERROR_NONSYSTEM                 236 ",
"ERROR_NONSYSTEM                 237 ",
"ERROR_NONSYSTEM                 238 ",
"ERROR_NONSYSTEM                 239 ",
"ERROR_VC_DISCONNECTED           240 ",
"ERROR_NONSYSTEM                 241 ",
"ERROR_NONSYSTEM                 242 ",
"ERROR_NONSYSTEM                 243 ",
"ERROR_NONSYSTEM                 244 ",
"ERROR_NONSYSTEM                 245 ",
"ERROR_NONSYSTEM                 246 ",
"ERROR_NONSYSTEM                 247 ",
"ERROR_NONSYSTEM                 248 ",
"ERROR_NONSYSTEM                 249 ",
"ERROR_CIRCULARITY_REQUESTED     250 ",
"ERROR_DIRECTORY_IN_CDS          251 ",
"ERROR_INVALID_FSD_NAME          252 ",
"ERROR_INVALID_PATH              253 ",
"ERROR_INVALID_EA_NAME           254 ",
"ERROR_EA_LIST_INCONSISTENT      255 ",
"ERROR_EA_LIST_TOO_LONG          256 ",
"ERROR_NO_META_MATCH             257 ",
"ERROR_FINDNOTIFY_TIMEOUT        258 ",
"ERROR_NO_MORE_ITEMS             259 ",
"ERROR_SEARCH_STRUC_REUSED       260 ",
"ERROR_CHAR_NOT_FOUND            261 ",
"ERROR_TOO_MUCH_STACK            262 ",
"ERROR_INVALID_ATTR              263 ",
"ERROR_INVALID_STARTING_RING     264 ",
"ERROR_INVALID_DLL_INIT_RING     265 ",
"ERROR_CANNOT_COPY               266 ",
"ERROR_DIRECTORY                 267 ",
"ERROR_OPLOCKED_FILE             268 ",
"ERROR_OPLOCK_THREAD_EXISTS      269 ",
"ERROR_VOLUME_CHANGED            270 ",
"ERROR_FINDNOTIFY_HANDLE_IN_USE  271 ",
"ERROR_FINDNOTIFY_HANDLE_CLOSED  272 ",
"ERROR_NOTIFY_OBJECT_REMOVED     273 ",
"ERROR_ALREADY_SHUTDOWN          274 ",
"ERROR_EAS_DIDNT_FIT             275 ",
"ERROR_EA_FILE_CORRUPT           276 ",
"ERROR_EA_TABLE_FULL             277 ",
"ERROR_INVALID_EA_HANDLE         278 ",
"ERROR_NO_CLUSTER                279 ",
"ERROR_CREATE_EA_FILE            280 ",
"ERROR_CANNOT_OPEN_EA_FILE       281 ",
"ERROR_EAS_NOT_SUPPORTED         282 ",
"ERROR_NEED_EAS_FOUND            283 ",
"ERROR_DUPLICATE_HANDLE          284 ",
"ERROR_DUPLICATE_NAME            285 ",
"ERROR_EMPTY_MUXWAIT             286 ",
"ERROR_MUTEX_OWNED               287 ",
"ERROR_NOT_OWNER                 288 ",
"ERROR_PARAM_TOO_SMALL           289 ",
"ERROR_TOO_MANY_HANDLES          290 ",
"ERROR_TOO_MANY_OPENS            291 ",
"ERROR_WRONG_TYPE                292 ",
"ERROR_UNUSED_CODE               293 ",
"ERROR_THREAD_NOT_TERMINATED     294 ",
"ERROR_INIT_ROUTINE_FAILED       295 ",
"ERROR_MODULE_IN_USE             296 ",
"ERROR_NOT_ENOUGH_WATCHPOINTS    297 ",
"ERROR_TOO_MANY_POSTS            298 ",
"ERROR_ALREADY_POSTED            299 ",
"ERROR_ALREADY_RESET             300 ",
"ERROR_SEM_BUSY                  301 ",
"ERROR                           302 ",
"ERROR_INVALID_PROCID            303 ",
"ERROR_INVALID_PDELTA            304 ",
"ERROR_NOT_DESCENDANT            305 ",
"ERROR_NOT_SESSION_MANAGER       306 ",
"ERROR_INVALID_PCLASS            307 ",
"ERROR_INVALID_SCOPE             308 ",
"ERROR_INVALID_THREADID          309 ",
"ERROR_DOSSUB_SHRINK             310 ",
"ERROR_DOSSUB_NOMEM              311 ",
"ERROR_DOSSUB_OVERLAP            312 ",
"ERROR_DOSSUB_BADSIZE            313 ",
"ERROR_DOSSUB_BADFLAG            314 ",
"ERROR_DOSSUB_BADSELECTOR        315 ",
"ERROR_MR_MSG_TOO_LONG           316 ",
"ERROR_MR_MID_NOT_FOUND          317 ",
"ERROR_MR_UN_ACC_MSGF            318 ",
"ERROR_MR_INV_MSGF_FORMAT        319 ",
"ERROR_MR_INV_IVCOUNT            320 ",
"ERROR_MR_UN_PERFORM             321 ",
"ERROR_TS_WAKEUP                 322 ",
"ERROR_TS_SEMHANDLE              323 ",
"ERROR_TS_NOTIMER                324 ",
"ERROR_TS_HANDLE                 326 ",
"ERROR_TS_DATETIME               327 ",
"ERROR_SYS_INTERNAL              328 ",
"ERROR_QUE_CURRENT_NAME          329 ",
"ERROR_QUE_PROC_NOT_OWNED        330 ",
"ERROR_QUE_PROC_OWNED            331 ",
"ERROR_QUE_DUPLICATE             332 ",
"ERROR_QUE_ELEMENT_NOT_EXIST     333 ",
"ERROR_QUE_NO_MEMORY             334 ",
"ERROR_QUE_INVALID_NAME          335 ",
"ERROR_QUE_INVALID_PRIORITY      336 ",
"ERROR_QUE_INVALID_HANDLE        337 ",
"ERROR_QUE_LINK_NOT_FOUND        338 ",
"ERROR_QUE_MEMORY_ERROR          339 ",
"ERROR_QUE_PREV_AT_END           340 ",
"ERROR_QUE_PROC_NO_ACCESS        341 ",
"ERROR_QUE_EMPTY                 342 ",
"ERROR_QUE_NAME_NOT_EXIST        343 ",
"ERROR_QUE_NOT_INITIALIZED       344 ",
"ERROR_QUE_UNABLE_TO_ACCESS      345 ",
"ERROR_QUE_UNABLE_TO_ADD         346 ",
"ERROR_QUE_UNABLE_TO_INIT        347 ",
"ERROR_VIO_INVALID_MASK          349 ",
"ERROR_VIO_PTR                   350 ",
"ERROR_VIO_APTR                  351 ",
"ERROR_VIO_RPTR                  352 ",
"ERROR_VIO_CPTR                  353 ",
"ERROR_VIO_LPTR                  354 ",
"ERROR_VIO_MODE                  355 ",
"ERROR_VIO_WIDTH                 356 ",
"ERROR_VIO_ATTR                  357 ",
"ERROR_VIO_ROW                   358 ",
"ERROR_VIO_COL                   359 ",
"ERROR_VIO_TOPROW                360 ",
"ERROR_VIO_BOTROW                361 ",
"ERROR_VIO_RIGHTCOL              362 ",
"ERROR_VIO_LEFTCOL               363 ",
"ERROR_SCS_CALL                  364 ",
"ERROR_SCS_VALUE                 365 ",
"ERROR_VIO_WAIT_FLAG             366 ",
"ERROR_VIO_UNLOCK                367 ",
"ERROR_SGS_NOT_SESSION_MGR       368 ",
"ERROR_SMG_INVALID_SGID          369 ",
"ERROR_SMG_NOSG                  370 ",
"ERROR_SMG_NO_SESSIONS           370 ",
"ERROR_SMG_GRP_NOT_FOUND         371 ",
"ERROR_SMG_SET_TITLE             372 ",
"ERROR_KBD_PARAMETER             373 ",
"ERROR_KBD_NO_DEVICE             374 ",
"ERROR_KBD_INVALID_IOWAIT        375 ",
"ERROR_KBD_INVALID_LENGTH        376 ",
"ERROR_KBD_INVALID_ECHO_MASK     377 ",
"ERROR_KBD_INVALID_INPUT_MASK    378 ",
"ERROR_MON_INVALID_PARMS         379 ",
"ERROR_MON_INVALID_DEVNAME       380 ",
"ERROR_MON_INVALID_HANDLE        381 ",
"ERROR_MON_BUFFER_TOO_SMALL      382 ",
"ERROR_MON_BUFFER_EMPTY          383 ",
"ERROR_MON_DATA_TOO_LARGE        384 ",
"ERROR_MOUSE_NO_DEVICE           385 ",
"ERROR_MOUSE_INV_HANDLE          386 ",
"ERROR_MOUSE_INV_PARMS           387 ",
"ERROR_MOUSE_CANT_RESET          388 ",
"ERROR_MOUSE_DISPLAY_PARMS       389 ",
"ERROR_MOUSE_INV_MODULE          390 ",
"ERROR_MOUSE_INV_ENTRY_PT        391 ",
"ERROR_MOUSE_INV_MASK            392 ",
"NO_ERROR_MOUSE_NO_DATA          393 ",
"NO_ERROR_MOUSE_PTR_DRAWN        394 ",
"ERROR_INVALID_FREQUENCY         395 ",
"ERROR_NLS_NO_COUNTRY_FILE       396 ",
"ERROR_NLS_OPEN_FAILED           397 ",
"ERROR_NLS_NO_CTRY_CODE          398 ",
"ERROR_NLS_TABLE_TRUNCATED       399 ",
"ERROR_NLS_BAD_TYPE              400 ",
"ERROR_NLS_TYPE_NOT_FOUND        401 ",
"ERROR_VIO_SMG_ONLY              402 ",
"ERROR_VIO_INVALID_ASCIIZ        403 ",
"ERROR_VIO_DEREGISTER            404 ",
"ERROR_VIO_NO_POPUP              405 ",
"ERROR_VIO_EXISTING_POPUP        406 ",
"ERROR_KBD_SMG_ONLY              407 ",
"ERROR_KBD_INVALID_ASCIIZ        408 ",
"ERROR_KBD_INVALID_MASK          409 ",
"ERROR_KBD_REGISTER              410 ",
"ERROR_KBD_DEREGISTER            411 ",
"ERROR_MOUSE_SMG_ONLY            412 ",
"ERROR_MOUSE_INVALID_ASCIIZ      413 ",
"ERROR_MOUSE_INVALID_MASK        414 ",
"ERROR_MOUSE_REGISTER            415 ",
"ERROR_MOUSE_DEREGISTER          416 ",
"ERROR_SMG_BAD_ACTION            417 ",
"ERROR_SMG_INVALID_CALL          418 ",
"ERROR_SCS_SG_NOTFOUND           419 ",
"ERROR_SCS_NOT_SHELL             420 ",
"ERROR_VIO_INVALID_PARMS         421 ",
"ERROR_VIO_FUNCTION_OWNED        422 ",
"ERROR_VIO_RETURN                423 ",
"ERROR_SCS_INVALID_FUNCTION      424 ",
"ERROR_SCS_NOT_SESSION_MGR       425 ",
"ERROR_VIO_REGISTER              426 ",
"ERROR_VIO_NO_MODE_THREAD        427 ",
"ERROR_VIO_NO_SAVE_RESTORE_THD   428 ",
"ERROR_VIO_IN_BG                 429 ",
"ERROR_VIO_ILLEGAL_DURING_POPUP  430 ",
"ERROR_SMG_NOT_BASESHELL         431 ",
"ERROR_SMG_BAD_STATUSREQ         432 ",
"ERROR_QUE_INVALID_WAIT          433 ",
"ERROR_VIO_LOCK                  434 ",
"ERROR_MOUSE_INVALID_IOWAIT      435 ",
"ERROR_VIO_INVALID_HANDLE        436 ",
"ERROR_VIO_ILLEGAL_DURING_LOCK   437 ",
"ERROR_VIO_INVALID_LENGTH        438 ",
"ERROR_KBD_INVALID_HANDLE        439 ",
"ERROR_KBD_NO_MORE_HANDLE        440 ",
"ERROR_KBD_CANNOT_CREATE_KCB     441 ",
"ERROR_KBD_CODEPAGE_LOAD_INCOMPL 442 ",
"ERROR_KBD_INVALID_CODEPAGE_ID   443 ",
"ERROR_KBD_NO_CODEPAGE_SUPPORT   444 ",
"ERROR_KBD_FOCUS_REQUIRED        445 ",
"ERROR_KBD_FOCUS_ALREADY_ACTIVE  446 ",
"ERROR_KBD_KEYBOARD_BUSY         447 ",
"ERROR_KBD_INVALID_CODEPAGE      448 ",
"ERROR_KBD_UNABLE_TO_FOCUS       449 ",
"ERROR_SMG_SESSION_NON_SELECT    450 ",
"ERROR_SMG_SESSION_NOT_FOREGRND  451 ",
"ERROR_SMG_SESSION_NOT_PARENT    452 ",
"ERROR_SMG_INVALID_START_MODE    453 ",
"ERROR_SMG_INVALID_RELATED_OPT   454 ",
"ERROR_SMG_INVALID_BOND_OPTION   455 ",
"ERROR_SMG_INVALID_SELECT_OPT    456 ",
"ERROR_SMG_START_IN_BACKGROUND   457 ",
"ERROR_SMG_INVALID_STOP_OPTION   458 ",
"ERROR_SMG_BAD_RESERVE           459 ",
"ERROR_SMG_PROCESS_NOT_PARENT    460 ",
"ERROR_SMG_INVALID_DATA_LENGTH   461 ",
"ERROR_SMG_NOT_BOUND             462 ",
"ERROR_SMG_RETRY_SUB_ALLOC       463 ",
"ERROR_KBD_DETACHED              464 ",
"ERROR_VIO_DETACHED              465 ",
"ERROR_MOU_DETACHED              466 ",
"ERROR_VIO_FONT                  467 ",
"ERROR_VIO_USER_FONT             468 ",
"ERROR_VIO_BAD_CP                469 ",
"ERROR_VIO_NO_CP                 470 ",
"ERROR_VIO_NA_CP                 471 ",
"ERROR_INVALID_CODE_PAGE         472 ",
"ERROR_CPLIST_TOO_SMALL          473 ",
"ERROR_CP_NOT_MOVED              474 ",
"ERROR_MODE_SWITCH_INIT          475 ",
"ERROR_CODE_PAGE_NOT_FOUND       476 ",
"ERROR_UNEXPECTED_SLOT_RETURNED  477 ",
"ERROR_SMG_INVALID_TRACE_OPTION  478 ",
"ERROR_VIO_INTERNAL_RESOURCE     479 ",
"ERROR_VIO_SHELL_INIT            480 ",
"ERROR_SMG_NO_HARD_ERRORS        481 ",
"ERROR_CP_SWITCH_INCOMPLETE      482 ",
"ERROR_VIO_TRANSPARENT_POPUP     483 ",
"ERROR_CRITSEC_OVERFLOW          484 ",
"ERROR_CRITSEC_UNDERFLOW         485 ",
"ERROR_VIO_BAD_RESERVE           486 ",
"ERROR_INVALID_ADDRESS           487 ",
"ERROR_ZERO_SELECTORS_REQUESTED  488 ",
"ERROR_NOT_ENOUGH_SELECTORS_AVA  489 ",
"ERROR_INVALID_SELECTOR          490 ",
"ERROR_SMG_INVALID_PROGRAM_TYPE  491 ",
"ERROR_SMG_INVALID_PGM_CONTROL   492 ",
"ERROR_SMG_INVALID_INHERIT_OPT   493 ",
"ERROR_VIO_EXTENDED_SG           494 ",
"ERROR_VIO_NOT_PRES_MGR_SG       495 ",
"ERROR_VIO_SHIELD_OWNED          496 ",
"ERROR_VIO_NO_MORE_HANDLES       497 ",
"ERROR_VIO_SEE_ERROR_LOG         498 ",
"ERROR_VIO_ASSOCIATED_DC         499 ",
"ERROR_KBD_NO_CONSOLE            500 ",
"ERROR_MOUSE_NO_CONSOLE          501 ",
"ERROR_MOUSE_INVALID_HANDLE      502 ",
"ERROR_SMG_INVALID_DEBUG_PARMS   503 ",
"ERROR_KBD_EXTENDED_SG           504 ",
"ERROR_MOU_EXTENDED_SG           505 ",
"ERROR_SMG_INVALID_ICON_FILE     506 ",
"ERROR_TRC_PID_NON_EXISTENT      507 ",
"ERROR_TRC_COUNT_ACTIVE          508 ",
"ERROR_TRC_SUSPENDED_BY_COUNT    509 ",
"ERROR_TRC_COUNT_INACTIVE        510 ",
"ERROR_TRC_COUNT_REACHED         511 ",
"ERROR_NO_MC_TRACE               512 ",
"ERROR_MC_TRACE                  513 ",
"ERROR_TRC_COUNT_ZERO            514 ",
"ERROR_SMG_TOO_MANY_DDS          515 ",
"ERROR_SMG_INVALID_NOTIFICATION  516 ",
"ERROR_LF_INVALID_FUNCTION       517 ",
"ERROR_LF_NOT_AVAIL              518 ",
"ERROR_LF_SUSPENDED              519 ",
"ERROR_LF_BUF_TOO_SMALL          520 ",
"ERROR_LF_BUFFER_CORRUPTED       521 ",
"ERROR_LF_BUFFER_FULL            521 ",
"ERROR_LF_INVALID_DAEMON         522 ",
"ERROR_LF_INVALID_RECORD         522 ",
"ERROR_LF_INVALID_TEMPL          523 ",
"ERROR_LF_INVALID_SERVICE        523 ",
"ERROR_LF_GENERAL_FAILURE        524 ",
"ERROR_LF_INVALID_ID             525 ",
"ERROR_LF_INVALID_HANDLE         526 ",
"ERROR_LF_NO_ID_AVAIL            527 ",
"ERROR_LF_TEMPLATE_AREA_FULL     528 ",
"ERROR_LF_ID_IN_USE              529 ",
"ERROR_MOU_NOT_INITIALIZED       530 ",
"ERROR_MOUINITREAL_DONE          531 ",
"ERROR_DOSSUB_CORRUPTED          532 ",
"ERROR_MOUSE_CALLER_NOT_SUBSYS   533 ",
"ERROR_ARITHMETIC_OVERFLOW       534 ",
"ERROR_TMR_NO_DEVICE             535 ",
"ERROR_TMR_INVALID_TIME          536 ",
"ERROR_PVW_INVALID_ENTITY        537 ",
"ERROR_PVW_INVALID_ENTITY_TYPE   538 ",
"ERROR_PVW_INVALID_SPEC          539 ",
"ERROR_PVW_INVALID_RANGE_TYPE    540 ",
"ERROR_PVW_INVALID_COUNTER_BLK   541 ",
"ERROR_PVW_INVALID_TEXT_BLK      542 ",
"ERROR_PRF_NOT_INITIALIZED       543 ",
"ERROR_PRF_ALREADY_INITIALIZED   544 ",
"ERROR_PRF_NOT_STARTED           545 ",
"ERROR_PRF_ALREADY_STARTED       546 ",
"ERROR_PRF_TIMER_OUT_OF_RANGE    547 ",
"ERROR_PRF_TIMER_RESET           548 ",
"ERROR_HPFS_CHKDSK_NO_PARM_SPACE 549 ",
"ERROR_HPFS_CHKDSK_NORECOGNIZE   550 ",
"ERROR_HPFS_CHKDSK_NOROOT_FIND   551 ",
"ERROR_HPFS_CHKDSK_NOFIX_FS      552 ",
"ERROR_HPFS_CHKDSK_CORRECT_FS    553 ",
"ERROR_HPFS_CHKDSK_ORGAN_FIX     554 ",
"ERROR_HPFS_CHKDSK_RELOC_BBPDATA 555 ",
"ERROR_HPFS_CHKDSK_REM_CORRU_BLO 556 ",
"ERROR_HPFS_CHKDSK_REM_CORRUP_FIL557 ",
"ERROR_HPFS_CHKDSK_FIX_SPACE_ALLO558 ",
"ERROR_HPFS_NOT_FORMATTED_DISK   559 ",
"ERROR_HPFS_CHKDSK_COR_ALLOC     560 ",
"ERROR_HPFS_CHKDSK_SEARC_UNALLOC 561 ",
"ERROR_HPFS_CHKDSK_DET_LOST_DATA 562 ",
"ERROR_HPFS_CHKDSK_PERCENT_SEARC 563 ",
"ERROR_HPFS_CHKDSK_LOST_DATASEARC564 ",
"ERROR_HPFS_CHKDSK_CRIT_NOREAD   565 ",
"ERROR_HPFS_CHKDSK_DISK_INUSE    566 ",
"ERROR_HPFS_CHKDSK_RECOVTMP_RELOC567 ",
"ERROR_HPFS_TOTAL_DISK_SPACE     568 ",
"ERROR_HPFS_DIR_KBYTES           569 ",
"ERROR_HPFS_FILE_KBYTES          570 ",
"ERROR_HPFS_KBYTES_AVAILABLE     571 ",
"ERROR_HPFS_CHKDSK_PLACE_REC_FILE572 ",
"ERROR_HPFS_CHKDSK_RECO_DIR_AS   573 ",
"ERROR_HPFS_CHKDSK_PLACEED_DATA  574 ",
"ERROR_HPFS_CHKDSK_RECOV_EA      575 ",
"ERROR_HPFS_CHKDSK_FIND_EA_INTEM 576 ",
"ERROR_HPFS_CHKDSK_RELOC_TEMP_EA 577 ",
"ERROR_HPFS_CHKDSK_RELOC_AC_LIST 578 ",
"ERROR_HPFS_CHKDSK_LIST_NORELOC  579 ",
"ERROR_HPFS_CHKDSK_TRUN_EA_LIST  580 ",
"ERROR_HPFS_CHKDSK_TRUN_EA_NAME  581 ",
"ERROR_HPFS_CHKDSK_TRUN_EA_BBLOCK582 ",
"ERROR_HPFS_CHKDSK_REM_INVALID_EA583 ",
"ERROR_HPFS_CHKDSK_FIX_EA_ALLOC  584 ",
"ERROR_HPFS_CHKDSK_FIX_ALACCCTRL 585 ",
"ERROR_HPFS_CHKDSK_ACCTR_LIST_BBL586 ",
"ERROR_HPFS_CHKDSK_REM_ACLIST    587 ",
"ERROR_HPFS_CHKDSK_FOUND_DATANORL588 ",
"ERROR_HPFS_WRONG_VERSION        589 ",
"ERROR_HPFS_CHKDSK_FOUND_DATATEMP590 ",
"ERROR_HPFS_CHKDSK_FIX_TEMPSTATUS591 ",
"ERROR_HPFS_CHKDSK_FIX_NEEDEADATA592 ",
"ERROR_HPFS_RECOVER_PARM_ERROR   593 ",
"ERROR_HPFS_RECOV_FILE_NOT_FOUND 594 ",
"ERROR_HPFS_RECOV_UNKNOWN_ERROR  595 ",
"ERROR_HPFS_RECOV_NOT_ENOUGH_MEM 596 ",
"ERROR_HPFS_RECOV_NOWRITE_DATA   597 ",
"ERROR_HPFS_RECOV_NOTEMP_CREATE  598 ",
"ERROR_HPFS_RECOV_EA_NOREAD      599 ",
"ERROR_HPFS_RECOV_FILE_BYTES     600 ",
"ERROR_HPFS_RECOV_BAD_BYTES_RECOV601 ",
"ERROR_HPFS_RECOV_FILEBYTES_NOREC602 ",
"ERROR_HPFS_RECOV_DISK_INUSE     603 ",
"ERROR_HPFS_RECOV_FILE_NODELETE  604 ",
"ERROR_HPFS_RECOV_NOCREATE_NEWFIL605 ",
"ERROR_HPFS_RECOV_SYSTEM_ERROR   606 ",
"ERROR_HPFS_SYS_PARM_ERROR       607 ",
"ERROR_HPFS_SYS_CANNOT_INSTALL   608 ",
"ERROR_HPFS_SYS_DRIVE_NOTFORMATED609 ",
"ERROR_HPFS_SYS_FILE_NOCREATE    610 ",
"ERROR_HPFS_SIZE_EXCEED          611 ",
"ERROR_HPFS_SYNTAX_ERR           612 ",
"ERROR_HPFS_NOTENOUGH_MEM        613 ",
"ERROR_HPFS_WANT_MEM             614 ",
"ERROR_HPFS_GET_RETURNED         615 ",
"ERROR_HPFS_SET_RETURNED         616 ",
"ERROR_HPFS_BOTH_RETURNED        617 ",
"ERROR_HPFS_STOP_RETURNED        618 ",
"ERROR_HPFS_SETPRTYRETURNED      619 ",
"ERROR_HPFS_ALCSG_RETURNED       620 ",
"ERROR_HPFS_MSEC_SET             621 ",
"ERROR_HPFS_OPTIONS              622 ",
"ERROR_HPFS_POS_NUM_VALUE        623 ",
"ERROR_HPFS_VALUE_TOO_LARGE      624 ",
"ERROR_HPFS_LAZY_NOT_VALID       625 ",
"ERROR_HPFS_VOLUME_ERROR         626 ",
"ERROR_HPFS_VOLUME_DIRTY         627 ",
"ERROR_HPFS_NEW_SECTOR           628 ",
"ERROR_HPFS_FORMAT_PARM_ERROR    629 ",
"ERROR_HPFS_CANNOT_ACCESS_CONFIG 630 ",
"ERROR_HPFS_RECOV_FILE           631 ",
"ERROR_HPFS_CHKDSK_KBYTES_RESERVE632 ",
"ERROR_HPFS_CHKDSK_KBYTES_IN_EA  633 ",
"ERROR_HPFS_BYTEBUF_SET          634 ",
"ERROR_HPFS_FORMATTING_COMPLETE  635 ",
"ERROR_HPFS_WRONG_VOLUME_LABEL   636 ",
"ERROR_HPFS_FMAT_TOO_MANY_DRS    637 ",
"ERROR_VDD_UNSUPPORTED_ACCESS    638 ",
"ERROR_VDD_LOCK_USEAGE_DENIED    639 ",
"ERROR_TIMEOUT                   640 ",
"ERROR_VDM_DOWN                  641 ",
"ERROR_VDM_LIMIT                 642 ",
"ERROR_VDD_NOT_FOUND             643 ",
"ERROR_INVALID_CALLER            644 ",
"ERROR_PID_MISMATCH              645 ",
"ERROR_INVALID_VDD_HANDLE        646 ",
"ERROR_VLPT_NO_SPOOLER           647 ",
"ERROR_VCOM_DEVICE_BUSY          648 ",
"ERROR_VLPT_DEVICE_BUSY          649 ",
"ERROR_NESTING_TOO_DEEP          650 ",
"ERRRR_VDD_MISSING               651 ",
 others => "....................................");

End Os2.Err;
