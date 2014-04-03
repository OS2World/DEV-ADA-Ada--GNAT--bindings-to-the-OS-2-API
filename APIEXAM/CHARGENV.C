/* Simple example for DosCall API OS/2 chargenv.exe  */
/* chargenv.c */
/* print arg list from parent   */
main(argc,argv,envp)
  int argc;
  char *argv[];    /* point to command line      */
  char *envp[];  /* point to env                      */
{
   char **ptr;
   for( ptr=argv;argc;argc--)
        printf("Arg=  %s\n",*ptr++);

   for( ptr=envp;*ptr;ptr++)
        printf("Env=  %s\n",*ptr);
     exit(0);
}
