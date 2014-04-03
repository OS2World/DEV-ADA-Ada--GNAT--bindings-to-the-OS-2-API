/* compile GNAT */ parse arg fn
'@echo off'
call adastart
i=pos('.',fn); if i>0 then fnm=left(fn,i-1);
                      else do; fnm=fn; fn=fn || '.adb'; end
fnl=fnm || '.lst'
say 'Creation ' fnm'.o file'
say 'Gnat compilation started time:' time() 'file ' fn ;
/* comp = 'gcc -c -gnatl -Zomf -Zsys ' || fn || ' > ' || fnl  */
comp = 'gcc -c -gnatl ' || fn || ' > ' || fnl
comp
rcomp=rc
'@echo on'
say 'Gnat compilation ended time  :' time() 'rc=' rcomp
if rcomp>0 then do
say 'Error  rc=' rcomp ' Listing in file ' fnl  ; pull otb
tedit fnl ;
say 'Listing delete y/n' ; pull otb
if otb='y' | otb='Y' then 'del' fnl
              end
              else '@del' fnl
exit
