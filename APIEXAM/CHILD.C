/* child.c */
#define INCL_SUB
#include <os2.h>
main()
{
     while(TRUE)
       VioWrtTTY("-",1,0);
}
